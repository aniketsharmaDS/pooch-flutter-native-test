import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/main.dart';

enum SnackbarType { success, info, warning, error }

class CustomSnackbar {
  static String? _lastMessage;
  static DateTime? _lastShownAt;

  static void show(String message, SnackbarType type) {
    Color backgroundColor;
    IconData icon;

    switch (type) {
      case SnackbarType.success:
        backgroundColor = AppColors.messageSuccess;
        icon = Icons.check_circle;
        break;
      case SnackbarType.info:
        backgroundColor = AppColors.messageInfo;
        icon = Icons.info;
        break;
      case SnackbarType.warning:
        backgroundColor = AppColors.messageWarning;
        icon = Icons.warning;
        break;
      case SnackbarType.error:
        backgroundColor = AppColors.error;
        icon = Icons.error;
        break;
    }

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Text(message, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 2),
      // action: SnackBarAction(
      //   label: 'Dismiss',
      //   textColor: Colors.white,
      //   onPressed: () {
      //     scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
      //   },
      // ),
    );

    // Avoid showing the same message repeatedly in a short timeframe
    final now = DateTime.now();
    if (_lastMessage != null && _lastMessage == message) {
      final since = now.difference(
        _lastShownAt ?? DateTime.fromMillisecondsSinceEpoch(0),
      );
      if (since.inMilliseconds < 1500) {
        // Already shown very recently; skip to avoid duplicate snackbars
        return;
      }
    }

    // Hide any currently visible snackbar (prevents stacking)
    scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);

    _lastMessage = message;
    _lastShownAt = now;
  }
}
