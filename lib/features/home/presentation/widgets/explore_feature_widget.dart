import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class ExploreFeatureWidget extends StatelessWidget {
  final String title;
  final String buttonText;
  final String imagePath;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final double imageHeightFromTop;

  const ExploreFeatureWidget({
    super.key,
    required this.title,
    required this.buttonText,
    required this.imagePath,
    required this.backgroundColor,
    required this.imageHeightFromTop,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppSpacing.s167.w,
        height: AppSpacing.s220.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadiusSize.r20.rr),
          border: Border.all(
            color: AppColors.white,
            width: AppRadiusSize.r1.rr,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadiusSize.r18.rr),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      backgroundColor.withValues(alpha: 0.02),
                      backgroundColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),

              /// 🧾 Title
              Positioned(
                top: AppSpacing.s16.h,
                left: 0,
                right: 0,
                child: Center(
                  child: AppText.h3(
                    title,
                    fontSize: AppFontSize.fs31,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
              ),

              Positioned(
                top: AppSpacing.s80.h,
                left: AppSpacing.s25.w,
                right: AppSpacing.s25.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadiusSize.r16.rr),
                  child: Container(
                    height: AppSpacing.s220.h,
                    color: backgroundColor,
                  ),
                ),
              ),

              Positioned(
                top: imageHeightFromTop,
                left: -AppSpacing.s20.w,
                right: -AppSpacing.s30.w,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: AppIcon(imagePath),
                ),
              ),

              /// 🌫 Bottom Blur + CTA
              Positioned(
                // top: 10000,
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(AppRadiusSize.r18.rr),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSpacing.s14.h,
                        horizontal: AppSpacing.s16.w,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0.4),
                            Colors.black.withValues(alpha: 0.1),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: AppButton(
                        borderColor: AppColors.white,
                        variant: AppButtonVariant.outlined,
                        size: AppButtonSize.extraSmall,
                        label: buttonText,
                        width: null,
                        onPressed: onTap,
                        trailingSvgAsset: AppIcons.svg.generic.arrowUpRight,
                        foregroundColor: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
