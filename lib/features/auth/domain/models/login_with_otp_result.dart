import 'package:equatable/equatable.dart';

class LoginWithOtpResult extends Equatable {
  const LoginWithOtpResult({required this.expiresIn, required this.message});

  final String expiresIn;
  final String message;

  @override
  List<Object?> get props => <Object?>[expiresIn, message];
}
