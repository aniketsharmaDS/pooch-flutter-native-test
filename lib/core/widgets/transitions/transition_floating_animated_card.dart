import 'package:flutter/material.dart';
import 'package:poochcare/core/widgets/transitions/transition_floating_card.dart';
import 'package:poochcare/features/intro_transition/data/models/intro_transition_model.dart';

class TransitionFloatingAnimatedCard extends StatefulWidget {
  final FloatingCardData data;
  final bool isActive;

  const TransitionFloatingAnimatedCard({
    super.key,
    required this.data,
    required this.isActive,
  });

  @override
  State<TransitionFloatingAnimatedCard> createState() =>
      _TransitionFloatingAnimatedCardState();
}

class _TransitionFloatingAnimatedCardState
    extends State<TransitionFloatingAnimatedCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _opacityAnimation;
  int _animationTriggerId = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _offsetAnimation = Tween<Offset>(
      begin: _beginOffsetFor(widget.data.slideFrom),
      end: Offset.zero,
    ).animate(curved);

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(curved);

    _handleActiveState();
  }

  @override
  void didUpdateWidget(covariant TransitionFloatingAnimatedCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.data.slideFrom != widget.data.slideFrom) {
      final curved = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      );

      _offsetAnimation = Tween<Offset>(
        begin: _beginOffsetFor(widget.data.slideFrom),
        end: Offset.zero,
      ).animate(curved);
    }

    if (oldWidget.isActive != widget.isActive ||
        oldWidget.data.delay != widget.data.delay) {
      _handleActiveState();
    }
  }

  void _handleActiveState() {
    _animationTriggerId++;

    if (!widget.isActive) {
      _controller.reset();
      return;
    }

    final triggerId = _animationTriggerId;
    Future.delayed(Duration(milliseconds: widget.data.delay), () {
      if (!mounted || triggerId != _animationTriggerId || !widget.isActive) {
        return;
      }
      _controller.forward(from: 0);
    });
  }

  Offset _beginOffsetFor(SlideFrom slideFrom) {
    switch (slideFrom) {
      case SlideFrom.left:
        return const Offset(-1, 0);
      case SlideFrom.right:
        return const Offset(1, 0);
      case SlideFrom.top:
        return const Offset(0, -1);
      case SlideFrom.bottom:
        return const Offset(0, 1);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(
        position: _offsetAnimation,
        child: TransitionFloatingCard(data: widget.data),
      ),
    );
  }
}
