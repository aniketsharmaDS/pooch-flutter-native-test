import 'dart:ui';

import 'package:flutter/material.dart';

class AppBlurOverlay extends StatelessWidget {
  final Widget child;
  final double blurStrength;
  final Animation<double>? animation;

  const AppBlurOverlay({
    super.key,
    required this.child,
    this.blurStrength = 10.0,
    this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final routeAnimation = animation ?? ModalRoute.of(context)?.animation;
    if (routeAnimation == null) return child;

    return AnimatedBuilder(
      animation: routeAnimation,
      child: child,
      builder: (context, animatedChild) {
        return Stack(
          children: [
            // Clip the filter to the route bounds so Flutter does not blur
            // more pixels than this overlay actually covers.
            Positioned.fill(
              child: RepaintBoundary(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: routeAnimation.value * blurStrength,
                    sigmaY: routeAnimation.value * blurStrength,
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0xFFA28D59).withValues(alpha: 0.6),
                    ),
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
            ),
            // ignore: use_null_aware_elements
            if (animatedChild != null) animatedChild,
          ],
        );
      },
    );
  }
}
