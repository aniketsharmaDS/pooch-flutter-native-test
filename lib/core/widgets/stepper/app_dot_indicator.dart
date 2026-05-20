import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';

class AppDotIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  final double activeWidth;
  final double activeHeight;

  final double inactiveWidth;
  final double inactiveHeight;

  final double spacing;

  final Color activeColor;
  final Color inactiveColor;

  const AppDotIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
    this.activeWidth = 30,
    this.activeHeight = 6,
    this.inactiveWidth = 6,
    this.inactiveHeight = 6,
    this.spacing = 3,
    this.activeColor = AppColors.p4_800,
    this.inactiveColor = AppColors.p4_100,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final isActive = index == currentIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(horizontal: spacing.w),
          width: isActive ? activeWidth.w : inactiveWidth.w,
          height: isActive ? activeHeight.h : inactiveHeight.h,
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(AppRadiusSize.r10),
          ),
        );
      }),
    );
  }
}
