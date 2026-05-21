import 'dart:async';
import 'dart:developer';

import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/core/pagination/pagination_bloc.dart';
import 'package:poochcare/core/pagination/pagination_result.dart';
import 'package:poochcare/core/services/snackbar_service.dart';
import 'package:poochcare/core/sync/global_update_bus.dart';
import 'package:poochcare/features/community/data/mappers/event_to_submitted_post_mapper.dart';
import 'package:poochcare/features/community/data/models/event_info_item_model.dart';
import 'package:poochcare/features/community/data/models/events_api_response.dart';
import 'package:poochcare/features/community/domain/models/create_event_payload_model.dart';
import 'package:poochcare/features/community/presentation/bloc/tips/tips_guide_bloc.dart';
import 'package:poochcare/features/community/repository/event_repository.dart';

class EventActions {
  static const likeEvent = 'LiKE_EVENT';
  static const unLikeEvent = 'UNLIKE_EVENT';
  static const rsvp = 'RSVP';
  static const leaveEvent = 'LEAVE_EVENT';
}

enum EventsType { allEvents, allUpcoming, allMyEvents, allMyUpcomingEvents }

class EventsBloc extends PaginationBloc<EventInfoItemModel> {
  final EventRepository repository;
  late final GlobalUpdateBus<dynamic> _bus;
  late final StreamSubscription _busSub;
  static const String _source = 'EventsBloc';

  EventsBloc({required this.repository})
    : super(
        fetchPage:
            ({
              required int page,
              String? search,
              Map<String, dynamic>? filters,
            }) async {
              log('filters in EventsBloc fetchPage: $filters');

              final EventsApiResponse response;

              log(
                'EventsBloc filters in fetchPage before condition: ${filters?['type']},\nEventsType.allMyEvents.name: ${EventsType.allMyEvents.name},\nEventsType.allMyUpcomingEvents.name: ${EventsType.allMyUpcomingEvents.name}',
              );

              if (filters?['type'] == EventsType.allMyEvents.name ||
                  filters?['type'] == EventsType.allMyUpcomingEvents.name) {
                response = await repository.fetchMyEventsFeed(
                  page: page,
                  search: search,
                  categoryId: filters?['categoryId'] as String?,
                  upcoming: filters?['upcoming'] as bool?,
                );
              } else {
                response = await repository.fetchAllEventsFeed(
                  page: page,
                  search: search,
                  categoryId: filters?['categoryId'] as String?,
                  upcoming: filters?['upcoming'] as bool?,
                );
              }

              return PaginationResult<EventInfoItemModel>(
                items: response.events,
                currentPage: response.pagination.currentPage,
                hasMore: response.pagination.hasMore,
                totalPages: response.pagination.totalPages,
                totalItems: response.pagination.totalItems,
              );
            },
      ) {
    /// ✅ 👇 (constructor body)
    _bus = getIt<GlobalUpdateBus<dynamic>>();
    _busSub = _bus.stream.listen((event) {
      log('📡 Bus:- EventsBloc received for ${event.source}');
      if (event.source == _source) return;
      final updatedItem = event.data;
      log(
        '📡 Bus:- EventsBloc received for ${event.source}: ${updatedItem.id}',
      );

      // updateItemEverywhere(
      //   test: (item) => item.id == event.id,
      //   update: (_) => event,
      //   fallbackItem: event,
      // );
    });
  }

  /// ✅ VERY IMPORTANT (avoid memory leak)
  @override
  Future<void> close() async {
    await _busSub.cancel();
    await super.close();
  }

  void fetchInitialEvents({
    required EventsType type,
    String? userId, // 👈 A
    String search = '',
    String? categoryId,
    bool? upcoming,
  }) {
    final scope = buildScope(type: type);

    final filters = _buildFilters(categoryId, upcoming, type);

    fetchInitial(
      search: search,
      filters: {
        ...?filters,
        'scope': scope, // 👈 ADD THIS
      },
    );
  }

  void loadMoreEvents() {
    fetchNextPage();
  }

  void refreshEvents() {
    refresh();
  }

  Map<String, dynamic>? _buildFilters(
    String? categoryId,
    bool? upcoming,
    EventsType type,
  ) {
    final filters = <String, dynamic>{};

    if (categoryId != null && categoryId.isNotEmpty) {
      filters['categoryId'] = categoryId;
    }

    if (upcoming != null) {
      filters['upcoming'] = upcoming;
    }

    filters['type'] = type.name; // 'all' or 'myEvents'

    return filters.isEmpty ? null : filters;
  }

  String buildScope({
    required EventsType type,
    String? userId,
    String? categoryId,
    bool? upcoming,
    String? search,
  }) {
    return [
      type.name,
      if (userId != null) 'user:$userId',
      if (categoryId != null) 'cat:$categoryId',
      if (upcoming != null) 'upcoming:$upcoming',
      if (search != null && search.isNotEmpty) 'q:$search',
    ].join('|');
  }

  Future<void> toggleEventLike({
    required String eventId,
    required bool targetIsLiked,
  }) async {
    log('Toggling like for eventId: $eventId, targetIsLiked: $targetIsLiked');
    startProcessing(
      eventId,
      targetIsLiked ? EventActions.likeEvent : EventActions.unLikeEvent,
    );

    final prevItems = state.items;
    final prevSelectedItem = state.selectedItem;

    /// 1. Optimistic update (instant UI using shared updater)
    updateItemEverywhere(
      test: (item) => item.id == eventId,
      update: (item) {
        final nextCount = targetIsLiked
            ? item.likesCount + 1
            : (item.likesCount - 1).clamp(0, 1000000);

        return item.copyWith(isLiked: targetIsLiked, likesCount: nextCount);
      },
    );

    try {
      /// 2. API call
      final ApiResponse result = await repository.toggleEventLike(
        eventId: eventId,
        isLiked: targetIsLiked,
      );
      if (!result.success) {
        CustomSnackbar.show(result.message, SnackbarType.error);
        rollbackFailedEverywhere(
          items: prevItems,
          selectedItem: prevSelectedItem,
        );
        return;
      } else {
        EventInfoItemModel eventInfoItemModel =
            EventInfoItemModelMapper.fromMap(
              result.data['event'] as Map<String, dynamic>,
            );
        log(
          'Event info from toggleEventLike API: ${eventInfoItemModel.toMap()}',
        );
        final bool isLikedFromApi = eventInfoItemModel.isLiked;
        final int likesCountFromApi = eventInfoItemModel.likesCount;
        updateItemEverywhere(
          test: (item) => item.id == eventId,
          update: (item) => item.copyWith(
            isLiked: isLikedFromApi,
            likesCount: likesCountFromApi,
          ),
        );

        final post = eventInfoItemModel.toSubmittedPost();

        _bus.emit(
          data: post,
          source: _source,
          destination: [
            'MyLivePostsBloc',
            'MyReviewPostsBloc',
          ], // 👈 OPTIONAL, can be used for targeted updates
        );

        CustomSnackbar.show(result.message, SnackbarType.success);
      }
    } catch (e) {
      /// 4. Rollback if API fails
      rollbackFailedEverywhere(
        items: prevItems,
        selectedItem: prevSelectedItem,
      );
    } finally {
      // ✅ STOP LOADING
      stopProcessing(
        eventId,
        targetIsLiked ? EventActions.likeEvent : EventActions.unLikeEvent,
      );
    }
  }

  Future<void> confirmAttendee({required String eventId}) async {
    log('Confirming attendee for eventId: $eventId');

    final prevItems = state.items;
    final prevSelectedItem = state.selectedItem;

    // ✅ START LOADING (ONLY RSVP BUTTON)
    startProcessing(eventId, EventActions.rsvp);

    // CANCELLED
    // ATTENDING

    /// 1. Optimistic update (instant UI using shared updater)
    // updateItemEverywhere(
    //   test: (item) => item.id == eventId,
    //   update: (item) {
    //     return item.copyWith(userRsvpStatus: 'ATTENDING', attendanceCount: item.attendanceCount + 1);
    //   },
    // );

    try {
      final ApiResponse result = await repository.confirmAttendee(
        eventId: eventId,
      );
      if (!result.success) {
        CustomSnackbar.show(result.message, SnackbarType.error);
        rollbackFailedEverywhere(
          items: prevItems,
          selectedItem: prevSelectedItem,
        );
        return;
      } else {
        updateItemEverywhere(
          test: (item) => item.id == eventId,
          update: (item) {
            return item.copyWith(
              userRsvpStatus: 'ATTENDING',
              attendanceCount: item.attendanceCount + 1,
            );
          },
        );
        CustomSnackbar.show(result.message, SnackbarType.success);
      }
    } catch (e) {
      /// 4. Rollback if API fails
      rollbackFailedEverywhere(
        items: prevItems,
        selectedItem: prevSelectedItem,
      );
    } finally {
      // ✅ STOP LOADING
      stopProcessing(eventId, EventActions.rsvp);
    }
  }

  Future<void> dropFromTheEvent({required String eventId}) async {
    log('Dropping attendee for eventId: $eventId');

    final prevItems = state.items;
    final prevSelectedItem = state.selectedItem;
    // ✅ START LOADING (ONLY RSVP BUTTON)
    startProcessing(eventId, EventActions.leaveEvent);

    try {
      /// 2. API call
      final ApiResponse result = await repository.dropFromTheEvent(
        eventId: eventId,
      );

      if (!result.success) {
        rollbackFailedEverywhere(
          items: prevItems,
          selectedItem: prevSelectedItem,
        );
        return;
      } else {
        updateItemEverywhere(
          test: (item) => item.id == eventId,
          update: (item) {
            return item.copyWith(
              userRsvpStatus: 'CANCELLED',
              attendanceCount: item.attendanceCount - 1,
            );
          },
        );
        CustomSnackbar.show(result.message, SnackbarType.success);
      }
    } catch (e) {
      /// 4. Rollback if API fails
      rollbackFailedEverywhere(
        items: prevItems,
        selectedItem: prevSelectedItem,
      );
    } finally {
      // ✅ STOP LOADING
      stopProcessing(eventId, EventActions.leaveEvent);
    }
  }

  Future<void> fetchEventDetails(
    String eventId, {
    bool isRefresh = false,
  }) async {
    try {
      /// 1. Get existing item (instant UI)
      final existingItem = state.items.any((e) => e.id == eventId)
          ? state.items.firstWhere((e) => e.id == eventId)
          : null;

      /// 2. Set loading state
      // ignore: invalid_use_of_visible_for_testing_member
      emit(
        state.copyWith(
          selectedItem: existingItem ?? state.selectedItem,
          isDetailLoading: !isRefresh && existingItem == null,
          isDetailRefreshing: isRefresh,
          clearDetailError: true,
        ),
      );

      /// 3. API call
      final event = await repository.getEventDetails(eventId: eventId);
      log('Event details from API: $event');

      /// ✅ IMPORTANT: handle null properly
      if (event == null) {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(state.copyWith(isDetailLoading: false, isDetailRefreshing: false));
        return;
      }

      /// 4. Update BOTH list + detail (single source of truth)
      updateItemEverywhere(
        test: (e) => e.id == eventId,
        update: (_) => event,
        fallbackItem: event,
      );

      /// 5. Stop loaders
      // ignore: invalid_use_of_visible_for_testing_member
      emit(state.copyWith(isDetailLoading: false, isDetailRefreshing: false));
    } catch (e) {
      // ignore: invalid_use_of_visible_for_testing_member
      emit(
        state.copyWith(
          isDetailLoading: false,
          isDetailRefreshing: false,
          detailError: e.toString(),
        ),
      );
    }
  }

  // Api's Related to My Evetns

  Future<void> createEvent({required CreateEventPayloadModel payload}) async {
    try {
      /// 2. API call
      final ApiResponse result = await repository.createEvent(payload: payload);
      if (!result.success) {
        CustomSnackbar.show(result.message, SnackbarType.error);
        throw Exception(result.message);
      } else {
        if (result.data is Map<String, dynamic>) {
          // ignore: unused_local_variable
          final EventInfoItemModel eventInfoItemModel =
              EventInfoItemModelMapper.fromMap(
                result.data as Map<String, dynamic>,
              );
          insertItem(
            item: eventInfoItemModel,
            select: true, // 👈 makes it selected immediately
            targetScopes: {
              buildScope(type: EventsType.allMyEvents),
              buildScope(type: EventsType.allEvents),
            },
          );
          CustomSnackbar.show(result.message, SnackbarType.success);
        } else {
          CustomSnackbar.show('Invalid response format', SnackbarType.error);
          throw Exception('Invalid response format');
        }
      }
    } catch (e) {
      // CustomSnackbar.show('some thing went wrong', SnackbarType.error);
      rethrow;
    }
  }

  Future<void> updateEvent({required CreateEventPayloadModel payload}) async {
    try {
      /// 2. API call
      final ApiResponse result = await repository.updateEvent(payload: payload);

      if (!result.success) {
        CustomSnackbar.show(result.message, SnackbarType.error);
        throw Exception(result.message);
      } else {
        if (result.data is Map<String, dynamic>) {
          // ignore: unused_local_variable
          final EventInfoItemModel eventInfoItemModel =
              EventInfoItemModelMapper.fromMap(
                result.data as Map<String, dynamic>,
              );
          updateItemEverywhere(
            test: (e) => e.id == payload.eventId,
            update: (_) => eventInfoItemModel,
          );

          final post = eventInfoItemModel.toSubmittedPost();

          _bus.emit(
            data: post,
            source: _source,
            destination: [
              'MyLivePostsBloc',
              'MyReviewPostsBloc',
            ], // 👈 OPTIONAL, can be used for targeted updates
          );

          CustomSnackbar.show(result.message, SnackbarType.success);
        } else {
          CustomSnackbar.show('Invalid response format', SnackbarType.error);
          throw Exception('Invalid response format');
        }
      }
    } catch (e) {
      // CustomSnackbar.show('some thing went wrong', SnackbarType.error);
      rethrow;
    }
  }

  Future<void> deleteEvent({required String eventId}) async {
    try {
      // / 2. API call
      final ApiResponse result = await repository.deleteEvent(eventId: eventId);
      if (!result.success) {
        CustomSnackbar.show(result.message, SnackbarType.error);
        throw Exception(result.message);
      } else {
        final EventInfoItemModel eventInfoItemModel = EventInfoItemModel(
          id: eventId,
        );
        //  To Delete the event from live and review and current block.
        final post = eventInfoItemModel.toSubmittedPost();

        _bus.emit(
          data: post,
          source: _source,
          actionType: TipsGuideActions.deleteTip,
          destination: [
            'MyLivePostsBloc',
            'MyReviewPostsBloc',
          ], // 👈 OPTIONAL, can be used for targeted updates
        );

        deleteItem(test: (e) => e.id == eventId);
        CustomSnackbar.show(result.message, SnackbarType.success);
      }
    } catch (e) {
      // CustomSnackbar.show('some thing went wrong', SnackbarType.error);
      rethrow;
    }
  }

  Future<void> reportEvent({
    required String eventId,
    required String reason,
  }) async {
    try {
      final ApiResponse result = await repository.reportEvent(
        eventId: eventId,
        reason: reason,
      );
      if (!result.success) {
        CustomSnackbar.show(result.message, SnackbarType.error);
        throw Exception(result.message);
      } else {
        CustomSnackbar.show(result.message, SnackbarType.success);
      }
    } catch (e) {
      // CustomSnackbar.show('some thing went wrong', SnackbarType.error);
      rethrow;
    }
  }
}
