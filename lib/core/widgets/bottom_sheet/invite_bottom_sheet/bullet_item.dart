import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class BulletItem extends StatelessWidget {
  final String text;

  const BulletItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.bodyS('•', color: const Color(0xff320E02)),
        SizedBox(width: 8.w),
        Expanded(child: AppText.bodyS(text, color: const Color(0xff320E02))),
      ],
    );
  }
}
