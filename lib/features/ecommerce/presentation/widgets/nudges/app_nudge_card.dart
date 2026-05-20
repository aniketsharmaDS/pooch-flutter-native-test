import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class AppNudgeCard extends StatelessWidget {
  final String cardTitle;
  final String cardDescription;
  final String cardButtonTitle;
  final String cardBackgroundImage;
  final VoidCallback? cardAction;
  final bool? cardTextInverse;
  final bool? cardVariantVet;

  const AppNudgeCard({
    super.key,
    required this.cardButtonTitle,
    required this.cardDescription,
    required this.cardTitle,
    required this.cardBackgroundImage,
    this.cardAction,
    this.cardTextInverse = false,
    this.cardVariantVet = false,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 346 / 153,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(cardBackgroundImage, fit: BoxFit.cover),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Align(child: _buildContentSection()),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: cardVariantVet! ? AppSize.cs170.csw : AppSize.cs155.csw,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpacing.s10.h),
            AppText.h1(
              cardTitle,
              maxLines: 2,
              style: TextStyle(
                fontSize: AppFontSize.fs16,
                color: cardTextInverse!
                    ? AppColors.buttonPrimaryText
                    : AppColors.textSecondary,
                height: 1.1,
              ),
            ),
            SizedBox(height: AppSpacing.s4.h),
            AppText.bodyS(
              cardDescription,
              maxLines: 3,
              style: TextStyle(
                height: 1.1,
                fontSize: AppFontSize.fs11,
                color: cardTextInverse!
                    ? AppColors.buttonPrimaryText
                    : AppColors.textSecondary,
              ),
            ),
            SizedBox(height: AppSpacing.s10.h),
            AppButton(
              label: cardButtonTitle,
              onPressed: cardAction,
              size: AppButtonSize.extraSmall,
              width: null,
              trailingSvgAsset: AppIcons.svg.generic.chevronRight,
              iconSize: 10.w,
              height: AppSize.cs30.csh,
            ),
          ],
        ),
      ),
    );
  }
}
