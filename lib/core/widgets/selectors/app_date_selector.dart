import 'package:flutter/material.dart';

import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';

import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class AppDateSelector extends StatelessWidget {
  const AppDateSelector({
    super.key,
    required this.label,
    required this.onTap,
    this.backgroundColor = AppColors.white,
    this.borderColor = AppColors.textPrimary,
    this.textColor = AppColors.textPrimary,
  });

  final String label;

  final VoidCallback onTap;

  final Color backgroundColor;

  final Color borderColor;

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      behavior: HitTestBehavior.opaque,

      child: Container(
        padding: const EdgeInsets.only(
          left: AppSpacing.s16,
          right: AppSpacing.s10,
        ),

        constraints: const BoxConstraints(minHeight: 44),

        decoration: BoxDecoration(
          color: backgroundColor,

          borderRadius: BorderRadius.circular(40),

          border: Border.all(color: borderColor, width: 1.5),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,

          children: [
            Flexible(
              child: AppText.h2(
                label,
                fontSize: AppFontSize.fs18,
                color: textColor,
                maxLines: 1,
              ),
            ),

            const SizedBox(width: 12),

            AppIcon(
              AppIcons.svg.generic.chevronDown,
              size: AppIconSize.is24,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
