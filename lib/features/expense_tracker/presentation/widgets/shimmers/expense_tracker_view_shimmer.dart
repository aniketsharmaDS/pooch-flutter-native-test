import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExpenseTrackerShimmer extends StatelessWidget {
  /// Use [isMonthly] to slightly change the layout if needed
  final bool isMonthly;
  const ExpenseTrackerShimmer({super.key, this.isMonthly = false});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.s100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Header (Month/Year + Pet)
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppRadiusSize.r16),
                    bottomRight: Radius.circular(AppRadiusSize.r16),
                  ),
                  color: Color(0xFFF2EDDD),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: AppSpacing.s8,
                    right: AppSpacing.s12,
                    top: AppSpacing.s16,
                    bottom: AppSpacing.s24,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _bar(height: 30, width: 120),
                          _bar(height: 30, width: 60),
                        ],
                      ),
                      const SizedBox(height: 60),

                      /// Donut chart placeholder
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: 24),

                      /// Breakdown list shimmer
                      Column(
                        children: List.generate(
                          4,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: _bar(height: 20, width: double.infinity),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// Button placeholder
                      _bar(height: 32, width: 110, radius: 16),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// Extra section
              if (isMonthly)
                Container(
                  width: double.infinity,
                  height: 100,
                  color: Colors.grey.shade300,
                ),
            ],
          ),
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
