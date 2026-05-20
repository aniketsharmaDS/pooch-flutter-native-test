// File: app_slider_input.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSlider extends StatelessWidget {
  const AppSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,

    // Optional
    this.divisions,
    this.onChangeStart,
    this.onChangeEnd,
    this.labelBuilder,

    // Styling
    this.padding,
    this.trackHeight,
    this.thumbRadius,
    this.activeGradient,
    this.inactiveTrackColor,
    this.thumbTextStyle,
    this.enableHapticFeedback = true,
  });

  /// Value Config
  final double value;
  final double min;
  final double max;
  final int? divisions;

  /// Callbacks
  final ValueChanged<double> onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;

  /// Label formatter
  final String Function(double value)? labelBuilder;

  /// Layout
  final EdgeInsetsGeometry? padding;

  /// Styling
  final double? trackHeight;
  final double? thumbRadius;
  final Gradient? activeGradient;
  final Color? inactiveTrackColor;
  final TextStyle? thumbTextStyle;

  /// UX
  final bool enableHapticFeedback;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final displayValue = labelBuilder?.call(value) ?? value.toStringAsFixed(0);

    final resolvedTrackHeight = trackHeight ?? 6.h;
    final resolvedThumbRadius = thumbRadius ?? 14.r;

    final resolvedGradient =
        activeGradient ??
        const LinearGradient(colors: [Color(0xFFFFBC20), Color(0xFFFFDB88)]);

    final resolvedInactiveTrack = inactiveTrackColor ?? Colors.grey.shade300;

    final resolvedTextStyle =
        thumbTextStyle ??
        theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: Colors.black,
        );

    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 8.h),
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: resolvedTrackHeight,
          trackShape: _AppSliderTrackShape(
            gradient: resolvedGradient,
            inactiveColor: resolvedInactiveTrack,
          ),
          thumbShape: _AppSliderThumbShape(
            radius: resolvedThumbRadius,
            gradient: resolvedGradient,
            min: min,
            max: max,
            textStyle: resolvedTextStyle,
          ),
          overlayShape: SliderComponentShape.noOverlay,
          activeTrackColor: Colors.transparent,
          inactiveTrackColor: resolvedInactiveTrack,
          thumbColor: Colors.transparent,
        ),
        child: Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          label: displayValue,
          onChanged: onChanged,
          onChangeStart: onChangeStart,
          onChangeEnd: (v) {
            if (enableHapticFeedback) {
              HapticFeedback.selectionClick();
            }
            onChangeEnd?.call(v);
          },
        ),
      ),
    );
  }
}

class _AppSliderTrackShape extends RoundedRectSliderTrackShape {
  const _AppSliderTrackShape({
    required this.gradient,
    required this.inactiveColor,
  });

  final Gradient gradient;
  final Color inactiveColor;

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    required TextDirection textDirection,
    Offset? secondaryOffset,
    bool isEnabled = true,
    bool isDiscrete = false,
    double additionalActiveTrackHeight = 2,
  }) {
    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // Active (Gradient)
    final activePaint = Paint()
      ..shader = gradient.createShader(
        Rect.fromLTRB(
          trackRect.left,
          trackRect.top,
          thumbCenter.dx,
          trackRect.bottom,
        ),
      );

    // Inactive
    final inactivePaint = Paint()..color = inactiveColor;

    final radius = Radius.circular(trackRect.height / 2);

    // Left (active)
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(
          trackRect.left,
          trackRect.top,
          thumbCenter.dx,
          trackRect.bottom,
        ),
        radius,
      ),
      activePaint,
    );

    // Right (inactive)
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(
          thumbCenter.dx,
          trackRect.top,
          trackRect.right,
          trackRect.bottom,
        ),
        radius,
      ),
      inactivePaint,
    );
  }
}

class _AppSliderThumbShape extends SliderComponentShape {
  const _AppSliderThumbShape({
    required this.radius,
    required this.gradient,
    required this.min,
    required this.max,
    this.textStyle,
  });

  final double radius;
  final Gradient gradient;
  final double min;
  final double max;
  final TextStyle? textStyle;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(radius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final scale = 1 + (activationAnimation.value * 0.25);
    final scaledRadius = radius * scale;

    final paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromCircle(center: center, radius: scaledRadius),
      );

    // Shadow
    context.canvas.drawShadow(
      Path()..addOval(Rect.fromCircle(center: center, radius: scaledRadius)),
      Colors.black.withValues(alpha: 0.25),
      4,
      true,
    );

    // Thumb
    context.canvas.drawCircle(center, scaledRadius, paint);

    // Value text
    final actualValue = (min + (max - min) * value).round();

    final textPainter = TextPainter(
      text: TextSpan(
        text: actualValue.toString(),
        style:
            textStyle ??
            TextStyle(
              color: Colors.white,
              fontSize: scaledRadius * 0.9,
              fontWeight: FontWeight.w700,
            ),
      ),
      textAlign: TextAlign.center,
      textDirection: textDirection,
    )..layout();

    textPainter.paint(
      context.canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );
  }
}
