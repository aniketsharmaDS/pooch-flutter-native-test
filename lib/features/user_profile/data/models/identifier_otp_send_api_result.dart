import 'package:poochcare/features/user_profile/data/models/identifier_otp_send_response.dart';

class IdentifierOtpSendApiResult {
  const IdentifierOtpSendApiResult({required this.data, required this.message});

  final IdentifierOtpSendResponse data;
  final String message;
}
