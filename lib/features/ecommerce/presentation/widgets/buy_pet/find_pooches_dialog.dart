import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';

/// ======================================================
/// FIND POOCHES DIALOG
/// ======================================================

class FindPoochesDialog {
  static Future<bool?> show(BuildContext context) {
    return AppDialog.show<bool?>(
      context: context,
      title: 'Find Pooches Near You',
      content:
          'Enable location to meet pooches looking for homes in your area.',
      icon: Lottie.asset(AppIcons.lottie.findPooches, repeat: false),
      primaryLabel: 'Allow',
      secondaryLabel: 'Deny',
      onPrimary: () => Future.value(true),
      onSecondary: () => Future.value(false),
    );
  }
}
