import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';

class PetDobWarningDialog {
  static Future<bool?> showNewPetDobWarning(BuildContext context) {
    return AppDialog.show<bool>(
      context: context,
      title: 'Date of Birth Confirmation',
      icon: Lottie.asset(
        repeat: false,
        AppIcons.lottie.question,
        width: 120,
        height: 120,
      ),
      content:
          "Your pet's date of birth is crucial for accurate health analysis, age-appropriate care recommendations, and diagnostic assessments. Please ensure the date you've entered is correct.",
      primaryLabel: 'Confirm',
      secondaryLabel: 'Cancel',
      onPrimary: () async => true,
      onSecondary: () async => false,
    );
  }

  static Future<bool?> showEditPetDobWarning(BuildContext context) {
    return AppDialog.show<bool>(
      context: context,
      title: 'Update Date of Birth?',
      icon: Lottie.asset(
        repeat: false,
        AppIcons.lottie.question,
        width: 120,
        height: 120,
      ),
      content:
          'Warning: Changing your pet\'s date of birth will recalculate their age and may affect existing health records, medical history interpretations, and age-based recommendations. Previous data linked to the old date of birth will be adjusted accordingly. Are you sure you want to proceed?',
      primaryLabel: 'Proceed',
      secondaryLabel: 'Cancel',
      onPrimary: () async => true,
      onSecondary: () async => false,
    );
  }
}
