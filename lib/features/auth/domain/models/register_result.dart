import 'package:equatable/equatable.dart';
import 'package:poochcare/features/auth/domain/models/register_user.dart';

class RegisterResult extends Equatable {
  const RegisterResult({
    required this.user,
    required this.needsOtpVerification,
    required this.verificationToken,
    required this.message,
  });

  final RegisterUser user;
  final bool needsOtpVerification;
  final String verificationToken;
  final String message;

  @override
  List<Object?> get props => <Object?>[
    user,
    needsOtpVerification,
    verificationToken,
    message,
  ];
}
