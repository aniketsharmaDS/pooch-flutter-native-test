import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/community/data/api/tips_and_guide_api_service.dart';
import 'package:poochcare/features/community/data/models/paginated_info.dart';
import 'package:poochcare/features/community/data/models/tips_api_response.dart';
import 'package:poochcare/features/community/data/models/tips_comment_api_response.dart';
import 'package:poochcare/features/community/data/models/tips_comment_info_model.dart';
import 'package:poochcare/features/community/data/models/tips_info_item_model.dart';

class TipsAndGuideRepository {
  const TipsAndGuideRepository(this._api);
  final TipsAndGuideApiService _api;

  ///////////////////////
  // All the Api Repository Related to Tips and Guides
  ///////////////////////
  ///

  /// Create a new tip/guide
  Future<ApiResponse> createTip({
    required String categoryId,
    required String title,
    required String description,
    required bool isDraft,
    List<dynamic>? attachmentUrls,
  }) async {
    try {
      final ApiResponse apiResponse = await _api.createTip(
        categoryId: categoryId,
        title: title,
        description: description,
        isDraft: isDraft,
        attachmentUrls: attachmentUrls,
      );

      log(
        'Create tip API => success=${apiResponse.success}, message=${apiResponse.message}, data=${apiResponse.data}',
      );

      // ✅ Just return response as-is (NO throwing)
      return apiResponse;
    } catch (e) {
      log('Create tip exception: $e');

      // ❌ Convert exception into ApiResponse instead of throwing
      return ApiResponse(
        // success: false,
        message: _extractError(e),
      );
    }
  }

  /// Create a new tip/guide
  Future<ApiResponse> updateTip({
    required String tipId,
    required String categoryId,
    required String title,
    required String description,
    required bool isDraft,
    List<dynamic>? attachmentUrls,
  }) async {
    try {
      final ApiResponse apiResponse = await _api.updateTip(
        tipId: tipId,
        categoryId: categoryId,
        title: title,
        description: description,
        isDraft: isDraft,
        attachmentUrls: attachmentUrls,
      );

      log(
        'Create tip API => success=${apiResponse.success}, message=${apiResponse.message}, data=${apiResponse.data}',
      );

      // ✅ Just return response as-is (NO throwing)
      return apiResponse;
    } catch (e) {
      log('Create tip exception: $e');

      // ❌ Convert exception into ApiResponse instead of throwing
      return ApiResponse(
        // success: false,
        message: _extractError(e),
      );
    }
  }

  /// delete a tip/guide
  Future<ApiResponse> deleteTip({required String tipId}) async {
    try {
      final ApiResponse apiResponse = await _api.deleteTip(tipId: tipId);

      log(
        'delete tip API => success=${apiResponse.success}, message=${apiResponse.message}, data=${apiResponse.data}',
      );

      // ✅ Just return response as-is (NO throwing)
      return apiResponse;
    } catch (e) {
      log('delete tip exception: $e');

      // ❌ Convert exception into ApiResponse instead of throwing
      return ApiResponse(
        // success: false,
        message: _extractError(e),
      );
    }
  }

  /// delete a tip/guide
  Future<ApiResponse> reportTip({
    required String tipId,
    required String reason,
  }) async {
    try {
      final ApiResponse apiResponse = await _api.reportTip(
        tipId: tipId,
        reason: reason,
      );

      log(
        'delete tip API => success=${apiResponse.success}, message=${apiResponse.message}, data=${apiResponse.data}',
      );

      // ✅ Just return response as-is (NO throwing)
      return apiResponse;
    } catch (e) {
      log('delete tip exception: $e');

      // ❌ Convert exception into ApiResponse instead of throwing
      return ApiResponse(
        // success: false,
        message: _extractError(e),
      );
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

  /// Fetch my tips and guides with pagination, search, and category filtering
  Future<TipsApiResponse> fetchMyTipsAndGuides({
    required int page,
    String? search,
    String? categoryId,
  }) async {
    try {
      final Map<String, dynamic> responseData = await _api.getMyTipsAndGuides(
        page: page,
        search: search,
        categoryId: categoryId,
      );

      if (responseData.isEmpty) {
        return TipsApiResponse(
          tips: const [],
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
        return TipsApiResponse(
          tips: const [],
          pagination: PaginationInfo(
            currentPage: page,
            totalPages: 0,
            totalItems: 0,
            itemsPerPage: 20,
          ),
        );
      }

      final dynamic tipsList = apiResponse.data['tips'];
      final dynamic paginationData = apiResponse.data['pagination'];

      final List<TipsInfoItemModel> tips = <TipsInfoItemModel>[];
      if (tipsList is List) {
        tips.addAll(
          tipsList.whereType<Map<String, dynamic>>().map((
            Map<String, dynamic> json,
          ) {
            return TipsInfoItemModelMapper.fromMap(json);
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

      return TipsApiResponse(tips: tips, pagination: pagination);
    } catch (e) {
      rethrow;
    }
  }

  /// Fetch all tips and guides with pagination, search, and category filtering
  Future<TipsApiResponse> fetchAllTipsAndGuides({
    required int page,
    String? search,
    String? categoryId,
  }) async {
    try {
      final Map<String, dynamic> responseData = await _api.getAllTipsAndGuides(
        page: page,
        search: search,
        categoryId: categoryId,
      );

      if (responseData.isEmpty) {
        return TipsApiResponse(
          tips: const [],
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
        return TipsApiResponse(
          tips: const [],
          pagination: PaginationInfo(
            currentPage: page,
            totalPages: 0,
            totalItems: 0,
            itemsPerPage: 20,
          ),
        );
      }

      final dynamic tipsList = apiResponse.data['tips'];
      final dynamic paginationData = apiResponse.data['pagination'];

      final List<TipsInfoItemModel> tips = <TipsInfoItemModel>[];
      if (tipsList is List) {
        tips.addAll(
          tipsList.whereType<Map<String, dynamic>>().map((
            Map<String, dynamic> json,
          ) {
            return TipsInfoItemModelMapper.fromMap(json);
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

      return TipsApiResponse(tips: tips, pagination: pagination);
    } catch (e) {
      rethrow;
    }
  }

  /// toggle like/unlike for an tip
  Future<ApiResponse> toggleTipsLike({String? tipsId, bool? isLiked}) async {
    try {
      final Map<String, dynamic> responseData = await _api.toggleTipsLike(
        tipsId: tipsId,
        isLiked: isLiked,
      );

      log('Response from toggleTipsLike API: $responseData');
      if (responseData.isEmpty) {
        return const ApiResponse(message: 'Something went wrong');
      }
      return ApiResponseMapper.fromMap(responseData);
    } catch (e) {
      return ApiResponse(message: e.toString());
    }
  }

  /// Fetch tips with pagination, search, and category filtering
  Future<TipsInfoItemModel?> gettipsDetails({required String tipsId}) async {
    try {
      final Map<String, dynamic> responseData = await _api.getTipsDetails(
        tipsId: tipsId,
      );

      if (responseData.isEmpty) {
        return null;
      }

      final ApiResponse apiResponse = ApiResponseMapper.fromMap(responseData);

      if (apiResponse.data == null ||
          apiResponse.data is! Map<String, dynamic>) {
        return null;
      }

      /// ✅ YOUR API STRUCTURE: data = FULL TIP OBJECT
      final Map<String, dynamic> tipJson =
          apiResponse.data as Map<String, dynamic>;

      /// ✅ Convert directly to model
      final tip = TipsInfoItemModelMapper.fromMap(tipJson);

      return tip;
    } catch (e) {
      rethrow;
    }
  }

  //  Api reltated to All Tips Comment
  /// Fetch all the tips Comment
  Future<TipsCommentApiResponse> fethAllTipComments({
    required int page,
    String? search,
    Map<String, dynamic>? filter,
  }) async {
    try {
      final Map<String, dynamic> responseData = await _api.fethAllTipComments(
        page: page,
        search: search,
        filter: filter,
      );

      if (responseData.isEmpty) {
        return TipsCommentApiResponse(
          comments: const [],
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
        return TipsCommentApiResponse(
          comments: const [],
          pagination: PaginationInfo(
            currentPage: page,
            totalPages: 0,
            totalItems: 0,
            itemsPerPage: 20,
          ),
        );
      }

      final dynamic tipsList = apiResponse.data['comments'];
      final dynamic paginationData = apiResponse.data['pagination'];

      final List<TipsCommentInfoModel> comments = <TipsCommentInfoModel>[];
      if (tipsList is List) {
        comments.addAll(
          tipsList.whereType<Map<String, dynamic>>().map((
            Map<String, dynamic> json,
          ) {
            return TipsCommentInfoModelMapper.fromMap(json);
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

      return TipsCommentApiResponse(comments: comments, pagination: pagination);
    } catch (e) {
      rethrow;
    }
  }

  /// Create a new comment for a tip
  Future<ApiResponse> createTipComment({
    required String tipId,
    required String message,
    String? parentCommentId,
  }) async {
    try {
      final ApiResponse apiResponse = await _api.createTipComment(
        tipId: tipId,
        message: message,
        parentCommentId: parentCommentId,
      );

      log(
        'Create tip API => success=${apiResponse.success}, message=${apiResponse.message}, data=${apiResponse.data}',
      );

      // ✅ Just return response as-is (NO throwing)
      return apiResponse;
    } catch (e) {
      log('Create tip exception: $e');

      // ❌ Convert exception into ApiResponse instead of throwing
      return ApiResponse(
        // success: false,
        message: _extractError(e),
      );
    }
  }

  /// delete a comment for a tip
  Future<ApiResponse> deleteTipComment({required String commentId}) async {
    try {
      final ApiResponse apiResponse = await _api.deleteTipComment(
        commentId: commentId,
      );

      log(
        'delete tip API => success=${apiResponse.success}, message=${apiResponse.message}, data=${apiResponse.data}',
      );

      // ✅ Just return response as-is (NO throwing)
      return apiResponse;
    } catch (e) {
      log('delete tip exception: $e');

      // ❌ Convert exception into ApiResponse instead of throwing
      return ApiResponse(
        // success: false,
        message: _extractError(e),
      );
    }
  }

  //  Api reltated to All Tips Comment
  /// Fetch all the tips Comment
  Future<TipsRepliesApiResponse> fetchCommentReplies({
    required String commentId,
    required int page,
  }) async {
    try {
      final Map<String, dynamic> responseData = await _api.fetchCommentReplies(
        commentId: commentId,
        page: page,
      );

      if (responseData.isEmpty) {
        return TipsRepliesApiResponse(
          replies: const [],
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
        return TipsRepliesApiResponse(
          replies: const [],
          pagination: PaginationInfo(
            currentPage: page,
            totalPages: 0,
            totalItems: 0,
            itemsPerPage: 20,
          ),
        );
      }

      final dynamic repliesList = apiResponse.data['replies'];
      final dynamic paginationData = apiResponse.data['pagination'];

      final List<TipsCommentInfoModel> replies = <TipsCommentInfoModel>[];
      if (repliesList is List) {
        replies.addAll(
          repliesList.whereType<Map<String, dynamic>>().map((
            Map<String, dynamic> json,
          ) {
            return TipsCommentInfoModelMapper.fromMap(json);
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

      return TipsRepliesApiResponse(replies: replies, pagination: pagination);
    } catch (e) {
      rethrow;
    }
  }
}
