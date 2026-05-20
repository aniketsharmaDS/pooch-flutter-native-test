import 'package:flutter/widgets.dart';

enum SlantType { left, right, both }

class GradientSlantPainter extends CustomPainter {
  final List<Color> colors;
  final SlantType type;

  GradientSlantPainter({required this.colors, required this.type});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // 1. Define the Gradient Shader
    final gradient = LinearGradient(
      begin: Alignment.topCenter, // Gradient starts on the far left
      end: Alignment.bottomCenter, // Gradient ends on the far right
      colors: colors,
    );

    // 2. Apply the Shader to the Paint object
    final paint = Paint()
      ..shader = gradient
          .createShader(rect) // <--- THIS IS THE KEY!
      ..style = PaintingStyle.fill
      ..isAntiAlias = true; // Crucial for smoothing slanted lines

    // 3. Define the Path (Same shape logic as before)
    final path = Path();
    double slantWidth = size.width * 0.2;
    double slantWidthFromRight = size.width * 0.8;
    path.moveTo(0, size.height);
    path.lineTo(type == SlantType.right ? 0 : slantWidth, 0);
    path.lineTo(
      type == SlantType.left
          ? size.width
          : type == SlantType.right
          ? slantWidthFromRight
          : size.width - slantWidth,
      0,
    );
    path.lineTo(size.width, size.height);
    path.close();

    // 4. Draw the Path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant GradientSlantPainter oldDelegate) =>
      colors != oldDelegate.colors;
}
