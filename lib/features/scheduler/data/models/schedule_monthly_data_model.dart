import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/scheduler/data/models/schedule_day_model.dart';
import 'package:poochcare/features/scheduler/data/models/schedule_summary_model.dart';

class ScheduleMonthlyDataModel {
  final int month;

  final int year;

  final String groupBy;

  final String timeZone;

  final int totalReminders;

  final int totalEvents;

  final Map<String, ScheduleDayModel> schedules;

  final ScheduleSummaryModel summary;

  const ScheduleMonthlyDataModel({
    required this.month,
    required this.year,
    required this.groupBy,
    required this.timeZone,
    required this.totalReminders,
    required this.totalEvents,
    required this.schedules,
    required this.summary,
  });

  factory ScheduleMonthlyDataModel.fromMap(Map<String, dynamic> map) {
    return ScheduleMonthlyDataModel(
      month: ParserUtils.readInt(map['month']),

      year: ParserUtils.readInt(map['year']),

      groupBy: ParserUtils.readString(map['groupBy']),

      timeZone: ParserUtils.readString(map['timeZone']),

      totalReminders: ParserUtils.readInt(map['totalReminders']),

      totalEvents: ParserUtils.readInt(map['totalEvents']),

      schedules: (map['schedules'] as Map<String, dynamic>? ?? {}).map(
        (key, value) =>
            MapEntry(key, ScheduleDayModel.fromMap(ParserUtils.readMap(value))),
      ),

      summary: ScheduleSummaryModel.fromMap(
        ParserUtils.readMap(map['summary']),
      ),
    );
  }
}
