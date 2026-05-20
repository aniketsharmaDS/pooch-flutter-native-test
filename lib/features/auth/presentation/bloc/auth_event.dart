import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class AuthStarted extends AuthEvent {
  const AuthStarted();
}

class LoginRequested extends AuthEvent {
  const LoginRequested({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => <Object?>[email, password];
}

class LoginWithOtpRequested extends AuthEvent {
  const LoginWithOtpRequested({
    required this.emailOrPhone,
    required this.countryCode,
  });

  final String emailOrPhone;
  final String countryCode;

  @override
  List<Object?> get props => <Object?>[emailOrPhone, countryCode];
}

class GoogleLoginRequested extends AuthEvent {
  const GoogleLoginRequested();
}

class FacebookLoginRequested extends AuthEvent {
  const FacebookLoginRequested();
}

class RegisterRequested extends AuthEvent {
  const RegisterRequested({
    required this.emailOrPhone,
    required this.countryCode,
  });

  final String emailOrPhone;
  final String countryCode;

  @override
  List<Object?> get props => <Object?>[emailOrPhone, countryCode];
}

class SendOtpRequested extends AuthEvent {
  const SendOtpRequested({required this.phone});

  final String phone;

  @override
  List<Object?> get props => <Object?>[phone];
}

class SendOtpCodeRequested extends AuthEvent {
  const SendOtpCodeRequested({required this.emailOrPhone});

  final String emailOrPhone;

  @override
  List<Object?> get props => <Object?>[emailOrPhone];
}

class VerifyOtpRequested extends AuthEvent {
  const VerifyOtpRequested({required this.phone, required this.otp});

  final String phone;
  final String otp;

  @override
  List<Object?> get props => <Object?>[phone, otp];
}

class VerifyOtpCodeRequested extends AuthEvent {
  const VerifyOtpCodeRequested({
    required this.emailOrPhone,
    required this.otpCode,
    required this.type,
    required this.deviceId,
    required this.fcmToken,
    required this.deviceType,
  });

  final String emailOrPhone;
  final String otpCode;
  final String type;
  final String? deviceId;
  final String? fcmToken;
  final String? deviceType;

  @override
  List<Object?> get props => <Object?>[
    emailOrPhone,
    otpCode,
    type,
    deviceId,
    fcmToken,
    deviceType,
  ];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class FetchUserSplashRequested extends AuthEvent {
  const FetchUserSplashRequested();
}
