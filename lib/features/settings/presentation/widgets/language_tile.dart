import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.shortCode,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String shortCode;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadiusSize.r20),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(AppSpacing.s16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadiusSize.r20),
          border: Border.all(
            color: isSelected ? AppColors.p1 : AppColors.primaryBorder,
            width: isSelected ? 1.5 : 1,
          ),
          color: isSelected
              ? AppColors.p1.withValues(alpha: 0.08)
              : AppColors.surface,
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 48.w,
              height: 48.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.p1 : AppColors.p5_50,
              ),
              child: AppText.h2(
                shortCode,
                color: isSelected ? AppColors.p5_900 : AppColors.p5_700,
              ),
            ),

            SizedBox(width: 14.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.h3(title),

                  SizedBox(height: 4.h),

                  AppText.bodyM(subtitle, color: AppColors.p5_400),
                ],
              ),
            ),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: isSelected
                  ? Container(
                      key: const ValueKey('selected'),
                      width: 28.w,
                      height: 28.w,
                      decoration: const BoxDecoration(
                        color: AppColors.p1,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: AppIcon(
                          AppIcons.svg.generic.check,
                          color: AppColors.p5_900,
                          size: 14.w,
                        ),
                      ),
                    )
                  : Container(
                      key: const ValueKey('unselected'),
                      width: 28.w,
                      height: 28.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.p5_200),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
