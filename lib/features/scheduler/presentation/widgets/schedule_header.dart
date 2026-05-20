import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/scheduler/presentation/view/schedule_screen.dart';

class ScheduleHeader extends StatelessWidget {
  const ScheduleHeader({
    super.key,
    required this.selectedDate,
    required this.selectedYear,
    required this.selectedView,
    required this.onViewChanged,
    required this.onYearTap,
    required this.isLoading,
  });

  final DateTime selectedDate;
  final int selectedYear;
  final ScheduleViewType selectedView;
  final bool isLoading;

  final ValueChanged<ScheduleViewType> onViewChanged;
  final VoidCallback onYearTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
      child: Row(
        children: [
          Expanded(
            child: AppText.h1(_headerTitle(), color: const Color(0XFF3F3C36)),
            // child:  isLoading
            //     ? Align(
            //         alignment: Alignment.centerLeft,
            //         child: Container(
            //           height: 28,
            //           width: 120,
            //           decoration: BoxDecoration(
            //             color: Colors.grey.shade300,
            //             borderRadius: BorderRadius.circular(6),
            //           ),
            //         ),
            //       )
            //     : AppText.h1(
            //         _headerTitle(),
            //         color: const Color(0XFF3F3C36),
            //       ),
          ),

          _viewDropdown(),

          const SizedBox(width: AppSpacing.s8),

          _chip(label: selectedYear.toString(), onTap: onYearTap),
        ],
      ),
    );
  }

  String _headerTitle() {
    switch (selectedView) {
      case ScheduleViewType.monthly:
        return _monthName(selectedDate.month);

      case ScheduleViewType.daily:
        return _dayHeader(selectedDate);

      case ScheduleViewType.weekly:
        return _weekHeader(selectedDate);
    }
  }

  String _dayHeader(DateTime date) {
    const weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return '${weekDays[date.weekday - 1]}, ${date.day} ${_monthName(date.month)}';
  }

  String _weekHeader(DateTime date) {
    final startOfWeek = date.subtract(Duration(days: date.weekday % 7));

    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    if (startOfWeek.month == endOfWeek.month) {
      return _monthName(startOfWeek.month);
    }

    return '${_shortMonth(startOfWeek.month)} / ${_shortMonth(endOfWeek.month)}';
  }

  String _shortMonth(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return months[month];
  }

  Widget _viewDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s14),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.textPrimary),
        borderRadius: BorderRadius.circular(AppRadiusSize.r80),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ScheduleViewType>(
          value: selectedView,
          borderRadius: BorderRadius.circular(AppRadiusSize.r12),
          icon: AppIcon(AppIcons.svg.generic.chevronDown, size: 18),
          items: ScheduleViewType.values.map((e) {
            return DropdownMenuItem(value: e, child: AppText.h2(_viewLabel(e)));
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onViewChanged(value);
            }
          },
        ),
      ),
    );
  }

  Widget _chip({required String label, required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadiusSize.r80),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s14,
          vertical: AppSpacing.s8,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.textPrimary),
          borderRadius: BorderRadius.circular(AppRadiusSize.r80),
        ),
        child: Row(
          children: [
            AppText.h2(label),

            AppSpacing.s8.wBox,

            AppIcon(AppIcons.svg.generic.chevronDown, size: 18),
          ],
        ),
      ),
    );
  }

  String _viewLabel(ScheduleViewType type) {
    switch (type) {
      case ScheduleViewType.monthly:
        return 'Monthly';

      case ScheduleViewType.weekly:
        return 'Weekly';

      case ScheduleViewType.daily:
        return 'Daily';
    }
  }

  String _monthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return months[month];
  }
}
