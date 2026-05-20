import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        '╔════════════════════════════════════════════════════════════',
      );
      debugPrint('║ [API REQUEST]');
      debugPrint('║ Method: ${options.method}');
      debugPrint('║ URL: ${options.uri}');

      if (options.headers.isNotEmpty) {
        debugPrint('║ Headers:');
        options.headers.forEach((key, value) {
          final maskedValue = _maskSensitiveData(key, value?.toString() ?? '');
          debugPrint('║   $key: $maskedValue');
        });
      }

      if (options.data != null) {
        debugPrint('║ Body: ${_formatData(options.data)}');
      }

      debugPrint(
        '╚════════════════════════════════════════════════════════════',
      );
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      debugPrint(
        '╔════════════════════════════════════════════════════════════',
      );
      debugPrint('║ [API RESPONSE]');
      debugPrint('║ Status Code: ${response.statusCode}');
      debugPrint('║ URL: ${response.requestOptions.uri}');
      debugPrint('║ Method: ${response.requestOptions.method}');

      if (response.headers.map.isNotEmpty) {
        debugPrint('║ Headers:');
        response.headers.forEach((name, values) {
          debugPrint('║   $name: ${values.join(', ')}');
        });
      }

      if (response.data != null) {
        debugPrint('║ Body: ${_formatData(response.data)}');
      }

      debugPrint(
        '╚════════════════════════════════════════════════════════════',
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        '╔════════════════════════════════════════════════════════════',
      );
      debugPrint('║ [API ERROR]');
      debugPrint('║ URL: ${err.requestOptions.uri}');
      debugPrint('║ Method: ${err.requestOptions.method}');
      debugPrint('║ Type: ${err.type}');
      debugPrint('║ Status Code: ${err.response?.statusCode}');
      debugPrint('║ Message: ${err.message}');

      if (err.response?.data != null) {
        debugPrint('║ Error Body: ${_formatData(err.response?.data)}');
      }

      debugPrint(
        '╚════════════════════════════════════════════════════════════',
      );
    }
    handler.next(err);
  }

  String _formatData(dynamic data) {
    if (data == null) {
      return 'null';
    }
    if (data is Map) {
      return data.toString();
    }
    if (data is List) {
      return data.toString();
    }
    return data.toString();
  }

  String _maskSensitiveData(String key, String value) {
    final sensitiveKeys = [
      'authorization',
      'token',
      'password',
      'secret',
      'api_key',
    ];
    if (sensitiveKeys.any(
      (sensitive) => key.toLowerCase().contains(sensitive),
    )) {
      return '***MASKED***';
    }
    return value;
  }
}
