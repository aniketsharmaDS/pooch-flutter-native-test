import 'package:poochcare/features/auth/data/models/verify_otp_response.dart';

class VerifyOtpApiResult {
  const VerifyOtpApiResult({required this.data, required this.message});

  final VerifyOtpResponse data;
  final String message;
}
