import 'package:equatable/equatable.dart';
import 'package:poochcare/features/home/data/models/notification_model.dart';

enum NotificationStatus { initial, loading, success, failure }

class NotificationState extends Equatable {
  final NotificationStatus status;
  final List<Notification> notifications;
  final PaginationInfo? pagination;
  final String errorMessage;
  final String successMessage;
  final int actionId;
  final int currentPage;
  final int totalPages;
  final bool hasReachedMax;

  const NotificationState({
    this.status = NotificationStatus.initial,
    this.notifications = const [],
    this.pagination,
    this.errorMessage = '',
    this.successMessage = '',
    this.actionId = 0,
    this.currentPage = 1,
    this.totalPages = 1,
    this.hasReachedMax = false,
  });

  NotificationState copyWith({
    NotificationStatus? status,
    List<Notification>? notifications,
    PaginationInfo? pagination,
    String? errorMessage,
    String? successMessage,
    int? actionId,
    int? currentPage,
    int? totalPages,
    bool? hasReachedMax,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      pagination: pagination ?? this.pagination,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      actionId: actionId ?? this.actionId,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
    status,
    notifications,
    pagination,
    errorMessage,
    successMessage,
    actionId,
    currentPage,
    totalPages,
    hasReachedMax,
  ];
}
