import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';

class AppWishlistButton extends StatefulWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final double size;

  const AppWishlistButton({
    super.key,
    required this.isSelected,
    required this.onTap,
    this.size = 14,
  });

  @override
  State<AppWishlistButton> createState() => _AppWishlistButtonState();
}

class _AppWishlistButtonState extends State<AppWishlistButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    _controller.forward().then((_) {
      _controller.reverse();
    });
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: _onTap,
            overlayColor: WidgetStatePropertyAll(Colors.white.withAlpha(30)),
            child: Center(
              child: widget.isSelected
                  ? ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          colors: [Color(0xFFFFBC20), Color(0xFFFFDB88)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      child: AppIcon(
                        AppIcons.svg.generic.heartFilledGradient,
                        size: widget.size,
                        color: Colors.white,
                      ),
                    )
                  : AppIcon(
                      AppIcons.svg.generic.heartOutlined,
                      size: widget.size,
                      color: const Color(0xFF8A8782),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return ScaleTransition(
  //     scale: _scaleAnimation,
  //     child: AppCircleButton(
  //       icon: widget.isSelected
  //           ? AppIcons.svg.generic.heartFilledGradient
  //           : AppIcons.svg.generic.heartOutlined,

  //       onTap: _onTap,

  //       variant: AppCircleButtonVariant.secondary,
  //       showShadow: false,
  //       visualSize: 24,
  //       iconSize: 28,

  //       hitSlop: const EdgeInsets.symmetric(horizontal: 8),

  //       bgColor: Colors.transparent,

  //       preserveSvgColor: widget.isSelected,

  //       iconColor: widget.isSelected ? null : const Color(0xFF8A8782),
  //     ),
  //   );
  // }
}
