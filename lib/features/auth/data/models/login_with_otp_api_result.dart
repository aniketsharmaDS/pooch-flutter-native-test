import 'package:poochcare/features/auth/data/models/login_with_otp_response.dart';

class LoginWithOtpApiResult {
  const LoginWithOtpApiResult({required this.data, required this.message});

  final LoginWithOtpResponse data;
  final String message;
}
