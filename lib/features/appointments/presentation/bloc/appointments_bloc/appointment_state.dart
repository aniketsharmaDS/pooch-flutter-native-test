import 'package:equatable/equatable.dart';
import 'package:poochcare/core/widgets/others/upcoming_appointments_view.dart';
import 'package:poochcare/features/appointments/data/models/appointments_response_model.dart';
import 'package:poochcare/features/insight/data/models/appointment_cal_response_model.dart';

enum AppointmentProgressStatus { initial, loading, success, failure }

enum AppointmentBookingStatus { initial, loading, success, failure }

enum AppointmentCalendarStatus { initial, loading, success, failure }

class AppointmentState extends Equatable {
  const AppointmentState({
    this.status = AppointmentProgressStatus.initial,
    this.bookingStatus = AppointmentBookingStatus.initial,
    this.appointmentCalStatus = AppointmentCalendarStatus.initial,
    this.errorMessage = '',
    this.successMessage = '',
    this.appointmentsData,
    this.appointmentsByDate = const {},
    this.appointmentCalList = const [],
    this.days = const [],
  });

  final AppointmentProgressStatus status;
  final AppointmentBookingStatus bookingStatus;
  final String? errorMessage;
  final String? successMessage;
  final AppointmentsResponseModel? appointmentsData;
  final Map<DateTime, List<AppointmentModel>> appointmentsByDate;
  final List<CalendarDay> days;
  final AppointmentCalendarStatus appointmentCalStatus;
  final List<AppointmentItem> appointmentCalList;

  AppointmentState copyWith({
    AppointmentProgressStatus? status,
    AppointmentBookingStatus? bookingStatus,
    String? errorMessage,
    String? successMessage,
    AppointmentsResponseModel? appointmentsData,
    Map<DateTime, List<AppointmentModel>>? appointmentsByDate,
    List<CalendarDay>? days,
    AppointmentCalendarStatus? appointmentCalStatus,
    List<AppointmentItem>? appointmentCalList,
  }) {
    return AppointmentState(
      days: days ?? this.days,
      appointmentsByDate: appointmentsByDate ?? this.appointmentsByDate,
      status: status ?? this.status,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      errorMessage: errorMessage,
      successMessage: successMessage,
      appointmentsData: appointmentsData ?? this.appointmentsData,
      appointmentCalStatus: appointmentCalStatus ?? this.appointmentCalStatus,
      appointmentCalList: appointmentCalList ?? this.appointmentCalList,
    );
  }

  @override
  List<Object?> get props => [
    status,
    bookingStatus,
    errorMessage,
    successMessage,
    appointmentsData,
    appointmentsByDate,
    days,
    appointmentCalStatus,
    appointmentCalList,
  ];
}
