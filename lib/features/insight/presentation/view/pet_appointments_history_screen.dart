// ignore_for_file: prefer_single_quotes

import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/enums/medical_history_record_type_filter.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/features/appointments/presentation/bloc/appointments_bloc/appointment_bloc.dart';
import 'package:poochcare/features/appointments/presentation/bloc/appointments_bloc/appointment_event.dart';
import 'package:poochcare/features/appointments/presentation/bloc/appointments_bloc/appointment_state.dart';
import 'package:poochcare/features/insight/data/models/appointment_cal_response_model.dart';
import 'package:poochcare/features/scheduler/presentation/widgets/schedule_week_view.dart';
import 'package:poochcare/router/app_router.dart';
import 'package:poochcare/router/router_service.dart';

@RoutePage()
class PetAppointmentsHistoryScreen extends StatefulWidget {
  const PetAppointmentsHistoryScreen({super.key});

  @override
  State<PetAppointmentsHistoryScreen> createState() =>
      _PetAppointmentsHistoryScreenState();
}

class _PetAppointmentsHistoryScreenState
    extends State<PetAppointmentsHistoryScreen> {
  late int selectedYear;

  DateTime selectedDate = DateTime.now();

  /// CACHE FOR LOADED MONTHS
  final Set<String> _loadedMonths = {};

  /// PREVENT MULTIPLE API CALLS
  bool _isFetchingMonth = false;

  @override
  void initState() {
    super.initState();

    selectedDate = DateTime.now();
    selectedYear = DateTime.now().year;

    /// INITIAL FETCH
    _fetchMonth(selectedDate, isForceRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      bloc: getIt<AppointmentBloc>(),
      builder: (context, state) {
        return AppPrimaryScreenContainer(
          title: "Your Pooch's Appointments History",
          child: SafeArea(
            child: Stack(
              children: [
                ScheduleWeekView(
                  showMonth: true,
                  events: buildCalendarViewEvents(state.appointmentCalList),
                  selectedDate: selectedDate,

                  onPageChange: (date) {
                    setState(() {
                      selectedDate = date;
                      selectedYear = date.year;
                    });

                    _handlePagination(date);
                  },
                  onEventTap: (event) {
                    log('Tapped on event-OUT-: ${event.event}');
                    String appointmentId = (event.event as AppointmentItem).id;
                    //  String recordId = (event.event as AppointmentItem).id;
                    // log('Tapped on event PAH: $appointmentId');
                    // String recordId = (event.event as AppointmentItem)
                    //     .medicalHistoryRecords.first.id;

                    // log('Tapped on event PAH: $appointmentId, recordId: $recordId');

                    appRouter.push(
                      PetMedicalDetailsRoute(
                        recordId: '',
                        appointmentId: appointmentId,
                        recordType: MedicalHistoryRecordTypeFilter.consultation,
                      ),
                    );
                  },
                ),

                /// ONLY INITIAL LOADER
                if (state.appointmentCalStatus ==
                        AppointmentCalendarStatus.loading &&
                    state.appointmentCalList.isEmpty)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        );
      },
    );
  }

  /// =========================
  /// PAGINATION LOGIC
  /// =========================

  Future<void> _handlePagination(DateTime date) async {
    final currentDay = date.day;

    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0).day;

    /// FIRST WEEK -> FETCH PREVIOUS MONTH
    if (currentDay <= 7) {
      final previousMonth = DateTime(date.year, date.month - 1);

      await _fetchMonth(previousMonth);
    }
    /// LAST WEEK -> FETCH NEXT MONTH
    else if (currentDay >= lastDayOfMonth - 6) {
      final nextMonth = DateTime(date.year, date.month + 1);

      await _fetchMonth(nextMonth);
    }
  }

  /// =========================
  /// MONTH FETCH
  /// =========================

  Future<void> _fetchMonth(DateTime date, {bool isForceRefresh = false}) async {
    if (_isFetchingMonth) return;

    final monthKey = _monthKey(date);

    /// SKIP IF ALREADY LOADED
    if (_loadedMonths.contains(monthKey) && !isForceRefresh) {
      return;
    }

    _isFetchingMonth = true;

    getIt<AppointmentBloc>().add(
      FetchCalendarAppointments(
        selectedDate: monthKey.toString(),
        isForceRefresh: isForceRefresh,
      ),
    );

    _loadedMonths.add(monthKey);

    /// SMALL DELAY TO PREVENT FAST MULTIPLE SWIPES
    // ignore: inference_failure_on_instance_creation
    await Future.delayed(const Duration(milliseconds: 300));

    _isFetchingMonth = false;
  }

  /// =========================
  /// YYYY-MM FORMAT
  /// =========================

  String _monthKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}';
  }

  /// =========================
  /// CALENDAR EVENT BUILDER
  /// =========================
  ///

  List<CalendarEventData<Object?>> buildCalendarViewEvents(
    List<AppointmentItem> appointments,
  ) {
    return appointments.map((e) {
      // 1. Date (business date)
      final date = DateTime.parse(e.appointmentDate).toLocal();
      // 2. Start / End time (UTC -> local)
      final start = DateTime.parse(e.startTime).toLocal();
      final end = DateTime.parse(e.endTime).toLocal();

      // 3. Combine DATE + TIME (IMPORTANT FIX)
      final calendarStartDate = DateTime(
        date.year,
        date.month,
        date.day,
        start.hour,
        start.minute,
        start.second,
      );
      final calendarEndDate = DateTime(
        date.year,
        date.month,
        date.day,
        end.hour,
        end.minute,
        end.second,
      );

      log('calendarDate-->------------------------------------');
      log('calendarDate-->1->${calendarStartDate.toString()}');
      log('calendarDate-->2->${calendarEndDate.toString()}');
      log('calendarDate-->3->${calendarEndDate.toString()}');

      return CalendarEventData<Object?>(
        date: calendarStartDate,
        startTime: calendarStartDate,
        endTime: calendarEndDate,
        title: e.pet.name,
        color: AppColors.p1_300,

        /// IMPORTANT
        event: e,
      );
    }).toList();
  }
}
