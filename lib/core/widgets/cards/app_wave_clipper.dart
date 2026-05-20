import 'package:flutter/material.dart';
import 'package:poochcare/core/widgets/enums/notch_variant.dart';

class AppWaveClipper extends CustomClipper<Path> {
  final double notchHeight;
  final double notchWidth;
  final double? borderRadius;
  final double? bottomNotchHeight;
  final double? bottomNotchWidth;
  final AppCardNotchVariant variant;

  AppWaveClipper({
    required this.notchHeight,
    required this.notchWidth,
    this.bottomNotchHeight,
    this.bottomNotchWidth,
    this.borderRadius,
    required this.variant,
  });

  @override
  Path getClip(Size size) {
    // final defaultRadius = size.width * 0.04;
    final double defaultRadius = 16.0;
    final r = borderRadius ?? defaultRadius;

    final h30 = 15.0;
    final h60 = 35.0;
    final h90 = 45.0;

    final path = Path();

    path.moveTo(0, r);
    path.quadraticBezierTo(0, 0, r, 0);

    /// TOP EDGE
    if (variant == AppCardNotchVariant.topRight ||
        variant == AppCardNotchVariant.topRightBottomLeft) {
      final start = size.width - notchWidth;

      path.lineTo(start, 0);

      path.quadraticBezierTo(
        start + notchWidth * .25,
        0,
        start + notchWidth * .25,
        (h30 + 10),
      );

      path.lineTo(start + notchWidth * .25, h30 + notchHeight);

      path.quadraticBezierTo(
        start + notchWidth * .25,
        h60 + notchHeight,
        start + notchWidth * .45,
        h60 + notchHeight,
      );

      path.lineTo(start + notchWidth * .85, h60 + notchHeight);

      path.quadraticBezierTo(
        size.width,
        (h60 + notchHeight),
        size.width,
        (h90 + notchHeight) + 20,
      );
    } else {
      path.lineTo(size.width - r, 0);
      path.quadraticBezierTo(size.width, 0, size.width, r);
    }

    /// RIGHT SIDE
    /// RIGHT SIDE
    if (variant == AppCardNotchVariant.bottomRight) {
      final start = size.height - notchHeight; // swapped

      path.lineTo(size.width, start);

      path.quadraticBezierTo(
        size.width,
        start + notchHeight * .25, // swapped
        size.width - h30,
        start + notchHeight * .25, // swapped
      );

      path.lineTo(
        size.width - notchWidth - h30,
        start + notchHeight * .25,
      ); // swapped

      path.quadraticBezierTo(
        size.width - notchWidth - h60,
        start + notchHeight * .25,
        size.width - notchWidth - h60,
        start + notchHeight * .45,
      );

      path.lineTo(
        size.width - notchWidth - h60,
        size.height - notchHeight * .15,
      );

      path.quadraticBezierTo(
        size.width - notchWidth - h60,
        size.height,
        size.width - notchWidth - h90,
        size.height,
      );
    } else {
      path.lineTo(size.width, size.height - r);
    }

    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - r,
      size.height,
    );

    /// BOTTOM EDGE
    if (variant == AppCardNotchVariant.bottomLeft ||
        variant == AppCardNotchVariant.topRightBottomLeft) {
      final tempNotchWidth = bottomNotchWidth ?? notchWidth;
      final tempNotchHeight = (bottomNotchHeight ?? notchHeight).clamp(
        40.0,
        80.0,
      );
      final start = tempNotchWidth;

      path.lineTo(start, size.height);

      path.quadraticBezierTo(
        start - tempNotchWidth * .25,
        size.height,
        start - tempNotchWidth * .25,
        size.height - h30,
      );

      path.lineTo(
        start - tempNotchWidth * .25,
        size.height - h30 - tempNotchHeight,
      );

      path.quadraticBezierTo(
        start - tempNotchWidth * .25,
        size.height - h60 - tempNotchHeight,
        start - tempNotchWidth * .45,
        size.height - h60 - tempNotchHeight,
      );

      path.lineTo(
        start - tempNotchWidth * .85,
        size.height - h60 - tempNotchHeight,
      );

      path.quadraticBezierTo(
        0,
        size.height - h60 - tempNotchHeight,
        0,
        size.height - h90 - tempNotchHeight,
      );
    } else {
      path.lineTo(r, size.height);
    }

    path.quadraticBezierTo(0, size.height, 0, size.height - r);

    path.close();

    return path;
  }

  Path getClip1(Size size) {
    final defaultRadius = size.width * 0.04;
    final r = borderRadius ?? defaultRadius;

    final h30 = size.height * 0.06;
    final h60 = size.height * 0.12;
    final h90 = size.height * 0.18;

    final path = Path();

    path.moveTo(0, r);
    path.quadraticBezierTo(0, 0, r, 0);

    /// TOP EDGE
    if (variant == AppCardNotchVariant.topRight ||
        variant == AppCardNotchVariant.topRightBottomLeft) {
      final start = size.width - notchWidth;

      path.lineTo(start, 0);

      path.quadraticBezierTo(
        start + notchWidth * .25,
        0,
        start + notchWidth * .25,
        h30,
      );

      path.lineTo(start + notchWidth * .25, h30 + notchHeight);

      path.quadraticBezierTo(
        start + notchWidth * .25,
        h60 + notchHeight,
        start + notchWidth * .45,
        h60 + notchHeight,
      );

      path.lineTo(start + notchWidth * .85, h60 + notchHeight);

      path.quadraticBezierTo(
        size.width,
        h60 + notchHeight,
        size.width,
        h90 + notchHeight,
      );
    } else {
      path.lineTo(size.width - r, 0);
      path.quadraticBezierTo(size.width, 0, size.width, r);
    }

    /// RIGHT SIDE
    /// RIGHT SIDE
    if (variant == AppCardNotchVariant.bottomRight) {
      final start = size.height - notchHeight; // swapped

      path.lineTo(size.width, start);

      path.quadraticBezierTo(
        size.width,
        start + notchHeight * .25, // swapped
        size.width - h30,
        start + notchHeight * .25, // swapped
      );

      path.lineTo(
        size.width - notchWidth - h30,
        start + notchHeight * .25,
      ); // swapped

      path.quadraticBezierTo(
        size.width - notchWidth - h60,
        start + notchHeight * .25,
        size.width - notchWidth - h60,
        start + notchHeight * .45,
      );

      path.lineTo(
        size.width - notchWidth - h60,
        size.height - notchHeight * .15,
      );

      path.quadraticBezierTo(
        size.width - notchWidth - h60,
        size.height,
        size.width - notchWidth - h90,
        size.height,
      );
    } else {
      path.lineTo(size.width, size.height - r);
    }

    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - r,
      size.height,
    );

    /// BOTTOM EDGE
    if (variant == AppCardNotchVariant.bottomLeft ||
        variant == AppCardNotchVariant.topRightBottomLeft) {
      final tempNotchWidth = bottomNotchWidth ?? notchWidth;
      final tempNotchHeight = bottomNotchHeight ?? notchHeight;
      final start = tempNotchWidth;

      path.lineTo(start, size.height);

      path.quadraticBezierTo(
        start - tempNotchWidth * .25,
        size.height,
        start - tempNotchWidth * .25,
        size.height - h30,
      );

      path.lineTo(
        start - tempNotchWidth * .25,
        size.height - h30 - tempNotchHeight,
      );

      path.quadraticBezierTo(
        start - tempNotchWidth * .25,
        size.height - h60 - tempNotchHeight,
        start - tempNotchWidth * .45,
        size.height - h60 - tempNotchHeight,
      );

      path.lineTo(
        start - tempNotchWidth * .85,
        size.height - h60 - tempNotchHeight,
      );

      path.quadraticBezierTo(
        0,
        size.height - h60 - tempNotchHeight,
        0,
        size.height - h90 - tempNotchHeight,
      );
    } else {
      path.lineTo(r, size.height);
    }

    path.quadraticBezierTo(0, size.height, 0, size.height - r);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
