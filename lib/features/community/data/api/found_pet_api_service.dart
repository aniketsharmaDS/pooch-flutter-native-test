import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/community/domain/models/missing_pet_report_payload_model.dart';

class FoundPetApiService {
  const FoundPetApiService(this._dio);

  final Dio _dio;
  // All the Api Repository Related to Found Pets
  ///////////////////////

  /// @param page: Current page number (1-indexed)
  /// @param search: Search query for title/description
  Future<Map<String, dynamic>> getMyFoundPets({
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
        // For petType filter, we need to convert the value to lowercase and replace spaces with underscores
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

      final Response<dynamic> response = await _dio.get<dynamic>(
        'my-community/found-pooch',
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
  Future<Map<String, dynamic>> getAllFoundPets({
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
        queryParams.addAll(updatedFilters);
      }
      log(
        'queryParams in MissingPetApiService getAllMissingPets: $queryParams filters: $filters',
      );
      final Response<dynamic> response = await _dio.get<dynamic>(
        'missing-pooch/found/reports',
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

  Future<ApiResponse> reportFoundPet({
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

  /// Fetch found report details by ID
  /// @param reportId: Filter by reportId ID (null for all categories)
  Future<Map<String, dynamic>> getFoundReportDetails({String? reportId}) async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        '/missing-pooch/found/reports/$reportId',
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
