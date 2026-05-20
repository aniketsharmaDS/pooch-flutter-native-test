import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/cards/app_wave_card.dart';
import 'package:poochcare/core/widgets/enums/notch_variant.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class JoinPoochCommunityNudge extends StatelessWidget {
  final VoidCallback? onJoinNow;

  const JoinPoochCommunityNudge({super.key, this.onJoinNow});

  @override
  Widget build(BuildContext context) {
    return AppWaveCard(
      variant: AppCardNotchVariant.bottomLeft,
      notchWidth: 60.w,
      notchHeight: 10.h,
      backgroundColor: const Color(0xFFFAC5C5),
      child: SizedBox(
        width: double.infinity,
        height: 153.h,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildImageSection(),
            SizedBox(width: 10.w),
            Expanded(child: _buildContentSection()),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return SizedBox(
      width: 150.w,
      height: 142.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -226.47.w,
            top: -58.h,
            child: IgnorePointer(
              child: Transform.rotate(
                angle: 170.76 * (math.pi / 180),
                child: Container(
                  width: 380.w,
                  height: 131.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999.r),
                    color: const Color(0xFFFFDCDD),
                  ),
                ),
              ),
            ),
          ),
          AppIcon(
            AppIcons.png.nudges.joinPoochCommunity,
            height: AppSize.cs142.h,
            width: 150.w,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Stack(
      // clipBehavior: Clip.hardEdge,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.h1(
                'Join the Pooch\nCommunity',
                maxLines: 2,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 8.h),
              AppText.bodyS(
                'Find advice, share stories,\nand grow together.',
                maxLines: 3,
                style: const TextStyle(height: 1.2),
              ),
              SizedBox(height: 14.h),
              AppButton(
                label: 'Join Now',
                onPressed: onJoinNow,
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

// extension CommunityPreviewPlaceholder on $AssetsImagesTransitionsGen {
//   AssetGenImage get communityPreview => poochOnboarding;
// }
