import 'package:poochcare/features/scheduler/domain/ui_models/schedule_monthly_ui_model.dart';

class ScheduleState {
  final ScheduleMonthlyUIModel? monthlySchedule;

  final bool isLoading;

  // final int selectedMonth;

  // final int selectedYear;

  final DateTime focusedDate;

  // final DateTime selectedDate;

  final bool isSubmitting;
  final bool submitSuccess;

  final String? successMessage;

  final String? error;

  // final DateTime visibleWeekDate;

  // ScheduleState({
  //   this.monthlySchedule,
  //   this.isLoading = false,
  //   this.selectedMonth = 1,
  //   this.selectedYear = 2026,
  //   DateTime? selectedDate,
  //   this.isSubmitting = false,
  //   this.submitSuccess = false,
  //   this.successMessage,
  //   this.error,
  //   DateTime? visibleWeekDate,
  // }) : selectedDate = selectedDate ?? DateTime(2026), visibleWeekDate = visibleWeekDate ?? DateTime.now();

  ScheduleState({
    this.monthlySchedule,
    this.isLoading = false,
    DateTime? focusedDate,
    this.isSubmitting = false,
    this.submitSuccess = false,
    this.successMessage,
    this.error,
  }) : focusedDate = focusedDate ?? DateTime.now();

  ScheduleState copyWith({
    ScheduleMonthlyUIModel? monthlySchedule,
    bool? isLoading,
    // int? selectedMonth,
    // int? selectedYear,
    // DateTime? selectedDate,
    bool? isSubmitting,

    bool? submitSuccess,

    String? successMessage,
    String? error,

    // DateTime? visibleWeekDate,
    DateTime? focusedDate,
  }) {
    return ScheduleState(
      monthlySchedule: monthlySchedule ?? this.monthlySchedule,

      isLoading: isLoading ?? this.isLoading,

      focusedDate: focusedDate ?? this.focusedDate,

      // selectedMonth: selectedMonth ?? this.selectedMonth,

      // selectedYear: selectedYear ?? this.selectedYear,

      // selectedDate: selectedDate ?? this.selectedDate,
      isSubmitting: isSubmitting ?? this.isSubmitting,

      submitSuccess: submitSuccess ?? this.submitSuccess,

      successMessage: successMessage ?? this.successMessage,

      error: error,

      // visibleWeekDate: visibleWeekDate ?? this.visibleWeekDate,
    );
  }
}
