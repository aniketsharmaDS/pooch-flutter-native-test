import 'package:poochcare/features/auth/data/models/register_response.dart';
import 'package:poochcare/features/auth/domain/models/register_result.dart';
import 'package:poochcare/features/auth/domain/models/register_user.dart';

class RegisterMapper {
  const RegisterMapper._();

  static RegisterResult toDomain(
    RegisterResponse response, {
    String message = '',
  }) {
    return RegisterResult(
      user: RegisterUser(
        name: response.user.name,
        phone: response.user.phone,
        role: response.user.role,
        hasInvites: response.user.hasInvites,
      ),
      needsOtpVerification: response.needsOtpVerification,
      verificationToken: response.verificationToken,
      message: message,
    );
  }
}
