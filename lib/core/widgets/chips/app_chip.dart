import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

enum AppChipVariant { singleLine, wrap }

class AppChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;
  final AppChipVariant? variant;
  final Color? selectedBgColor;
  final Color? unselectedBgColor;
  final Color? selectedBorderColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  const AppChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onSelected,
    this.variant = AppChipVariant.singleLine,
    this.selectedBgColor,
    this.unselectedBgColor,
    this.selectedBorderColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveSelectedBorderColor =
        selectedBorderColor ?? AppColors.textSecondary;
    final effectivePadding =
        padding ??
        EdgeInsets.symmetric(
          horizontal: AppSpacing.s16.w,
          vertical: AppSpacing.s8.h,
        );
    final effectiveBorderRadius = borderRadius ?? AppSpacing.s20.r;

    return GestureDetector(
      onTap: () => onSelected?.call(!isSelected),
      child: Container(
        padding: effectivePadding,
        decoration: BoxDecoration(
          color: selectedBgColor,
          border: Border.all(
            color: isSelected
                ? effectiveSelectedBorderColor
                : Colors.transparent,
            width: isSelected ? AppSize.cs1.csw : 0,
          ),
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
        ),
        child: AppText.h4(
          label,
          color: selectedTextColor ?? AppColors.textSecondary,
          variant: AppTextVariant.noEllipsis,
          // maxLines: null,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
