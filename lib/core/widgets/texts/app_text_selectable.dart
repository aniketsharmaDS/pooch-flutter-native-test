import 'package:flutter/material.dart';

class AppSelectableText extends StatelessWidget {
  final String text;
  final bool isSelected;

  final Widget Function(
    String text, {
    TextStyle? style,
    int? maxLines,
    TextAlign? textAlign,
  })
  builder;

  final int? maxLines;
  final TextAlign? textAlign;
  final Duration duration;

  const AppSelectableText({
    super.key,
    required this.text,
    required this.isSelected,
    required this.builder, // 👈 this is key
    this.maxLines,
    this.textAlign,
    this.duration = const Duration(milliseconds: 180),
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: isSelected ? const Color(0xFF1A1A1A) : const Color(0xFF404041),
      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
      fontFamily: isSelected ? 'Gilroy700' : 'Gilroy400',
    );

    return AnimatedDefaultTextStyle(
      duration: duration,
      curve: Curves.easeInOut,
      style: style,
      child: builder(
        text,
        style: style,
        maxLines: maxLines,
        textAlign: textAlign,
      ),
    );
  }
}
