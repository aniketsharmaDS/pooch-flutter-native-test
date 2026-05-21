import 'package:dio/dio.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/core/errors/error_mapper.dart';
import 'package:poochcare/features/home/data/models/updates_and_reminders_response.dart';

class UpdatesApiService {
  const UpdatesApiService(this._dio);

  final Dio _dio;

  static const String _updatesPath = '/insights/updates-and-reminders';

  Future<UpdatesAndRemindersResponse> getUpdatesAndReminders() async {
    try {
      final response = await _dio.get<dynamic>(_updatesPath);

      final dynamic body = response.data;

      if (body is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return UpdatesAndRemindersResponse.fromJson(body);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }
}
