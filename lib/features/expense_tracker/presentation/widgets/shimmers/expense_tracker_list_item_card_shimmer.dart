import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExpenseTrackerListItemCardShimmer extends StatelessWidget {
  const ExpenseTrackerListItemCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.s14.w,
          vertical: AppSpacing.s14.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadiusSize.r12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// content placeholder
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bar(height: 14, width: double.infinity),
                  SizedBox(height: 4.h),
                  _bar(height: 12, width: 120.w),
                ],
              ),
            ),

            SizedBox(width: AppSpacing.s12.w),

            /// Amount placeholder
            _bar(height: 14, width: 60.w),
          ],
        ),
      ),
    );
  }

  Widget _bar({
    required double height,
    required double width,
    double radius = 6,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
