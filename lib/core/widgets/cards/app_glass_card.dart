import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';

class AppGlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;

  const AppGlassCard({super.key, required this.child, this.borderRadius = 16});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),

            // ✅ only visual styling
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.white_50.withValues(alpha: 0.6),
                AppColors.white_50.withValues(alpha: 0.7),
              ],
            ),

            boxShadow: [
              BoxShadow(
                color: const Color(0xB2F3E5D4),
                blurRadius: AppRadiusSize.r16.rr,
                offset: const Offset(0, 4),
              ),
            ],

            border: Border.all(
              color: AppColors.white_50.withValues(alpha: 0.3),
            ),
          ),

          child: child, // ✅ no padding here
        ),
      ),
    );
  }
}
