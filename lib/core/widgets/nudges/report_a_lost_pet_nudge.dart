import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/theme/app_typography.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/cards/app_wave_card.dart';
import 'package:poochcare/core/widgets/enums/notch_variant.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class ReportALostPetNudge extends StatelessWidget {
  final VoidCallback? onReport;

  const ReportALostPetNudge({super.key, this.onReport});

  @override
  Widget build(BuildContext context) {
    return AppWaveCard(
      variant: AppCardNotchVariant.bottomRight,
      notchWidth: AppSpacing.s15.w,
      notchHeight: AppSpacing.s40.h,
      // padding: EdgeInsets.zero,
      backgroundColor: const Color(0xFFF48282).withValues(alpha: 0.70),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildImageSection(),
            AppSpacing.s35.wBox,
            Expanded(child: _buildContentSection()),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return SizedBox(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AppIcon(
            AppIcons.png.nudges.dogCat,
            height: AppSize.cs142.csh,
            width: AppSize.cs150.csh,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 0.w,
            bottom: AppSpacing.s3.h,
            child: AppIcon(
              AppIcons.svg.nudges.dogCatCommunityChip,
              width: AppSize.cs50.csh,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 0.w,
          top: -AppSpacing.s20.h,
          child: IgnorePointer(
            child: AppIcon(
              AppIcons.svg.nudges.reportLostPetShape,
              width: AppSize.cs210.csh,
              // fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 10.h),
              AppText.h1(
                'Report a Lost Pet',
                maxLines: 2,
                style: TextStyle(
                  fontSize: AppFontSize.fs18,
                  color: AppColors.textFieldBackgroundDefault,
                  height: 1.2,
                ),
              ),
              AppSpacing.s6.hBox,
              AppText.bodyS(
                'Help the community spot \nyour pooch and bring \nthem home safely.',
                color: AppColors.textFieldBackgroundDefault,
                maxLines: 3,
                style: const TextStyle(height: 1.2),
              ),
              AppSpacing.s8.hBox,
              AppButton(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.s12.w,
                  AppSpacing.s8.h,
                  AppSpacing.s12.w,
                  AppSpacing.s8.h,
                ),
                label: 'Report Now',
                onPressed: onReport,
                size: AppButtonSize.xSmall,
                width: null,
                customTextStyle: AppTypography.buttonS.copyWith(
                  fontSize: AppFontSize.fs12,
                ),
                trailingSvgAsset: AppIcons.svg.generic.chevronRight,
                iconSize: AppIconSize.is10.ir,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
