import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/main.dart';

/// =============================
/// SNACKBAR TYPES
/// =============================
enum SnackbarType { success, info, warning, error }

/// =============================
/// INTERNAL CONFIG MODEL
/// =============================
class _SnackBarConfig {
  final Color color;
  final IconData icon;

  const _SnackBarConfig(this.color, this.icon);
}

/// =============================
/// APP SNACKBAR SERVICE
/// =============================
class AppSnackBar {
  static String? _lastMessage;
  static DateTime? _lastShownAt;

  /// MAIN METHOD
  static void show(
    String message, {
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 2),
    String? actionLabel,
    VoidCallback? onAction,
    bool useRoot = true,
    BuildContext? context,
  }) {
    final messenger = useRoot
        ? scaffoldMessengerKey.currentState
        : (context != null ? ScaffoldMessenger.of(context) : null);

    if (messenger == null) return;

    final config = _getConfig(type);
    final now = DateTime.now();

    /// =============================
    /// DUPLICATE PREVENTION
    /// =============================
    if (_lastMessage == message &&
        _lastShownAt != null &&
        now.difference(_lastShownAt!).inMilliseconds < 1500) {
      return;
    }

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: config.color,
      duration: duration,
      content: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(config.icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
      action: (actionLabel != null && onAction != null)
          ? SnackBarAction(
              label: actionLabel,
              textColor: Colors.white,
              onPressed: onAction,
            )
          : null,
    );

    /// =============================
    /// SHOW SNACKBAR
    /// =============================
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    _lastMessage = message;
    _lastShownAt = now;
  }

  /// =============================
  /// TYPE CONFIGURATION
  /// =============================
  static _SnackBarConfig _getConfig(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return const _SnackBarConfig(
          AppColors.messageSuccess,
          Icons.check_circle,
        );
      case SnackbarType.info:
        return const _SnackBarConfig(AppColors.messageInfo, Icons.info);
      case SnackbarType.warning:
        return const _SnackBarConfig(AppColors.messageWarning, Icons.warning);
      case SnackbarType.error:
        return const _SnackBarConfig(AppColors.messageError, Icons.error);
    }
  }
}
