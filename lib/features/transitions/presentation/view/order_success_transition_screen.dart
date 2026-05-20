import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:poochcare/core/store/onboarding/onboarding_journey_store_bloc.dart';
import 'package:poochcare/core/store/onboarding/onboarding_journey_store_state.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/transitions/transition_floating_animated_card.dart';
import 'package:poochcare/features/intro_transition/data/models/intro_transition_model.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class OrderSuccessTransitionScreen extends StatefulWidget {
  const OrderSuccessTransitionScreen({super.key});

  @override
  State<OrderSuccessTransitionScreen> createState() =>
      _OrderSuccessTransitionScreenState();
}

class _OrderSuccessTransitionScreenState
    extends State<OrderSuccessTransitionScreen>
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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEADBC8), Color(0xFFE6B75C)],
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 120),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: AppText.h4(
                    'Welcome to\nthe Family!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: AppText.bodyL(
                    'You\'ve successfully\nbrought home a pooch.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: FadeTransition(
                          opacity: _imageOpacity,
                          child: Image.asset(
                            AppIcons.png.transitions.poochOrderSuccess,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            frameBuilder:
                                (
                                  context,
                                  child,
                                  frame,
                                  wasSynchronouslyLoaded,
                                ) {
                                  if (wasSynchronouslyLoaded || frame != null) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                          if (mounted &&
                                              !_animationController
                                                  .isAnimating &&
                                              _animationController.value == 0) {
                                            _animationController.forward();
                                          }
                                        });
                                  }
                                  return child;
                                },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                color: Colors.black12,
                                alignment: Alignment.center,
                                child: const Text('Image placeholder'),
                              );
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(1, -0.80),
                        child: TransitionFloatingAnimatedCard(
                          data: FloatingCardData(
                            title: 'Happy &\nhealthy',
                            position: const Alignment(1, -0.80),
                            slideFrom: SlideFrom.right,
                            delay: 200,
                            customContent: Lottie.asset(
                              AppIcons.lottie.animalFriendly,
                              height: 50.h,
                              width: 50.h,
                              repeat: false,
                            ),
                          ),
                          isActive: true,
                        ),
                      ),
                      Align(
                        alignment: const Alignment(-1.0, 0.24),
                        child: TransitionFloatingAnimatedCard(
                          data: FloatingCardData(
                            title: 'Ready for home',
                            position: const Alignment(-1.0, 0.24),
                            delay: 400,
                            customContent: const Icon(
                              Icons.home,
                              color: Colors.orange,
                            ),
                          ),
                          isActive: true,
                        ),
                      ),
                      Align(
                        alignment: const Alignment(0.0, 1.0),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ClipRect(
                              child: BackdropFilter(
                                filter: ui.ImageFilter.blur(
                                  sigmaX: 2,
                                  sigmaY: 2,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withValues(alpha: 0.3),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                24,
                                0,
                                24,
                                20 + bottomInset,
                              ),
                              child: AppButton(
                                label: 'Continue',
                                enableGlass: true,
                                onPressed: () {
                                  final journeyType = context
                                      .read<OnboardingJourneyStoreBloc>()
                                      .state
                                      .journeyType;

                                  if (journeyType ==
                                      OnboardingJourneyType.buyPet) {
                                    context.router.replaceAll([
                                      CreateParentProfileRoute(),
                                    ]);
                                    return;
                                  }

                                  context.router.replaceAll([
                                    const HomeRoute(),
                                    const OrdersListingRoute(),
                                  ]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
