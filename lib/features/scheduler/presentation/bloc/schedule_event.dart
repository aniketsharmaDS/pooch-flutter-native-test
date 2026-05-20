import 'package:poochcare/features/scheduler/data/models/request_models/create_event_request_model.dart';
import 'package:poochcare/features/scheduler/data/models/request_models/create_reminder_request_model.dart';
import 'package:poochcare/features/scheduler/domain/ui_models/schedule_item_ui_model.dart';

abstract class ScheduleEvent {}

class LoadMonthlySchedule extends ScheduleEvent {
  final int month;

  final int year;

  LoadMonthlySchedule({required this.month, required this.year});
}

class ChangeScheduleMonth extends ScheduleEvent {
  final int month;

  ChangeScheduleMonth(this.month);
}

class ChangeScheduleYear extends ScheduleEvent {
  final int year;

  ChangeScheduleYear(this.year);
}

class ChangeSelectedDate extends ScheduleEvent {
  final DateTime date;

  ChangeSelectedDate(this.date);
}

class CreateReminder extends ScheduleEvent {
  final CreateReminderRequestModel request;

  CreateReminder(this.request);
}

class CreateEvent extends ScheduleEvent {
  final CreateEventRequestModel request;

  CreateEvent(this.request);
}

class UpdateReminder extends ScheduleEvent {
  final String id;
  final CreateReminderRequestModel request;
  final ScheduleItemUIModel currentItem;

  UpdateReminder({
    required this.id,
    required this.request,
    required this.currentItem,
  });
}

class UpdateEvent extends ScheduleEvent {
  final String id;
  final CreateEventRequestModel request;
  final ScheduleItemUIModel currentItem;

  UpdateEvent({
    required this.id,
    required this.request,
    required this.currentItem,
  });
}

class DeleteSchedule extends ScheduleEvent {
  final String id;
  DeleteSchedule(this.id);
}
