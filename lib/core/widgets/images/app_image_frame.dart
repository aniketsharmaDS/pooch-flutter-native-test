import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';

class AppImageFrame extends StatelessWidget {
  final double width;
  final double height;
  final String imageUrl;
  final BoxFit fit;
  final bool hasBorder;
  final bool hasShadow;

  const AppImageFrame({
    super.key,
    required this.width,
    required this.height,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.hasBorder = false,
    this.hasShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    // Handle empty image URL - show fallback placeholder
    if (imageUrl.trim().isEmpty) {
      return SizedBox(
        width: width,
        height: height,
        child: ClipPath(
          clipper: EightShapeClipper(),
          child: Container(
            color: const Color(0xFFF6F0E6),
            child: Center(
              child: AppIcon(
                AppIcons.svg.generic.poochLogo,
                width: AppSize.cs18,
                height: AppSize.cs18,
              ),
            ),
          ),
        ),
      );
    }

    Widget child = ClipPath(
      clipper: EightShapeClipper(),
      child: AppIcon(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        // onError: () {
        //   // Handled below with custom error widget
        // },
      ),
    );

    if (hasBorder || hasShadow) {
      child = CustomPaint(
        painter: EightShapePainter(hasBorder: hasBorder, hasShadow: hasShadow),
        child: child,
      );
    }

    return SizedBox(width: width, height: height, child: child);
  }
}

class EightShapeClipper extends CustomClipper<Path> {
  static Path getPath(Size size) {
    final w = size.width;
    final h = size.height;

    final radius = w * 0.5; // full capsule width
    final halfH = h / 2;

    final path = Path();

    // Top capsule
    final top = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(w / 2, halfH * 0.5),
        width: w,
        height: halfH,
      ),
      Radius.circular(radius),
    );

    // Bottom capsule
    final bottom = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(w / 2, halfH * 1.5),
        width: w,
        height: halfH,
      ),
      Radius.circular(radius),
    );

    path.addRRect(top);
    path.addRRect(bottom);

    return path;
  }

  @override
  Path getClip(Size size) => getPath(size);

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class EightShapePainter extends CustomPainter {
  final bool hasBorder;
  final bool hasShadow;

  EightShapePainter({required this.hasBorder, required this.hasShadow});

  @override
  void paint(Canvas canvas, Size size) {
    final path = EightShapeClipper.getPath(size);

    if (hasShadow) {
      canvas.drawShadow(path, Colors.black.withValues(alpha: 0.2), 12, false);
    }

    if (hasBorder) {
      final paint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
