import 'package:poochcare/features/home/data/models/updates_and_reminders_response.dart';

abstract class UpdatesRepository {
  Future<UpdatesAndRemindersResponse> getUpdatesAndReminders();
}
