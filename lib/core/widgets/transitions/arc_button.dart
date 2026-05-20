import 'dart:ui';

import 'package:flutter/material.dart';

class ArcButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget icon;
  final double size;

  const ArcButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Material(
          color: Colors.white.withValues(alpha: 0.7),
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              width: size,
              height: size,
              child: Center(child: icon),
            ),
          ),
        ),
      ),
    );
  }
}
