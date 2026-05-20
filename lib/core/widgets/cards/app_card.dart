import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_theme.dart';

class AppCard extends StatelessWidget {
  const AppCard({required this.child, super.key, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppTheme.spacingMd),
        child: child,
      ),
    );
  }
}
