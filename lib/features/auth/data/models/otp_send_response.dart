import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'otp_send_response.mapper.dart';

@MappableClass()
class OtpSendResponse with OtpSendResponseMappable {
  const OtpSendResponse({this.placeholder = ''});

  @MappableField(hook: SafeStringHook())
  final String placeholder;
}
