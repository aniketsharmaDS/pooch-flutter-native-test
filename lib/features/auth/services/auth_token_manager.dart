import 'dart:async';

import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/core/services/session_reset_service.dart';
import 'package:poochcare/core/services/token_storage.dart';
import 'package:poochcare/features/auth/data/api/auth_api_service.dart';
import 'package:poochcare/features/auth/data/models/verify_otp_response.dart';
import 'package:poochcare/features/auth/domain/models/otp_tokens.dart';

class AuthTokenManager {
  AuthTokenManager({
    required AuthApiService api,
    required TokenStorage storage,
    required SessionResetService sessionResetService,
  }) : _api = api,
       _storage = storage,
       _sessionResetService = sessionResetService;

  final AuthApiService _api;
  final TokenStorage _storage;
  final SessionResetService _sessionResetService;

  Future<OtpTokens?> readTokens() => _storage.readTokens();

  Future<String?> getValidAccessToken() async {
    final OtpTokens? tokens = await _storage.readTokens();
    if (tokens == null || tokens.accessToken.isEmpty) {
      return null;
    }

    if (!_isExpired(tokens.accessTokenExpiresAt)) {
      return tokens.accessToken;
    }

    // Access token expired; validate refresh token.
    if (tokens.refreshToken.isEmpty ||
        _isExpired(tokens.refreshTokenExpiresAt)) {
      await _expireSession();
      return null;
    }

    return _refreshAndGetAccessToken(tokens.refreshToken);
  }

  Future<String?> _refreshAndGetAccessToken(String refreshToken) async {
    // De-duplicate concurrent refreshes.
    final Future<String?> ongoing =
        _refreshFuture ??
        (_refreshFuture = _refresh(refreshToken).whenComplete(() {
          _refreshFuture = null;
        }));

    return ongoing;
  }

  Future<String?> _refresh(String refreshToken) async {
    try {
      final VerifyOtpTokensResponse refreshed = await _api.refreshToken(
        refreshToken: refreshToken,
      );

      final OtpTokens newTokens = OtpTokens(
        accessToken: refreshed.accessToken,
        refreshToken: refreshed.refreshToken,
        expiresIn: refreshed.expiresIn,
        accessTokenExpiresAt: refreshed.accessTokenExpiresAt,
        refreshTokenExpiresAt: refreshed.refreshTokenExpiresAt,
      );

      await _storage.saveTokens(newTokens);
      return newTokens.accessToken;
    } on ApiException catch (e) {
      // If refresh is unauthorized/expired, force logout.
      if (e.statusCode == 401) {
        await _expireSession();
        return null;
      }
      rethrow;
    } catch (_) {
      // Conservative: do not keep retrying forever.
      rethrow;
    }
  }

  Future<void> _expireSession() async {
    await _sessionResetService.clearSessionData();
  }

  bool _isExpired(String rawExpiry) {
    final DateTime? expiry = _parseExpiry(rawExpiry);
    if (expiry == null) {
      // If we can't parse, treat as expired.
      return true;
    }
    return !expiry.isAfter(DateTime.now().toUtc());
  }

  DateTime? _parseExpiry(String raw) {
    final String value = raw.trim();
    if (value.isEmpty) return null;

    // ISO-8601
    final DateTime? iso = DateTime.tryParse(value);
    if (iso != null) return iso.toUtc();

    // Epoch seconds/millis
    final int? asInt = int.tryParse(value);
    if (asInt == null) return null;

    // Heuristic: 13 digits => millis, 10 digits => seconds
    if (value.length >= 13) {
      return DateTime.fromMillisecondsSinceEpoch(asInt, isUtc: true);
    }

    return DateTime.fromMillisecondsSinceEpoch(asInt * 1000, isUtc: true);
  }

  Future<String?>? _refreshFuture;
}
