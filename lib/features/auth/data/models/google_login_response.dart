import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'google_login_response.mapper.dart';

@MappableClass()
class GoogleLoginResponse with GoogleLoginResponseMappable {
  const GoogleLoginResponse({
    this.user = const GoogleLoginUserResponse(),
    this.hasInvites = false,
    this.tokens = const GoogleLoginTokensResponse(),
  });

  final GoogleLoginUserResponse user;

  @MappableField(hook: SafeBoolHook())
  final bool hasInvites;

  final GoogleLoginTokensResponse tokens;
}

@MappableClass()
class GoogleLoginUserResponse with GoogleLoginUserResponseMappable {
  const GoogleLoginUserResponse({
    this.id = '',
    this.provider = '',
    this.isActive = false,
    this.isDeleted = false,
    this.isOnboarded = false,
    this.isProfileCompleted = false,
    this.isPetOnboarded = false,
    this.points = 0,
    this.createdAt = '',
    this.updatedAt = '',
    this.name = '',
    this.email = '',
    this.primaryIdentifier = '',
    this.isSocialLogin = false,
    this.role = '',
    this.isVerified = false,
    this.updatedAtLegacy = '',
    this.createdAtLegacy = '',
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String provider;

  @MappableField(hook: SafeBoolHook())
  final bool isActive;

  @MappableField(hook: SafeBoolHook())
  final bool isDeleted;

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
  final String email;

  @MappableField(hook: SafeStringHook())
  final String primaryIdentifier;

  @MappableField(hook: SafeBoolHook())
  final bool isSocialLogin;

  @MappableField(hook: SafeStringHook())
  final String role;

  @MappableField(hook: SafeBoolHook())
  final bool isVerified;

  @MappableField(key: 'updated_at', hook: SafeStringHook())
  final String updatedAtLegacy;

  @MappableField(key: 'created_at', hook: SafeStringHook())
  final String createdAtLegacy;
}

@MappableClass()
class GoogleLoginTokensResponse with GoogleLoginTokensResponseMappable {
  const GoogleLoginTokensResponse({
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
