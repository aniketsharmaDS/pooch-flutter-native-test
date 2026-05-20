import 'package:dio/dio.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/core/errors/error_mapper.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/settings/data/models/update_language_preference_request_model.dart';

class SettingsApiService {
  const SettingsApiService(this._dio);

  final Dio _dio;

  static const _updateLanguagePreferencePath = '/user/language-preference';

  Future<void> updateLanguagePreference({
    required UpdateLanguagePreferenceRequestModel request,
  }) async {
    try {
      final response = await _dio.put<dynamic>(
        _updateLanguagePreferencePath,
        data: request.toMap(),
        options: Options(contentType: Headers.jsonContentType),
      );

      final dynamic body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to update language preference',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }
}
