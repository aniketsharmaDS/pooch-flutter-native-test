import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class CircularCoparentAvatar extends StatelessWidget {
  final bool isSelected;
  final String label;
  final VoidCallback? onTap;

  const CircularCoparentAvatar({
    this.isSelected = false,
    this.label = 'C',
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sizeOfContainer = isSelected ? 54.w : 60.w;
    final borderColor = isSelected ? AppColors.p4_900 : Colors.transparent;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.s4),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: borderColor),
          shape: BoxShape.circle,
        ),
        child: Container(
          alignment: Alignment.center,
          height: sizeOfContainer,
          width: sizeOfContainer,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFBC20), Color(0xFFFFDB88)],
            ),
            shape: BoxShape.circle,
          ),
          child: AppText.h4(
            label.isEmpty ? 'C' : label.substring(0, 1).toUpperCase(),
            fontSize: AppFontSize.fs18,
            color: const Color(0xFF521703),
          ),
        ),
      ),
    );
  }
}
