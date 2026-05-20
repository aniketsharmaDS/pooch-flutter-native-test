import 'package:flutter/material.dart';

class CollageItem extends StatefulWidget {
  final String imagePath;
  final double? size;
  final double? circleSize;
  final double? imageSize;
  final Color backgroundColor;
  final Alignment alignment;
  final Alignment circleAlignment;
  final Alignment imageAlignment;
  final Offset imageOffset;
  final Offset imagePositionOffset;
  final Duration delay;

  const CollageItem({
    super.key,
    required this.imagePath,
    this.size,
    this.circleSize,
    this.imageSize,
    required this.backgroundColor,
    required this.alignment,
    this.circleAlignment = Alignment.center,
    this.imageAlignment = Alignment.center,
    this.imageOffset = Offset.zero,
    this.imagePositionOffset = Offset.zero,
    this.delay = Duration.zero,
  });

  @override
  State<CollageItem> createState() => _CollageItemState();
}

class _CollageItemState extends State<CollageItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _circleScale;
  late Animation<double> _imageScale;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    // Circle: scale from 0.6 to 1.0 during 0.0 → 0.5 (smooth easeOut, no bounce)
    _circleScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // Image: scale from 0.85 to 1.0 during 0.3 → 1.0 (emerges from circle)
    _imageScale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    // Fade: 0 → 1 during 0.0 → 0.4
    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    // Trigger animation after delay
    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resolvedCircleSize =
        widget.circleSize ?? ((widget.size ?? widget.imageSize ?? 0) * 0.75);
    final resolvedImageSize =
        widget.imageSize ?? widget.size ?? resolvedCircleSize;
    final resolvedSize =
        widget.size ??
        (resolvedCircleSize > resolvedImageSize
            ? resolvedCircleSize
            : resolvedImageSize);

    return Align(
      alignment: widget.alignment,
      child: AnimatedBuilder(
        animation: _fade,
        builder: (context, child) {
          return Opacity(opacity: _fade.value, child: child);
        },
        child: SizedBox(
          width: resolvedSize,
          height: resolvedSize,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Background circle with independent alignment
              Align(
                alignment: widget.circleAlignment,
                child: AnimatedBuilder(
                  animation: _circleScale,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _circleScale.value,
                      child: child,
                    );
                  },
                  child: Container(
                    width: resolvedCircleSize,
                    height: resolvedCircleSize,
                    decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              // Image with independent alignment and scale animation
              Align(
                alignment: widget.imageAlignment,
                child: AnimatedBuilder(
                  animation: _imageScale,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _imageScale.value,
                      child: child,
                    );
                  },
                  child: Image.asset(
                    widget.imagePath,
                    width: resolvedImageSize,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
