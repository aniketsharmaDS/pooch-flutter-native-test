import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/cards/app_wave_card.dart';
import 'package:poochcare/core/widgets/enums/notch_variant.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class PetOptionWaveCard extends StatelessWidget {
  const PetOptionWaveCard({
    super.key,
    required this.title,
    required this.image,
    required this.isSelected,
    this.showBlur = false,
    required this.onTap,
    this.variant = AppCardNotchVariant.topRight,
    this.notchHeight = 50,
    this.notchWidth = 120,
  });

  final String title;
  final String image;
  final bool isSelected;
  final bool showBlur;
  final AppCardNotchVariant variant;
  final VoidCallback onTap;
  final double notchHeight;
  final double notchWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
        child: AspectRatio(
          aspectRatio: 1.6,
          // height: AppSize.cs210.csh,
          // width: double.infinity,
          child: AppWaveCard(
            borderRadius: AppRadiusSize.r20,
            variant: variant,
            notchWidth: notchWidth,
            notchHeight: notchHeight,
            // padding: EdgeInsets.zero,
            isElevated: true,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                AppIcon(image, fit: BoxFit.cover),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 220),
                  opacity: showBlur ? 1 : 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              0,
                              AppSpacing.s5.h,
                              0,
                              AppSpacing.s16.h,
                            ),
                            child: AppText.h2(
                              title,
                              color: AppColors.white,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 220),
                    scale: isSelected ? 1 : 0.9,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 220),
                      opacity: isSelected ? 1 : 0,
                      child: IgnorePointer(
                        ignoring: !isSelected,
                        child: AppCircleButton(
                          icon: AppIcons.svg.generic.check,
                          size: AppCircleButtonSize.large,
                          iconSize: AppIconSize.is20,
                          bgColor: AppColors.white,
                          iconColor: AppColors.p4_400,
                          showShadow: false,
                          borderRadius: AppRadiusSize.r80,
                          onTap: onTap,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
