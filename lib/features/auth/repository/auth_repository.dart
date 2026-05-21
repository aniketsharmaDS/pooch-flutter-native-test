import 'package:poochcare/features/auth/data/api/auth_api_service.dart';
import 'package:poochcare/features/auth/data/mappers/login_with_otp_mapper.dart';
import 'package:poochcare/features/auth/data/mappers/otp_send_mapper.dart';
import 'package:poochcare/features/auth/data/mappers/register_mapper.dart';
import 'package:poochcare/features/auth/data/mappers/social_login_mapper.dart';
import 'package:poochcare/features/auth/data/mappers/verify_otp_mapper.dart';
import 'package:poochcare/features/auth/domain/models/login_with_otp_result.dart';
import 'package:poochcare/features/auth/domain/models/otp_send_result.dart';
import 'package:poochcare/features/auth/domain/models/otp_verification_result.dart';
import 'package:poochcare/features/auth/domain/models/register_result.dart';
import 'package:poochcare/features/auth/domain/models/social_login_result.dart';

class AuthRepository {
  const AuthRepository(this._api);

  final AuthApiService _api;

  Future<Map<String, dynamic>> fetchUserSplash() async {
    return _api.fetchUserSplash();
  }

  Future<SocialLoginResult> googleLogin({
    required String uid,
    required String fullName,
    required String email,
    required String phone,
    required String photoUrl,
    required String googleIdToken,
  }) async {
    final result = await _api.googleLogin(
      uid: uid,
      fullName: fullName,
      email: email,
      phone: phone,
      photoUrl: photoUrl,
      googleIdToken: googleIdToken,
    );
    return SocialLoginMapper.toDomain(result.data, message: result.message);
  }

  Future<SocialLoginResult> facebookLogin({
    required String uid,
    required String fullName,
    required String email,
    required String phone,
    required String photoUrl,
    required String facebookIdToken,
  }) async {
    final result = await _api.facebookLogin(
      uid: uid,
      fullName: fullName,
      email: email,
      phone: phone,
      photoUrl: photoUrl,
      facebookIdToken: facebookIdToken,
    );
    return SocialLoginMapper.toDomain(result.data, message: result.message);
  }

  Future<void> sendOtp({required String phone}) async {
    await _api.sendOtp(phone: phone);
  }

  Future<LoginWithOtpResult> loginWithOtp({
    required String emailOrPhone,
    required String countryCode,
  }) async {
    final result = await _api.loginWithOtp(
      emailOrPhone: emailOrPhone,
      countryCode: countryCode,
    );
    return LoginWithOtpMapper.toDomain(result.data, message: result.message);
  }

  Future<OtpSendResult> sendOtpCode({required String emailOrPhone}) async {
    final result = await _api.sendOtpCode(emailOrPhone: emailOrPhone);
    return OtpSendMapper.toDomain(result.data, message: result.message);
  }

  Future<OtpVerificationResult> verifyOtpCode({
    required String emailOrPhone,
    required String otpCode,
    required String type,
    String deviceId = '',
    String fcmToken = '',
    String deviceType = '',
  }) async {
    final result = await _api.verifyOtpCode(
      emailOrPhone: emailOrPhone,
      otpCode: otpCode,
      type: type,
      deviceId: deviceId,
      fcmToken: fcmToken,
      deviceType: deviceType,
    );
    return VerifyOtpMapper.toDomain(result.data, message: result.message);
  }

  Future<RegisterResult> register({
    required String emailOrPhone,
    required String countryCode,
  }) async {
    final result = await _api.register(
      emailOrPhone: emailOrPhone,
      countryCode: countryCode,
    );
    return RegisterMapper.toDomain(result.data, message: result.message);
  }

  Future<void> logout() => _api.logout();
}
