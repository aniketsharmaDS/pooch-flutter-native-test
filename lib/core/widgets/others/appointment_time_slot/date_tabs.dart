import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class DateTabs extends StatelessWidget {
  final List<DateTime> dates;
  final int selectedIndex;
  final ValueChanged<int> onDateTap;
  final int Function(DateTime date) getCount;

  const DateTabs({
    super.key,
    required this.dates,
    required this.selectedIndex,
    required this.onDateTap,
    required this.getCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.cs60.csh,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        separatorBuilder: (_, _) => const SizedBox(width: 0),
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected = selectedIndex == index;
          final count = getCount(date);

          return SizedBox(
            width: AppSize.cs120.csh,
            child: InkWell(
              onTap: () => onDateTap(index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppText.h4(
                    _getDateLabel(date, index),
                    textAlign: TextAlign.center,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: 2),
                  AppText.h3(
                    '$count SLOTS AVAILABLE',
                    textAlign: TextAlign.center,
                    fontSize: AppFontSize.fs11,
                    color: const Color(0xff16B364),
                  ),
                  const SizedBox(height: 6),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    curve: Curves.easeOut,
                    height: isSelected ? 2 : 1,
                    color: isSelected ? AppColors.p1 : AppColors.p5_100,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _getDateLabel(DateTime date, int index) {
    if (index == 0) {
      return 'Today';
    }
    if (index == 1) {
      return 'Tomorrow';
    }
    return DateFormat('E, dd MMM').format(date);
  }
}
