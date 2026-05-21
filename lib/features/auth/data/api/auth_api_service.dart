import 'package:dio/dio.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/auth/data/models/google_login_api_result.dart';
import 'package:poochcare/features/auth/data/models/google_login_response.dart';
import 'package:poochcare/features/auth/data/models/login_with_otp_api_result.dart';
import 'package:poochcare/features/auth/data/models/login_with_otp_response.dart';
import 'package:poochcare/features/auth/data/models/otp_send_api_result.dart';
import 'package:poochcare/features/auth/data/models/otp_send_response.dart';
import 'package:poochcare/features/auth/data/models/register_api_result.dart';
import 'package:poochcare/features/auth/data/models/register_response.dart';
import 'package:poochcare/features/auth/data/models/verify_otp_api_result.dart';
import 'package:poochcare/features/auth/data/models/verify_otp_response.dart';

class AuthApiService {
  const AuthApiService(this._dio);
  final Dio _dio;

  // static const String _loginPath = '/auth/login';
  static const String _loginWithOtpPath = '/auth/login-with-otp';
  static const String _googleLoginPath = '/auth/google-login';
  static const String _facebookLoginPath = '/auth/facebook-login';
  static const String _registerPath = '/auth/register';
  static const String _logoutPath = '/auth/logout';
  static const String _sendOtpPath = '/auth/send-otp';
  static const String _sendOtpCodePath = '/auth/otp/send';
  static const String _verifyOtpPath = '/auth/verify-otp';
  static const String _refreshTokenPath = '/auth/refresh-token';
  static const String _userSplashPath = '/splash/user-splash';

  Future<Map<String, dynamic>> fetchUserSplash() async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        _userSplashPath,
      );
      final dynamic body = response.data;
      if (body is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      final ApiResponse envelope = ApiResponseMapper.fromMap(body);
      if (!envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Failed to load splash content.',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope.data;
      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return payload;
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<VerifyOtpTokensResponse> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final String token = refreshToken.trim();
      final Response<dynamic> response = await _dio.get<dynamic>(
        _refreshTokenPath,
        queryParameters: <String, dynamic>{'refreshToken': token},
        options: Options(
          extra: <String, dynamic>{'skipAuth': true},
          headers: <String, dynamic>{'Authorization': 'Bearer $token'},
        ),
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

      final dynamic tokensPayload = payload['tokens'] is Map<String, dynamic>
          ? payload['tokens']
          : payload;
      if (tokensPayload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return VerifyOtpTokensResponseMapper.fromMap(tokensPayload);
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<void> sendOtp({required String phone}) async {
    try {
      await _dio.post<dynamic>(
        _sendOtpPath,
        data: <String, dynamic>{'phone': phone.trim()},
      );
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<LoginWithOtpApiResult> loginWithOtp({
    required String emailOrPhone,
    required String countryCode,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        _loginWithOtpPath,
        data: <String, dynamic>{
          'emailOrPhone': emailOrPhone.trim(),
          'countryCode': countryCode.trim(),
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

      return LoginWithOtpApiResult(
        data: LoginWithOtpResponseMapper.fromMap(payload),
        message: envelope?.message ?? '',
      );
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<OtpSendApiResult> sendOtpCode({required String emailOrPhone}) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        _sendOtpCodePath,
        data: <String, dynamic>{'emailOrPhone': emailOrPhone.trim()},
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

      return OtpSendApiResult(
        data: OtpSendResponseMapper.fromMap(payload),
        message: envelope?.message ?? '',
      );
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<GoogleLoginApiResult> googleLogin({
    required String uid,
    required String fullName,
    required String email,
    required String phone,
    required String photoUrl,
    required String googleIdToken,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        _googleLoginPath,
        data: <String, dynamic>{
          'uid': uid.trim(),
          'fullName': fullName.trim(),
          'email': email.trim(),
          'phone': phone.trim(),
          'photoUrl': photoUrl.trim(),
          'googleIdToken': googleIdToken.trim(),
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

      return GoogleLoginApiResult(
        data: GoogleLoginResponseMapper.fromMap(payload),
        message: envelope?.message ?? '',
      );
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<GoogleLoginApiResult> facebookLogin({
    required String uid,
    required String fullName,
    required String email,
    required String phone,
    required String photoUrl,
    required String facebookIdToken,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        _facebookLoginPath,
        data: <String, dynamic>{
          'uid': uid.trim(),
          'fullName': fullName.trim(),
          'email': email.trim(),
          'phone': phone.trim(),
          'photoUrl': photoUrl.trim(),
          'facebookIdToken': facebookIdToken.trim(),
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

      return GoogleLoginApiResult(
        data: GoogleLoginResponseMapper.fromMap(payload),
        message: envelope?.message ?? '',
      );
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<VerifyOtpApiResult> verifyOtpCode({
    required String emailOrPhone,
    required String otpCode,
    required String type,
    String deviceId = '',
    String fcmToken = '',
    String deviceType = '',
  }) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        _verifyOtpPath,
        data: <String, dynamic>{
          'emailOrPhone': emailOrPhone.trim(),
          'otpCode': otpCode.trim(),
          'type': type.trim(),
          'deviceType': deviceType.trim(),
          'deviceId': deviceId.trim(),
          'notificationToken': fcmToken.trim(),
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

      return VerifyOtpApiResult(
        data: VerifyOtpResponseMapper.fromMap(payload),
        message: envelope?.message ?? '',
      );
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<RegisterApiResult> register({
    required String emailOrPhone,
    required String countryCode,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        _registerPath,
        data: <String, dynamic>{
          'emailOrPhone': emailOrPhone.trim(),
          'countryCode': countryCode.trim(),
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

      return RegisterApiResult(
        data: RegisterResponseMapper.fromMap(payload),
        message: envelope?.message ?? '',
      );
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<void> logout() async {
    try {
      await _dio.post<dynamic>(_logoutPath);
    } on DioException catch (_) {
      // No-op: local logout should still complete even if backend call fails.
    }
  }

  // dynamic _extractPayload(Map<String, dynamic> body) {
  //   if (body.containsKey('success') && body.containsKey('data')) {
  //     final ApiResponse envelope = ApiResponseMapper.fromMap(body);
  //     return envelope.data;
  //   }

  //   return body;
  // }

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
        'Invalid email or password',
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
      return const ApiException('Something went wrong');
    }

    return ApiException(
      'Something went wrong. Please try again.',
      code: 'API_ERROR',
      statusCode: statusCode,
    );
  }
}
