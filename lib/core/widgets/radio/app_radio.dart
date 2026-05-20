import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_spacing.dart';

class AppRadio extends StatelessWidget {
  final String label;

  final bool isSelected;
  final VoidCallback onTap;

  final Widget? icon;
  final Widget? selectedIcon;

  final bool use3DIcon;
  final Axis layout;

  final double width;
  final double height;

  final EdgeInsetsGeometry? padding;

  final Color? backgroundColor;
  final Color? selectedBackgroundColor;

  final Color? borderColor;
  final Color? selectedBorderColor;

  final double borderRadius;

  // 3D icon positioning
  final double icon3DPositionTop;
  final double icon3DPositionRight;

  const AppRadio({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
    this.selectedIcon,
    this.use3DIcon = false,
    this.layout = Axis.vertical,
    this.width = AppSpacing.s100,
    this.height = AppSpacing.s100,
    this.padding,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.borderColor,
    this.selectedBorderColor,
    this.borderRadius = 15,
    this.icon3DPositionTop = -20,
    this.icon3DPositionRight = 8,
  });

  @override
  Widget build(BuildContext context) {
    final Color resolvedBackground = isSelected
        ? (selectedBackgroundColor ?? Colors.white)
        : (backgroundColor ?? Colors.white);

    final Color resolvedBorder = isSelected
        ? (selectedBorderColor ??
              Theme.of(context).colorScheme.primary.withValues(alpha: 90))
        : (borderColor ?? const Color(0xFFEFE8E6));

    final Color resolvedTextColor = isSelected
        ? AppColors.primaryIcon
        : AppColors.secondaryIcon;

    final Widget? resolvedIcon = isSelected && selectedIcon != null
        ? selectedIcon
        : icon;

    final Widget iconWidget = resolvedIcon == null
        ? const SizedBox.shrink()
        : (resolvedIcon is SizedBox || resolvedIcon is Image)
        ? resolvedIcon
        : IconTheme.merge(
            data: IconThemeData(
              size: use3DIcon ? AppSpacing.s72.h : AppSpacing.s28.h,
              color: resolvedTextColor,
            ),
            child: resolvedIcon,
          );

    final Widget textWidget = Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: resolvedTextColor,
        fontSize: use3DIcon ? AppSpacing.s12p7.h : AppSpacing.s12.h,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
      ),
    );

    final Widget content;

    if (use3DIcon) {
      // 3D mode: horizontal card with text left and icon right (floating overflow)
      content = Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: textWidget,
                ),
              ),
              AppSpacing.s70.wBox, // Reserve space for icon
            ],
          ),
          Positioned(
            right: icon3DPositionRight,
            top: icon3DPositionTop,
            child: iconWidget,
          ),
        ],
      );
    } else {
      content = layout == Axis.horizontal
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: textWidget),
                if (resolvedIcon != null) AppSpacing.s10.wBox,
                iconWidget,
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconWidget,
                if (resolvedIcon != null) AppSpacing.s8.hBox,
                textWidget,
              ],
            );
    }

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            padding:
                padding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: resolvedBackground,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: resolvedBorder,
                width: isSelected ? 1.4 : 1,
              ),
            ),
            child: content,
          ),
        ),
      ),
    );
  }
}
