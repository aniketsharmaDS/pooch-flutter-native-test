import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class GetHelpProgressSection extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final bool isFinding;
  final bool isEmpty;

  const GetHelpProgressSection({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.isFinding = false,
    this.isEmpty = false,
  });

  double get progress {
    if (totalSteps <= 0) return 0;
    return (currentStep / totalSteps).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final contentWidth = constraints.maxWidth * 0.65;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.s16.w,
            vertical: AppSpacing.s12.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔥 SAME WIDTH AS BAR (but NOT centering whole widget)
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: contentWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.h3('Progress', fontSize: AppFontSize.fs12),
                      AppText.h4(
                        isFinding
                            ? 'Finding You A Pooch...'
                            : isEmpty
                            ? 'No Pooch Found'
                            : '$currentStep / $totalSteps',
                        color: AppColors.p2_800,
                        fontSize: AppFontSize.fs12,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: AppSpacing.s8.h),

              // 🔥 SAME WIDTH BAR (aligned with row)
              Align(
                alignment: Alignment.centerLeft,
                child: Stack(
                  children: [
                    Container(
                      height: AppSize.cs8.h,
                      width: contentWidth,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(AppRadiusSize.r12),
                      ),
                    ),

                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: AppSize.cs8.h,
                      width: contentWidth * progress,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFBC20), Color(0xFFFFDB88)],
                        ),
                        borderRadius: BorderRadius.circular(AppRadiusSize.r12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
