import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class AssistHeaderWidget extends StatelessWidget {
  const AssistHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppSize.cs200.csh,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          radius: 1.2,
          colors: [Color(0xFFFFF3C4), Color(0x00FFFFFF)],
          stops: [0.0, 1.0],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.translate(
            offset: Offset(0, AppSpacing.s10.h),
            child: _gradientText('Pooch', AppFontSize.fs49),
          ),
          _gradientText('ASSIST', AppFontSize.fs64),

          Transform.translate(
            offset: Offset(0, -AppSpacing.s28.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  // flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: AppText.bodyL(
                      'Ask me whatever',
                      color: const Color(0xFF6F382B),
                      fontSize: AppFontSize.fs14,
                    ),
                  ),
                ),

                _buildMicButton(),

                Expanded(
                  // flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AppText.bodyL(
                      'you want...',
                      color: const Color(0xFF6F382B),
                      fontSize: AppFontSize.fs14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _gradientText(String text, double fontSize) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFBC20), Color(0xFFFFDB88)],
      ).createShader(bounds),
      child: AppText.displayXL(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white, // IMPORTANT
        ),
      ),
    );
  }

  Widget _buildMicButton() {
    return SizedBox(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: AppRadiusSize.r60.rr,
            height: AppRadiusSize.r60.rr,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFFEFAF1),
                width: AppRadiusSize.r2.rr,
              ),
            ),
          ),

          // 🟡 Radial circle (68px)
          Container(
            width: AppRadiusSize.r58.rr,
            height: AppRadiusSize.r58.rr,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFFF7EA), // adjust to your radial tone
            ),
          ),

          // 🟠 Radial circle (50px)
          Container(
            width: AppRadiusSize.r50.rr,
            height: AppRadiusSize.r50.rr,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFFE4b2), // slightly darker inner radial
            ),
          ),

          // 🎤 Button (center)
          AppCircleButton(
            variant: AppCircleButtonVariant.secondary,
            bgColor: const Color(0xFFFDB927),
            size: AppCircleButtonSize.medium,
            showShadow: false,
            icon: AppIcons.svg.generic.mic,
            preserveSvgColor: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
