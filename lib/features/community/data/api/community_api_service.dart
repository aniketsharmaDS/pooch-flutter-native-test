import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:poochcare/core/network/api_response.dart';

class CommunityApiService {
  const CommunityApiService(this._dio);

  final Dio _dio;

  ///////////////////////
  // All the Api Repository Related my Posts in review and Live
  ///////////////////////
  /// Fetch My Under Review Posts (Tips/Events) with pagination and search
  /// @param page: Current page number (1-indexed)
  /// @param type: "live", "under_review", "draft" for tips-guides/events
  /// @param search: Search query for title/description
  Future<Map<String, dynamic>> myAllPosts({
    required int page,
    String? search,
    String? type = 'live', // "live" or "under_review"
    int pageSize = 20,
  }) async {
    try {
      log('MyLivePostsBloc filters in type  Service fetchPage: $type');
      final Map<String, dynamic> queryParams = <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
      };

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      String endpoint = '/my-community/live';
      if (type == 'under_review') {
        endpoint = '/my-community/under-review';
      }

      final Response<dynamic> response = await _dio.get<dynamic>(
        endpoint,
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

  ///////////////////////
  // All Api's related to Categoreis and for its data.
  ///////////////////////
  Future<ApiResponse> getAllTipsCategories() async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        '/community-tips/categories',
      );

      if (response.data is Map<String, dynamic>) {
        return ApiResponseMapper.fromMap(response.data as Map<String, dynamic>);
      }

      return const ApiResponse(
        // success: false,
        message: 'Invalid response format',
      );
    } catch (e) {
      return ApiResponse(
        // success: false,
        message: e.toString(),
      );
    }
  }

  /// Fetch tips/guides with pagination, search, and category filtering
  /// @param page: Current page number (1-indexed)
  /// @param search: Search query for title/description
  /// @param categoryId: Filter by category ID (null for all categories)
  /// @param upcoming: Filter by upcoming events (null for all events)
  Future<Map<String, dynamic>> getCountryPetShelter({
    required int page,
    String? search,
    double? latitude,
    double? longitude,
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

      if (latitude != null) {
        queryParams['latitude'] = latitude;
      }

      if (longitude != null) {
        queryParams['longitude'] = longitude;
      }

      final Response<dynamic> response = await _dio.get<dynamic>(
        '/pet-shelters/by-country',
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
  Future<ApiResponse> getShareLink({
    required String contentId,
    required String contentType,
  }) async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        '/share/$contentType/$contentId',
      );
      if (response.data is Map<String, dynamic>) {
        return ApiResponseMapper.fromMap(response.data as Map<String, dynamic>);
      }

      return const ApiResponse(message: 'Invalid response format');
    } catch (e) {
      return ApiResponse(message: e.toString());
    }
  }
}
