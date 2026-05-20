import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:poochcare/features/auth/domain/models/otp_tokens.dart';

class TokenStorage {
  TokenStorage({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const String _kAccessToken = 'access_token';
  static const String _kRefreshToken = 'refresh_token';
  static const String _kExpiresIn = 'expires_in';
  static const String _kAccessTokenExpiresAt = 'access_token_expires_at';
  static const String _kRefreshTokenExpiresAt = 'refresh_token_expires_at';

  Future<void> saveTokens(OtpTokens tokens) async {
    await _storage.write(key: _kAccessToken, value: tokens.accessToken);
    await _storage.write(key: _kRefreshToken, value: tokens.refreshToken);
    await _storage.write(key: _kExpiresIn, value: tokens.expiresIn);
    await _storage.write(
      key: _kAccessTokenExpiresAt,
      value: tokens.accessTokenExpiresAt,
    );
    await _storage.write(
      key: _kRefreshTokenExpiresAt,
      value: tokens.refreshTokenExpiresAt,
    );
  }

  Future<OtpTokens?> readTokens() async {
    final String? accessToken = await _storage.read(key: _kAccessToken);
    final String? refreshToken = await _storage.read(key: _kRefreshToken);
    final String? expiresIn = await _storage.read(key: _kExpiresIn);
    final String? accessTokenExpiresAt = await _storage.read(
      key: _kAccessTokenExpiresAt,
    );
    final String? refreshTokenExpiresAt = await _storage.read(
      key: _kRefreshTokenExpiresAt,
    );

    if (accessToken == null || accessToken.isEmpty) {
      return null;
    }

    return OtpTokens(
      accessToken: accessToken,
      refreshToken: refreshToken ?? '',
      expiresIn: expiresIn ?? '',
      accessTokenExpiresAt: accessTokenExpiresAt ?? '',
      refreshTokenExpiresAt: refreshTokenExpiresAt ?? '',
    );
  }

  Future<void> clear() async {
    await _storage.delete(key: _kAccessToken);
    await _storage.delete(key: _kRefreshToken);
    await _storage.delete(key: _kExpiresIn);
    await _storage.delete(key: _kAccessTokenExpiresAt);
    await _storage.delete(key: _kRefreshTokenExpiresAt);
  }
}
