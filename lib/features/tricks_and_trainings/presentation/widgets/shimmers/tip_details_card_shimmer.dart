import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TipDetailsCardShimmer extends StatelessWidget {
  const TipDetailsCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Skeletonizer(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.s12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadiusSize.r20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // 🔥 prevents full height stretch
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image placeholder
              _imagePlaceholder(),

              AppSpacing.s16.hBox,

              /// Title
              _line(width: double.infinity, height: 18),

              AppSpacing.s12.hBox,

              /// Description line 1
              _line(width: double.infinity, height: 12),

              AppSpacing.s8.hBox,

              /// Description line 2
              _line(width: 250, height: 12),

              AppSpacing.s20.hBox,

              /// Button placeholder
              _buttonPlaceholder(),
            ],
          ),
        ),
      ),
    );
  }

  /// ----------------------------
  /// Image placeholder
  /// ----------------------------
  Widget _imagePlaceholder() {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(AppRadiusSize.r12),
      ),
    );
  }

  /// ----------------------------
  /// Text line placeholder
  /// ----------------------------
  Widget _line({required double width, required double height}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  /// ----------------------------
  /// Button placeholder
  /// ----------------------------
  Widget _buttonPlaceholder() {
    return Container(
      height: 44,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
