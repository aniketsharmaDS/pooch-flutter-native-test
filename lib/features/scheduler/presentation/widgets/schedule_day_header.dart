import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class ScheduleDayHeader extends StatelessWidget {
  const ScheduleDayHeader({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    const weekDays = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
    ];

    final dayName = weekDays[date.weekday % 7];

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.bodyM(dayName, color: AppColors.textSecondary),

          const SizedBox(height: 4),

          AppText.h1('${date.day}', color: AppColors.textPrimary),
        ],
      ),
    );
  }
}
