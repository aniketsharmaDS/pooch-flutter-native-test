import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'login_with_otp_response.mapper.dart';

@MappableClass()
class LoginWithOtpResponse with LoginWithOtpResponseMappable {
  const LoginWithOtpResponse({this.expiresIn = ''});

  @MappableField(key: 'expires_in', hook: SafeStringHook())
  final String expiresIn;
}
