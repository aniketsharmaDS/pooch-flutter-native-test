import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

/// A like counter widget with animation that displays like count and status.
/// Shows a scale animation (like YouTube) when transitioning from unliked to liked.
/// State is managed by the parent and notified via [onTap].
class AppLikeCounter extends StatefulWidget {
  final int count;
  final bool isLiked;
  final VoidCallback? onTap;
  final double iconSize;
  final Color activeColor;
  final Color inactiveColor;
  final TextStyle? textStyle;

  const AppLikeCounter({
    super.key,
    this.count = 0,
    this.isLiked = false,
    this.onTap,
    this.iconSize = 20,
    this.activeColor = AppColors.textPrimary,
    this.inactiveColor = AppColors.textPrimary,
    this.textStyle,
  });

  @override
  State<AppLikeCounter> createState() => _AppLikeCounterState();
}

class _AppLikeCounterState extends State<AppLikeCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 1.1,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.1,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_animationController);
  }

  @override
  void didUpdateWidget(AppLikeCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Trigger animation when transitioning from unliked to liked
    if (!oldWidget.isLiked && widget.isLiked) {
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      final millions = count / 1000000;
      return millions % 1 == 0
          ? '${millions.toInt()}M'
          : '${millions.toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      final thousands = count / 1000;
      return thousands % 1 == 0
          ? '${thousands.toInt()}K'
          : '${thousands.toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  Widget _buildLikeIcon({required double iconSize}) {
    if (!widget.isLiked) {
      return Icon(
        Icons.favorite_border,
        size: iconSize,
        color: const Color(0xFF8A8782),
      );
    }

    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) {
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFBC20), Color(0xFFFFDB88)],
        ).createShader(bounds);
      },
      child: Icon(Icons.favorite, size: iconSize, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool shouldShowCount = widget.count > 0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: AppSpacing.s38.w,
          height: AppSpacing.s38.w,
          child: IconButton(
            style: const ButtonStyle(
              padding: WidgetStatePropertyAll(EdgeInsets.zero),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: widget.onTap,
            icon: AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: _buildLikeIcon(iconSize: widget.iconSize),
                );
              },
            ),
          ),
        ),
        if (shouldShowCount) ...[
          // SizedBox(width: 4.w),
          AppText.bodyS(
            _formatCount(widget.count),
            color: AppColors.communityActionLabel,
          ),
        ],
      ],
    );
  }
}
