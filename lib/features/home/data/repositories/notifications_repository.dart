import 'package:poochcare/features/home/data/api/notifications_api_service.dart';
import 'package:poochcare/features/home/data/models/notification_model.dart';

class NotificationsRepository {
  final NotificationApiService service;

  NotificationsRepository(this.service);

  Future<NotificationResponse> getNotifications({
    int page = 1,
    int limit = 10,
  }) {
    return service.getNotifications(page: page, limit: limit);
  }
}
