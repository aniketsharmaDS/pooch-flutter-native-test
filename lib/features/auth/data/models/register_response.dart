import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'register_response.mapper.dart';

@MappableClass()
class RegisterResponse with RegisterResponseMappable {
  const RegisterResponse({
    this.user = const RegisterUserResponse(),
    this.needsOtpVerification = false,
    this.verificationToken = '',
  });

  final RegisterUserResponse user;

  @MappableField(key: 'needsOTPVerification', hook: SafeBoolHook())
  final bool needsOtpVerification;

  @MappableField(hook: SafeStringHook())
  final String verificationToken;
}

@MappableClass()
class RegisterUserResponse with RegisterUserResponseMappable {
  const RegisterUserResponse({
    this.name = '',
    this.phone = '',
    this.role = '',
    this.hasInvites = false,
    this.email = '',
  });

  @MappableField(hook: SafeStringHook())
  final String name;

  @MappableField(hook: SafeStringHook())
  final String phone;

  @MappableField(hook: SafeStringHook())
  final String role;

  @MappableField(hook: SafeStringHook())
  final String email;

  @MappableField(hook: SafeBoolHook())
  final bool hasInvites;
}
