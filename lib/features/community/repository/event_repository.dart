import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/community/data/api/event_api_service.dart';
import 'package:poochcare/features/community/data/models/event_info_item_model.dart';
import 'package:poochcare/features/community/data/models/events_api_response.dart';
import 'package:poochcare/features/community/data/models/paginated_info.dart';
import 'package:poochcare/features/community/domain/models/create_event_payload_model.dart';

class EventRepository {
  const EventRepository(this._api);
  final EventApiService _api;

  ///////////////////////
  // All the Api Repository Related to Events
  ///////////////////////

  /// Create a new tip/guide
  Future<ApiResponse> createEvent({
    required CreateEventPayloadModel payload,
  }) async {
    try {
      final ApiResponse apiResponse = await _api.createEvent(payload: payload);

      log(
        'Create event API => success=${apiResponse.success}, message=${apiResponse.message}, data=${apiResponse.data}',
      );

      // ✅ Just return response as-is (NO throwing)
      return apiResponse;
    } catch (e) {
      log('Create event exception: $e');

      // ❌ Convert exception into ApiResponse instead of throwing
      return ApiResponse(
        // success: false,
        message: _extractError(e),
      );
    }
  }

  /// Create a new tip/guide
  Future<ApiResponse> updateEvent({
    required CreateEventPayloadModel payload,
  }) async {
    try {
      final ApiResponse apiResponse = await _api.updateEvent(payload: payload);

      log(
        'Create event API => success=${apiResponse.success}, message=${apiResponse.message}, data=${apiResponse.data}',
      );

      // ✅ Just return response as-is (NO throwing)
      return apiResponse;
    } catch (e) {
      log('Create event exception: $e');

      // ❌ Convert exception into ApiResponse instead of throwing
      return ApiResponse(
        // success: false,
        message: _extractError(e),
      );
    }
  }

  /// delete a tip/guide
  Future<ApiResponse> deleteEvent({required String eventId}) async {
    try {
      final ApiResponse apiResponse = await _api.deleteEvent(eventId: eventId);

      log(
        'delete event API => success=${apiResponse.success}, message=${apiResponse.message}, data=${apiResponse.data}',
      );

      // ✅ Just return response as-is (NO throwing)
      return apiResponse;
    } catch (e) {
      log('delete event exception: $e');

      // ❌ Convert exception into ApiResponse instead of throwing
      return ApiResponse(
        // success: false,
        message: _extractError(e),
      );
    }
  }

  /// delete a tip/guide
  Future<ApiResponse> reportEvent({
    required String eventId,
    required String reason,
  }) async {
    try {
      final ApiResponse apiResponse = await _api.reportEvent(
        eventId: eventId,
        reason: reason,
      );

      log(
        'report event API => success=${apiResponse.success}, message=${apiResponse.message}, data=${apiResponse.data}',
      );

      // ✅ Just return response as-is (NO throwing)
      return apiResponse;
    } catch (e) {
      log('report event exception: $e');

      // ❌ Convert exception into ApiResponse instead of throwing
      return ApiResponse(
        // success: false,
        message: _extractError(e),
      );
    }
  }

  /// Fetch tips with pagination, search, and category filtering
  Future<EventsApiResponse> fetchMyEventsFeed({
    required int page,
    String? search,
    String? categoryId,
    bool? upcoming,
  }) async {
    try {
      final Map<String, dynamic> responseData = await _api.getMyEventsFeed(
        page: page,
        search: search,
        categoryId: categoryId,
        upcoming: upcoming,
      );

      if (responseData.isEmpty) {
        return EventsApiResponse(
          events: const [],
          pagination: PaginationInfo(
            currentPage: page,
            totalPages: 0,
            totalItems: 0,
            itemsPerPage: 20,
          ),
        );
      }

      final ApiResponse apiResponse = ApiResponseMapper.fromMap(responseData);

      if (apiResponse.data == null ||
          apiResponse.data is! Map<String, dynamic>) {
        return EventsApiResponse(
          events: const [],
          pagination: PaginationInfo(
            currentPage: page,
            totalPages: 0,
            totalItems: 0,
            itemsPerPage: 20,
          ),
        );
      }

      final dynamic eventsList = apiResponse.data['events'];
      final dynamic paginationData = apiResponse.data['pagination'];

      final List<EventInfoItemModel> events = <EventInfoItemModel>[];
      if (eventsList is List) {
        events.addAll(
          eventsList.whereType<Map<String, dynamic>>().map((
            Map<String, dynamic> json,
          ) {
            return EventInfoItemModelMapper.fromMap(json);
          }),
        );
      }

      PaginationInfo pagination = PaginationInfo(
        currentPage: page,
        totalPages: 0,
        totalItems: 0,
        itemsPerPage: 20,
      );

      if (paginationData is Map<String, dynamic>) {
        pagination = PaginationInfo(
          currentPage: paginationData['currentPage'] as int? ?? page,
          totalPages: paginationData['totalPages'] as int? ?? 0,
          totalItems: paginationData['totalItems'] as int? ?? 0,
          itemsPerPage: paginationData['itemsPerPage'] as int? ?? 20,
        );
      }

      return EventsApiResponse(events: events, pagination: pagination);
    } catch (e) {
      rethrow;
    }
  }

  /// toggle like/unlike for an event
  Future<ApiResponse> toggleEventLike({String? eventId, bool? isLiked}) async {
    try {
      final Map<String, dynamic> responseData = await _api.toggleEventLike(
        eventId: eventId,
        isLiked: isLiked,
      );

      log('Response from toggleEventLike API: $responseData');
      if (responseData.isEmpty) {
        return const ApiResponse(message: 'Something went wrong');
      }
      return ApiResponseMapper.fromMap(responseData);
    } catch (e) {
      return ApiResponse(message: e.toString());
    }
  }

  /// Confirm the Attendee for an event
  Future<ApiResponse> confirmAttendee({String? eventId}) async {
    try {
      final Map<String, dynamic> responseData = await _api.confirmAttendee(
        eventId: eventId,
      );
      log('Response from confirmAttendee API: $responseData');
      if (responseData.isEmpty) {
        return const ApiResponse(
          // success: false,
          message: 'Something went wrong',
        );
      }

      return ApiResponseMapper.fromMap(responseData);
    } catch (e) {
      return ApiResponse(
        // success: false,
        message: e.toString(),
      );
    }
  }

  /// drop from the event the Attendee for an event
  Future<ApiResponse> dropFromTheEvent({String? eventId}) async {
    try {
      final Map<String, dynamic> responseData = await _api.dropFromTheEvent(
        eventId: eventId,
      );
      if (responseData.isEmpty) {
        return const ApiResponse(
          // success: false,
          message: 'Something went wrong',
        );
      }
      return ApiResponseMapper.fromMap(responseData);
    } catch (e) {
      return ApiResponse(
        // success: false,
        message: e.toString(),
      );
    }
  }

  /// Fetch tips with pagination, search, and category filtering
  Future<EventInfoItemModel?> getEventDetails({required String eventId}) async {
    try {
      final Map<String, dynamic> responseData = await _api.getEventDetails(
        eventId: eventId,
      );

      if (responseData.isEmpty) {
        return null;
      }

      final ApiResponse apiResponse = ApiResponseMapper.fromMap(responseData);

      if (apiResponse.data == null ||
          apiResponse.data is! Map<String, dynamic>) {
        return null;
      }

      /// ✅ YOUR API STRUCTURE: data = FULL EVENT OBJECT
      final Map<String, dynamic> eventJson =
          apiResponse.data as Map<String, dynamic>;

      /// ✅ Convert directly to model
      final event = EventInfoItemModelMapper.fromMap(eventJson);

      return event;
    } catch (e) {
      rethrow;
    }
  }

  ///////////////////////
  // Api related to All Events other mine
  ///////////////////////
  /// Fetch tips with pagination, search, and category filtering
  Future<EventsApiResponse> fetchAllEventsFeed({
    required int page,
    String? search,
    String? categoryId,
    bool? upcoming,
  }) async {
    try {
      final Map<String, dynamic> responseData = await _api.getAllEventsFeed(
        page: page,
        search: search,
        categoryId: categoryId,
        upcoming: upcoming,
      );

      if (responseData.isEmpty) {
        return EventsApiResponse(
          events: const [],
          pagination: PaginationInfo(
            currentPage: page,
            totalPages: 0,
            totalItems: 0,
            itemsPerPage: 20,
          ),
        );
      }

      final ApiResponse apiResponse = ApiResponseMapper.fromMap(responseData);

      if (apiResponse.data == null ||
          apiResponse.data is! Map<String, dynamic>) {
        return EventsApiResponse(
          events: const [],
          pagination: PaginationInfo(
            currentPage: page,
            totalPages: 0,
            totalItems: 0,
            itemsPerPage: 20,
          ),
        );
      }

      final dynamic eventsList = apiResponse.data['events'];
      final dynamic paginationData = apiResponse.data['pagination'];

      final List<EventInfoItemModel> events = <EventInfoItemModel>[];
      if (eventsList is List) {
        events.addAll(
          eventsList.whereType<Map<String, dynamic>>().map((
            Map<String, dynamic> json,
          ) {
            return EventInfoItemModelMapper.fromMap(json);
          }),
        );
      }

      PaginationInfo pagination = PaginationInfo(
        currentPage: page,
        totalPages: 0,
        totalItems: 0,
        itemsPerPage: 20,
      );

      if (paginationData is Map<String, dynamic>) {
        pagination = PaginationInfo(
          currentPage: paginationData['currentPage'] as int? ?? page,
          totalPages: paginationData['totalPages'] as int? ?? 0,
          totalItems: paginationData['totalItems'] as int? ?? 0,
          itemsPerPage: paginationData['itemsPerPage'] as int? ?? 20,
        );
      }

      return EventsApiResponse(events: events, pagination: pagination);
    } catch (e) {
      rethrow;
    }
  }

  String _extractError(dynamic e) {
    if (e is DioException) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        final message = data['message'];

        if (message is String) {
          return message;
        }

        return e.message ?? 'Something went wrong';
      }

      return e.message ?? 'Something went wrong';
    }

    return 'Something went wrong';
  }
}
