import 'package:dio/dio.dart';
import 'package:poochcare/core/config/app_config.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/network/auth_interceptor.dart';
import 'package:poochcare/core/network/error_interceptor.dart';
import 'package:poochcare/core/network/localization_interceptor.dart';
import 'package:poochcare/core/network/logging_interceptor.dart';
import 'package:poochcare/core/services/localization_service.dart';

class DioClient {
  DioClient({
    required String baseUrl,
    required Future<String?> Function() tokenProvider,
  }) : dio = Dio(
         BaseOptions(
           baseUrl: baseUrl,
           // Use timeout from AppConfig
           connectTimeout: Duration(seconds: AppConfig.apiTimeoutSeconds),
           receiveTimeout: Duration(seconds: AppConfig.apiTimeoutSeconds),
           headers: const <String, String>{'Content-Type': 'application/json'},
         ),
       ) {
    dio.interceptors.addAll(<Interceptor>[
      AuthInterceptor(tokenProvider: tokenProvider),
      LocalizationInterceptor(
        localizationService: getIt<LocalizationService>(),
      ),
      LoggingInterceptor(),
      ErrorInterceptor(),
    ]);
  }

  final Dio dio;
}
