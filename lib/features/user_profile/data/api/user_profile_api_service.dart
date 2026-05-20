import 'package:dio/dio.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/user_profile/data/models/get_parent_groups_api_result.dart';
import 'package:poochcare/features/user_profile/data/models/get_parent_groups_response.dart';
import 'package:poochcare/features/user_profile/data/models/identifier_otp_send_api_result.dart';
import 'package:poochcare/features/user_profile/data/models/identifier_otp_send_response.dart';
import 'package:poochcare/features/user_profile/data/models/save_house_details_api_result.dart';
import 'package:poochcare/features/user_profile/data/models/save_house_details_response.dart';
import 'package:poochcare/features/user_profile/data/models/update_user_profile_api_result.dart';
import 'package:poochcare/features/user_profile/data/models/user_profile_model.dart';
import 'package:poochcare/features/user_profile/data/models/user_profile_response.dart';

class UserProfileApiService {
  const UserProfileApiService(this._dio);

  final Dio _dio;

  static const String _updateProfilePath = '/user/profile';
  static const String _getProfilePath = '/user/profile';
  static const String _updateParentGroupPetPath = '/parent-group-pets';
  static const String _sendOtpForIdentifierPath =
      '/user/send-otp-for-identifier';
  static const String _saveHouseDetailsPath = '/onboarding/parent';
  static const String _getParentGroupsPath = '/parent-groups';

  Future<GetParentGroupsApiResult> getParentGroups() async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        _getParentGroupsPath,
      );

      final dynamic body = response.data;
      if (body is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      final ApiResponse? envelope =
          body.containsKey('success') && body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;
      final dynamic payload = envelope?.data ?? body;
      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return GetParentGroupsApiResult(
        data: GetParentGroupsResponse.fromMap(payload),
        message: envelope?.message ?? '',
      );
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<UserProfileResponse> getUserProfileDetails() async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        _getProfilePath,
      );

      final dynamic body = response.data;
      if (body is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      final ApiResponse? envelope =
          body.containsKey('success') && body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;
      final dynamic payload = envelope?.data ?? body;
      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return UserProfileResponseMapper.fromMap(payload);
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<UserProfileModel> getProfile() async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        _getProfilePath,
      );

      final dynamic body = response.data;
      if (body is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      final ApiResponse? envelope =
          body.containsKey('success') && body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;
      final dynamic payload = envelope?.data ?? body;
      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return UserProfileModelMapper.fromMap(payload);
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<void> updateParentGroupPet({
    required String petId,
    required Map<String, dynamic> payload,
  }) async {
    try {
      final Response<dynamic> response = await _dio.put<dynamic>(
        '$_updateParentGroupPetPath/$petId',
        data: payload,
      );

      final dynamic body = response.data;
      if (body is Map<String, dynamic> && body.containsKey('success')) {
        final ApiResponse envelope = ApiResponseMapper.fromMap(body);
        if (!envelope.success) {
          throw ApiException(
            envelope.message.isNotEmpty
                ? envelope.message
                : 'Unable to update pet profile',
            code: 'API_ERROR',
            statusCode: envelope.status,
          );
        }
      }
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<void> deleteParentGroupPet({required String petId}) async {
    try {
      final Response<dynamic> response = await _dio.delete<dynamic>(
        '$_updateParentGroupPetPath/$petId',
      );

      final dynamic body = response.data;
      if (body is Map<String, dynamic> && body.containsKey('success')) {
        final ApiResponse envelope = ApiResponseMapper.fromMap(body);
        if (!envelope.success) {
          throw ApiException(
            envelope.message.isNotEmpty
                ? envelope.message
                : 'Unable to delete pet profile',
            code: 'API_ERROR',
            statusCode: envelope.status,
          );
        }
      }
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<IdentifierOtpSendApiResult> sendOtpForIdentifier({
    String? countryCode,
    String? newEmail,
    String? newPhone,
  }) async {
    try {
      final normalizedCountryCode = (countryCode ?? '').trim();
      final normalizedEmail = (newEmail ?? '').trim();
      final normalizedPhone = (newPhone ?? '').trim();

      final Response<dynamic> response = await _dio.post<dynamic>(
        _sendOtpForIdentifierPath,
        data: <String, dynamic>{
          'countryCode': normalizedCountryCode.isEmpty
              ? null
              : normalizedCountryCode,
          'newEmail': normalizedEmail.isEmpty ? null : normalizedEmail,
          'newPhone': normalizedPhone.isEmpty ? null : normalizedPhone,
        },
      );

      final dynamic body = response.data;
      if (body is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      final ApiResponse? envelope =
          body.containsKey('success') && body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;
      final dynamic payload = envelope?.data ?? body;
      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return IdentifierOtpSendApiResult(
        data: IdentifierOtpSendResponseMapper.fromMap(payload),
        message: envelope?.message ?? '',
      );
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<UpdateUserProfileApiResult> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String dateOfBirth,
    String? otpCode,
    required String countryCode,
    required String profilePicture,
    required String gender,
  }) async {
    try {
      final Response<dynamic> response = await _dio.patch<dynamic>(
        _updateProfilePath,
        data: <String, dynamic>{
          'name': name.trim(),
          'email': email.trim(),
          'phone': phone.trim(),
          'dateOfBirth': dateOfBirth.trim(),
          'otpCode': otpCode,
          'countryCode': countryCode.trim(),
          'profilePicture': profilePicture.trim(),
          'gender': gender.trim(),
        },
      );

      final dynamic body = response.data;
      if (body is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      final ApiResponse? envelope =
          body.containsKey('success') && body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;
      final dynamic payload = envelope?.data ?? body;
      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return UpdateUserProfileApiResult(
        data: UserProfileResponseMapper.fromMap(payload),
        message: envelope?.message ?? '',
      );
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<SaveHouseDetailsApiResult> saveHouseDetails({
    required String parentName,
    required String houseName,
    required String relation,
    required bool isMultiplePets,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        _saveHouseDetailsPath,
        data: <String, dynamic>{
          'parent_name': parentName.trim(),
          'house_name': houseName.trim(),
          'relation': relation.trim(),
          'is_multiple_pets': isMultiplePets,
        },
      );

      final dynamic body = response.data;
      if (body is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      final ApiResponse? envelope =
          body.containsKey('success') && body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;
      final dynamic payload = envelope?.data ?? body;
      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return SaveHouseDetailsApiResult(
        data: SaveHouseDetailsResponseMapper.fromMap(payload),
        message: envelope?.message ?? '',
      );
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
      if (message != null && message.trim().isNotEmpty) {
        return ApiException(
          message,
          code: code ?? 'API_ERROR',
          statusCode: statusCode,
        );
      }
    }

    if (statusCode == 401) {
      return const ApiException(
        'Unauthorized request.',
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
      return const ApiException('Something went wrong!', code: 'NO_INTERNET');
    }

    return ApiException(
      'Something went wrong. Please try again.',
      code: 'API_ERROR',
      statusCode: statusCode,
    );
  }
}
