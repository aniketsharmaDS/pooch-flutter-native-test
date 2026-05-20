import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class PetSeeResultView extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const PetSeeResultView({
    super.key,
    this.title = 'See Results',
    this.subtitle = 'Based on your details',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadiusSize.r16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadiusSize.r16),
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: 72.h),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadiusSize.r16),
            gradient: const LinearGradient(
              // begin: Alignment.centerLeft,
              // end: Alignment.centerRight,
              colors: [Color(0xFFFBC245), Color(0xFFF6E7BD)],
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.h1(
                      title,
                      fontSize: AppFontSize.fs18,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(height: 4.h),
                    AppText.bodyL(
                      subtitle,
                      fontSize: AppFontSize.fs14,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              AppCircleButton(
                icon: AppIcons.svg.generic.send,
                onTap: onTap,
                bgColor: AppColors.buttonPrimaryBg,
                iconColor: AppColors.white,
                shadowColor: const Color(0xCB9B6266).withValues(alpha: 0.4),
                iconSize: AppIconSize.is20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
