import 'package:poochcare/features/auth/data/api/auth_api_service.dart';
import 'package:poochcare/features/auth/data/mappers/otp_send_mapper.dart';
import 'package:poochcare/features/auth/data/mappers/register_mapper.dart';
import 'package:poochcare/features/auth/data/mappers/user_mapper.dart';
import 'package:poochcare/features/auth/data/mappers/verify_otp_mapper.dart';
import 'package:poochcare/features/auth/domain/models/otp_send_result.dart';
import 'package:poochcare/features/auth/domain/models/otp_verification_result.dart';
import 'package:poochcare/features/auth/domain/models/register_result.dart';
import 'package:poochcare/features/auth/domain/models/user.dart';

class AuthRepository {
  const AuthRepository(this._api);

  final AuthApiService _api;

  Future<User> login({required String email, required String password}) async {
    final response = await _api.login(email: email, password: password);
    return UserMapper.toDomain(response);
  }

  Future<void> sendOtp({required String phone}) async {
    await _api.sendOtp(phone: phone);
  }

  Future<OtpSendResult> sendOtpCode({required String emailOrPhone}) async {
    final result = await _api.sendOtpCode(emailOrPhone: emailOrPhone);
    return OtpSendMapper.toDomain(result.data, message: result.message);
  }

  Future<User> verifyOtp({required String phone, required String otp}) async {
    final response = await _api.verifyOtp(phone: phone, otp: otp);
    return UserMapper.toDomain(response);
  }

  Future<OtpVerificationResult> verifyOtpCode({
    required String emailOrPhone,
    required String otpCode,
    required String type,
  }) async {
    final result = await _api.verifyOtpCode(
      emailOrPhone: emailOrPhone,
      otpCode: otpCode,
      type: type,
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
