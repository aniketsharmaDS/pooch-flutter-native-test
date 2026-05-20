import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class ExpenseTrackerListItemCard extends StatelessWidget {
  const ExpenseTrackerListItemCard({
    super.key,
    required this.title,
    required this.dateTimeText,
    required this.amount,
    this.onTap,
  });

  final String title;
  final String dateTimeText;
  final String amount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadiusSize.r12),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.s14.w,
            vertical: AppSpacing.s14.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadiusSize.r12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// LEFT CONTENT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TITLE
                    AppText.h1(
                      title,
                      fontSize: AppFontSize.fs14,
                      color: AppColors.p5,
                    ),

                    SizedBox(height: 4.h),

                    /// DATE & TIME
                    AppText.support(dateTimeText, color: AppColors.p5_400),
                  ],
                ),
              ),

              SizedBox(width: AppSpacing.s12.w),

              /// AMOUNT
              AppText.h1(
                amount,
                fontSize: AppFontSize.fs14,
                color: AppColors.p2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
