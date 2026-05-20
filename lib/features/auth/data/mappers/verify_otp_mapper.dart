import 'package:poochcare/features/auth/data/models/verify_otp_response.dart';
import 'package:poochcare/features/auth/domain/models/otp_tokens.dart';
import 'package:poochcare/features/auth/domain/models/otp_verification_result.dart';
import 'package:poochcare/features/auth/domain/models/otp_verification_user.dart';

class VerifyOtpMapper {
  const VerifyOtpMapper._();

  static OtpVerificationResult toDomain(
    VerifyOtpResponse response, {
    String message = '',
  }) {
    return OtpVerificationResult(
      type: response.type,
      user: OtpVerificationUser(
        id: response.user.id,
        provider: response.user.provider,
        providerId: response.user.providerId,
        isSocialLogin: response.user.isSocialLogin,
        isActive: response.user.isActive,
        isDeleted: response.user.isDeleted,
        deletedBy: response.user.deletedBy,
        deletedAt: response.user.deletedAt,
        deletionReason: response.user.deletionReason,
        isOnboarded: response.user.isOnboarded,
        isProfileCompleted: response.user.isProfileCompleted,
        isPetOnboarded: response.user.isPetOnboarded,
        points: response.user.points,
        createdAt: response.user.createdAt,
        updatedAt: response.user.updatedAt,
        name: response.user.name,
        phone: response.user.phone,
        countryCode: response.user.countryCode,
        country: response.user.country,
        role: response.user.role,
        primaryIdentifier: response.user.primaryIdentifier,
        isVerified: response.user.isVerified,
        hasInvites: response.user.hasInvites,
        updatedAtLegacy: response.user.updatedAtLegacy,
        createdAtLegacy: response.user.createdAtLegacy,
        email: response.user.email,
      ),
      tokens: OtpTokens(
        accessToken: response.tokens.accessToken,
        refreshToken: response.tokens.refreshToken,
        expiresIn: response.tokens.expiresIn,
        accessTokenExpiresAt: response.tokens.accessTokenExpiresAt,
        refreshTokenExpiresAt: response.tokens.refreshTokenExpiresAt,
      ),
      hasInvites: response.hasInvites,
      message: message,
    );
  }
}
