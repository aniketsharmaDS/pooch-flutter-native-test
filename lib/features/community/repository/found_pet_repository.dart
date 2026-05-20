import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/community/data/api/found_pet_api_service.dart';
import 'package:poochcare/features/community/data/models/found_pet_api_response.dart';
import 'package:poochcare/features/community/data/models/found_pet_model.dart';
import 'package:poochcare/features/community/data/models/paginated_info.dart';

class FoundPetRepository {
  const FoundPetRepository(this._api);
  final FoundPetApiService _api;

  ///////////////////////
  // All the Api Repository Related to Found Pets
  ///////////////////////

  /// Fetch found pets with pagination and search
  Future<FoundPetApiResponse> getMyFoundPets({
    required int page,
    String? search,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final Map<String, dynamic> responseData = await _api.getMyFoundPets(
        page: page,
        search: search,
        filters: filters,
      );

      if (responseData.isEmpty) {
        return FoundPetApiResponse(
          foundPets: const [],
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
        return FoundPetApiResponse(
          foundPets: const [],
          pagination: PaginationInfo(
            currentPage: page,
            totalPages: 0,
            totalItems: 0,
            itemsPerPage: 20,
          ),
        );
      }

      final dynamic reports = apiResponse.data['foundReports'];
      final dynamic paginationData = apiResponse.data['pagination'];

      log(
        'getMyFoundPets response - page: $page, search: $search, reports length: ${reports is List ? reports.length : 'N/A'}, paginationData: $paginationData',
      );

      final List<FoundPetModel> foundPets = <FoundPetModel>[];
      if (reports is List) {
        foundPets.addAll(
          reports.whereType<Map<String, dynamic>>().map((
            Map<String, dynamic> json,
          ) {
            return FoundPetModelMapper.fromMap(json);
          }),
        );
      }

      log(
        'getMyFoundPets response - mapped foundPets length: ${foundPets.length}',
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

      return FoundPetApiResponse(foundPets: foundPets, pagination: pagination);
    } catch (e) {
      rethrow;
    }
  }

  Future<FoundPetApiResponse> getAllFoundPets({
    required int page,
    String? search,
    Map<String, dynamic>? filters,
  }) async {
    log('filters: ${filters?.toString()}');
    try {
      final Map<String, dynamic> responseData = await _api.getAllFoundPets(
        page: page,
        search: search,
        filters: filters,
      );

      if (responseData.isEmpty) {
        return FoundPetApiResponse(
          foundPets: const [],
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
        return FoundPetApiResponse(
          foundPets: const [],
          pagination: PaginationInfo(
            currentPage: page,
            totalPages: 0,
            totalItems: 0,
            itemsPerPage: 20,
          ),
        );
      }

      final dynamic reports = apiResponse.data['foundReports'];
      final dynamic paginationData = apiResponse.data['pagination'];
      // log('paginationData 1->$paginationData');
      log('paginationData 1->$reports.length');

      final List<FoundPetModel> foundPets = <FoundPetModel>[];
      int failedCount = 0;
      int successCount = 0;
      if (reports is List) {
        for (int i = 0; i < reports.length; i++) {
          final item = reports[i];

          if (item is Map<String, dynamic>) {
            try {
              final parsed = FoundPetModelMapper.fromMap(item);
              foundPets.add(parsed);
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
        'paginationData 1->$foundPets.length , failedCount: $failedCount, successCount: $successCount',
      );
      if (paginationData is Map<String, dynamic>) {
        pagination = PaginationInfo(
          currentPage: paginationData['currentPage'] as int? ?? page,
          totalPages: paginationData['totalPages'] as int? ?? 0,
          totalItems: paginationData['totalItems'] as int? ?? 0,
          itemsPerPage: paginationData['itemsPerPage'] as int? ?? 20,
        );
      }

      return FoundPetApiResponse(foundPets: foundPets, pagination: pagination);
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

  // ignore: unused_element
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

  /// Fetch tips with pagination, search, and category filtering
  Future<FoundPetModel?> getFoundReportDetails({
    required String reportId,
  }) async {
    try {
      final Map<String, dynamic> responseData = await _api
          .getFoundReportDetails(reportId: reportId);

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
      final event = FoundPetModelMapper.fromMap(eventJson);

      return event;
    } catch (e) {
      rethrow;
    }
  }
}
