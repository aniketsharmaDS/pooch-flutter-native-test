import 'package:dio/dio.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/community/domain/models/create_event_payload_model.dart';

class EventApiService {
  const EventApiService(this._dio);

  final Dio _dio;
  // All the Api Repository Related to Events
  ///////////////////////

  Future<ApiResponse> createEvent({
    required CreateEventPayloadModel payload,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post(
        '/events/create',
        data: payload.toJson(),
        options: Options(
          validateStatus: (status) => true, // 👈 IMPORTANT
        ),
      );
      final responseData = response.data;
      if (responseData == null || responseData is! Map<String, dynamic>) {
        return const ApiResponse(message: 'Invalid response from server');
      }
      return ApiResponseMapper.fromMap(responseData);
    } catch (e) {
      return ApiResponse(message: e.toString());
    }
  }

  Future<ApiResponse> updateEvent({
    required CreateEventPayloadModel payload,
  }) async {
    try {
      final Response<dynamic> response = await _dio.put(
        '/events/${payload.eventId}',
        data: payload.toJson(),
        options: Options(
          validateStatus: (status) => true, // 👈 IMPORTANT
        ),
      );
      final responseData = response.data;
      if (responseData == null || responseData is! Map<String, dynamic>) {
        return const ApiResponse(message: 'Invalid response from server');
      }
      return ApiResponseMapper.fromMap(responseData);
    } catch (e) {
      return ApiResponse(message: e.toString());
    }
  }

  Future<ApiResponse> deleteEvent({required String eventId}) async {
    try {
      final Response<dynamic> response = await _dio.delete(
        '/events/$eventId',
        options: Options(
          validateStatus: (status) => true, // 👈 IMPORTANT
        ),
      );

      final responseData = response.data;

      if (responseData == null || responseData is! Map<String, dynamic>) {
        return const ApiResponse(message: 'Invalid response from server');
      }

      return ApiResponseMapper.fromMap(responseData);
    } catch (e) {
      return ApiResponse(message: e.toString());
    }
  }

  Future<ApiResponse> reportEvent({
    required String eventId,
    required String reason,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post(
        '/events/report',
        data: {'reason': reason, 'event_id': eventId},
        options: Options(
          validateStatus: (status) => true, // 👈 IMPORTANT
        ),
      );

      final responseData = response.data;

      if (responseData == null || responseData is! Map<String, dynamic>) {
        return const ApiResponse(message: 'Invalid response from server');
      }

      return ApiResponseMapper.fromMap(responseData);
    } catch (e) {
      return ApiResponse(message: e.toString());
    }
  }

  /// Fetch tips/guides with pagination, search, and category filtering
  /// @param page: Current page number (1-indexed)
  /// @param search: Search query for title/description
  /// @param categoryId: Filter by category ID (null for all categories)
  /// @param upcoming: Filter by upcoming events (null for all events)
  Future<Map<String, dynamic>> getMyEventsFeed({
    required int page,
    String? search,
    String? categoryId,
    bool? upcoming,
    int pageSize = 20,
  }) async {
    try {
      final Map<String, dynamic> queryParams = <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
      };

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      if (categoryId != null && categoryId.isNotEmpty) {
        queryParams['category_id'] = categoryId;
      }

      if (upcoming != null) {
        queryParams['upcoming'] = upcoming;
      }

      final Response<dynamic> response = await _dio.get<dynamic>(
        '/my-community/events',
        queryParameters: queryParams,
      );
      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        return data;
      }
      return <String, dynamic>{};
    } catch (e) {
      rethrow;
    }
  }

  /// Fetch tips/guides with pagination, search, and category filtering
  /// @param page: Current page number (1-indexed)
  /// @param search: Search query for title/description
  /// @param categoryId: Filter by category ID (null for all categories)
  /// @param upcoming: Filter by upcoming events (null for all events)
  Future<Map<String, dynamic>> getAllEventsFeed({
    required int page,
    String? search,
    String? categoryId,
    bool? upcoming,
    int pageSize = 20,
  }) async {
    try {
      final Map<String, dynamic> queryParams = <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
      };

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      if (categoryId != null && categoryId.isNotEmpty) {
        queryParams['category_id'] = categoryId;
      }

      if (upcoming != null) {
        queryParams['upcoming'] = upcoming;
      }

      final Response<dynamic> response = await _dio.get<dynamic>(
        '/events/feed',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        return data;
      }

      return <String, dynamic>{};
    } catch (e) {
      rethrow;
    }
  }

  ///  toggle event Like
  /// @param eventId: event ID to like/unlike
  /// @param isLiked: to toggle like/unlike (true for like, false for unlike)
  Future<Map<String, dynamic>> toggleEventLike({
    String? eventId,
    bool? isLiked,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        '/events/$eventId/like',
        data: <String, dynamic>{'action': isLiked == true ? 'LIKE' : 'UNLIKE'},
      );

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        return data;
      }

      return <String, dynamic>{};
    } catch (e) {
      rethrow;
    }
  }

  /// confirm Event Attendee
  /// @param eventId: event ID fo confirm the attendee
  Future<Map<String, dynamic>> confirmAttendee({String? eventId}) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        '/events/rsvp',
        data: <String, dynamic>{'event_id': eventId},
      );

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        return data;
      }
      return <String, dynamic>{};
    } catch (e) {
      rethrow;
    }
  }

  /// drop from the Event
  /// @param eventId: event ID fo confirm the attendee
  Future<Map<String, dynamic>> dropFromTheEvent({String? eventId}) async {
    try {
      final Response<dynamic> response = await _dio.delete<dynamic>(
        '/events/$eventId/rsvp',
      );

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        return data;
      }
      return <String, dynamic>{};
    } catch (e) {
      rethrow;
    }
  }

  /// Fetch event details by ID
  /// @param eventId: Filter by eventId ID (null for all categories)
  Future<Map<String, dynamic>> getEventDetails({String? eventId}) async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        '/events/$eventId',
      );
      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        return data;
      }
      return <String, dynamic>{};
    } catch (e) {
      rethrow;
    }
  }
}
