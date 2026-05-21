import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/home/data/repositories/notifications_repository.dart';
import 'package:poochcare/features/home/presentation/bloc/notifications_event.dart';
import 'package:poochcare/features/home/presentation/bloc/notifications_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationsRepository _apiService;

  NotificationBloc(this._apiService) : super(const NotificationState()) {
    on<FetchNotificationsEvent>(_onFetchNotifications);
    on<ResetNotificationsEvent>(_onReset);
  }

  Future<void> _onFetchNotifications(
    FetchNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    // Prevent fetching if already at max or currently loading
    if (state.hasReachedMax || state.status == NotificationStatus.loading) {
      return;
    }

    // Reset if force refresh is requested
    if (event.isForceRefresh) {
      emit(
        state.copyWith(
          status: NotificationStatus.loading,
          currentPage: 1,
          totalPages: 1,
          hasReachedMax: false,
          notifications: [],
        ),
      );
    } else {
      emit(state.copyWith(status: NotificationStatus.loading));
    }

    try {
      final response = await _apiService.getNotifications(
        page: state.currentPage,
      );

      if (response.success && response.data != null) {
        final newNotifications = response.data!.notifications;
        final isLastPage = state.currentPage >= response.data!.pagination.pages;

        // Append new notifications to existing list
        final updatedNotifications = event.isForceRefresh
            ? newNotifications
            : [...state.notifications, ...newNotifications];

        emit(
          state.copyWith(
            status: NotificationStatus.success,
            notifications: updatedNotifications,
            pagination: response.data!.pagination,
            currentPage: state.currentPage + 1,
            totalPages: response.data!.pagination.pages,
            hasReachedMax: isLastPage,
            actionId: state.actionId + 1,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: NotificationStatus.failure,
            errorMessage: response.message.isNotEmpty
                ? response.message
                : 'Failed to fetch notifications',
            actionId: state.actionId + 1,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: NotificationStatus.failure,
          errorMessage: e.toString(),
          actionId: state.actionId + 1,
        ),
      );
    }
  }

  void _onReset(
    ResetNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) {
    emit(const NotificationState());
  }
}
