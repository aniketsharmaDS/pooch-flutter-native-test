import 'package:poochcare/features/auth/data/models/google_login_response.dart';
import 'package:poochcare/features/auth/domain/models/otp_tokens.dart';
import 'package:poochcare/features/auth/domain/models/social_login_result.dart';
import 'package:poochcare/features/auth/domain/models/social_login_user.dart';

class SocialLoginMapper {
  const SocialLoginMapper._();

  static SocialLoginResult toDomain(
    GoogleLoginResponse response, {
    String message = '',
  }) {
    return SocialLoginResult(
      user: SocialLoginUser(
        id: response.user.id,
        provider: response.user.provider,
        isActive: response.user.isActive,
        isDeleted: response.user.isDeleted,
        isOnboarded: response.user.isOnboarded,
        isProfileCompleted: response.user.isProfileCompleted,
        isPetOnboarded: response.user.isPetOnboarded,
        points: response.user.points,
        createdAt: response.user.createdAt,
        updatedAt: response.user.updatedAt,
        name: response.user.name,
        email: response.user.email,
        primaryIdentifier: response.user.primaryIdentifier,
        isSocialLogin: response.user.isSocialLogin,
        role: response.user.role,
        isVerified: response.user.isVerified,
        updatedAtLegacy: response.user.updatedAtLegacy,
        createdAtLegacy: response.user.createdAtLegacy,
      ),
      hasInvites: response.hasInvites,
      tokens: OtpTokens(
        accessToken: response.tokens.accessToken,
        refreshToken: response.tokens.refreshToken,
        expiresIn: response.tokens.expiresIn,
        accessTokenExpiresAt: response.tokens.accessTokenExpiresAt,
        refreshTokenExpiresAt: response.tokens.refreshTokenExpiresAt,
      ),
      message: message,
    );
  }
}
