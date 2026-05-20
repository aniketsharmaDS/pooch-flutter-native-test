import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class ConsultationCouponBanner extends StatelessWidget {
  final String offerText;
  final String description;
  final String couponCode;

  const ConsultationCouponBanner({
    super.key,
    required this.couponCode,
    required this.description,
    required this.offerText,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s10),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppRadiusSize.r16),
            ),
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.s17),
                AppText.h1(
                  'A great deal is waiting for you!',
                  fontSize: AppFontSize.fs16,
                ),
                const SizedBox(height: AppSpacing.s17),
                consultationBannerWidget(
                  description: description,
                  offerText: offerText,
                ),
                const SizedBox(height: AppSpacing.s5),
                AppText.bodyM(
                  'Valid until 19th August 2026',
                  fontSize: AppFontSize.fs10,
                ),
                const SizedBox(height: AppSpacing.s9),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText.h1(
                      'Use code: $couponCode',
                      fontSize: AppFontSize.fs14,
                    ),
                    const SizedBox(width: AppSpacing.s15),
                    InkWell(
                      onTap: () {},
                      child: AppIcon(AppIcons.svg.generic.copy),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.s12),
                AppButton(
                  onPressed: () {},
                  label: 'Redeem Now',
                  width: null,
                  size: AppButtonSize.small,
                  height: 35,
                  trailingIcon: AppIcon(AppIcons.svg.generic.caretRight),
                ),
                const SizedBox(height: AppSpacing.s20),
              ],
            ),
          ),
          Positioned(
            right: 35,
            top: 15,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: AppIcon(AppIcons.svg.generic.close),
            ),
          ),
        ],
      ),
    );
  }

  Container consultationBannerWidget({
    required String offerText,
    required String description,
  }) {
    return Container(
      height: 140.h,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF3B82F6).withValues(alpha: 0.7),
      ),
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
            children: [
              // 1. The Darker Blue Circle Background
              Positioned(
                right: -50, // Move it off-screen to create the curve
                top: -50,
                bottom: -50,
                child: Container(
                  width: 300, // Large width to create a soft curve
                  decoration: const BoxDecoration(
                    color: Color(0xFF3676E0), // Darker blue circle
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: AppIcon(
                  AppIcons.png.nudges.findVetClinic,
                  fit: BoxFit.cover,
                  size: 140,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: horizontalPadding,
                    bottom: bottomPadding,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: contentMaxWidth),
                    child: _buildContentSection(
                      contentMaxWidth,
                      offerText,
                      description,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContentSection(
    double contentMaxWidth,
    String offerText,
    String description,
  ) {
    // final buttonWidth = (contentMaxWidth * 0.82).clamp(100.0, 140.0);

    return Padding(
      padding: EdgeInsets.only(right: AppSpacing.s10.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.h1(
            'Get',
            maxLines: 2,
            style: TextStyle(
              fontSize: AppFontSize.fs16,
              color: AppColors.white_50,
              height: 1.2,
            ),
          ),
          AppText.displayXL(
            offerText,
            maxLines: 1,
            style: TextStyle(
              fontSize: AppFontSize.fs42,
              color: AppColors.white_50,
              height: 1.1,
            ),
          ),
          AppText.bodyS(
            description,
            maxLines: 3,
            color: AppColors.white_50,
            style: const TextStyle(height: 1.2),
          ),
          SizedBox(height: 14.h),
        ],
      ),
    );
  }
}
