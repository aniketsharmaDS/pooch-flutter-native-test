import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';

class BottomNavigationPersistent extends StatelessWidget {
  final bool isLast;
  final VoidCallback onNext;

  final double lift = 30.0;
  final double arcHeight = 120.0;

  const BottomNavigationPersistent({
    super.key,
    required this.isLast,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    if (isLast) {
      return SafeArea(
        child: ClipRRect(
          // clipper:  ,
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 3, sigmaY: 2),
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: AppSpacing.s20,
                left: AppSpacing.s24,
                right: AppSpacing.s24,
                top: AppSpacing.s30,
              ),
              child: ClipRect(
                child: AppButton(
                  label: 'Get Started',
                  enableGlass: true,
                  // variant: AppButtonVariant.filled,
                  borderColor: Colors.white.withValues(alpha: 0.05),
                  foregroundColor: Colors.white,
                  onPressed: onNext,
                ),
              ),
            ),
          ),
        ),
      );
    }

    final double arcApexY = arcHeight * 0.38 - lift;
    final double buttonDiameter = 56.0;
    final double buttonBottom = arcHeight - arcApexY - (buttonDiameter / 2);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRect(
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 3, sigmaY: 2),
            child: Container(
              height: arcHeight + lift,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.4),
                    Colors.transparent,
                  ],
                ),
              ),
              child: CustomPaint(painter: ArcPainter(lift: lift)),
            ),
          ),
        ),
        Positioned(
          bottom: buttonBottom.roundToDouble(),
          child: RepaintBoundary(
            child: Container(
              width: AppSize.cs56.roundToDouble(),
              height: AppSize.cs56.roundToDouble(),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    // spreadRadius: 0,
                  ),
                ],
              ),
              child: ClipOval(
                // clipBehavior: Clip.antiAlias,
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Material(
                    color: Colors.white.withValues(alpha: 0.75),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: onNext,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: SizedBox(
                        width: AppSize.cs56.roundToDouble(),
                        height: AppSize.cs56.roundToDouble(),
                        child: Center(
                          child: AppIcon(AppIcons.svg.generic.rightIcon),

                          /// TEST THIS TEMPORARILY
                          /// If this looks clean, your SVG is the issue
                          // child: Icon(
                          //   Icons.arrow_forward_ios_rounded,
                          //   size: 22,
                          // ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PositionPadding extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const PositionPadding({
    super.key,
    required this.child,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: padding, child: child);
  }
}

class ArcPainter extends CustomPainter {
  final double lift;

  ArcPainter({required this.lift});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..shader = ui.Gradient.linear(
        Offset(size.width, 0),
        const Offset(0, 0),
        [AppColors.white, AppColors.white.withValues(alpha: 0.1)],
        [0.1783, 0.8812],
      );

    final path = Path()
      ..moveTo(0, size.height - lift)
      ..quadraticBezierTo(
        size.width / 2,
        size.height * 0.01 - lift,
        size.width,
        size.height - lift,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
