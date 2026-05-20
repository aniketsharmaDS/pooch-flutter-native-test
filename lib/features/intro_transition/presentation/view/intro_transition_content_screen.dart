import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/transitions/transition_floating_animated_card.dart';
import 'package:poochcare/features/intro_transition/data/models/intro_transition_model.dart';

class IntroTransitionContent extends StatefulWidget {
  final IntroTransitionModel data;
  final VoidCallback onSkip;
  final bool isActive;

  const IntroTransitionContent({
    super.key,
    required this.data,
    required this.onSkip,
    required this.isActive,
  });

  @override
  State<IntroTransitionContent> createState() => _IntroTransitionContentState();
}

class _IntroTransitionContentState extends State<IntroTransitionContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _imageController;
  late final Animation<double> _imageOpacity;

  @override
  void initState() {
    super.initState();
    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _imageOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _imageController, curve: Curves.easeInOutBack),
    );

    if (widget.isActive) {
      _imageController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant IntroTransitionContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActive != widget.isActive) {
      if (widget.isActive) {
        _imageController.forward(from: 0);
      } else {
        _imageController.reset();
      }
    }
  }

  @override
  void dispose() {
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [widget.data.bgGradientStart, widget.data.bgGradientEnd],
        ),
      ),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Stack(
          children: [
            // Main Image
            Align(
              alignment: Alignment.bottomCenter,
              child: FadeTransition(
                opacity: _imageOpacity,
                child: Image.asset(
                  widget.data.imagePath,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      color: Colors.black12,
                      alignment: Alignment.center,
                      child: const Text('Image placeholder'),
                    );
                  },
                ),
              ),
            ),

            // Floating Cards
            Positioned.fill(
              child: Stack(
                children: widget.data.cards.map((cardData) {
                  return Align(
                    alignment: cardData.position,
                    child: TransitionFloatingAnimatedCard(
                      data: cardData,
                      isActive: widget.isActive,
                    ),
                  );
                }).toList(),
              ),
            ),

            // Top Content Layer
            Positioned.fill(
              child: Column(
                children: [
                  // Top Row (Skip button)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.s16.w,
                      vertical: AppSpacing.s16.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (widget.data.showSkip)
                          Column(
                            children: [
                              // const SizedBox(height: 24),
                              AppSpacing.s16.hBox,
                              AppButton(
                                variant: AppButtonVariant.text,
                                size: AppButtonSize.small,
                                width: AppSize.cs95,
                                onPressed: widget.onSkip,
                                label: 'SKIP',
                                textStyle: const TextStyle(
                                  fontFamily: 'Gilroy700',
                                ),
                                // textColor: Colors.black87,
                                trailingIcon: AppIcon(
                                  AppIcons.svg.generic.rightSkip,
                                  size: AppIconSize.is12,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          )
                        else
                          AppSpacing.s48.hBox,
                      ],
                    ),
                  ),
                  AppSpacing.s16.hBox,
                  AppText.h4(
                    textAlign: TextAlign.center,
                    widget.data.title,
                    style: TextStyle(
                      fontSize: AppFontSize.fs52,
                      color: AppColors.textSecondary,
                      height: 0.85,
                      shadows: const [
                        Shadow(
                          color: AppColors.textShadow,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                  ),

                  AppSpacing.s14.hBox,

                  // Subtitle
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.s32.w),
                    child: AppText.h4(
                      textAlign: TextAlign.center,
                      widget.data.subtitle,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: AppFontSize.fs16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
