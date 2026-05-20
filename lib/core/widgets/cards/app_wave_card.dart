// import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/widgets/cards/app_wave_clipper.dart';
import 'package:poochcare/core/widgets/enums/notch_variant.dart';

class AppWaveCard extends StatelessWidget {
  final Widget child;
  final Widget? actionWidget;
  final Color backgroundColor;
  final double notchHeight;
  final double notchWidth;
  final double? bottomNotchHeight;
  final double? bottomNotchWidth;
  final double? borderRadius;
  final bool isElevated;
  final bool isGlass;
  final EdgeInsetsGeometry? padding;
  final Clip clip;

  final AppCardNotchVariant variant;

  const AppWaveCard({
    super.key,
    required this.child,
    this.actionWidget,
    this.backgroundColor = const Color.fromARGB(74, 221, 205, 182),
    this.notchHeight = 50,
    this.notchWidth = 120,
    this.bottomNotchHeight,
    this.bottomNotchWidth,
    this.borderRadius,
    this.variant = AppCardNotchVariant.topRight,
    this.padding = const EdgeInsets.all(0),
    this.isElevated = false,
    this.isGlass = false,
    this.clip = Clip.none,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: clip,
      children: [
        /// SHADOW
        ///
        if (!isElevated) ...[
          PhysicalShape(
            clipper: AppWaveClipper(
              borderRadius: borderRadius,
              notchHeight: notchHeight,
              notchWidth: notchWidth,
              bottomNotchHeight: bottomNotchHeight,
              bottomNotchWidth: bottomNotchWidth,
              variant: variant,
            ),
            clipBehavior: Clip.antiAlias,
            color: backgroundColor,
            child: Container(
              decoration: const BoxDecoration(),
              padding: padding,
              child: child,
            ),
          ),
        ] else if (isGlass == true) ...[
          GlassContainer(
            // height: 200,
            // width: 200,
            blur: 10,
            // color: const Color(0xFFDDCDB6).withValues(alpha: 0.29),
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     Colors.white.withOpacity(0.2),
            //     Colors.blue.withOpacity(0.3),
            //   ],
            // ),
            //--code to remove border
            border: const Border.fromBorderSide(BorderSide.none),
            shadowStrength: 5,
            shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(16),
            // shadowColor: const Color(0xFFDDCDB6).withValues(alpha: 0.29),
            child: PhysicalShape(
              clipper: AppWaveClipper(
                borderRadius: borderRadius,
                notchHeight: notchHeight,
                notchWidth: notchWidth,
                bottomNotchHeight: bottomNotchHeight,
                bottomNotchWidth: bottomNotchWidth,
                variant: variant,
              ),
              clipBehavior: Clip.antiAlias,
              color: const Color(
                0xFFDDCDB6,
              ).withValues(alpha: 0.29), // 👈 glass tint
              // elevation: AppRadiusSize.r8.rr,
              // shadowColor: const Color(
              //   0xFFDDCDB6,
              // ).withValues(alpha: 0.29),
              child: Container(
                decoration: const BoxDecoration(),
                padding: padding,
                child: child,
              ),
            ),
          ),
        ] else ...[
          PhysicalShape(
            clipper: AppWaveClipper(
              borderRadius: borderRadius,
              notchHeight: notchHeight,
              notchWidth: notchWidth,
              bottomNotchHeight: bottomNotchHeight,
              bottomNotchWidth: bottomNotchWidth,
              variant: variant,
            ),
            clipBehavior: Clip.antiAlias,
            color: backgroundColor,
            elevation: AppRadiusSize.r8.rr,
            shadowColor: AppColors.shadowPrimary.withValues(alpha: 0.4),
            child: Container(
              decoration: const BoxDecoration(),
              padding: padding,
              child: child,
            ),
          ),
        ],

        if (actionWidget != null)
          Positioned(right: 0, top: 3, child: actionWidget!),
      ],
    );
  }
}
