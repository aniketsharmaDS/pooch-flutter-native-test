import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/cards/app_wave_card.dart';
import 'package:poochcare/core/widgets/enums/notch_variant.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class HelpMeFindPoochNudge extends StatelessWidget {
  final VoidCallback? onGetHelp;

  const HelpMeFindPoochNudge({super.key, this.onGetHelp});

  @override
  Widget build(BuildContext context) {
    return AppWaveCard(
      variant: AppCardNotchVariant.bottomRight,
      notchWidth: 15.w,
      notchHeight: 40.h,
      backgroundColor: const Color(0xFFE3C3B1),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildImageSection(),
            SizedBox(width: 14.w),
            Expanded(child: _buildContentSection()),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return SizedBox(
      child: AppIcon(
        AppIcons.png.transitions.poochOnboarding,
        height: 142.h,
        width: 150.w,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildContentSection() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          width: 300.w,
          right: -10.w,
          top: -30.w,
          child: IgnorePointer(
            child: AppIcon(
              AppIcons.svg.nudges.helpPooch,
              width: 300.w,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.h1(
                'Help me find or\ndiscover a Pooch',
                maxLines: 2,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textSecondary,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 8.h),
              AppText.bodyS(
                'A pooch is family-let us\nhelp you find the right one.',
                maxLines: 3,
                style: const TextStyle(height: 1.2),
              ),
              SizedBox(height: 14.h),
              AppButton(
                label: 'Get Help',
                onPressed: onGetHelp,
                size: AppButtonSize.extraSmall,
                width: null,
                trailingSvgAsset: AppIcons.svg.generic.chevronRight,
                iconSize: 10.w,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
