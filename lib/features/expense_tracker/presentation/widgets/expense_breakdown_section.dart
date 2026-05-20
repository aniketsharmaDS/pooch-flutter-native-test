import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class ExpenseBreakdownItemData {
  final String title;
  final String amount;
  final Color color;

  const ExpenseBreakdownItemData({
    required this.title,
    required this.amount,
    required this.color,
  });
}

class ExpenseBreakdownSection extends StatelessWidget {
  const ExpenseBreakdownSection({super.key, required this.items});

  final List<ExpenseBreakdownItemData> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE
          AppText.h1(
            'Expense Breakdown',
            fontSize: AppFontSize.fs14,
            color: const Color(0xFF320E02),
          ),

          SizedBox(height: AppSpacing.s16.h),

          /// ITEMS
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.s10.h),
              child: _ExpenseBreakdownItem(item: item),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpenseBreakdownItem extends StatelessWidget {
  const _ExpenseBreakdownItem({required this.item});

  final ExpenseBreakdownItemData item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// DOT
        Container(
          width: AppSize.cs10.w,
          height: AppSize.cs10.h,
          decoration: BoxDecoration(color: item.color, shape: BoxShape.circle),
        ),

        SizedBox(width: AppSpacing.s26.w),

        /// TITLE
        Expanded(
          child: AppText.bodyL(
            item.title,
            fontSize: AppFontSize.fs14,
            color: AppColors.textPrimary,
          ),
        ),

        SizedBox(width: AppSpacing.s12.w),

        /// AMOUNT
        AppText.bodyS(item.amount, color: AppColors.textPrimary),
      ],
    );
  }
}
