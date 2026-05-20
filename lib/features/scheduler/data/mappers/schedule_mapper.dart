import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poochcare/features/scheduler/data/models/schedule_day_model.dart';
import 'package:poochcare/features/scheduler/data/models/schedule_item_model.dart';
import 'package:poochcare/features/scheduler/data/models/schedule_monthly_data_model.dart';
import 'package:poochcare/features/scheduler/data/models/schedule_summary_model.dart';
import 'package:poochcare/features/scheduler/domain/ui_models/schedule_day_ui_model.dart';
import 'package:poochcare/features/scheduler/domain/ui_models/schedule_item_ui_model.dart';
import 'package:poochcare/features/scheduler/domain/ui_models/schedule_monthly_ui_model.dart';
import 'package:poochcare/features/scheduler/domain/ui_models/schedule_summary_ui_model.dart';

class ScheduleMapper {
  static ScheduleMonthlyUIModel toUIModel(ScheduleMonthlyDataModel model) {
    return ScheduleMonthlyUIModel(
      month: model.month,

      year: model.year,

      totalReminders: model.totalReminders,

      totalEvents: model.totalEvents,

      schedules: model.schedules.values.map(toDayUIModel).toList(),

      summary: toSummaryUIModel(model.summary),
    );
  }

  static ScheduleDayUIModel toDayUIModel(ScheduleDayModel model) {
    return ScheduleDayUIModel(
      date: model.date,

      parsedDate: DateTime.tryParse(model.date) ?? DateTime.now(),

      items: model.items.map((e) => toItemUIModel(e, model.date)).toList(),
    );
  }

  static ScheduleItemUIModel toItemUIModel(
    ScheduleItemModel model,
    String date,
  ) {
    final parsedTime = _parseDateTime(date, model.time);

    return ScheduleItemUIModel(
      id: model.id,

      type: model.type,

      title: model.title,

      time: model.time,

      date: date,

      startDateTime: parsedTime,

      petId: model.petId,

      petName: model.petName,

      petType: model.petType,

      petGender: model.petGender,

      taskCategory: model.taskCategory,

      eventType: model.eventType,

      notes: model.notes,

      location: model.location,

      endDate: model.endDate,

      isMultiDay: model.isMultiDay,

      formattedTime: DateFormat('hh:mm a').format(parsedTime),

      indicatorColor: _getIndicatorColor(model.type),
    );
  }

  static ScheduleSummaryUIModel toSummaryUIModel(ScheduleSummaryModel model) {
    return ScheduleSummaryUIModel(
      remindersCount: model.remindersCount,

      eventsCount: model.eventsCount,

      datesWithSchedules: model.datesWithSchedules,
    );
  }

  static DateTime _parseDateTime(String date, String time) {
    final parsedDate = DateTime.tryParse(date);

    if (parsedDate == null) {
      return DateTime.now();
    }

    final split = time.split(':');

    if (split.length < 2) {
      return parsedDate;
    }

    return DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
      int.tryParse(split[0]) ?? 0,
      int.tryParse(split[1]) ?? 0,
    );
  }

  static Color _getIndicatorColor(String type) {
    switch (type.toLowerCase()) {
      case 'event':
        return Colors.orange;

      case 'reminder':
        return Colors.green;

      default:
        return Colors.blue;
    }
  }
}
