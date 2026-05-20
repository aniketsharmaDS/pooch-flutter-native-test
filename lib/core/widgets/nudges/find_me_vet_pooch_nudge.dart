import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/cards/app_wave_card.dart';
import 'package:poochcare/core/widgets/enums/notch_variant.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class FindMeVetPoochNudge extends StatelessWidget {
  final VoidCallback? onGetHelp;

  const FindMeVetPoochNudge({super.key, this.onGetHelp});

  @override
  Widget build(BuildContext context) {
    return AppWaveCard(
      variant: AppCardNotchVariant.bottomRight,
      notchWidth: AppSpacing.s5.w,
      notchHeight: AppSpacing.s50.h,
      borderRadius: AppSpacing.s12.r,
      backgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.7),
      child: AspectRatio(
        aspectRatio: 2.2, // Adjust as needed for the desired shape
        child: LayoutBuilder(
          builder: (context, constraints) {
            final contentMaxWidth = constraints.maxWidth * 0.56;
            final horizontalPadding = (constraints.maxWidth * 0.06).clamp(
              14.0,
              28.0,
            );
            final bottomPadding = (constraints.maxHeight * 0.08).clamp(
              10.0,
              18.0,
            );
            return Stack(
              fit: StackFit.expand,
              children: [
                AppIcon(AppIcons.png.nudges.vetNudgeGroup, fit: BoxFit.cover),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: horizontalPadding,
                      bottom: bottomPadding,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: contentMaxWidth),
                      child: _buildContentSection(contentMaxWidth),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContentSection(double contentMaxWidth) {
    // final buttonWidth = (contentMaxWidth * 0.82).clamp(100.0, 140.0);

    return Padding(
      padding: EdgeInsets.only(right: AppSpacing.s10.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.h1(
            'Your Vet Support,\nAnytime You Need It',
            maxLines: 2,
            style: TextStyle(
              fontSize: AppFontSize.fs16,
              color: AppColors.white_50,
              height: 1.2,
            ),
          ),
          SizedBox(height: 8.h),
          AppText.bodyS(
            'Quick, trusted care for\nyour pooch.',
            maxLines: 3,
            color: AppColors.white_50,
            style: const TextStyle(height: 1.2),
          ),
          SizedBox(height: 14.h),
          AppButton(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.s15.w,
              AppSpacing.s10.h,
              AppSpacing.s10.w,
              AppSpacing.s10.h,
            ),
            label: 'Find Vet Clinics',
            onPressed: onGetHelp,
            size: AppButtonSize.medium,
            textStyle: TextStyle(fontSize: AppFontSize.fs12),
            height: 36.h,
            width: null,
            trailingSvgAsset: AppIcons.svg.generic.chevronRight,
            iconSize: 10.w,
          ),
        ],
      ),
    );
  }
}
