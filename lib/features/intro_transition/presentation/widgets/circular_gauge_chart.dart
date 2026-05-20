import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class CircularGaugeChart extends StatelessWidget {
  final double percentage; // 0-100
  final double size;
  final double strokeWidth;
  final String? label;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const CircularGaugeChart({
    super.key,
    required this.percentage,
    this.size = 60.0,
    this.strokeWidth = 8.0,
    this.label,
    this.labelStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _GaugePainter(
          percentage: percentage.clamp(0.0, 100.0),
          strokeWidth: strokeWidth,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.h1(
                '${label ?? percentage.toStringAsFixed(0)}%',
                color: const Color(0xFFFF8917),
                fontSize: AppFontSize.fs13,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;

  _GaugePainter({required this.percentage, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - (strokeWidth / 2);
    final innerRadius = radius - (strokeWidth / 2);

    final centerFillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;

    canvas.drawCircle(center, innerRadius, centerFillPaint);

    // Background circle (light gray)
    final bgPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = const Color(0xFFFBEEE1);

    canvas.drawCircle(center, radius, bgPaint);

    // Gradient paint for filled circle
    final gradientPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = ui.Gradient.linear(
        const Offset(0, 0),
        Offset(size.width, size.height),
        [
          const Color(0xFFFF8917), // Orange
          const Color(0xFFFFD677), // Yellow
        ],
      );

    // Draw arc based on percentage
    final sweepAngle = (percentage / 100) * 2 * pi;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start from top
      sweepAngle,
      false,
      gradientPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is _GaugePainter) {
      return oldDelegate.percentage != percentage;
    }
    return true;
  }
}
