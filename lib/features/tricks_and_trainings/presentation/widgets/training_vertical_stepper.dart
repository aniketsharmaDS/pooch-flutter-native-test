import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/cards/training_list_item_card.dart';

class TrainingStepData {
  final String imageUrl;
  final String title;
  final String description;
  final bool isCompleted;
  final VoidCallback? onTap;

  const TrainingStepData({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.isCompleted,
    this.onTap,
  });
}

class TrainingVerticalStepper extends StatelessWidget {
  final List<TrainingStepData> steps;
  final VoidCallback? onTap;

  const TrainingVerticalStepper({super.key, required this.steps, this.onTap});

  @override
  Widget build(BuildContext context) {
    final currentStepIndex = steps.indexWhere((e) => !e.isCompleted);

    Color getLineColor(int index, int currentStepIndex) {
      final current = steps[index];
      final next = steps[index + 1];

      // Both steps completed → green
      if (current.isCompleted && next.isCompleted) {
        return const Color(0xFF22C55E);
      }

      // Current completed but next is NOT → active line (p2_400)
      if (current.isCompleted && !next.isCompleted) {
        return AppColors.p2_400;
      }

      // Default future steps
      return AppColors.p5_100;
    }

    return Column(
      children: List.generate(steps.length, (index) {
        final item = steps[index];

        final bool isCompleted = item.isCompleted;

        final bool isCurrent = index == currentStepIndex;

        final Color indicatorColor = isCompleted
            ? const Color(0xFF22C55E)
            : isCurrent
            ? AppColors.p2_400
            : AppColors.p5_100;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Stepper
              SizedBox(
                width: AppSize.cs26,
                child: Transform.translate(
                  offset: const Offset(0, -AppSpacing.s6),
                  child: Column(
                    children: [
                      /// Top line
                      if (index != 0)
                        Expanded(
                          child: Container(
                            width: 2.w,
                            color: getLineColor(index - 1, currentStepIndex),
                          ),
                        )
                      else
                        const Spacer(),

                      /// Circle
                      Container(
                        width: AppSize.cs26,
                        height: AppSize.cs26,
                        decoration: BoxDecoration(
                          color: isCompleted
                              ? indicatorColor
                              : AppColors.transparent,
                          border: Border.all(color: indicatorColor),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: isCompleted
                              ? AppIcon(
                                  AppIcons.svg.generic.check,
                                  color: AppColors.white,
                                  size: AppIconSize.is14,
                                )
                              : AppText.support(
                                  '${index + 1}'.padLeft(2, '0'),
                                  color: indicatorColor,
                                ),
                        ),
                      ),

                      /// Bottom line
                      if (index != steps.length - 1)
                        Expanded(
                          child: Container(
                            width: 2.w,
                            color: getLineColor(index, currentStepIndex),
                          ),
                        )
                      else
                        const Spacer(),
                    ],
                  ),
                ),
              ),

              AppSpacing.s12.wBox,

              /// Card
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.s16),
                  child: TrainingListItemCard(
                    imageUrl: item.imageUrl,
                    title: item.title,
                    description: item.description,
                    steps: '',
                    onTap: () {
                      item.onTap?.call();
                    },
                    descriptionMaxLines: 2,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
