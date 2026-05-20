import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class PickerOptionTile extends StatelessWidget {
  const PickerOptionTile({
    super.key,
    required this.title,
    required this.iconData,
    required this.onTap,
  });

  final String title;
  final IconData iconData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: onTap,
      child: Ink(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          color: const Color(0xFFFFFEFD),
          border: Border.all(color: const Color(0xFFEFE8E6)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData, size: 24.sp, color: const Color(0xFF906556)),
            SizedBox(height: 8.h),
            AppText.bodyM(title, color: const Color(0xFF906556)),
          ],
        ),
      ),
    );
  }
}
