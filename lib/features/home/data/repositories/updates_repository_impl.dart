import 'package:poochcare/features/home/data/api/updates_api_service.dart';
import 'package:poochcare/features/home/data/models/updates_and_reminders_response.dart';
import 'package:poochcare/features/home/domain/repository/updates_repository.dart';

class UpdatesRepositoryImpl implements UpdatesRepository {
  final UpdatesApiService service;

  UpdatesRepositoryImpl(this.service);

  @override
  Future<UpdatesAndRemindersResponse> getUpdatesAndReminders() {
    return service.getUpdatesAndReminders();
  }
}
