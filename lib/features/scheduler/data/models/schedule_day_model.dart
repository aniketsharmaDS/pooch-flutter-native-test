import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/scheduler/data/models/schedule_item_model.dart';

class ScheduleDayModel {
  final String date;

  final List<ScheduleItemModel> items;

  const ScheduleDayModel({required this.date, required this.items});

  factory ScheduleDayModel.fromMap(Map<String, dynamic> map) {
    return ScheduleDayModel(
      date: ParserUtils.readString(map['date']),

      items: (map['items'] as List? ?? [])
          .map((e) => ScheduleItemModel.fromMap(ParserUtils.readMap(e)))
          .toList(),
    );
  }
}
