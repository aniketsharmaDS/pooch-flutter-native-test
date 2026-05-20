import 'package:poochcare/features/auth/data/models/otp_send_response.dart';
import 'package:poochcare/features/auth/domain/models/otp_send_result.dart';

class OtpSendMapper {
  const OtpSendMapper._();

  static OtpSendResult toDomain(
    OtpSendResponse response, {
    String message = '',
  }) {
    return OtpSendResult(message: message);
  }
}
