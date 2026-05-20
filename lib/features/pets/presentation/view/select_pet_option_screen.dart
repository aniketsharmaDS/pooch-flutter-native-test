import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/enums/notch_variant.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/pets/presentation/widgets/pet_option_wave_card.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class SelectPetOptionScreen extends StatefulWidget {
  const SelectPetOptionScreen({
    super.key,
    this.initialPhoneNumber,
    this.initialEmail,
    this.initialCountryCode,
  });

  final String? initialPhoneNumber;
  final String? initialEmail;
  final String? initialCountryCode;

  @override
  State<SelectPetOptionScreen> createState() => _SelectPetOptionScreenState();
}

class _SelectPetOptionScreenState extends State<SelectPetOptionScreen> {
  int selectedIndex = -1;

  void _onNext() {
    if (selectedIndex == 0) {
      context.router.push(
        CreatePetProfileRoute(
          initialPhoneNumber: widget.initialPhoneNumber,
          initialEmail: widget.initialEmail,
          initialCountryCode: widget.initialCountryCode,
        ),
      );
      return;
    }

    if (selectedIndex == 1) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Coming soon.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isCtaEnabled = selectedIndex >= 0;

    return Scaffold(
      body: AppPrimaryBgContainer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppSpacing.s12.hBox,
                SizedBox(
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: IconButton(
                      //     onPressed: () => context.router.maybePop(),
                      //     style: IconButton.styleFrom(
                      //       foregroundColor: AppColors.textPrimary,
                      //       padding: EdgeInsets.zero,
                      //       minimumSize: Size(
                      //         AppSpacing.s24.w,
                      //         AppSpacing.s24.h,
                      //       ),
                      //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      //     ),
                      //     icon: AppIcon(
                      //       AppIcons.svg.generic.chevronLeft,
                      //       size: AppIconSize.is16,
                      //     ),
                      //   ),
                      // ),
                      AppText.h1(
                        'Welcome to pooch!',
                        fontSize: AppFontSize.fs16,
                        color: AppColors.p4_900,
                      ),
                    ],
                  ),
                ),

                // AppSpacing.s12.hBox,
                AppSpacing.s40.hBox,
                Center(
                  child: AppText.h4(
                    'Select option',
                    fontSize: AppFontSize.fs32,
                    color: AppColors.textPrimary,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                AppSpacing.s25.hBox,
                PetOptionWaveCard(
                  title: 'I have a pet',
                  image: AppIcons.jpg.onboarding.havePet,
                  isSelected: selectedIndex == 0,
                  showBlur: selectedIndex >= 0 && selectedIndex != 0,
                  notchWidth: AppSize.cs60,
                  notchHeight: AppSize.cs24,
                  onTap: () => setState(() => selectedIndex = 0),
                ),
                AppSpacing.s20.hBox,
                PetOptionWaveCard(
                  title: "I don't have a pet, need \nto buy/adopt?",
                  image: AppIcons.jpg.onboarding.dontHavePet,
                  isSelected: selectedIndex == 1,
                  showBlur: selectedIndex >= 0 && selectedIndex != 1,
                  variant: AppCardNotchVariant.bottomLeft,
                  notchWidth: AppSize.cs56,
                  notchHeight: AppSize.cs16,
                  onTap: () => setState(() => selectedIndex = 1),
                ),
                const Spacer(),
                Center(
                  child: Opacity(
                    opacity: isCtaEnabled ? 1 : 0.5,
                    child: AppCircleButton(
                      icon: AppIcons.svg.generic.chevronRight,
                      size: AppCircleButtonSize.xlarge,
                      iconSize: AppIconSize.is16,
                      bgColor: AppColors.p5_900,
                      iconColor: AppColors.white,
                      onTap: isCtaEnabled ? _onNext : null,
                    ),
                  ),
                ),
                AppSpacing.s24.hBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
