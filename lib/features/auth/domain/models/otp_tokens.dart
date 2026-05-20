import 'package:equatable/equatable.dart';

class OtpTokens extends Equatable {
  const OtpTokens({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.accessTokenExpiresAt,
    required this.refreshTokenExpiresAt,
  });

  final String accessToken;
  final String refreshToken;
  final String expiresIn;
  final String accessTokenExpiresAt;
  final String refreshTokenExpiresAt;

  @override
  List<Object?> get props => <Object?>[
    accessToken,
    refreshToken,
    expiresIn,
    accessTokenExpiresAt,
    refreshTokenExpiresAt,
  ];
}
