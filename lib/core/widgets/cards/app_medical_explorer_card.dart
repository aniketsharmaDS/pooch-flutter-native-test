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

class AppMedicalExplorerCard extends StatelessWidget {
  final String title;
  final String buttonText;
  final String imagePath;
  final VoidCallback? onTap;

  const AppMedicalExplorerCard({
    super.key,
    required this.title,
    required this.buttonText,
    required this.imagePath,
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
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFD9EEFF), Color(0xFF3B82F6)],
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
                  child: AppText.support(title, fontSize: AppFontSize.fs16),
                ),
              ),

              /// 🖼 Image Card
              Positioned(
                top: AppSpacing.s50.h,
                left: AppSpacing.s12.w,
                right: AppSpacing.s12.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadiusSize.r16.rr),
                  child: Container(
                    height: AppSpacing.s110.h,
                    color: Colors.blue.shade400,
                  ),
                ),
              ),

              // ignore: prefer_single_quotes
              if (title == "Vaccinations") ...[
                Positioned(
                  top: AppSpacing.s50.h,
                  left: -AppSpacing.s70.w,
                  right: 0,
                  bottom: AppSpacing.s60.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadiusSize.r16.rr),
                    child: AppIcon(imagePath, fit: BoxFit.cover),
                  ),
                ),
              ] else ...[
                Positioned(
                  top: AppSpacing.s40.h,
                  left: -AppSpacing.s20.w,
                  right: -AppSpacing.s30.w,
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadiusSize.r16.rr),
                    child: AppIcon(imagePath, fit: BoxFit.cover),
                  ),
                ),
              ],

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
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                        variant: AppButtonVariant.text,
                        size: AppButtonSize.extraSmall,
                        label: buttonText,
                        onPressed: onTap,
                        trailingSvgAsset: AppIcons.svg.generic.arrowRight,
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
