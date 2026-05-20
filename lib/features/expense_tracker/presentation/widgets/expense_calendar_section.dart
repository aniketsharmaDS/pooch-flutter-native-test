import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class ExpenseCalendarSection extends StatelessWidget {
  const ExpenseCalendarSection({
    super.key,
    required this.month,
    required this.year,
    required this.highlightedDates,
  });

  final String month;
  final int year;
  final List<int> highlightedDates;

  static const List<String> _weekdays = [
    'Su',
    'Mo',
    'Tu',
    'We',
    'Th',
    'Fr',
    'Sa',
  ];

  static const monthMap = {
    'Jan': 1,
    'Feb': 2,
    'Mar': 3,
    'Apr': 4,
    'May': 5,
    'Jun': 6,
    'Jul': 7,
    'Aug': 8,
    'Sep': 9,
    'Oct': 10,
    'Nov': 11,
    'Dec': 12,
  };

  @override
  Widget build(BuildContext context) {
    final monthIndex = monthMap[month] ?? 1;

    final firstDayOfMonth = DateTime(year, monthIndex);

    final lastDayOfMonth = DateTime(year, monthIndex + 1, 0);

    /// Sunday = 0
    final startingWeekday = firstDayOfMonth.weekday % 7;

    final daysInMonth = lastDayOfMonth.day;

    /// Previous month
    final previousMonthLastDay = DateTime(year, monthIndex, 0).day;

    final List<_CalendarDay> calendarDays = [];

    /// PREVIOUS MONTH DAYS
    for (int i = startingWeekday - 1; i >= 0; i--) {
      calendarDays.add(
        _CalendarDay(day: previousMonthLastDay - i, isCurrentMonth: false),
      );
    }

    /// CURRENT MONTH DAYS
    for (int i = 1; i <= daysInMonth; i++) {
      calendarDays.add(_CalendarDay(day: i, isCurrentMonth: true));
    }

    int nextMonthDay = 1;

    /// NEXT MONTH DAYS
    while (calendarDays.length % 7 != 0) {
      calendarDays.add(
        _CalendarDay(day: nextMonthDay++, isCurrentMonth: false),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.s16.w,
        vertical: AppSpacing.s20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE
          AppText.h1(
            'Daily Expenses for $month $year',
            fontSize: AppFontSize.fs16,
            color: const Color(0xFF3F3C36),
          ),

          SizedBox(height: AppSpacing.s16.h),

          /// WEEKDAYS
          Row(
            children: _weekdays.map((day) {
              return Expanded(
                child: Center(
                  child: AppText.bodyM(day, color: const Color(0xFF320E02)),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: AppSpacing.s12.h),

          /// CALENDAR GRID
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: calendarDays.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 2.h,
              crossAxisSpacing: 1.w,
            ),
            itemBuilder: (context, index) {
              final item = calendarDays[index];

              final isHighlighted =
                  item.isCurrentMonth && highlightedDates.contains(item.day);

              return Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    if (item.isCurrentMonth)
                      BoxShadow(
                        color: const Color(0xFF000E33).withValues(alpha: 0.1),
                        blurRadius: 8.r,
                        spreadRadius: 1.r,
                      ),
                  ],
                  color: isHighlighted
                      ? const Color(0xFF22C55E)
                      : item.isCurrentMonth
                      ? AppColors.white
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadiusSize.r6),
                ),
                child: Center(
                  child: AppText.h3(
                    '${item.day}',
                    color: isHighlighted
                        ? Colors.white
                        : item.isCurrentMonth
                        ? const Color(0xFF320E02)
                        : const Color(0xFFD0CCC3),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CalendarDay {
  final int day;
  final bool isCurrentMonth;

  const _CalendarDay({required this.day, required this.isCurrentMonth});
}
