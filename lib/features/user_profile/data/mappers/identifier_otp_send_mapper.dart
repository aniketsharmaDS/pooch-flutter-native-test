import 'package:poochcare/features/user_profile/data/models/identifier_otp_send_response.dart';
import 'package:poochcare/features/user_profile/domain/models/identifier_otp_send_result.dart';

class IdentifierOtpSendMapper {
  const IdentifierOtpSendMapper._();

  static IdentifierOtpSendResult toDomain(
    IdentifierOtpSendResponse response, {
    String message = '',
  }) {
    return IdentifierOtpSendResult(message: message);
  }
}
