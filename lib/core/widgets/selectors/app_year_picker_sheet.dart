import 'package:flutter/material.dart';

import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';

import 'package:poochcare/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class AppYearPickerSheet extends StatefulWidget {
  const AppYearPickerSheet({
    super.key,
    required this.initialYear,
    required this.accountCreatedAt,
    this.pastYearsCount = 5,
    this.futureYearsCount = 0,
  });

  final int initialYear;
  final DateTime accountCreatedAt;
  final int pastYearsCount;
  final int futureYearsCount;

  static Future<int?> show({
    required BuildContext context,
    required int initialYear,
    required DateTime accountCreatedAt,
    int futureYearsCount = 0,
    int pastYearsCount = 5,
  }) async {
    int? selectedYear;

    final pickerKey = GlobalKey<_AppYearPickerSheetState>();

    await AppBottomSheet.show<void>(
      context: context,

      title: 'Select Year',

      backgroundColor: AppColors.primarybackground,

      content: AppYearPickerSheet(
        key: pickerKey,
        initialYear: initialYear,
        accountCreatedAt: accountCreatedAt,
        futureYearsCount: futureYearsCount,
        pastYearsCount: pastYearsCount,
      ),

      actions: [
        AppButton(
          label: 'Done',

          onPressed: () {
            selectedYear = pickerKey.currentState?.selectedYear;

            Navigator.of(context).pop();
          },
        ),
      ],
    );

    return selectedYear;
  }

  @override
  State<AppYearPickerSheet> createState() => _AppYearPickerSheetState();
}

class _AppYearPickerSheetState extends State<AppYearPickerSheet> {
  late int selectedYear;

  final currentYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();

    selectedYear = widget.initialYear;
  }

  @override
  Widget build(BuildContext context) {
    // final years = List.generate(6, (index) => createdYear - index);

    final accountYear = widget.accountCreatedAt.year;

    final startYear = accountYear - widget.pastYearsCount;
    final endYear = accountYear + widget.futureYearsCount;

    final years = [
      for (int y = startYear; y <= endYear; y++) y,
    ].reversed.toList();

    debugPrint('ACCOUNT CREATED YEAR: ${widget.accountCreatedAt.year}');
    debugPrint('START YEAR: $startYear');
    debugPrint('END YEAR: $endYear');

    return Wrap(
      spacing: 12,
      runSpacing: 12,

      children: years.map((year) {
        final isSelected = selectedYear == year;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedYear = year;
            });
          },

          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),

            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.p1
                  : const Color(0xFFDDC2B6).withValues(alpha: 0.29),

              borderRadius: BorderRadius.circular(AppRadiusSize.r80),
            ),

            child: AppText.bodyM(
              year.toString(),

              color: isSelected ? Colors.white : AppColors.textPrimary,
            ),
          ),
        );
      }).toList(),
    );
  }
}
