import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class FilterPickerButtonItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onPressed;

  const FilterPickerButtonItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 28),
            const SizedBox(height: 8),
            AppText.bodyS(title, maxLines: 1),
          ],
        ),
      ),
    );
  }
}
