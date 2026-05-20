import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class CommunityHeaderCard extends StatelessWidget {
  final String title;
  final String message;
  final Color? titleColor;
  final Color? messageColor;
  final Color? backgroundColor;

  const CommunityHeaderCard({
    super.key,
    this.title = 'Happy Update!',
    required this.message,
    this.titleColor,
    this.messageColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.s16.w),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.s16.r),
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppText.h1(
            title,
            color: titleColor ?? AppColors.primary,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          AppSpacing.s8.hBox,
          AppText.h1(
            message,
            color: messageColor ?? const Color(0xFF6B5210),
            textAlign: TextAlign.center,
            fontSize: AppFontSize.fs14,
            style: const TextStyle(fontWeight: FontWeight.w400, height: 1.5),
            // maxLines: null,
            // variant: AppTextVariant.noEllipsis,
          ),
        ],
      ),
    );
  }
}
