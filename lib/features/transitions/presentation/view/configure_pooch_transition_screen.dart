import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/transitions/transition_floating_animated_card.dart';
import 'package:poochcare/features/intro_transition/data/models/intro_transition_model.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class ConfigurePoochTransitionScreen extends StatefulWidget {
  const ConfigurePoochTransitionScreen({super.key});

  @override
  State<ConfigurePoochTransitionScreen> createState() =>
      _ConfigurePoochTransitionScreenState();
}

class _ConfigurePoochTransitionScreenState
    extends State<ConfigurePoochTransitionScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _imageOpacity;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _imageOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    if (!mounted) {
      return;
    }
    context.router.replaceAll([const HomeRoute()]);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topSpacing = MediaQuery.of(context).padding.top + 56;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEADBC8), Color(0xFFF5E9DA)],
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: topSpacing),
                SizedBox(
                  height: size.height * 0.5,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      FadeTransition(
                        opacity: _imageOpacity,
                        child: Image.asset(
                          AppIcons.png.transitions.poochConfigure,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          frameBuilder:
                              (context, child, frame, wasSynchronouslyLoaded) {
                                if (wasSynchronouslyLoaded || frame != null) {
                                  WidgetsBinding.instance.addPostFrameCallback((
                                    _,
                                  ) {
                                    if (mounted &&
                                        !_animationController.isAnimating &&
                                        _animationController.value == 0) {
                                      _animationController.forward();
                                    }
                                  });
                                }
                                return child;
                              },
                        ),
                      ),
                      Align(
                        alignment: const Alignment(1.05, -0.6),
                        child: TransitionFloatingAnimatedCard(
                          data: FloatingCardData(
                            title: 'Pooch, set.',
                            subtitle: 'Care made simple',
                            position: const Alignment(1.05, -0.6),
                            contentHeight: AppSize.cs40,
                            contentWidth: AppSize.cs40,
                            slideFrom: SlideFrom.right,
                            delay: 200,
                            customContent: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                AppRadiusSize.r12,
                              ),
                              child: SizedBox(
                                width: AppIconSize.is40,
                                height: AppIconSize.is40,
                                child: Lottie.asset(
                                  AppIcons.lottie.poochHug,
                                  width: AppIconSize.is40,
                                  height: AppIconSize.is40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          isActive: true,
                        ),
                      ),
                      Align(
                        alignment: const Alignment(-1.05, 0.7),
                        child: TransitionFloatingAnimatedCard(
                          data: FloatingCardData(
                            title: 'Care starts here',
                            customSubtitle: Row(
                              mainAxisSize: MainAxisSize.min,
                              // spacing: AppSpacing.s1,
                              children: List.generate(
                                5,
                                (index) => Lottie.asset(
                                  AppIcons.lottie.shinyHeart,
                                  width: AppIconSize.is24,
                                  height: AppIconSize.is24,
                                ),
                                // (index) => AppIcon(
                                //   AppIcons.lottie.shinyHeart,
                                //   size: AppIconSize.is28,
                                // ),
                              ),
                            ),
                            // subtitle: '❤️❤️❤️❤️❤️',
                            position: const Alignment(-1.05, 0.7),
                            delay: 400,
                          ),
                          isActive: true,
                        ),
                      ),
                    ],
                  ),
                ),
                // const Spacer(),
                SizedBox(height: size.height * 0.08),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: AppText.displayM(
                    'Configuring your\nPooch universe',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.textFieldInputTextDefault,
                      height: 1.1,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: AppText.h3(
                    'We\'re making sure you have\neverything ready to take the\nbest care of your babies',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.textFieldInputTextDefault,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
