import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/cards/app_wave_card.dart';
import 'package:poochcare/core/widgets/enums/notch_variant.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class AuthPetShapeHeaderView extends StatelessWidget {
  const AuthPetShapeHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -15,
            left: 0,
            right: 0,
            child: AppWaveCard(
              clip: Clip.hardEdge,
              variant: AppCardNotchVariant.topRightBottomLeft,
              backgroundColor: AppColors.transparent,
              notchHeight: AppSpacing.s30.h,
              notchWidth: AppSpacing.s160.w,
              bottomNotchHeight: AppSpacing.s10.h,
              bottomNotchWidth: AppSpacing.s80.w,
              // borderRadius: AppRadiusSize.r20,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFFE7B4), // #FFE7B4
                        Color(0xFFF5F1E5), // #F5F1E5
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -10,
            left: 0,
            right: 0,
            // top: 0,
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText.h4(
                    'WELCOME TO',
                    fontSize: AppFontSize.fs12,
                    letterSpacing: 2.0,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: AppSpacing.s8.h),
                  SvgPicture.asset(
                    AppIcons.svg.generic.poochTitle,
                    height: AppSpacing.s40.h,
                  ),
                  SizedBox(height: AppSpacing.s2.h),
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: Image.asset(AppIcons.png.register.registerDogCat),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
