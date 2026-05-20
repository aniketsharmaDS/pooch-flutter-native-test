import 'dart:developer';

import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/community/data/api/community_api_service.dart';
import 'package:poochcare/features/community/data/models/my_posts_api_response.dart';
import 'package:poochcare/features/community/data/models/my_submitted_posts_model.dart';
import 'package:poochcare/features/community/data/models/paginated_info.dart';
import 'package:poochcare/features/community/data/models/pet_shelter_api_response.dart';
import 'package:poochcare/features/community/data/models/pet_shelter_model.dart';
import 'package:poochcare/features/community/data/models/tips_category_model.dart';

class CommunityRepository {
  const CommunityRepository(this._api);
  final CommunityApiService _api;

  ///////////////////////
  // All the Api Repository Related my Posts in review and Live
  ///////////////////////

  /// Fetch My Under Review Events and tips
  Future<MyPostsApiResponse> myAllPosts({
    required int page,
    String? search,
    String? type, // "tips" or "events"
  }) async {
    try {
      log('MyLivePostsBloc filters in Repository fetchPage: $type');
      final Map<String, dynamic> responseData = await _api.myAllPosts(
        page: page,
        search: search,
        type: type,
      );

      if (responseData.isEmpty) {
        return MyPostsApiResponse(
          posts: const [],
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
        return MyPostsApiResponse(
          posts: const [],
          pagination: PaginationInfo(
            currentPage: page,
            totalPages: 0,
            totalItems: 0,
            itemsPerPage: 20,
          ),
        );
      }

      final dynamic responseList = apiResponse.data['posts'];
      final dynamic paginationData = apiResponse.data['pagination'];

      final List<MySubmittedPostsModel> postsList = <MySubmittedPostsModel>[];
      if (responseList is List) {
        postsList.addAll(
          responseList.whereType<Map<String, dynamic>>().map((
            Map<String, dynamic> json,
          ) {
            return MySubmittedPostsModelMapper.fromMap(json);
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
      log('MyLivePostsBloc filters in Repository postsList: $postsList.length');
      return MyPostsApiResponse(posts: postsList, pagination: pagination);
    } catch (e) {
      log('MyLivePostsBloc filters in Repository Catch: $type');
      rethrow;
    }
  }

  ///////////////////////
  // All the Api Repository Related to Category
  ///////////////////////

  Future<List<TipsCategoryModel>> getTipsCategories() async {
    try {
      final ApiResponse apiResponse = await _api.getAllTipsCategories();
      // ✅ Handle API failure
      if (!apiResponse.success) {
        throw Exception(apiResponse.message);
      }
      // ✅ Ensure correct type
      if (apiResponse.data is! List) {
        return const [];
      }
      final List data = apiResponse.data as List;

      return data
          .whereType<Map<String, dynamic>>() // filters valid maps only
          .map((e) => TipsCategoryModelMapper.fromMap(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Fetch tips with pagination, search, and category filtering
  Future<PetShelterApiResponse> fetchAllShelters({
    required int page,
    String? search,
    double? latitude,
    double? longitude,
  }) async {
    try {
      final Map<String, dynamic> responseData = await _api.getCountryPetShelter(
        page: page,
        search: search,
        latitude: latitude,
        longitude: longitude,
      );

      if (responseData.isEmpty) {
        return PetShelterApiResponse(
          shelters: const [],
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
        return PetShelterApiResponse(
          shelters: const [],
          pagination: PaginationInfo(
            currentPage: page,
            totalPages: 0,
            totalItems: 0,
            itemsPerPage: 20,
          ),
        );
      }

      final dynamic sheltersList = apiResponse.data['shelters'];
      final dynamic paginationData = apiResponse.data['pagination'];

      final List<PetShelterModel> shelters = <PetShelterModel>[];
      if (sheltersList is List) {
        shelters.addAll(
          sheltersList.whereType<Map<String, dynamic>>().map((
            Map<String, dynamic> json,
          ) {
            return PetShelterModelMapper.fromMap(json);
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

      return PetShelterApiResponse(shelters: shelters, pagination: pagination);
    } catch (e) {
      rethrow;
    }
  }
}
