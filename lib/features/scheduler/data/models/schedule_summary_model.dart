import 'package:poochcare/core/utils/parser_utils.dart';

class ScheduleSummaryModel {
  final int remindersCount;

  final int eventsCount;

  final int datesWithSchedules;

  const ScheduleSummaryModel({
    required this.remindersCount,
    required this.eventsCount,
    required this.datesWithSchedules,
  });

  factory ScheduleSummaryModel.fromMap(Map<String, dynamic> map) {
    return ScheduleSummaryModel(
      remindersCount: ParserUtils.readInt(map['remindersCount']),

      eventsCount: ParserUtils.readInt(map['eventsCount']),

      datesWithSchedules: ParserUtils.readInt(map['datesWithSchedules']),
    );
  }
}
