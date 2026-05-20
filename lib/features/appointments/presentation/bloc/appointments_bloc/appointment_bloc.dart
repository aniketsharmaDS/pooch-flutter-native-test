import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:poochcare/core/utils/app_extensions/date_only_extension.dart';
import 'package:poochcare/core/widgets/others/upcoming_appointments_view.dart';
import 'package:poochcare/features/appointments/data/models/appointments_response_model.dart';
import 'package:poochcare/features/appointments/presentation/bloc/appointments_bloc/appointment_event.dart';
import 'package:poochcare/features/appointments/presentation/bloc/appointments_bloc/appointment_state.dart';
import 'package:poochcare/features/insight/repository/clinics_repository.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc(this.repository) : super(const AppointmentState()) {
    on<FetchAllAppointments>(_onFetchAllAppointments);
    on<BookAppointment>(_onBookAppointment);
    on<FetchCalendarAppointments>(_onFetchCalendarAppointments);
  }

  final ClinicsRepository repository;

  Future<void> _onFetchAllAppointments(
    FetchAllAppointments event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(state.copyWith(status: AppointmentProgressStatus.loading));

    try {
      final response = await repository.getAllAppointments(
        page: event.page ?? 1,
        isForceRefresh: event.isForceRefresh,
      );
      final dates = response.appointments.map((e) {
        final date = DateTime.parse(e.startTime);
        return date.toLocal();
      }).toList();

      final upcomingDate = getRecentUpcomingDate(dates);
      final getUpcomingDays = _buildUpcomingWeekDays(
        upcomingDateTime: upcomingDate ?? DateTime.now(),
      );

      final appointments = getAppointmentsList(response);
      final appointmentsByDate = groupAppointments(appointments);

      emit(
        state.copyWith(
          status: AppointmentProgressStatus.success,
          appointmentsData: response,
          appointmentsByDate: appointmentsByDate,
          days: getUpcomingDays,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AppointmentProgressStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onFetchCalendarAppointments(
    FetchCalendarAppointments event,
    Emitter<AppointmentState> emit,
  ) async {
    if (event.isForceRefresh) {
      emit(
        state.copyWith(
          appointmentCalStatus: AppointmentCalendarStatus.loading,
          appointmentCalList: [],
        ),
      );
    }

    /// ONLY SHOW FULLSCREEN LOADER ON INITIAL LOAD
    if (event.isForceRefresh && state.appointmentCalList.isEmpty) {
      emit(
        state.copyWith(appointmentCalStatus: AppointmentCalendarStatus.loading),
      );
    }

    try {
      final response = await repository.getAllCalendarAppointments(
        selectedDate: event.selectedDate,
      );

      /// EXISTING IDS
      final existingIds = state.appointmentCalList.map((e) => e.id).toSet();

      /// REMOVE DUPLICATES
      final newItems = response.where((e) {
        return !existingIds.contains(e.id);
      }).toList();

      /// CONCAT NEW + OLD
      final updatedList = [...state.appointmentCalList, ...newItems];

      // final upcomingDate = getRecentUpcomingDate(dates);
      // final getUpcomingDays = _buildUpcomingWeekDays(
      //   upcomingDateTime: upcomingDate ?? DateTime.now(),
      // );

      log('updatedList-->${updatedList.length}');
      emit(
        state.copyWith(
          appointmentCalStatus: AppointmentCalendarStatus.success,
          appointmentCalList: updatedList,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          appointmentCalStatus: AppointmentCalendarStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onBookAppointment(
    BookAppointment event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(
      state.copyWith(
        bookingStatus: AppointmentBookingStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      await repository.createAppointment(
        petId: event.petId,
        clinicId: event.clinicId,
        appointmentDate: event.appointmentDate,
        appointmentTime: event.appointmentTime,
        consultationType: event.consultationType,
        chiefComplaint: event.chiefComplaint,
        priority: event.priority,
        durationMinutes: event.durationMinutes,
        findPayload: event.findPayload,
      );

      emit(
        state.copyWith(
          bookingStatus: AppointmentBookingStatus.success,
          successMessage: 'Appointment booked successfully',
        ),
      );

      add(const FetchAllAppointments(1, true));
    } catch (e) {
      emit(
        state.copyWith(
          bookingStatus: AppointmentBookingStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  String getTimeFromDate({required DateTime appontmentTime}) {
    final time = DateFormat('hh:mm a').format(appontmentTime);
    return time;
  }

  String getOnlyDate({required DateTime previousDate}) {
    final date = previousDate.toLocal().dateOnly;
    return '${date.day}-${date.month}-${date.year}';
  }

  String getTimeWithWeekDay({required DateTime appointmentDate}) {
    final time = DateFormat('hh:mm a').format(appointmentDate);
    final weekDay = _weekdayLabel(
      weekday: appointmentDate.weekday,
      useFullWeekNames: true,
    );

    return '$weekDay $time';
  }

  List<AppointmentModel> getAppointmentsList(
    AppointmentsResponseModel response,
  ) {
    return response.appointments.map((appointment) {
      final DateTime appointmentDate = DateTime.parse(
        appointment.appointmentDate,
      ).toLocal();
      final String appointmentId = appointment.id;
      final String petName = appointment.pet?.name ?? '';
      final String appointmentTime = getTimeWithWeekDay(
        appointmentDate: DateTime.parse(appointment.startTime).toLocal(),
      );
      final String petProfile = appointment.pet?.profilePicture ?? '';
      final status = appointment.appointmentStatus == 'rescheduled'
          ? AppointmentStatus.rescheduled
          : appointment.appointmentStatus == 'cancelled'
          ? AppointmentStatus.cancelled
          : AppointmentStatus.normal;
      final oldTime = status == AppointmentStatus.rescheduled
          ? appointment.previousTimeLogs.isNotEmpty
                ? getOnlyDate(
                    previousDate: DateTime.parse(
                      appointment.previousTimeLogs.first.appointmentDate,
                    ),
                  )
                : null
          : null;
      final isShowChatOption = shouldShowChatOption(
        appointmentDate: DateTime.parse(appointment.startTime).toLocal(),
      );
      return AppointmentModel(
        appointmentId: appointmentId,
        petName: petName,
        oldTime: oldTime,
        message: isShowChatOption
            ? 'Your vet is available at ${getTimeFromDate(appontmentTime: DateTime.parse(appointment.startTime).toLocal())}'
            : null,
        title: 'Appointment for $petName',
        time: appointmentTime,
        image: petProfile,
        status: status,
        type: 'appointment',
        dateTime: appointmentDate,
      );
    }).toList();
  }

  Map<DateTime, List<AppointmentModel>> groupAppointments(
    List<AppointmentModel> appointments,
  ) {
    final Map<DateTime, List<AppointmentModel>> groupedData = {};

    for (var appointment in appointments) {
      final dateKey = appointment.dateTime.dateOnly;
      if (groupedData[dateKey] == null) {
        groupedData[dateKey] = [];
      }
      groupedData[dateKey]!.add(appointment);
    }

    return groupedData;
  }

  bool shouldShowChatOption({required DateTime appointmentDate}) {
    final now = DateTime.now();
    log(now.difference(appointmentDate).inMinutes.toString());
    return appointmentDate.difference(now).inMinutes <= 30;
  }

  String _weekdayLabel({required int weekday, bool useFullWeekNames = false}) {
    final weekdays = useFullWeekNames
        ? [
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Saturday',
            'Sunday',
          ]
        : ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[weekday - 1];
  }

  List<CalendarDay> _buildUpcomingWeekDays({
    required DateTime upcomingDateTime,
  }) {
    final today = DateTime(
      upcomingDateTime.year,
      upcomingDateTime.month,
      upcomingDateTime.day,
    );

    return List.generate(30, (index) {
      final date = today.add(Duration(days: index));
      return CalendarDay(
        dateTime: date,
        day: _weekdayLabel(weekday: date.weekday),
        date: date.day.toString().padLeft(2, '0'),
      );
    });
  }

  DateTime? getRecentUpcomingDate(List<DateTime> dates) {
    final now = DateTime.now();

    DateTime normalize(DateTime d) => DateTime(d.year, d.month, d.day);
    final today = normalize(now);

    final validDates = dates.where((date) {
      final d = normalize(date);
      return d.isAtSameMomentAs(today) || d.isAfter(today);
    }).toList();

    if (validDates.isEmpty) return null;

    return validDates.reduce((a, b) => a.isBefore(b) ? a : b);
  }
}
