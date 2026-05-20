import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TipAndTrainingListItemCardShimmer extends StatelessWidget {
  const TipAndTrainingListItemCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.s12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadiusSize.r20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image Placeholder
            Container(
              width: AppSize.cs70,
              height: AppSize.cs70,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(AppRadiusSize.r12),
              ),
            ),

            AppSpacing.s12.wBox,

            /// Content Placeholder
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title line 1
                  _bar(height: 14, width: double.infinity),

                  const SizedBox(height: 4),

                  /// Title line 2
                  _bar(height: 14, width: 150),

                  const SizedBox(height: 6),

                  /// Description line 1
                  _bar(height: 12, width: double.infinity),

                  const SizedBox(height: 4),

                  /// Description line 2
                  _bar(height: 12, width: 180),
                ],
              ),
            ),
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
