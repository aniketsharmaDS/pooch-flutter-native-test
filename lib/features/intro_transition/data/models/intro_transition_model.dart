import 'package:flutter/material.dart';

enum SlideFrom { left, right, top, bottom }

enum FloatingCardContentAlignment { left, center, right }

class IntroTransitionModel {
  final String title;
  final String subtitle;
  final String imagePath;
  final List<FloatingCardData> cards;
  final bool showSkip;
  final bool isLast;
  final Color bgGradientStart;
  final Color bgGradientEnd;

  IntroTransitionModel({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.cards,
    this.showSkip = true,
    this.isLast = false,
    required this.bgGradientStart,
    required this.bgGradientEnd,
  });

  IntroTransitionModel copyWith({
    String? title,
    String? subtitle,
    String? imagePath,
    List<FloatingCardData>? cards,
    bool? showSkip,
    bool? isLast,
    Color? bgGradientStart,
    Color? bgGradientEnd,
  }) {
    return IntroTransitionModel(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      imagePath: imagePath ?? this.imagePath,
      cards: cards ?? this.cards,
      showSkip: showSkip ?? this.showSkip,
      isLast: isLast ?? this.isLast,
      bgGradientStart: bgGradientStart ?? this.bgGradientStart,
      bgGradientEnd: bgGradientEnd ?? this.bgGradientEnd,
    );
  }
}

class FloatingCardData {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Alignment position;
  final Widget? customContent;
  final Widget? customSubtitle;
  final double? contentWidth;
  final double? contentPaddingHorizontal;
  final double? contentPaddingVertical;
  final double? contentHeight;
  final bool contentOnRight; // NEW: controls left/right positioning
  final FloatingCardContentAlignment? contentAlignment;
  final SlideFrom slideFrom;
  final int delay;

  FloatingCardData({
    required this.title,
    this.subtitle,
    this.icon,
    required this.position,
    this.customContent,
    this.customSubtitle,
    this.contentPaddingHorizontal,
    this.contentPaddingVertical,
    this.contentWidth,
    this.contentHeight,
    this.contentOnRight = false, // default to left
    this.contentAlignment,
    this.slideFrom = SlideFrom.left,
    this.delay = 0,
  });
}
