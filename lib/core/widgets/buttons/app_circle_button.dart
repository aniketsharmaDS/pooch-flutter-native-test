import 'dart:io' show Platform;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

enum AppCircleButtonSize {
  small,
  medium,
  regular,
  large,
  xlarge,
  xxlarge,
  xxxlarge,
}

enum AppCircleButtonVariant { primary, secondary, glass }

enum AppCircleButtonShape { circle, square }

enum RippleType { bounded, unbounded }

class AppCircleButton extends StatefulWidget {
  final String icon;
  final bool isLoading;

  final AppCircleButtonSize size;
  final AppCircleButtonVariant variant;
  final double? visualSize;
  final double? iconSize;

  final AppCircleButtonShape shape;
  final double? borderRadius;

  final Color? bgColor;
  final Color? iconColor;

  final bool showShadow;
  final Color? shadowColor;

  final VoidCallback? onTap;
  final String? semanticLabel;

  final int? badgeCount;
  final bool? showBadge;
  final Color? badgeColor;
  final Color? badgeTextColor;

  final EdgeInsets hitSlop;
  final RippleType rippleType;
  final bool useMaterial;
  final bool enableHaptic;
  final bool preserveSvgColor;
  final bool enableFeedback;

  const AppCircleButton({
    super.key,
    required this.icon,
    this.isLoading = false,
    this.size = AppCircleButtonSize.regular,
    this.shape = AppCircleButtonShape.circle,
    this.variant = AppCircleButtonVariant.primary,
    this.visualSize,
    this.iconSize,
    this.borderRadius,
    this.bgColor,
    this.iconColor,
    this.showShadow = true,
    this.shadowColor,
    this.onTap,
    this.semanticLabel,
    this.badgeCount = 0,
    this.showBadge = false,
    this.badgeColor = AppColors.primary,
    this.badgeTextColor = AppColors.textPrimary,
    this.hitSlop = const EdgeInsets.all(8),
    this.rippleType = RippleType.unbounded,
    this.useMaterial = false,
    this.enableHaptic = true,
    this.enableFeedback = false,
    this.preserveSvgColor = false,
  });

  @override
  State<AppCircleButton> createState() => _AppCircleButtonState();
}

class _AppCircleButtonState extends State<AppCircleButton> {
  bool _isPressed = false;

  double _defaultSize() {
    switch (widget.size) {
      case AppCircleButtonSize.small:
        return 32.r;
      case AppCircleButtonSize.medium:
        return 40.r;
      case AppCircleButtonSize.regular:
        return 42.r;
      case AppCircleButtonSize.large:
        return 48.r;
      case AppCircleButtonSize.xlarge:
        return 56.r;
      case AppCircleButtonSize.xxlarge:
        return 64.r;
      case AppCircleButtonSize.xxxlarge:
        return 68.r;
    }
  }

  double _defaultIconSize() {
    switch (widget.size) {
      case AppCircleButtonSize.small:
        return 16.r;
      case AppCircleButtonSize.medium:
        return 20.r;
      case AppCircleButtonSize.regular:
        return 22.r;
      case AppCircleButtonSize.large:
        return 24.r;
      case AppCircleButtonSize.xlarge:
        return 28.r;
      case AppCircleButtonSize.xxlarge:
        return 32.r;
      case AppCircleButtonSize.xxxlarge:
        return 36.r;
    }
  }

  Color _getBackgroundColor() {
    if (widget.bgColor != null) {
      return (_isPressed && widget.enableFeedback)
          ? widget.bgColor!.withValues(alpha: 0.1)
          : widget.bgColor!;
    }

    switch (widget.variant) {
      case AppCircleButtonVariant.primary:
        return _isPressed ? const Color(0xFF260B01) : const Color(0xFF1B1B1B);
      case AppCircleButtonVariant.secondary:
        return _isPressed ? const Color(0xFFFFF9E9) : const Color(0xFFFFFEFD);
      case AppCircleButtonVariant.glass:
        return _isPressed ? const Color(0xFFFFECBC) : const Color(0xFFFFF9E9);
    }
  }

  Color _getShadowColor() {
    if (widget.shadowColor != null) {
      return _isPressed
          ? widget.shadowColor!.withValues(alpha: 0.2)
          : widget.shadowColor!;
    }

    switch (widget.variant) {
      case AppCircleButtonVariant.primary:
        return AppColors.shadowPrimary;
      case AppCircleButtonVariant.secondary:
      case AppCircleButtonVariant.glass:
        return AppColors.shadowSecodary;
    }
  }

  bool _isNetwork(String path) => path.startsWith('http');
  bool _isSvg(String path) => path.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onTap == null || widget.isLoading;

    final visualSize = widget.visualSize ?? _defaultSize();
    final iconSize = widget.iconSize ?? _defaultIconSize();

    final iconColor = isDisabled
        ? Colors.grey.shade400
        : widget.iconColor ?? Colors.black;

    final bgColor = isDisabled
        ? _getBackgroundColor().withValues(alpha: 0.5)
        : _getBackgroundColor();

    /// ICON
    Widget icon;
    if (widget.isLoading) {
      icon = SizedBox(
        width: iconSize,
        height: iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(iconColor),
        ),
      );
    } else if (_isSvg(widget.icon)) {
      icon = _isNetwork(widget.icon)
          ? SvgPicture.network(
              widget.icon,
              width: iconSize,
              height: iconSize,
              colorFilter: widget.preserveSvgColor
                  ? null
                  : ColorFilter.mode(iconColor, BlendMode.srcIn),
            )
          : SvgPicture.asset(
              widget.icon,
              width: iconSize,
              height: iconSize,
              // colorFilter: widget.preserveSvgColor
              //     ? null
              //     : ColorFilter.mode(iconColor, BlendMode.srcIn),
            );
    } else {
      icon = _isNetwork(widget.icon)
          ? Image.network(
              widget.icon,
              width: iconSize,
              height: iconSize,
              color: iconColor,
            )
          : Image.asset(
              widget.icon,
              width: iconSize,
              height: iconSize,
              color: iconColor,
            );
    }

    final isCircle = widget.shape == AppCircleButtonShape.circle;
    final borderRadius = isCircle
        ? BorderRadius.circular(visualSize / 2)
        : BorderRadius.circular(widget.borderRadius ?? 12);

    final shapeBorder = isCircle
        ? const CircleBorder()
        : RoundedRectangleBorder(borderRadius: borderRadius);

    /// 🔥 VISUAL BUTTON
    Widget visualButton = AnimatedScale(
      duration: const Duration(milliseconds: 120),
      scale: _isPressed ? 0.92 : 1,
      child: Container(
        width: visualSize,
        height: visualSize,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: (widget.showShadow && !isDisabled)
              ? [
                  BoxShadow(
                    color: _getShadowColor(),
                    blurRadius: AppRadiusSize.r6.rr,
                  ),
                ]
              : [],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: borderRadius,
              child: widget.variant == AppCircleButtonVariant.glass
                  ? BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                      child: _innerContainer(bgColor, borderRadius, icon),
                    )
                  : _innerContainer(bgColor, borderRadius, icon),
            ),
            // 👇 move badge here (outside clipping)
            if (widget.showBadge == true) ...[
              Positioned(top: -2, right: -2, child: _buildBadge()),
            ],
          ],
        ),
      ),
    );

    /// GESTURE
    final useMaterial = widget.useMaterial || (!Platform.isIOS);

    Widget gestureLayer;

    if (useMaterial) {
      gestureLayer = Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: isDisabled
              ? null
              : () {
                  if (widget.enableHaptic) {
                    HapticFeedback.lightImpact();
                  }
                  widget.onTap?.call();
                },
          onHighlightChanged: (v) => setState(() => _isPressed = v),
          customBorder: widget.rippleType == RippleType.bounded
              ? shapeBorder
              : null,
          splashColor: widget.enableFeedback
              ? iconColor.withValues(alpha: 0.12)
              : Colors.transparent,
          highlightColor: widget.enableFeedback
              ? iconColor.withValues(alpha: 0.06)
              : Colors.transparent,
          child: SizedBox.expand(child: Center(child: visualButton)),
        ),
      );
    } else {
      gestureLayer = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: isDisabled
            ? null
            : () {
                if (widget.enableHaptic) {
                  HapticFeedback.lightImpact();
                }
                widget.onTap?.call();
              },
        child: SizedBox.expand(child: Center(child: visualButton)),
      );
    }

    return Semantics(
      button: true,
      enabled: !isDisabled,
      label: widget.semanticLabel ?? 'Icon button',
      child: SizedBox(
        width: visualSize + widget.hitSlop.horizontal,
        height: visualSize + widget.hitSlop.vertical,
        child: gestureLayer,
      ),
    );
  }

  /// ✅ INNER UI
  Widget _innerContainer(
    Color bgColor,
    BorderRadius borderRadius,
    Widget icon,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: widget.variant == AppCircleButtonVariant.glass
            ? bgColor.withValues(alpha: 0.6)
            : bgColor,
        borderRadius: borderRadius,
        border: widget.variant == AppCircleButtonVariant.glass
            ? Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: AppSpacing.s1.w,
              )
            : null,
      ),
      child: Center(child: icon),
    );
  }

  Widget _buildBadge() {
    final count = widget.badgeCount;

    if ((count == null || count == 0) && widget.showBadge != true) {
      return const SizedBox.shrink();
    }

    final isDot = widget.showBadge == true && (count == null || count == 0);

    String text = '';
    if (!isDot) {
      text = widget.badgeCount! > 99 ? '99+' : '${widget.badgeCount}';
    }

    return Positioned(
      top: -AppSpacing.s2.h,
      right: -AppSpacing.s4.w,
      child: Container(
        width: AppRadiusSize.r16.rr,
        height: AppRadiusSize.r16.rr,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.badgeColor,
          shape: BoxShape.circle,
        ),
        clipBehavior: Clip.antiAlias,
        child: isDot
            ? Container(
                width: 6.r,
                height: 6.r,
                decoration: BoxDecoration(
                  color: widget.badgeColor,
                  shape: BoxShape.circle,
                ),
              )
            : Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: AppText.support(
                    text,
                    color: widget.badgeTextColor,
                    textAlign: TextAlign.center,
                    fontSize: AppFontSize.fs8,
                  ),
                ),
              ),
      ),
    );
  }
}
