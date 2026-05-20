import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/features/intro_transition/data/models/intro_transition_model.dart';
import 'package:poochcare/features/intro_transition/presentation/widgets/circular_gauge_chart.dart';

List<IntroTransitionModel> getIntroTransitionScreen() {
  return [
    // 1. Pooch Secure
    IntroTransitionModel(
      title: 'Pooch\nSecure',
      subtitle: 'Facial Recognition for your pets.',
      imagePath: AppIcons.png.transitions.poochSecure,
      bgGradientStart: const Color(0x99FFEDCF),
      bgGradientEnd: const Color(0xFFEBB945),

      cards: [
        FloatingCardData(
          title: 'Pet Emergency Fund',
          position: const Alignment(-1.1, -0.3),
          contentWidth: AppSize.cs40,
          contentHeight: AppSize.cs40,
          delay: 700,
          customContent: Lottie.asset(
            AppIcons.lottie.coin,
            width: AppSize.cs100,
            height: AppSize.cs100,
            fit: BoxFit.contain,
          ),
        ),
        FloatingCardData(
          title: 'AI + AR',
          subtitle: 'AI mood scans',
          position: const Alignment(0.95, 0.1),
          slideFrom: SlideFrom.right,
          delay: 900,
          customContent: Lottie.asset(
            AppIcons.lottie.scan,
            width: AppSize.cs100,
            height: AppSize.cs100,
            fit: BoxFit.contain,
          ),
        ),
      ],
    ),

    // 2. Pooch Insights
    IntroTransitionModel(
      title: 'Pooch\nInsights',
      subtitle: 'Real time health awareness of your pets.',
      imagePath: AppIcons.png.transitions.poochInsights,
      bgGradientStart: const Color(0x99FFEFEA),
      bgGradientEnd: const Color(0xFFE59743),
      cards: [
        FloatingCardData(
          title: 'Health',
          subtitle: 'Score',
          position: const Alignment(-0.9, -0.2),
          contentWidth: AppSize.cs90,
          contentHeight: AppSize.cs80,
          contentOnRight: true,
          delay: 700,
          customContent: const CircularGaugeChart(
            percentage: 25,
            label: '35',
            size: 70,
            strokeWidth: 15,
            valueStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFF8917),
            ),
          ),
        ),
        FloatingCardData(
          contentWidth: AppSize.cs40,
          contentHeight: AppSize.cs60,
          contentPaddingHorizontal: AppSpacing.s10.w,
          contentOnRight: true,
          contentAlignment: FloatingCardContentAlignment.center,
          // contentPaddingVertical: AppSpacing.s20.h,
          title: '',
          slideFrom: SlideFrom.right,
          delay: 900,
          customContent: AppIcon(
            AppIcons.svg.transitions.insightVet,
            width: 40,
            height: 40,
          ),
          position: const Alignment(0.93, 0.06),
        ),
      ],
    ),

    // 3. Pooch Serve
    IntroTransitionModel(
      title: 'Pooch\nServe',
      subtitle: 'Access quality petcare at your finger tips',
      imagePath: AppIcons.png.transitions.poochServe,
      bgGradientStart: const Color(0x99FFF8F2),
      bgGradientEnd: const Color(0xFFF8C78B),
      cards: [
        FloatingCardData(
          title: 'Vet Checkup',
          subtitle: 'Today, 3:00 PM',
          // icon: Icons.circle,
          position: const Alignment(-0.98, -0.05),
          delay: 700,
          customContent: ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [Color(0xFFFFBC20), Color(0xFFFFDB88)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: const Icon(
              Icons.circle,
              size: 18,
              color: Colors.white, // required for mask
            ),
          ),
        ),
        FloatingCardData(
          title: 'Everything you need',
          subtitle: '500+ products available',
          position: const Alignment(1.05, 0.4),
          slideFrom: SlideFrom.right,
          contentWidth: AppSize.cs40,
          contentHeight: AppSize.cs40,
          delay: 900,
          customContent: Lottie.asset(AppIcons.lottie.giveOrder),
        ),
      ],
    ),

    // 4. Pooch Fun
    IntroTransitionModel(
      title: 'Pooch\nFun',
      subtitle: 'Enjoy their goofy cuteness even more',
      imagePath: AppIcons.png.transitions.poochFun,
      bgGradientStart: const Color(0x99FFE1CE),
      bgGradientEnd: const Color(0xFFDE9F6C),
      showSkip: false,
      isLast: true,
      cards: [
        FloatingCardData(
          title: 'Your virtual Buddy',
          // subtitle: '❤️❤️❤️❤️',
          customSubtitle: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpacing.s10,
            children: List.generate(
              4,
              (index) => AppIcon(
                AppIcons.png.transitions.heart,
                size: AppIconSize.is24,
              ),
            ),
          ),
          position: const Alignment(-0.9, -0.3),
          contentWidth: AppSize.cs40,
          contentHeight: AppSize.cs40,
          delay: 700,
          customContent: AppIcon(
            AppIcons.png.transitions.funPuppy,
            width: AppSize.cs56,
            height: AppSize.cs56,
          ),
        ),
        FloatingCardData(
          title: 'Adoption\nSupport',
          icon: Icons.pets,
          position: const Alignment(0.45, 0.60),
          contentHeight: AppSize.cs56,
          contentWidth: AppSize.cs56,
          slideFrom: SlideFrom.right,
          delay: 900,
          customContent: SvgPicture.asset(
            AppIcons.svg.transitions.kittens,
            width: 30,
            height: 30,
          ),
        ),
      ],
    ),
  ];
}
