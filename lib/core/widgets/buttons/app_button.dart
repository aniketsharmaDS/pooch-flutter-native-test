import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_typography.dart';

/// =============================
/// APP BUTTON (FINAL PRODUCTION READY)
/// =============================

enum AppButtonVariant { filled, outlined, text }

enum AppButtonSize { xSmall, extraSmall, small, medium, large }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  final bool isLoading;
  final bool isDisabled;

  final Widget? leadingIcon;
  final Widget? trailingIcon;

  final String? leadingSvgAsset;
  final String? trailingSvgAsset;
  final String? leadingPngAsset;
  final String? trailingPngAsset;
  final double? iconSize;
  final bool tintAssetIconsWithTextColor;

  /// null → wrap content
  /// double.infinity → full width (default)
  /// any numeric value → custom width
  final double? width;
  final double? height;

  final AppButtonSize size;
  final EdgeInsetsGeometry? padding;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;

  final double borderRadius;
  final double borderWidth;

  /// 🔥 NEW: pill shape support
  final bool isPill;

  final bool enableGlass;
  final double blurAmount;

  final TextStyle? textStyle;
  final TextStyle? customTextStyle;

  final AppButtonVariant variant;

  // to disable the touch ripple effect.
  final bool disableRippleEffect; // 👈

  final bool removePadding;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.leadingIcon,
    this.trailingIcon,
    this.leadingSvgAsset,
    this.trailingSvgAsset,
    this.leadingPngAsset,
    this.trailingPngAsset,
    this.iconSize,
    this.tintAssetIconsWithTextColor = true,
    this.width = double.infinity,
    this.height,
    this.size = AppButtonSize.large,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderRadius = 12.0,
    this.borderWidth = 1.2,
    this.isPill = true,
    this.enableGlass = false,
    this.blurAmount = 20.0,
    this.textStyle,
    this.customTextStyle,
    this.variant = AppButtonVariant.filled,
    this.disableRippleEffect = false,
    this.removePadding = false,
  });

  bool get _isDisabled => isDisabled || isLoading || onPressed == null;

  double get _height {
    if (height != null) return height!;
    switch (size) {
      case AppButtonSize.xSmall:
        return 32.h;
      case AppButtonSize.extraSmall:
        return 36.h;
      case AppButtonSize.small:
        return 40.h;
      case AppButtonSize.medium:
        return 48.h;
      case AppButtonSize.large:
        return 56.h;
    }
  }

  EdgeInsets get _defaultPadding {
    switch (size) {
      case AppButtonSize.xSmall:
        return EdgeInsets.symmetric(horizontal: 12.w);
      case AppButtonSize.extraSmall:
        return EdgeInsets.symmetric(horizontal: 12.w);
      case AppButtonSize.small:
        return EdgeInsets.symmetric(horizontal: 14.w);
      case AppButtonSize.medium:
        return EdgeInsets.symmetric(horizontal: 18.w);
      case AppButtonSize.large:
        return EdgeInsets.symmetric(horizontal: 22.w);
    }
  }

  TextStyle _getTextStyle(Color fg) {
    TextStyle base;

    switch (size) {
      case AppButtonSize.large:
      case AppButtonSize.medium:
        base = AppTypography.buttonL;
        break;

      case AppButtonSize.small:
        base = AppTypography.buttonS;
        break;
      case AppButtonSize.extraSmall:
        base = AppTypography.tabLabel;
        break;

      case AppButtonSize.xSmall:
        base = AppTypography.outline;
        break;
    }

    // 🔥 Variant adjustment
    if (variant == AppButtonVariant.text) {
      base = base.copyWith(fontWeight: FontWeight.w500);
    }
    if (customTextStyle != null) {
      return (customTextStyle ?? base).copyWith(color: fg);
    }
    return base.merge(textStyle).copyWith(color: textStyle?.color ?? fg);
  }

  double get _resolvedRadius => isPill ? _height / 2 : borderRadius.r;

  double get _minWidth {
    if (removePadding) return 0;
    switch (size) {
      case AppButtonSize.xSmall:
        return 64.w;
      case AppButtonSize.extraSmall: // 👈 new (36 height)
        return 72.w;
      case AppButtonSize.small:
        return 88.w;
      case AppButtonSize.medium:
        return 96.w;
      case AppButtonSize.large:
        return 112.w;
    }
  }

  double get _resolvedIconSize {
    // ✅ If user provided custom size → use it
    // ✅ If user provided custom size → use it
    if (iconSize != null) return iconSize!.w;

    // ✅ Otherwise fallback to size-based system
    switch (size) {
      case AppButtonSize.xSmall:
        return 12.w;
      case AppButtonSize.extraSmall:
        return 14.w;
      case AppButtonSize.small:
        return 16.w;
      case AppButtonSize.medium:
        return 18.w;
      case AppButtonSize.large:
        return 20.w;
    }
  }

  Widget? _buildIcon({
    required Color color,
    Widget? iconWidget,
    String? svgAsset,
    String? pngAsset,
  }) {
    if (iconWidget != null) return iconWidget;

    if (svgAsset != null) {
      return SvgPicture.asset(
        svgAsset,
        width: _resolvedIconSize,
        height: _resolvedIconSize,
        colorFilter: tintAssetIconsWithTextColor
            ? ColorFilter.mode(color, BlendMode.srcIn)
            : null,
      );
    }

    if (pngAsset != null) {
      return Image.asset(
        pngAsset,
        width: _resolvedIconSize,
        height: _resolvedIconSize,
        color: tintAssetIconsWithTextColor ? color : null,
        colorBlendMode: tintAssetIconsWithTextColor ? BlendMode.srcIn : null,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Determine colors based on button state
    late Color defaultBg;
    late Color defaultFg;
    late Color defaultBorder;

    if (_isDisabled) {
      // Disabled state colors
      switch (variant) {
        case AppButtonVariant.filled:
          defaultBg = AppColors.buttonDisabledBg;
          defaultFg = AppColors.buttonDisabledText;
          defaultBorder = AppColors.buttonDisabledBg;
          break;
        case AppButtonVariant.outlined:
          defaultBg = AppColors.transparent;
          defaultFg = AppColors.buttonDisabledBg;
          defaultBorder = AppColors.buttonDisabledBg;
          break;
        case AppButtonVariant.text:
          defaultBg = AppColors.transparent;
          defaultFg = AppColors.buttonDisabledBg;
          defaultBorder = AppColors.transparent;
          break;
      }
    } else {
      // Normal state colors based on variant
      switch (variant) {
        case AppButtonVariant.filled:
          defaultBg = AppColors.buttonPrimaryBg;
          defaultFg = AppColors.buttonPrimaryText;
          defaultBorder = AppColors.buttonPrimaryBg;
          break;
        case AppButtonVariant.outlined:
          defaultBg = AppColors.transparent;
          defaultFg = AppColors.buttonPrimaryBg;
          defaultBorder = AppColors.buttonPrimaryBg;
          break;
        case AppButtonVariant.text:
          defaultBg = AppColors.transparent;
          defaultFg = AppColors.buttonPrimaryBg;
          defaultBorder = AppColors.transparent;
          break;
      }
    }

    final bg = backgroundColor ?? defaultBg;
    final fg = foregroundColor ?? defaultFg;
    final border = borderColor ?? defaultBorder;
    final isFullWidth = width == double.infinity;
    final resolvedConstraints = width == null
        ? BoxConstraints(minWidth: _minWidth)
        : null;
    final resolvedLeadingIcon = _buildIcon(
      color: fg,
      iconWidget: leadingIcon,
      svgAsset: leadingSvgAsset,
      pngAsset: leadingPngAsset,
    );
    final resolvedTrailingIcon = _buildIcon(
      color: fg,
      iconWidget: trailingIcon,
      svgAsset: trailingSvgAsset,
      pngAsset: trailingPngAsset,
    );

    Widget child = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: width,
      height: _height,
      constraints: resolvedConstraints,
      padding: removePadding ? EdgeInsets.zero : (padding ?? _defaultPadding),
      decoration: BoxDecoration(
        color: enableGlass
            ? AppColors.white.withValues(alpha: 0.4)
            : AppColors.transparent,
        borderRadius: BorderRadius.circular(_resolvedRadius),
        border: variant == AppButtonVariant.outlined || borderColor != null
            ? Border.all(color: border, width: borderWidth.w)
            : null,
      ),
      child: IconTheme.merge(
        data: IconThemeData(color: fg, size: _resolvedIconSize),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 🔹 Original content (kept for width)
            Opacity(
              opacity: isLoading ? 0 : 1,
              child: Row(
                mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (resolvedLeadingIcon != null) ...[
                    resolvedLeadingIcon,
                    SizedBox(width: 8.w),
                  ],
                  if (isFullWidth)
                    Flexible(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: _getTextStyle(fg),
                      ),
                    )
                  else
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: _getTextStyle(fg),
                    ),
                  if (resolvedTrailingIcon != null) ...[
                    SizedBox(width: 8.w),
                    resolvedTrailingIcon,
                  ],
                ],
              ),
            ),

            // 🔹 Loader (overlay)
            if (isLoading)
              SizedBox(
                height: 20.w,
                width: 20.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(fg),
                ),
              ),
          ],
        ),
      ),
    );

    if (enableGlass) {
      child = ClipRRect(
        borderRadius: BorderRadius.circular(_resolvedRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
          child: child,
        ),
      );
    }

    return Semantics(
      button: true,
      enabled: !_isDisabled,
      child: Opacity(
        opacity: _isDisabled ? 1 : 1,
        child: IgnorePointer(
          ignoring: _isDisabled,
          child: Material(
            color: enableGlass ? AppColors.transparent : bg,
            borderRadius: BorderRadius.circular(_resolvedRadius),
            child: InkWell(
              borderRadius: BorderRadius.circular(_resolvedRadius),
              splashColor: disableRippleEffect
                  ? AppColors.transparent
                  : fg.withValues(alpha: 0.16),
              highlightColor: disableRippleEffect
                  ? AppColors.transparent
                  : fg.withValues(alpha: 0.08),
              onTap: onPressed,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

/// =========================================
/// ✅ USAGE EXAMPLES (ALL SCENARIOS COVERED)
/// =========================================

/*

/// IMPORTANT: Wrap app with ScreenUtilInit
ScreenUtilInit(
  designSize: const Size(375, 812),
  builder: (_, child) => MyApp(),
);

--------------------------------------------------
1. FULL WIDTH BUTTON (DEFAULT)
--------------------------------------------------
AppButton(
  label: 'Continue',
  onPressed: () {},
)

--------------------------------------------------
2. WRAP CONTENT
--------------------------------------------------
AppButton(
  label: 'Save',
  width: null,
  onPressed: () {},
)

--------------------------------------------------
3. INSIDE LIST ITEM (PERFECT BEHAVIOR)
--------------------------------------------------
ListTile(
  title: Text('Item Title'),
  trailing: AppButton(
    label: 'Action',
    size: AppButtonSize.small,
    onPressed: () {},
  ),
)

--------------------------------------------------
4. TWO BUTTONS IN SAME ROW (PROPER SPACE)
--------------------------------------------------
Row(
  children: [
    Expanded(
      child: AppButton(
        label: 'Cancel',
        variant: AppButtonVariant.outlined,
        onPressed: () {},
      ),
    ),
    SizedBox(width: 12.w),
    Expanded(
      child: AppButton(
        label: 'Confirm',
        onPressed: () {},
      ),
    ),
  ],
)

--------------------------------------------------
5. ICON BUTTON
--------------------------------------------------
AppButton(
  label: 'Add',
  leadingIcon: Icon(Icons.add, size: 18.sp),
  onPressed: () {},
)

--------------------------------------------------
6. LOADING BUTTON
--------------------------------------------------
AppButton(
  label: 'Submitting',
  isLoading: true,
  onPressed: () {},
)

--------------------------------------------------
7. GLASS BUTTON
--------------------------------------------------
AppButton(
  label: 'Glass',
  enableGlass: true,
  onPressed: () {},
)

*/
