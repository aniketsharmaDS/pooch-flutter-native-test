import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPrimaryBgContainer extends StatelessWidget {
  final Widget child;
  final BorderRadius? borderRadius; // 👈 ADD THIS

  final primarybgColor = const Color(0xFFFCF3DA);
  final radialColor = const Color(0xFFFFBC20);
  const AppPrimaryBgContainer({
    super.key,
    required this.child,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ClipRRect(
      // ✅ THIS FIXES EVERYTHING
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Stack(
        children: [
          /// 🔹 Base Linear Gradient (overall tone)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primarybgColor, // beige
                  primarybgColor,
                ],
              ),
            ),
          ),

          /// 🔸 Top Right Radial Glow
          Positioned(
            // top: -224.h,
            // right: -137.w,
            top: -screenHeight * 0.3, // Adjusted to be more responsive
            right: -screenWidth * 0.3, // Adjusted to be more responsive
            child: _radialCircle(size: 374.r, color: radialColor),
          ),

          // /// 🔸 Mid Top (slightly left of top-right)
          Positioned(
            // top: 200.h,
            // left: -160.w,
            top: screenHeight * 0.15, // Adjusted to be more responsive
            left: -(screenWidth * 0.465), // Adjusted to be more responsive
            child: _radialCircle(size: 300.r, color: radialColor),
          ),

          // /// 🔸 Mid Bottom (slightly right of bottom-left)
          Positioned(
            // bottom: 220.h,
            // right: -150.w,
            bottom: screenHeight * 0.25, // Adjusted to be more responsive
            right: -(screenWidth * 0.45), // Adjusted to be more responsive
            child: _radialCircle(size: 300.r, color: radialColor),
          ),

          // /// 🔸 Bottom Left Radial Glow
          Positioned(
            // bottom: -130.h,
            // left: -90.w,
            bottom: -screenHeight * 0.15, // Adjusted to be more responsive
            left: -(screenWidth * 0.25), // Adjusted to be more responsive
            child: _radialCircle(size: 325.r, color: radialColor),
          ),

          /// ✅ IMPORTANT: Your content
          Positioned.fill(child: child),
        ],
      ),
    );
  }

  Widget _radialCircle({required double size, required Color color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: 0.3),
            color.withValues(alpha: 0.1), // 👈 FIX
            primarybgColor.withValues(alpha: 0.1), // fully transparent edge
          ],
          stops: const [0.0, 0.7, 1.0],
        ),
      ),
    );
  }
}
