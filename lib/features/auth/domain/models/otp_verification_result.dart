import 'package:equatable/equatable.dart';
import 'package:poochcare/features/auth/domain/models/otp_tokens.dart';
import 'package:poochcare/features/auth/domain/models/otp_verification_user.dart';

class OtpVerificationResult extends Equatable {
  const OtpVerificationResult({
    required this.type,
    required this.user,
    required this.tokens,
    required this.hasInvites,
    required this.message,
  });

  final String type;
  final OtpVerificationUser user;
  final OtpTokens tokens;
  final bool hasInvites;
  final String message;

  @override
  List<Object?> get props => <Object?>[type, user, tokens, hasInvites, message];
}
