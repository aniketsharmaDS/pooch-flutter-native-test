import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class FetchNotificationsEvent extends NotificationEvent {
  final int page;
  final int limit;
  final bool isForceRefresh;

  const FetchNotificationsEvent({
    this.page = 1,
    this.limit = 10,
    this.isForceRefresh = false,
  });

  @override
  List<Object?> get props => [page, limit, isForceRefresh];
}

class ResetNotificationsEvent extends NotificationEvent {
  const ResetNotificationsEvent();
}
