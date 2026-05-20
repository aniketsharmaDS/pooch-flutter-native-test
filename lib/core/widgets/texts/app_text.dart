import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_typography.dart';

enum AppTextVariant {
  normal, // default → ellipsis
  noEllipsis, // full text
}

class AppText extends StatelessWidget {
  final String text;
  final TextStyle baseStyle;

  final Color? color;
  final double? fontSize;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final double? letterSpacing;

  final AppTextVariant variant;

  const AppText._(
    this.text, {
    required this.baseStyle,
    this.color,
    this.fontSize,
    this.style,
    this.textAlign,
    this.maxLines,
    this.letterSpacing = 0.0,
    this.variant = AppTextVariant.normal,
    // ignore: unused_element_parameter
    super.key, // forward key to StatelessWidget
  });

  /// ================================
  /// 🔥 FACTORY METHODS
  /// ================================

  // Display XL (60)
  factory AppText.displayXL(
    String text, {
    Color? color,
    TextStyle? style,
    int? maxLines,
    TextAlign? textAlign,
    double? letterSpacing,
    AppTextVariant? variant,
  }) {
    return AppText._(
      text,
      baseStyle: AppTypography.displayXL,
      color: color,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      letterSpacing: letterSpacing,
      variant: variant ?? AppTextVariant.normal,
    );
  }

  // Display L (50)
  factory AppText.displayL(
    String text, {
    Color? color,
    TextStyle? style,
    int? maxLines,
    TextAlign? textAlign,
    double? letterSpacing,
    AppTextVariant? variant,
  }) {
    return AppText._(
      text,
      baseStyle: AppTypography.displayL,
      color: color,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      letterSpacing: letterSpacing,
      variant: variant ?? AppTextVariant.normal,
    );
  }

  // Display M (32)
  factory AppText.displayM(
    String text, {
    Color? color,
    TextStyle? style,
    int? maxLines,
    TextAlign? textAlign,
    double? letterSpacing,
    AppTextVariant? variant,
  }) {
    return AppText._(
      text,
      baseStyle: AppTypography.displayM,
      color: color,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      letterSpacing: letterSpacing,
      variant: variant ?? AppTextVariant.normal,
    );
  }

  // Display S (28)
  factory AppText.displayS(
    String text, {
    Color? color,
    TextStyle? style,
    int? maxLines,
    TextAlign? textAlign,
    double? letterSpacing,
    AppTextVariant? variant,
  }) {
    return AppText._(
      text,
      baseStyle: AppTypography.displayS,
      color: color,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      letterSpacing: letterSpacing,
      variant: variant ?? AppTextVariant.normal,
    );
  }

  // H1 (24)
  factory AppText.h1(
    String text, {
    Color? color,
    double? fontSize,
    TextStyle? style,
    int? maxLines,
    TextAlign? textAlign,
    double? letterSpacing,
    AppTextVariant? variant,
  }) {
    return AppText._(
      text,
      baseStyle: AppTypography.h1,
      color: color,
      fontSize: fontSize,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      letterSpacing: letterSpacing,
      variant: variant ?? AppTextVariant.normal,
    );
  }

  // H2 (18)
  factory AppText.h2(
    String text, {
    Color? color,
    double? fontSize,
    TextStyle? style,
    int? maxLines,
    TextAlign? textAlign,
    double? letterSpacing,
    AppTextVariant? variant,
  }) {
    return AppText._(
      text,
      baseStyle: AppTypography.h2,
      color: color,
      fontSize: fontSize,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      letterSpacing: letterSpacing,
      variant: variant ?? AppTextVariant.normal,
    );
  }

  // H3 (16)
  factory AppText.h3(
    String text, {
    Color? color,
    double? fontSize,
    TextStyle? style,
    int? maxLines,
    TextAlign? textAlign,
    double? letterSpacing,
    AppTextVariant? variant,
  }) {
    return AppText._(
      text,
      baseStyle: AppTypography.h3,
      color: color,
      fontSize: fontSize,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      letterSpacing: letterSpacing,
      variant: variant ?? AppTextVariant.normal,
    );
  }

  // H4 (14)
  factory AppText.h4(
    String text, {
    Color? color,
    double? fontSize,
    TextStyle? style,
    int? maxLines,
    TextAlign? textAlign,
    double? letterSpacing,
    AppTextVariant? variant,
  }) {
    return AppText._(
      text,
      baseStyle: AppTypography.h4,
      color: color,
      fontSize: fontSize,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      letterSpacing: letterSpacing,
      variant: variant ?? AppTextVariant.normal,
    );
  }

  // Body L (16)
  factory AppText.bodyL(
    String text, {
    Color? color,
    double? fontSize,
    TextStyle? style,
    int? maxLines,
    TextAlign? textAlign,
    double? letterSpacing,
    AppTextVariant? variant,
  }) {
    return AppText._(
      text,
      baseStyle: AppTypography.bodyL,
      color: color,
      fontSize: fontSize,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      letterSpacing: letterSpacing,
      variant: variant ?? AppTextVariant.normal,
    );
  }

  // Body M (14)
  factory AppText.bodyM(
    String text, {
    Color? color,
    double? fontSize,
    TextStyle? style,
    int? maxLines,
    TextAlign? textAlign,
    double? letterSpacing,
    AppTextVariant? variant,
  }) {
    return AppText._(
      text,
      baseStyle: AppTypography.bodyM,
      color: color,
      fontSize: fontSize,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      letterSpacing: letterSpacing,
      variant: variant ?? AppTextVariant.normal,
    );
  }

  // Body S (12)
  factory AppText.bodyS(
    String text, {
    Color? color,
    double? fontSize,
    TextStyle? style,
    int? maxLines,
    TextAlign? textAlign,
    double? letterSpacing,
    AppTextVariant? variant,
  }) {
    return AppText._(
      text,
      baseStyle: AppTypography.bodyS,
      color: color,
      fontSize: fontSize,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      letterSpacing: letterSpacing,
      variant: variant ?? AppTextVariant.normal,
    );
  }

  // Support (10)
  factory AppText.support(
    String text, {
    Color? color,
    double? fontSize,
    TextStyle? style,
    int? maxLines,
    TextAlign? textAlign,
    double? letterSpacing,
    AppTextVariant? variant,
  }) {
    return AppText._(
      text,
      baseStyle: AppTypography.support,
      color: color,
      fontSize: fontSize,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      letterSpacing: letterSpacing,
      variant: variant ?? AppTextVariant.normal,
    );
  }

  // Button L (16)
  factory AppText.buttonL(
    String text, {
    Color? color,
    double? fontSize,
    double? letterSpacing,
    TextStyle? style,
  }) {
    return AppText._(
      text,
      baseStyle: AppTypography.buttonL,
      color: color,
      fontSize: fontSize,
      style: style,
      letterSpacing: letterSpacing,
    );
  }

  // Button S (14)
  factory AppText.buttonS(
    String text, {
    Color? color,
    double? fontSize,
    double? letterSpacing,
    TextStyle? style,
  }) {
    return AppText._(
      text,
      baseStyle: AppTypography.buttonS,
      color: color,
      fontSize: fontSize,
      style: style,
      letterSpacing: letterSpacing,
    );
  }

  // Outline (11)
  factory AppText.outline(
    String text, {
    Color? color,
    double? fontSize,
    double? letterSpacing,
    TextStyle? style,
  }) {
    return AppText._(
      text,
      baseStyle: AppTypography.outline,
      color: color,
      fontSize: fontSize,
      style: style,
      letterSpacing: letterSpacing,
    );
  }

  // Tab Label (12)
  factory AppText.tabLabel(
    String text, {
    Color? color,
    double? fontSize,
    double? letterSpacing,
    TextStyle? style,
  }) {
    return AppText._(
      text,
      baseStyle: AppTypography.tabLabel,
      color: color,
      fontSize: fontSize,
      style: style,
      letterSpacing: letterSpacing,
    );
  }

  /// ================================
  /// BUILD
  @override
  Widget build(BuildContext context) {
    TextStyle finalStyle = baseStyle.copyWith(
      color: color ?? AppColors.textPrimary,
      fontSize: fontSize ?? baseStyle.fontSize,
      letterSpacing: letterSpacing ?? baseStyle.letterSpacing ?? 0.0,
    );

    if (style != null) finalStyle = finalStyle.merge(style);

    return Text(
      text,
      style: finalStyle,
      textAlign: textAlign,
      maxLines: variant == AppTextVariant.noEllipsis ? null : maxLines,
      overflow: variant == AppTextVariant.noEllipsis
          ? TextOverflow.visible
          : TextOverflow.ellipsis,
    );
  }
}
