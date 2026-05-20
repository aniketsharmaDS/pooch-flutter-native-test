import 'package:poochcare/features/scheduler/domain/ui_models/schedule_day_ui_model.dart';
import 'package:poochcare/features/scheduler/domain/ui_models/schedule_summary_ui_model.dart';

class ScheduleMonthlyUIModel {
  final int month;

  final int year;

  final int totalReminders;

  final int totalEvents;

  final List<ScheduleDayUIModel> schedules;

  final ScheduleSummaryUIModel summary;

  const ScheduleMonthlyUIModel({
    required this.month,
    required this.year,
    required this.totalReminders,
    required this.totalEvents,
    required this.schedules,
    required this.summary,
  });
}
