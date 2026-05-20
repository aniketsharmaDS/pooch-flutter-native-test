import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';

class AppSwitch extends StatelessWidget {
  final String? label;
  final bool value;
  final ValueChanged<bool> onChanged;

  final Color? backgroundColor;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? textColor;
  final double? borderRadius;

  const AppSwitch({
    super.key,
    this.label,
    required this.value,
    required this.onChanged,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor,
    this.textColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Label
          if (label != null)
            Text(
              label!,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: textColor ?? AppColors.textPrimary,
              ),
            ),

          SizedBox(width: 8.w),

          /// Switch (Material 3 style)
          Transform.scale(
            scale: 0.85,
            child: Switch(
              value: value,
              onChanged: onChanged,

              /// ✅ NEW API (Flutter 3.41)
              thumbColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return activeColor ?? AppColors.activeColor;
                }
                return inactiveColor ?? AppColors.inActiveColor;
              }),

              trackColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return (activeColor ?? AppColors.activeColor).withValues(
                    alpha: 0.5,
                  );
                }
                return AppColors.inActiveColor.withValues(alpha: 0.3);
              }),
            ),
          ),
        ],
      ),
    );
  }
}

/*
bool isActive = false;

AppSwitchFilter(
  label: "Active",
  value: isActive,
  onChanged: (val) {
    setState(() {
      isActive = val;
    });
  },
)
*/
