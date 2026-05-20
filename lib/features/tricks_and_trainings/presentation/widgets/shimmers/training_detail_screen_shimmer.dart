import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_spacing.dart';

class TrainingDetailsScreenShimmer extends StatelessWidget {
  const TrainingDetailsScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacing.s16.hBox,

            /// Stepper shimmer
            ...List.generate(
              4,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            AppSpacing.s24.hBox,
          ],
        ),
      ),
    );
  }
}
