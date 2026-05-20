import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';

class FormSubmitBottomBar extends StatelessWidget {
  const FormSubmitBottomBar({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = true,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            border: Border(
              top: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.s16.w,
                vertical: AppSpacing.s12.h,
              ),
              child: AppButton(
                label: label,
                onPressed: isLoading ? null : onPressed,
                isLoading: isLoading,
                isDisabled: isDisabled,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
