import 'dart:developer';

import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.tokenProvider});

  final Future<String?> Function() tokenProvider;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    log('AuthInterceptor: Checking for token to add to request');
    log('skipAuth: ${options.extra['skipAuth']}');
    if (options.extra['skipAuth'] == true) {
      log('Skipping authentication for this request');
      handler.next(options);
      return;
    }

    final String? token = await tokenProvider();
    if (token != null && token.isNotEmpty) {
      log('Adding Authorization header with token: $token');
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
