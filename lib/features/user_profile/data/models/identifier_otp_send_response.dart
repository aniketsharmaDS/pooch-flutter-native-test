import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'identifier_otp_send_response.mapper.dart';

@MappableClass()
class IdentifierOtpSendResponse with IdentifierOtpSendResponseMappable {
  const IdentifierOtpSendResponse({this.placeholder = ''});

  @MappableField(hook: SafeStringHook())
  final String placeholder;
}
