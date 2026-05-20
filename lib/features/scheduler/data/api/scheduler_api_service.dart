import 'package:dio/dio.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/core/errors/error_mapper.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/scheduler/data/models/request_models/create_event_request_model.dart';
import 'package:poochcare/features/scheduler/data/models/request_models/create_reminder_request_model.dart';
import 'package:poochcare/features/scheduler/data/models/schedule_monthly_response_model.dart';

class ScheduleApiService {
  const ScheduleApiService(this._dio);

  final Dio _dio;

  static const _monthlySchedulePath = '/pet-schedulers/monthly-schedule';

  static const _createReminderPath = '/pet-schedulers/reminders';

  static const _createEventPath = '/pet-schedulers/events';

  static const _updateReminderPath = '/pet-schedulers/reminders';

  static const _updateEventPath = '/pet-schedulers/events';

  static const _deleteSchedulePath = '/pet-schedulers';

  Future<ScheduleMonthlyResponseModel> getMonthlySchedule({
    required int month,
    required int year,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        _monthlySchedulePath,

        queryParameters: {'month': month, 'year': year},
      );

      final dynamic body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(envelope.message);
      }

      return ScheduleMonthlyResponseModel.fromMap(ParserUtils.readMap(body));
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  Future<void> createReminder({
    required CreateReminderRequestModel request,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        _createReminderPath,

        data: request.toMap(),
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
              : 'Unable to create reminder',

          code: 'API_ERROR',

          statusCode: envelope.status,
        );
      }
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<void> createEvent({required CreateEventRequestModel request}) async {
    try {
      final response = await _dio.post<dynamic>(
        _createEventPath,
        data: request.toMap(),
      );

      final body = response.data;

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
              : 'Unable to create event',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  Future<void> updateReminder({
    required String id,
    required CreateReminderRequestModel request,
  }) async {
    try {
      final response = await _dio.patch<dynamic>(
        '$_updateReminderPath/$id',
        data: request.toMap(),
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
              : 'Unable to update reminder',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<void> updateEvent({
    required String id,
    required CreateEventRequestModel request,
  }) async {
    try {
      final response = await _dio.patch<dynamic>(
        '$_updateEventPath/$id',
        data: request.toMap(),
      );

      final body = response.data;

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
              : 'Unable to update event',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  Future<void> deleteSchedule({required String id}) async {
    try {
      final response = await _dio.delete<dynamic>('$_deleteSchedulePath/$id');

      final body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(envelope.message);
      }
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }
}
