import 'package:dio/dio.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/community/domain/models/missing_pet_report_payload_model.dart';

class MissingPetApiService {
  const MissingPetApiService(this._dio);

  final Dio _dio;
  // All the Api Repository Related to Missing Pets
  ///////////////////////

  /// @param page: Current page number (1-indexed)
  /// @param search: Search query for title/description
  Future<Map<String, dynamic>> getMyMissingPets({
    required int page,
    String? search,
    Map<String, dynamic>? filters,
    int pageSize = 20,
  }) async {
    try {
      final Map<String, dynamic> queryParams = <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
      };

      if (filters != null && filters.isNotEmpty) {
        final updatedFilters = Map<String, dynamic>.from(filters);

        // for petId filter, we need to ensure it's passed as is without modification
        if (updatedFilters.containsKey('petId')) {
          final value = updatedFilters['petId']?.toString().trim();
          // remove original key
          updatedFilters.remove('petId');
          if (value != null &&
              value.isNotEmpty &&
              value.toLowerCase() != 'all') {
            updatedFilters['pet_id'] = value;
          }
        }

        queryParams.addAll(updatedFilters);
      }

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final Response<dynamic> response = await _dio.get<dynamic>(
        'missing-pooch/user/my-reports',
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

  /// @param page: Current page number (1-indexed)
  /// @param search: Search query for title/description
  Future<Map<String, dynamic>> getAllMissingPets({
    required int page,
    String? search,
    Map<String, dynamic>? filters,
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

      if (filters != null && filters.isNotEmpty) {
        final updatedFilters = Map<String, dynamic>.from(filters);
        if (updatedFilters.containsKey('petType')) {
          final value = updatedFilters['petType']?.toString().trim();
          // remove original key
          updatedFilters.remove('petType');
          if (value != null &&
              value.isNotEmpty &&
              value.toLowerCase() != 'all') {
            updatedFilters['pet_type'] = value;
          }
        }
        if (updatedFilters.containsKey('petGender')) {
          final value = updatedFilters['petGender']?.toString().trim();
          // remove original key
          updatedFilters.remove('petGender');
          if (value != null &&
              value.isNotEmpty &&
              value.toLowerCase() != 'all') {
            updatedFilters['gender'] = value;
          }
        }
        queryParams.addAll(updatedFilters);
      }
      final Response<dynamic> response = await _dio.get<dynamic>(
        'missing-pooch/feed',
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

  Future<ApiResponse> reprortMissingPet({
    required MissingPetReportPayloadModel payload,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post(
        '/missing-pooch/create',
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

  Future<ApiResponse> updatedMissingPetReport({
    required String reportId,
    required MissingPetReportPayloadModel payload,
  }) async {
    try {
      final Response<dynamic> response = await _dio.put(
        '/missing-pooch/$reportId',
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

  /// Fetch missing report details by ID
  /// @param reportId: Filter by reportId ID (null for all categories)
  Future<Map<String, dynamic>> getMissingReportDetails({
    String? reportId,
  }) async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        '/missing-pooch/$reportId',
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

  /// Fetch missing report details by ID
  /// @param reportId: Filter by reportId ID (null for all categories)
  Future<Map<String, dynamic>> getMissingReportMatchSuggestions({
    String? reportId,
  }) async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        '/missing-pooch/$reportId/match-suggestions',
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

  Future<ApiResponse> reportMissingPetFound({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post(
        '/missing-pooch/found/report',
        data: payload,
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

  Future<ApiResponse> reUnitePooch({required String reportId}) async {
    try {
      final Response<dynamic> response = await _dio.patch(
        '/missing-pooch/$reportId/reunite',
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

  Future<ApiResponse> deleteReportPost({required String reportId}) async {
    try {
      final Response<dynamic> response = await _dio.delete(
        '/missing-pooch/$reportId',
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
}
