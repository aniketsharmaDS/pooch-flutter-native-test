import 'package:poochcare/features/auth/data/models/otp_send_response.dart';

class OtpSendApiResult {
  const OtpSendApiResult({required this.data, required this.message});

  final OtpSendResponse data;
  final String message;
}
