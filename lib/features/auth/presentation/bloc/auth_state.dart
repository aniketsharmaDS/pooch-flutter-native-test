import 'package:equatable/equatable.dart';
import 'package:poochcare/features/auth/domain/models/login_with_otp_result.dart';
import 'package:poochcare/features/auth/domain/models/otp_send_result.dart';
import 'package:poochcare/features/auth/domain/models/otp_verification_result.dart';
import 'package:poochcare/features/auth/domain/models/register_result.dart';
import 'package:poochcare/features/auth/domain/models/social_login_result.dart';

enum AuthStatus { initial, loading, success, failure }

enum AuthRequestType {
  none,
  register,
  loginWithOtp,
  googleLogin,
  sendOtp,
  verifyOtp,
}

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.requestType = AuthRequestType.none,
    this.googleLoginResult,
    this.loginOtpResult,
    this.registerResult,
    this.otpResult,
    this.otpSendResult,
    this.errorMessage,
  });

  final AuthStatus status;
  final AuthRequestType requestType;
  final SocialLoginResult? googleLoginResult;
  final LoginWithOtpResult? loginOtpResult;
  final RegisterResult? registerResult;
  final OtpVerificationResult? otpResult;
  final OtpSendResult? otpSendResult;
  final String? errorMessage;

  AuthState copyWith({
    AuthStatus? status,
    AuthRequestType? requestType,
    SocialLoginResult? googleLoginResult,
    LoginWithOtpResult? loginOtpResult,
    RegisterResult? registerResult,
    OtpVerificationResult? otpResult,
    OtpSendResult? otpSendResult,
    String? errorMessage,
    bool clearError = false,
    bool clearData = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      requestType: requestType ?? this.requestType,
      googleLoginResult: clearData
          ? null
          : (googleLoginResult ?? this.googleLoginResult),
      loginOtpResult: clearData
          ? null
          : (loginOtpResult ?? this.loginOtpResult),
      registerResult: clearData
          ? null
          : (registerResult ?? this.registerResult),
      otpResult: clearData ? null : (otpResult ?? this.otpResult),
      otpSendResult: clearData ? null : (otpSendResult ?? this.otpSendResult),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => <Object?>[
    status,
    requestType,
    googleLoginResult,
    loginOtpResult,
    registerResult,
    otpResult,
    otpSendResult,
    errorMessage,
  ];
}
