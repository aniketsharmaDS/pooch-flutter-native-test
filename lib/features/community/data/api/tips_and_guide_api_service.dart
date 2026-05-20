import 'package:dio/dio.dart';
import 'package:poochcare/core/network/api_response.dart';

class TipsAndGuideApiService {
  const TipsAndGuideApiService(this._dio);

  final Dio _dio;
  ///////////////////////
  // All the Api Repository Related to Tips and Guides
  ///////////////////////

  Future<ApiResponse> createTip({
    required String categoryId,
    required String title,
    required String description,
    required bool isDraft,
    List<dynamic>? attachmentUrls,
  }) async {
    try {
      final data = {
        'category_id': categoryId,
        'title': title,
        'description': description,
        'is_draft': isDraft,
        if (attachmentUrls != null && attachmentUrls.isNotEmpty)
          'attachment_urls': attachmentUrls,
      };

      final Response<dynamic> response = await _dio.post(
        '/community-tips/create',
        data: data,
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

  Future<ApiResponse> updateTip({
    required String tipId,
    required String categoryId,
    required String title,
    required String description,
    required bool isDraft,
    List<dynamic>? attachmentUrls,
  }) async {
    try {
      final data = {
        'category_id': categoryId,
        'title': title,
        'description': description,
        'is_draft': isDraft,
        if (attachmentUrls != null && attachmentUrls.isNotEmpty)
          'attachment_urls': attachmentUrls,
      };

      final Response<dynamic> response = await _dio.put(
        '/community-tips/$tipId',
        data: data,
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

  Future<ApiResponse> deleteTip({required String tipId}) async {
    try {
      final Response<dynamic> response = await _dio.delete(
        '/community-tips/$tipId',
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

  Future<ApiResponse> reportTip({
    required String tipId,
    required String reason,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post(
        '/community-tips/report',
        data: <String, dynamic>{'tip_id': tipId, 'reason': reason},
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
  Future<Map<String, dynamic>> getMyTipsAndGuides({
    required int page,
    String? search,
    String? categoryId,
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

      final Response<dynamic> response = await _dio.get<dynamic>(
        '/community-tips/user/my-tips',
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
  Future<Map<String, dynamic>> getAllTipsAndGuides({
    required int page,
    String? search,
    String? categoryId,
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

      final Response<dynamic> response = await _dio.get<dynamic>(
        '/community-tips/feed',
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

  ///  toggle tip Like
  /// @param tipsId: tip ID to like/unlike
  /// @param isLiked: to toggle like/unlike (true for like, false for unlike)
  Future<Map<String, dynamic>> toggleTipsLike({
    String? tipsId,
    bool? isLiked,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        '/community-tips/$tipsId/like',
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

  /// Fetch tip details by ID
  /// @param tipsId: Filter by tipsId ID (null for all categories)
  Future<Map<String, dynamic>> getTipsDetails({String? tipsId}) async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        '/community-tips/$tipsId',
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
  Future<Map<String, dynamic>> fethAllTipComments({
    required int page,
    String? search,
    Map<String, dynamic>? filter,
    int pageSize = 20,
  }) async {
    try {
      final Map<String, dynamic> queryParams = <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
        if (search != null && search.isNotEmpty) 'search': search,
      };

      final apiFilters = Map<String, dynamic>.from(filter ?? {});

      // ✅ Extract and remove tipId from filter
      final dynamic rawTipId = apiFilters.remove('tipId');
      final String? tipId = (rawTipId is String && rawTipId.isNotEmpty)
          ? rawTipId
          : rawTipId?.toString();

      final Response<dynamic> response = await _dio.get<dynamic>(
        '/community-tips/$tipId/comments',
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

  Future<ApiResponse> createTipComment({
    required String tipId,
    required String message,
    String? parentCommentId,
  }) async {
    try {
      final data = {
        'tip_id': tipId,
        'comment': message,
        if (parentCommentId != null && parentCommentId.isNotEmpty)
          'parent_comment_id': parentCommentId,
      };

      final Response<dynamic> response = await _dio.post(
        '/community-tips/comments',
        data: data,
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

  Future<ApiResponse> deleteTipComment({required String commentId}) async {
    try {
      final Response<dynamic> response = await _dio.delete(
        '/community-tips/comments/$commentId',
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

  Future<ApiResponse> getReplies({required String commentId}) async {
    try {
      final Response<dynamic> response = await _dio.get(
        '/community-tips/comments/$commentId/replies',
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

  Future<Map<String, dynamic>> fetchCommentReplies({
    required int page,
    required String commentId,
    int pageSize = 20,
  }) async {
    try {
      final Map<String, dynamic> queryParams = <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
      };

      final Response<dynamic> response = await _dio.get<dynamic>(
        '/community-tips/comments/$commentId/replies',
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
}
