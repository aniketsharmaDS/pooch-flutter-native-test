import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class AppVerticalStepperEvent {
  final String text;
  final String? timestamp;

  const AppVerticalStepperEvent({required this.text, this.timestamp});
}

class AppVerticalStepperItem {
  final String title;
  final List<AppVerticalStepperEvent> events;

  const AppVerticalStepperItem({required this.title, this.events = const []});
}

class AppVerticalStepper extends StatelessWidget {
  final List<AppVerticalStepperItem> items;
  final int currentStep;
  final Color filledColor;
  final Color unfilledColor;

  const AppVerticalStepper({
    super.key,
    required this.items,
    required this.currentStep,
    this.filledColor = const Color(0xFFDC7E06),
    this.unfilledColor = const Color(0xFFF9C98D),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(items.length, (index) {
        final item = items[index];
        final isLast = index == items.length - 1;
        final isStepReached = index <= currentStep;
        final connectorColor = index < currentStep
            ? filledColor
            : unfilledColor;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 22.w,
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 14.w,
                      height: 14.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isStepReached ? filledColor : unfilledColor,
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 2.w,
                          margin: EdgeInsets.symmetric(vertical: 2.h),
                          color: connectorColor,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.h3(
                        item.title,
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                        maxLines: 2,
                      ),
                      if (item.events.isNotEmpty) SizedBox(height: 10.h),
                      ...item.events.map((event) => _EventRow(event: event)),
                    ],
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

class _EventRow extends StatelessWidget {
  final AppVerticalStepperEvent event;

  const _EventRow({required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Container(
              width: 4.w,
              height: 4.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF6B6B6B),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.h4(
                  event.text,
                  color: const Color(0xFF666667),
                  maxLines: 2,
                ),
                if (event.timestamp != null) ...[
                  SizedBox(height: 2.h),
                  AppText.bodyS(
                    event.timestamp!,
                    color: const Color(0xFF7A7A7A),
                    maxLines: 2,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
