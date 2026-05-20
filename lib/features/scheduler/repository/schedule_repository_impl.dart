import 'package:poochcare/features/scheduler/data/api/scheduler_api_service.dart';
import 'package:poochcare/features/scheduler/data/mappers/schedule_mapper.dart';
import 'package:poochcare/features/scheduler/data/models/request_models/create_event_request_model.dart';
import 'package:poochcare/features/scheduler/data/models/request_models/create_reminder_request_model.dart';
import 'package:poochcare/features/scheduler/domain/repository/schedule_repository.dart';
import 'package:poochcare/features/scheduler/domain/ui_models/schedule_monthly_ui_model.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  const ScheduleRepositoryImpl(this._apiService);

  final ScheduleApiService _apiService;

  @override
  Future<ScheduleMonthlyUIModel> getMonthlySchedule({
    required int month,
    required int year,
  }) async {
    final response = await _apiService.getMonthlySchedule(
      month: month,
      year: year,
    );

    return ScheduleMapper.toUIModel(response.data);
  }

  @override
  Future<void> createReminder({
    required CreateReminderRequestModel request,
  }) async {
    await _apiService.createReminder(request: request);
  }

  @override
  Future<void> createEvent({required CreateEventRequestModel request}) async {
    await _apiService.createEvent(request: request);
  }

  @override
  Future<void> updateReminder({
    required String id,
    required CreateReminderRequestModel request,
  }) async {
    await _apiService.updateReminder(id: id, request: request);
  }

  @override
  Future<void> updateEvent({
    required String id,
    required CreateEventRequestModel request,
  }) async {
    await _apiService.updateEvent(id: id, request: request);
  }

  @override
  Future<void> deleteSchedule({required String id}) async {
    await _apiService.deleteSchedule(id: id);
  }
}
