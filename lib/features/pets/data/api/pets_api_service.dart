import 'package:dio/dio.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/pets/data/models/pet_insights_response.dart';
import 'package:poochcare/features/pets/data/models/pet_model.dart';
import 'package:poochcare/features/pets/domain/models/breed.dart';

class PetsApiService {
  const PetsApiService(this._dio);

  final Dio _dio;

  static const String _createPetPath = '/onboarding/pets';
  static const String _addPetToParentGroupBasePath = '/rbac-parent-groups';
  static const String _breedsPath = '/breeds';
  static const String _petInsightsPath = '/insights/pet-insights';

  Future<List<Breed>> getBreeds({
    required String petType,
    String languageCode = 'en',
  }) async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        _breedsPath,
        queryParameters: <String, dynamic>{'petType': petType},
      );

      final dynamic raw = response.data;
      if (raw is! Map<String, dynamic>) {
        return const <Breed>[];
      }

      final ApiResponse envelope = ApiResponseMapper.fromMap(raw);
      if (!envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to fetch breeds',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic data = envelope.data;
      if (data is! Map<String, dynamic>) {
        return const <Breed>[];
      }

      final dynamic breedsRaw = data['breeds'];
      if (breedsRaw is! List) {
        return const <Breed>[];
      }

      return breedsRaw
          .whereType<Map<String, dynamic>>()
          .map((e) => Breed.fromMap(e, languageCode: languageCode))
          .where((b) => b.id.isNotEmpty)
          .where((b) => b.petType.isEmpty || b.petType == petType)
          .toList(growable: false);
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<void> createPet(PetModel pet) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        _createPetPath,
        data: <String, dynamic>{
          'pets': <Map<String, dynamic>>[
            <String, dynamic>{
              'profilePicture': pet.profilePicture ?? '',
              'bcsScore': pet.bcsScore ?? '',
              'name': pet.name,
              'type': pet.type,
              'breedId': pet.breedId,
              'gender': pet.gender,
              'dob': pet.dob,
              'size': _mapPetSize(pet.size),
              'weight': pet.weight,
              'height': pet.height,
              'heightUnit': _mapHeightUnit(pet.heightUnit),
              'weightUnit': _mapWeightUnit(pet.weightUnit),
              'healthInfo': pet.healthInfo ?? '',
            },
          ],
        },
      );

      final dynamic body = response.data;
      if (body is Map<String, dynamic> && body.containsKey('success')) {
        final ApiResponse envelope = ApiResponseMapper.fromMap(body);
        if (!envelope.success) {
          throw ApiException(
            envelope.message.isNotEmpty
                ? envelope.message
                : 'Unable to create pet profile',
            code: 'API_ERROR',
            statusCode: envelope.status,
          );
        }
      }
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<void> addPetToParentGroup({
    required String parentGroupId,
    required PetModel pet,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        '$_addPetToParentGroupBasePath/$parentGroupId/pets',
        data: <String, dynamic>{
          'pets': <Map<String, dynamic>>[
            <String, dynamic>{
              'profilePicture': pet.profilePicture ?? '',
              'bcsScore': pet.bcsScore ?? 0,
              'name': pet.name,
              'type': pet.type,
              'breedId': pet.breedId,
              'gender': pet.gender,
              'dob': _toIsoDateOnly(pet.dob),
              'size': _mapPetSize(pet.size),
              'weight': pet.weight,
              'height': pet.height,
              'heightUnit': _mapHeightUnit(pet.heightUnit),
              'weightUnit': _mapWeightUnit(pet.weightUnit),
              'healthInfo': pet.healthInfo ?? '',
            },
          ],
        },
      );

      final dynamic body = response.data;
      if (body is Map<String, dynamic> && body.containsKey('success')) {
        final ApiResponse envelope = ApiResponseMapper.fromMap(body);
        if (!envelope.success) {
          throw ApiException(
            envelope.message.isNotEmpty
                ? envelope.message
                : 'Unable to add pet',
            code: 'API_ERROR',
            statusCode: envelope.status,
          );
        }
      }
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<PetInsightsResponse> getPetInsights({String? petId}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (petId != null && petId.isNotEmpty) {
        queryParams['petId'] = petId;
      }

      final Response<dynamic> response = await _dio.get<dynamic>(
        _petInsightsPath,
        queryParameters: queryParams,
      );

      final dynamic body = response.data;
      if (body is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      final ApiResponse? envelope =
          body.containsKey('success') && body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;
      if (envelope != null && !envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to fetch pet insights',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body;
      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return PetInsightsResponse.fromMap(payload);
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  ApiException _mapDioError(DioException error) {
    final int statusCode = error.response?.statusCode ?? 0;
    final dynamic responseData = error.response?.data;

    if (responseData is Map<String, dynamic>) {
      final String? message = responseData['message'] as String?;
      final String? code = responseData['code'] as String?;
      if (message != null && message.isNotEmpty) {
        return ApiException(
          message,
          code: code ?? 'API_ERROR',
          statusCode: statusCode,
        );
      }
    }

    if (statusCode == 401) {
      return const ApiException(
        'Unauthorized. Please login again.',
        code: 'UNAUTHORIZED',
        statusCode: 401,
      );
    }

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return const ApiException(
        'Request timed out. Please try again.',
        code: 'TIMEOUT',
        statusCode: 408,
      );
    }

    if (error.type == DioExceptionType.connectionError) {
      return const ApiException('Something went wrong', code: 'NO_INTERNET');
    }

    return ApiException(
      'Something went wrong. Please try again.',
      code: 'API_ERROR',
      statusCode: statusCode,
    );
  }

  String _mapPetSize(String size) {
    switch (size.toLowerCase()) {
      case 'toy':
      case 'small':
        return 'S';
      case 'medium':
        return 'M';
      case 'large':
        return 'L';
      case 'giant':
        return 'GIANT';
      default:
        return size;
    }
  }

  String _mapWeightUnit(String unit) {
    switch (unit.toLowerCase()) {
      case 'kg':
      case 'kgs':
        return 'kgs';
      case 'lb':
      case 'lbs':
        return 'lbs';
      default:
        return unit;
    }
  }

  String _mapHeightUnit(String unit) {
    switch (unit.toLowerCase()) {
      case 'cm':
      case 'cms':
        return 'cms';
      case 'ft':
      case 'fts':
        return 'fts';
      default:
        return unit;
    }
  }

  String _toIsoDateOnly(String input) {
    final raw = input.trim();
    if (raw.isEmpty) return '';

    final parsed = DateTime.tryParse(raw);
    if (parsed != null) {
      return parsed.toIso8601String().split('T').first;
    }

    final match = RegExp(
      r'^(\d{1,2})[\/-](\d{1,2})[\/-](\d{4})$',
    ).firstMatch(raw);
    if (match == null) return raw;

    final day = int.tryParse(match.group(1) ?? '');
    final month = int.tryParse(match.group(2) ?? '');
    final year = int.tryParse(match.group(3) ?? '');
    if (day == null || month == null || year == null) return raw;

    final dt = DateTime(year, month, day);
    return dt.toIso8601String().split('T').first;
  }
}
