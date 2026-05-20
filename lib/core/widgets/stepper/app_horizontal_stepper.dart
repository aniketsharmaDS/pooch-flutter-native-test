import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppHorizontalStepper extends StatelessWidget {
  final List<String> steps;
  final int currentStep;

  const AppHorizontalStepper({
    super.key,
    required this.steps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Step indicators
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),

          // padding: const EdgeInsets.all(8.0),
          child: Row(
            children: List.generate(steps.length * 2 - 1, (index) {
              if (index.isEven) {
                final stepIndex = index ~/ 2;
                final isCompleted = stepIndex < currentStep;
                final isCurrent = stepIndex == currentStep;

                return _buildStepCircle(
                  context,
                  stepIndex + 1,
                  isCompleted: isCompleted,
                  isCurrent: isCurrent,
                );
              } else {
                final stepIndex = index ~/ 2;
                final isCompleted = stepIndex < currentStep;

                return Expanded(
                  child: Container(
                    height: 5.h,
                    color: isCompleted
                        ? const Color(0xFFDC7E06)
                        : const Color(0xFFF9C98D),
                  ),
                );
              }
            }),
          ),
        ),
        SizedBox(height: 10.h),

        // Step labels
        Row(
          children: List.generate(steps.length * 2 - 1, (index) {
            if (index.isEven) {
              final stepIndex = index ~/ 2;

              return Expanded(
                child: Text(
                  steps[stepIndex],
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF1B1B1B),
                    fontSize: 12.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ),
      ],
    );
  }

  Widget _buildStepCircle(
    BuildContext context,
    int stepNumber, {
    required bool isCompleted,
    required bool isCurrent,
  }) {
    final activeColor = const Color(0xFFDC7E06);
    final inactiveColor = const Color(0xFFF9C98D);

    Color fillColor;
    if (isCompleted || isCurrent) {
      fillColor = activeColor;
    } else {
      fillColor = inactiveColor;
    }

    return Container(
      width: 16.w,
      height: 16.w,
      decoration: BoxDecoration(shape: BoxShape.circle, color: fillColor),
    );
  }
}
