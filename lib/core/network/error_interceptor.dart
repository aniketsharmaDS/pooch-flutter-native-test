import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        if (kDebugMode) {
          debugPrint('Connection timeout - check network');
        }
        break;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        if (statusCode == 401) {
          // Handle unauthorized - trigger logout
          if (kDebugMode) {
            debugPrint('Unauthorized - token expired');
          }
        }
        break;
      default:
        if (kDebugMode) {
          debugPrint('API Error: ${err.message}');
        }
        break;
    }
    handler.next(err);
  }
}
