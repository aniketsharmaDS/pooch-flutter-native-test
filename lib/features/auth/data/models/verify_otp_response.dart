import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'verify_otp_response.mapper.dart';

@MappableClass()
class VerifyOtpResponse with VerifyOtpResponseMappable {
  const VerifyOtpResponse({
    this.type = '',
    this.user = const VerifyOtpUserResponse(),
    this.tokens = const VerifyOtpTokensResponse(),
    this.hasInvites = false,
  });

  @MappableField(hook: SafeStringHook())
  final String type;

  final VerifyOtpUserResponse user;
  final VerifyOtpTokensResponse tokens;

  @MappableField(hook: SafeBoolHook())
  final bool hasInvites;
}

@MappableClass()
class VerifyOtpUserResponse with VerifyOtpUserResponseMappable {
  const VerifyOtpUserResponse({
    this.id = '',
    this.provider = '',
    this.providerId = '',
    this.isSocialLogin = false,
    this.isActive = false,
    this.isDeleted = false,
    this.deletedBy = '',
    this.deletedAt = '',
    this.deletionReason = '',
    this.isOnboarded = false,
    this.isProfileCompleted = false,
    this.isPetOnboarded = false,
    this.points = 0,
    this.createdAt = '',
    this.updatedAt = '',
    this.name = '',
    this.phone = '',
    this.countryCode = '',
    this.country = '',
    this.role = '',
    this.primaryIdentifier = '',
    this.isVerified = false,
    this.hasInvites = false,
    this.updatedAtLegacy = '',
    this.createdAtLegacy = '',
    this.email = '',
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String provider;

  @MappableField(hook: SafeStringHook())
  final String providerId;

  @MappableField(hook: SafeBoolHook())
  final bool isSocialLogin;

  @MappableField(hook: SafeBoolHook())
  final bool isActive;

  @MappableField(hook: SafeBoolHook())
  final bool isDeleted;

  @MappableField(hook: SafeStringHook())
  final String deletedBy;

  @MappableField(hook: SafeStringHook())
  final String deletedAt;

  @MappableField(hook: SafeStringHook())
  final String deletionReason;

  @MappableField(hook: SafeBoolHook())
  final bool isOnboarded;

  @MappableField(hook: SafeBoolHook())
  final bool isProfileCompleted;

  @MappableField(hook: SafeBoolHook())
  final bool isPetOnboarded;

  @MappableField(hook: SafeIntHook())
  final int points;

  @MappableField(key: 'createdAt', hook: SafeStringHook())
  final String createdAt;

  @MappableField(key: 'updatedAt', hook: SafeStringHook())
  final String updatedAt;

  @MappableField(hook: SafeStringHook())
  final String name;

  @MappableField(hook: SafeStringHook())
  final String phone;

  @MappableField(hook: SafeStringHook())
  final String countryCode;

  @MappableField(hook: SafeStringHook())
  final String country;

  @MappableField(hook: SafeStringHook())
  final String role;

  @MappableField(hook: SafeStringHook())
  final String primaryIdentifier;

  @MappableField(hook: SafeBoolHook())
  final bool isVerified;

  @MappableField(hook: SafeBoolHook())
  final bool hasInvites;

  @MappableField(key: 'updated_at', hook: SafeStringHook())
  final String updatedAtLegacy;

  @MappableField(key: 'created_at', hook: SafeStringHook())
  final String createdAtLegacy;

  @MappableField(hook: SafeStringHook())
  final String email;
}

@MappableClass()
class VerifyOtpTokensResponse with VerifyOtpTokensResponseMappable {
  const VerifyOtpTokensResponse({
    this.accessToken = '',
    this.refreshToken = '',
    this.expiresIn = '',
    this.accessTokenExpiresAt = '',
    this.refreshTokenExpiresAt = '',
  });

  @MappableField(key: 'access_token', hook: SafeStringHook())
  final String accessToken;

  @MappableField(key: 'refresh_token', hook: SafeStringHook())
  final String refreshToken;

  @MappableField(key: 'expires_in', hook: SafeStringHook())
  final String expiresIn;

  @MappableField(key: 'access_token_expires_at', hook: SafeStringHook())
  final String accessTokenExpiresAt;

  @MappableField(key: 'refresh_token_expires_at', hook: SafeStringHook())
  final String refreshTokenExpiresAt;
}
