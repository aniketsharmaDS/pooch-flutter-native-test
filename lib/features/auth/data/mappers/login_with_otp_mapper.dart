import 'package:poochcare/features/auth/data/models/login_with_otp_response.dart';
import 'package:poochcare/features/auth/domain/models/login_with_otp_result.dart';

class LoginWithOtpMapper {
  const LoginWithOtpMapper._();

  static LoginWithOtpResult toDomain(
    LoginWithOtpResponse response, {
    String message = '',
  }) {
    return LoginWithOtpResult(expiresIn: response.expiresIn, message: message);
  }
}
