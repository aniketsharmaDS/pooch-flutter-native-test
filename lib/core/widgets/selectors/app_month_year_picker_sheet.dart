import 'package:flutter/material.dart';

import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';

import 'package:poochcare/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class AppMonthYearPickerResult {
  final int month;

  final int year;

  final DateTime accountCreatedAt;

  const AppMonthYearPickerResult({
    required this.month,
    required this.year,
    required this.accountCreatedAt,
  });
}

class AppMonthYearPickerSheet extends StatefulWidget {
  const AppMonthYearPickerSheet({
    super.key,
    required this.initialMonth,
    required this.initialYear,
    required this.accountCreatedAt,
  });

  final int initialMonth;

  final int initialYear;

  final DateTime accountCreatedAt;

  static Future<AppMonthYearPickerResult?> show({
    required BuildContext context,
    required int initialMonth,
    required int initialYear,
    required DateTime accountCreatedAt,
  }) async {
    AppMonthYearPickerResult? result;

    final pickerKey = GlobalKey<_AppMonthYearPickerSheetState>();

    await AppBottomSheet.show<AppMonthYearPickerResult?>(
      context: context,
      backgroundColor: AppColors.primarybackground,

      title: 'Select Month & Year',

      content: AppMonthYearPickerSheet(
        key: pickerKey,
        initialMonth: initialMonth,
        initialYear: initialYear,
        accountCreatedAt: accountCreatedAt,
      ),

      actions: [
        AppButton(
          label: 'Done',
          onPressed: () {
            result = pickerKey.currentState?.getResult();

            Navigator.of(context).pop();
          },
        ),
      ],
    );

    return result;
  }

  @override
  State<AppMonthYearPickerSheet> createState() =>
      _AppMonthYearPickerSheetState();
}

class _AppMonthYearPickerSheetState extends State<AppMonthYearPickerSheet> {
  late int selectedMonth;

  late int selectedYear;

  final now = DateTime.now();

  final months = const [
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

  @override
  void initState() {
    super.initState();

    selectedMonth = widget.initialMonth;

    selectedYear = widget.initialYear;
  }

  @override
  Widget build(BuildContext context) {
    final createdYear = widget.accountCreatedAt.year;

    final years = List.generate(6, (index) => createdYear - index);

    return Column(
      mainAxisSize: MainAxisSize.min,

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        /// YEARS
        SizedBox(
          height: 42,

          child: ListView.separated(
            scrollDirection: Axis.horizontal,

            itemCount: years.length,

            separatorBuilder: (_, _) => const SizedBox(width: 8),

            itemBuilder: (context, index) {
              final year = years[index];

              final isSelected = selectedYear == year;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedYear = year;

                    /// prevent future month
                    if (selectedYear == now.year && selectedMonth > now.month) {
                      selectedMonth = now.month;
                    }
                  });
                },

                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),

                  alignment: Alignment.center,

                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : const Color(0xFFDDC2B6).withValues(alpha: 0.29),

                    borderRadius: BorderRadius.circular(AppRadiusSize.r80),

                    border: Border.all(color: AppColors.transparent),
                  ),

                  child: AppText.bodyM(
                    year.toString(),

                    color: isSelected ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: AppSpacing.s20),

        /// MONTHS
        GridView.builder(
          shrinkWrap: true,

          physics: const NeverScrollableScrollPhysics(),

          itemCount: 12,

          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,

            mainAxisSpacing: 12,

            crossAxisSpacing: 12,

            childAspectRatio: 2.5,
          ),

          itemBuilder: (context, index) {
            final month = index + 1;

            final isFutureMonth = selectedYear == now.year && month > now.month;

            final isSelected = selectedMonth == month;

            return GestureDetector(
              onTap: isFutureMonth
                  ? null
                  : () {
                      setState(() {
                        selectedMonth = month;
                      });
                    },

              child: Container(
                alignment: Alignment.center,

                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.p1
                      : isFutureMonth
                      ? Colors.grey.shade200
                      : const Color(0xFFDDC2B6).withValues(alpha: 0.29),

                  borderRadius: BorderRadius.circular(AppRadiusSize.r12),
                ),

                child: AppText.bodyM(
                  months[index],

                  color: isSelected
                      ? Colors.white
                      : isFutureMonth
                      ? Colors.grey
                      : AppColors.textPrimary,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  AppMonthYearPickerResult getResult() {
    return AppMonthYearPickerResult(
      month: selectedMonth,
      year: selectedYear,
      accountCreatedAt: widget.accountCreatedAt,
    );
  }
}
