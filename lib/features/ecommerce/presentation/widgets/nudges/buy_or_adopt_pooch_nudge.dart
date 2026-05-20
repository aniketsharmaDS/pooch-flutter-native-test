import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/cards/app_wave_card.dart';
import 'package:poochcare/core/widgets/enums/notch_variant.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class BuyOrAdoptPoochNudge extends StatelessWidget {
  final VoidCallback? onBuyOrAdopt;

  const BuyOrAdoptPoochNudge({super.key, this.onBuyOrAdopt});

  @override
  Widget build(BuildContext context) {
    return AppWaveCard(
      variant: AppCardNotchVariant.bottomRight,
      notchWidth: 15.w,
      notchHeight: 40.h,
      // padding: EdgeInsets.zero,
      backgroundColor: const Color(0xFFFECF51),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildImageSection(),
            SizedBox(width: 35.w),
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
          Positioned(
            left: 0.w,
            top: 0.h,
            child: IgnorePointer(
              child: AppIcon(
                AppIcons.svg.nudges.buyOrAdoptShapeTwo,
                width: 150.w,
                // fit: BoxFit.cover,
              ),
            ),
          ),
          AppIcon(
            AppIcons.png.nudges.dogCat,
            height: 142.h,
            width: 150.w,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 0.w,
            bottom: 3.h,
            child: AppIcon(
              AppIcons.svg.nudges.dogCatChip,
              width: 50.w,
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
          width: 300.w,
          // right: 10.w,
          left: -25.w,
          bottom: -10.w,
          // top: -30.w,
          child: IgnorePointer(
            child: AppIcon(
              AppIcons.svg.nudges.buyOrAdoptShape,
              width: 130.w,
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
              SizedBox(height: 10.h),
              AppText.h1(
                'Buy or adopt a \npooch you love',
                maxLines: 2,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textSecondary,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 8.h),
              AppText.bodyS(
                'Find the perfect pup and \ngive them a loving home',
                maxLines: 3,
                style: const TextStyle(height: 1.2),
              ),
              SizedBox(height: 14.h),
              AppButton(
                label: 'See Pets',
                onPressed: onBuyOrAdopt,
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
