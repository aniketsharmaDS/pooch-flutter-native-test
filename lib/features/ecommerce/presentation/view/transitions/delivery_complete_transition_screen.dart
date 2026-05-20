import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/transitions/transition_floating_animated_card.dart';
import 'package:poochcare/features/intro_transition/data/models/intro_transition_model.dart';

@RoutePage()
class DelieveryCompleteTransitionScreen extends StatefulWidget {
  const DelieveryCompleteTransitionScreen({super.key});

  @override
  State<DelieveryCompleteTransitionScreen> createState() =>
      _DelieveryCompleteTransitionScreenState();
}

class _DelieveryCompleteTransitionScreenState
    extends State<DelieveryCompleteTransitionScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _imageOpacity;
  late final String _selectedPetImage;

  static int _petCycleIndex = 0;

  String _getAlternatingPetImage() {
    switch (_petCycleIndex) {
      case 0:
        _petCycleIndex = 1;
        return AppIcons.png.transitions.poochDeliveredDog;
      case 1:
        _petCycleIndex = 2;
        return AppIcons.png.transitions.poochDeliveredCat;
      case 2:
        _petCycleIndex = 0;
        return AppIcons.png.transitions.poochDeliveredBoth;
      default:
        _petCycleIndex = 1;
        return AppIcons.png.transitions.poochDeliveredDog;
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedPetImage = _getAlternatingPetImage();

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
                    'Delivered\nwith Love',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 46,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: AppText.bodyL(
                    'Your pooch is home and ready\nto start making memories.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w400),
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
                            _selectedPetImage,
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
                            customContent: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ),
                          isActive: true,
                        ),
                      ),
                      Align(
                        alignment: const Alignment(-1.0, 0.24),
                        child: TransitionFloatingAnimatedCard(
                          data: FloatingCardData(
                            title: 'A loving home found',
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
                                label: 'See Order Details',
                                enableGlass: true,
                                onPressed: () {},
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
