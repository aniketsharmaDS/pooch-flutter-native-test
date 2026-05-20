import 'dart:math';
import 'package:flutter/material.dart';

class DashedRectPainter extends CustomPainter {
  final Color color;

  DashedRectPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const dashWidth = 4.0;
    const dashSpace = 3.0;

    // Draw top
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(min(startX + dashWidth, size.width), 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }

    // Draw bottom
    startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height),
        Offset(min(startX + dashWidth, size.width), size.height),
        paint,
      );
      startX += dashWidth + dashSpace;
    }

    // Draw left
    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, min(startY + dashWidth, size.height)),
        paint,
      );
      startY += dashWidth + dashSpace;
    }

    // Draw right
    startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width, startY),
        Offset(size.width, min(startY + dashWidth, size.height)),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant DashedRectPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
