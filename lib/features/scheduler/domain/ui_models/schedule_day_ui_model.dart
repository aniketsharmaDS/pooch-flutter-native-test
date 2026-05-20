import 'package:poochcare/features/scheduler/domain/ui_models/schedule_item_ui_model.dart';

class ScheduleDayUIModel {
  final String date;

  final DateTime parsedDate;

  final List<ScheduleItemUIModel> items;

  const ScheduleDayUIModel({
    required this.date,
    required this.parsedDate,
    required this.items,
  });
}
