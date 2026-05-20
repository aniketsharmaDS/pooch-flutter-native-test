import 'package:equatable/equatable.dart';
import 'package:poochcare/features/auth/domain/models/otp_tokens.dart';
import 'package:poochcare/features/auth/domain/models/social_login_user.dart';

class SocialLoginResult extends Equatable {
  const SocialLoginResult({
    required this.user,
    required this.hasInvites,
    required this.tokens,
    required this.message,
  });

  final SocialLoginUser user;
  final bool hasInvites;
  final OtpTokens tokens;
  final String message;

  @override
  List<Object?> get props => <Object?>[user, hasInvites, tokens, message];
}
