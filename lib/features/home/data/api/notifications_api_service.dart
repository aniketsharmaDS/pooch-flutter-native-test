import 'package:dio/dio.dart';
import 'package:poochcare/core/errors/error_mapper.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/home/data/models/notification_model.dart';

class NotificationApiService {
  const NotificationApiService(this._dio);

  final Dio _dio;

  static const String _notificationsPath = '/notifications';

  /// Get notifications
  Future<NotificationResponse> getNotifications({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        _notificationsPath,
        queryParameters: {'page': page, 'limit': limit},
      );
      final payload = _unwrapEnvelope(response.data);

      return NotificationResponse.fromJson(payload as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  // Helper Methods for clean code

  dynamic _unwrapEnvelope(dynamic body) {
    if (body is! Map<String, dynamic>) return body;

    final ApiResponse? envelope =
        body.containsKey('success') && body.containsKey('data')
        ? ApiResponseMapper.fromMap(body)
        : null;

    if (envelope != null && !envelope.success) {
      throw Exception(
        envelope.message.isNotEmpty
            ? envelope.message
            : 'Unable to fetch notifications',
      );
    }

    return body;
  }
}
