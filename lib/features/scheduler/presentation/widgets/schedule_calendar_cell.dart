import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class ScheduleCalendarCell extends StatelessWidget {
  const ScheduleCalendarCell({
    super.key,
    required this.day,
    required this.isCurrentMonth,
    required this.indicators,
    this.isSelected = false,
    this.onTap,
  });

  final int day;
  final bool isCurrentMonth;
  final List<Color> indicators;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadiusSize.r6),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.s8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.p1 : AppColors.white,
          borderRadius: BorderRadius.circular(AppRadiusSize.r6),
          boxShadow: [
            if (isCurrentMonth)
              BoxShadow(
                color: const Color(0XFF000E33).withValues(alpha: 0.05),
                blurRadius: 1,
              ),
          ],
        ),
        child: Stack(
          children: [
            if (indicators.isNotEmpty)
              Positioned(
                top: 0,
                right: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: indicators
                      .take(3)
                      .map(
                        (e) => Container(
                          margin: const EdgeInsets.only(left: 2),
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: e,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),

            Center(
              child: AppText.h3(
                day.toString(),
                color: isSelected
                    ? AppColors.white
                    : isCurrentMonth
                    ? AppColors.black
                    : const Color(0x00175426).withValues(alpha: 0.15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
