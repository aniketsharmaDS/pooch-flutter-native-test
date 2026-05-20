import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class AppTag extends StatelessWidget {
  final Color color;
  final Color? backgroundColor;
  final String title;
  const AppTag({
    this.backgroundColor,
    required this.color,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 17.h,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
      decoration: BoxDecoration(
        color: backgroundColor ?? color.withValues(alpha: 0.1),
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(AppRadiusSize.r20),
      ),
      child: AppText.h4(
        title,
        color: color,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: AppFontSize.fs10,
        ),
      ),
    );
  }
}
