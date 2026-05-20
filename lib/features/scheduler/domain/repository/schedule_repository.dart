import 'package:poochcare/features/scheduler/data/models/request_models/create_event_request_model.dart';
import 'package:poochcare/features/scheduler/data/models/request_models/create_reminder_request_model.dart';
import 'package:poochcare/features/scheduler/domain/ui_models/schedule_monthly_ui_model.dart';

abstract class ScheduleRepository {
  ScheduleRepository();

  Future<ScheduleMonthlyUIModel> getMonthlySchedule({
    required int month,
    required int year,
  });

  Future<void> createReminder({required CreateReminderRequestModel request});

  Future<void> createEvent({required CreateEventRequestModel request});

  Future<void> updateReminder({
    required String id,
    required CreateReminderRequestModel request,
  });

  Future<void> updateEvent({
    required String id,
    required CreateEventRequestModel request,
  });

  Future<void> deleteSchedule({required String id});
}
