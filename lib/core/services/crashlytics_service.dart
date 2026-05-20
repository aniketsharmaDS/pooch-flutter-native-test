import 'dart:ui';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class CrashlyticsService {
  static final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  /// Sets up Crashlytics to capture all Flutter & Dart crashes
  static Future<void> setupCrashlytics() async {
    // Catch Flutter framework errors
    FlutterError.onError = (FlutterErrorDetails errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    // Catch uncaught async errors (outside Flutter framework)
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true; // handled
    };
  }

  /// Log custom events
  static Future<void> log(String message) async {
    _crashlytics.log(message);
  }

  /// Record non-fatal errors
  static Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    bool fatal = false,
  }) async {
    await _crashlytics.recordError(exception, stack, fatal: fatal);
  }

  /// Force a crash (for testing)
  static Future<void> crash() async {
    _crashlytics.crash();
  }

  static Future<void> setUserInfo({
    required String? userId,
    required String? userEmail,
  }) async {
    // Attach user info
    if (userId != null) {
      await _crashlytics.setUserIdentifier(userId);
    }
    if (userEmail != null) {
      await _crashlytics.setCustomKey('user_email', userEmail);
    }
  }
}
