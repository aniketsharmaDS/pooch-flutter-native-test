import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class IconInfo extends StatelessWidget {
  const IconInfo({
    super.key,
    required this.icon,
    required this.text,
    this.textColor = const Color(0xFF696764),
    this.iconColor = const Color(0xFF696764),
  });

  final String icon;
  final String text;
  final Color textColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppIcon(icon, size: 10.r, color: iconColor),
        SizedBox(width: 3.w),
        AppText.bodyL(
          text,
          color: textColor,
          fontSize: 10.sp,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
