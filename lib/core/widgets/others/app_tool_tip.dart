import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_typography.dart';

class AppTooltip extends StatelessWidget {
  const AppTooltip({
    super.key,
    required this.message,
    required this.child,
    this.preferBelow = true,
    this.verticalOffset = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
    this.textStyle,
    this.backgroundColor = const Color(0xFF1D1C1B),
    this.borderColor = const Color(0x1AFFFFFF),
    this.borderRadius = 14,
    this.triggerMode = TooltipTriggerMode.tap,
    this.waitDuration = Duration.zero,
    this.showDuration = const Duration(seconds: 2),
  });

  final String message;
  final Widget child;
  final bool preferBelow;
  final double verticalOffset;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final TextStyle? textStyle;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final TooltipTriggerMode triggerMode;
  final Duration waitDuration;
  final Duration showDuration;

  @override
  Widget build(BuildContext context) {
    final effectiveTextStyle = textStyle ?? AppTypography.bodyM;

    return Tooltip(
      message: message,
      textStyle: effectiveTextStyle,
      preferBelow: preferBelow,
      verticalOffset: verticalOffset,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      triggerMode: triggerMode,
      waitDuration: waitDuration,
      showDuration: showDuration,
      child: child,
    );
  }
}
