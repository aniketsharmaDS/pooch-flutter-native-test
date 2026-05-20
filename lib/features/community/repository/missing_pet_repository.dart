import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/community/data/api/missing_pet_api_service.dart';
import 'package:poochcare/features/community/data/models/missing_pet_api_response.dart';
import 'package:poochcare/features/community/data/models/missing_pet_model.dart';
import 'package:poochcare/features/community/data/models/paginated_info.dart';
import 'package:poochcare/features/community/data/models/pooch_missing_match_status_model.dart';
import 'package:poochcare/features/community/domain/models/missing_pet_report_payload_model.dart';

class MissingPetRepository {
  const MissingPetRepository(this._api);
  final MissingPetApiService _api;

  ///////////////////////
  // All the Api Repository Related to Missing Pets
  ///////////////////////

  /// Fetch missing pets with pagination and search
  Future<MissingPetApiResponse> getMyMissingPets({
    required int page,
    String? search,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final Map<String, dynamic> responseData = await _api.getMyMissingPets(
        page: page,
        search: search,
        filters: filters,
      );

      if (responseData.isEmpty) {
        return MissingPetApiResponse(
          missingPets: const [],
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
        return MissingPetApiResponse(
          missingPets: const [],
          pagination: PaginationInfo(
            currentPage: page,
            totalPages: 0,
            totalItems: 0,
            itemsPerPage: 20,
          ),
        );
      }

      final dynamic reports = apiResponse.data['reports'];
      final dynamic paginationData = apiResponse.data['pagination'];

      log(
        'getMyMissingPets response - page: $page, search: $search, reports length: ${reports is List ? reports.length : 'N/A'}, paginationData: $paginationData',
      );

      final List<MissingPetModel> missingPets = <MissingPetModel>[];
      if (reports is List) {
        missingPets.addAll(
          reports.whereType<Map<String, dynamic>>().map((
            Map<String, dynamic> json,
          ) {
            return MissingPetModelMapper.fromMap(json);
          }),
        );
      }

      log(
        'getMyMissingPets response - mapped missingPets length: ${missingPets.length}',
      );

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

      return MissingPetApiResponse(
        missingPets: missingPets,
        pagination: pagination,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<MissingPetApiResponse> getAllMissingPets({
    required int page,
    String? search,
    Map<String, dynamic>? filters,
  }) async {
    log('filters: ${filters?.toString()}');
    try {
      final Map<String, dynamic> responseData = await _api.getAllMissingPets(
        page: page,
        search: search,
        filters: filters,
      );

      if (responseData.isEmpty) {
        return MissingPetApiResponse(
          missingPets: const [],
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
        return MissingPetApiResponse(
          missingPets: const [],
          pagination: PaginationInfo(
            currentPage: page,
            totalPages: 0,
            totalItems: 0,
            itemsPerPage: 20,
          ),
        );
      }

      final dynamic reports = apiResponse.data['reports'];
      final dynamic paginationData = apiResponse.data['pagination'];
      // log('paginationData 1->$paginationData');
      log('paginationData 1->$reports.length');

      final List<MissingPetModel> missingPets = <MissingPetModel>[];
      int failedCount = 0;
      int successCount = 0;
      if (reports is List) {
        for (int i = 0; i < reports.length; i++) {
          final item = reports[i];

          if (item is Map<String, dynamic>) {
            try {
              final parsed = MissingPetModelMapper.fromMap(item);
              missingPets.add(parsed);
              successCount++;
            } catch (e) {
              failedCount++;
              log('❌ Parsing failed at index: $i');
              log('❌ Error: $e');
              log('❌ Data: $item.toString()');

              _debugJsonMismatch(item); // 👈 key-level debug
            }
          } else {
            log('⚠️ Skipped non-map item at index $i: $item');
          }
        }
      }

      PaginationInfo pagination = PaginationInfo(
        currentPage: page,
        totalPages: 0,
        totalItems: 0,
        itemsPerPage: 20,
      );
      log(
        'paginationData 1->$missingPets.length , failedCount: $failedCount, successCount: $successCount',
      );
      if (paginationData is Map<String, dynamic>) {
        pagination = PaginationInfo(
          currentPage: paginationData['currentPage'] as int? ?? page,
          totalPages: paginationData['totalPages'] as int? ?? 0,
          totalItems: paginationData['totalItems'] as int? ?? 0,
          itemsPerPage: paginationData['itemsPerPage'] as int? ?? 20,
        );
      }

      return MissingPetApiResponse(
        missingPets: missingPets,
        pagination: pagination,
      );
    } catch (e) {
      rethrow;
    }
  }

  void _debugJsonMismatch(Map<String, dynamic> json) {
    final expectedTypes = {
      'id': String,
      'name': String,
      'age': int,
      'isLost': bool,
      'createdAt': String,
      // 👆 add all your model fields here
    };

    for (final key in expectedTypes.keys) {
      if (!json.containsKey(key)) {
        log('🚫 Missing key: $key');
        continue;
      }

      final value = json[key];
      final expectedType = expectedTypes[key];

      if (value != null && value.runtimeType != expectedType) {
        log(
          '⚠️ Type mismatch on "$key": '
          'Expected $expectedType, got ${value.runtimeType} → value: $value',
        );
      }
    }

    // Extra keys check
    for (final key in json.keys) {
      if (!expectedTypes.containsKey(key)) {
        log('➕ Extra key from API: $key');
      }
    }
  }

  Future<ApiResponse> reprortMissingPet({
    required MissingPetReportPayloadModel payload,
  }) async {
    try {
      final ApiResponse apiResponse = await _api.reprortMissingPet(
        payload: payload,
      );

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

  Future<ApiResponse> updatedMissingPetReport({
    required String reportId,
    required MissingPetReportPayloadModel payload,
  }) async {
    try {
      final ApiResponse apiResponse = await _api.updatedMissingPetReport(
        reportId: reportId,
        payload: payload,
      );

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

  /// Fetch tips with pagination, search, and category filtering
  Future<MissingPetModel?> getMissingReportDetails({
    required String reportId,
  }) async {
    try {
      final Map<String, dynamic> responseData = await _api
          .getMissingReportDetails(reportId: reportId);

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
      final event = MissingPetModelMapper.fromMap(eventJson);

      return event;
    } catch (e) {
      rethrow;
    }
  }

  /// Fetch tips with pagination, search, and category filtering
  Future<PoochMissingMatchStatusModel?> getMissingReportMatchSuggestions({
    required String reportId,
  }) async {
    try {
      final Map<String, dynamic> responseData = await _api
          .getMissingReportMatchSuggestions(reportId: reportId);

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
      final result = PoochMissingMatchStatusModelMapper.fromMap(eventJson);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> reportMissingPetFound({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final ApiResponse apiResponse = await _api.reportMissingPetFound(
        payload: payload,
      );

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

  Future<ApiResponse> reUnitePooch({required String reportId}) async {
    try {
      final ApiResponse apiResponse = await _api.reUnitePooch(
        reportId: reportId,
      );

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

  Future<ApiResponse> deleteReportPost({required String reportId}) async {
    try {
      final ApiResponse apiResponse = await _api.deleteReportPost(
        reportId: reportId,
      );

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
