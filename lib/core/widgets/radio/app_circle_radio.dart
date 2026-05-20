// File: app_circle_radio.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';

class AppCircleRadio extends StatelessWidget {
  /// Whether this radio button is selected
  final bool isSelected;

  /// Callback when tapped
  final VoidCallback onTap;

  /// Outer circle diameter
  final double outerSize;

  /// Inner circle diameter
  final double innerSize;

  /// Outer circle border color
  final Color? borderColor;

  /// Inner circle fill color when selected
  final Color? fillColor;

  /// Optional label text displayed next to the circle
  final String? label;

  /// Optional text style for the label
  final TextStyle? labelStyle;

  /// Spacing between circle and label
  final double labelSpacing;

  /// Padding around the entire radio when it has a label
  final EdgeInsetsGeometry? padding;

  /// Background color when the radio has a label (button effect)
  final Color? backgroundColor;

  /// Selected background color
  final Color? selectedBackgroundColor;

  /// Border radius when it has label
  final double borderRadius;

  const AppCircleRadio({
    super.key,
    required this.isSelected,
    required this.onTap,
    this.outerSize = 16, // default 16, scales with .w
    this.innerSize = 8, // default 8, scales with .w
    this.borderColor,
    this.fillColor,
    this.label,
    this.labelStyle,
    this.labelSpacing = 8,
    this.padding,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final Color resolvedBorderColor = borderColor ?? AppColors.radioActive;
    final Color resolvedFillColor = fillColor ?? AppColors.radioActive;

    final Widget circle = Container(
      width: outerSize.w,
      height: outerSize.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: resolvedBorderColor, width: 1.5.w),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: innerSize.w,
                height: innerSize.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: resolvedFillColor,
                ),
              ),
            )
          : null,
    );

    if (label != null && label!.isNotEmpty) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius.r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding:
                padding ??
                EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                circle,
                SizedBox(width: labelSpacing.w),
                Flexible(
                  child: Text(
                    label!,
                    style:
                        labelStyle ??
                        TextStyle(fontSize: 14.sp, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular((outerSize / 2).w),
        child: Padding(
          padding: EdgeInsets.all(8.w), // bigger touch area
          child: circle,
        ),
      );
    }
  }
}
