import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class NoMatchFoundBottom extends StatelessWidget {
  final VoidCallback? onManualSearchPressed;
  final VoidCallback? onContactSheltersPressed;

  const NoMatchFoundBottom({
    super.key,
    this.onManualSearchPressed,
    this.onContactSheltersPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppText.support(
          'Some pets may not be registered\nin the system yet, you can still\nnotify parents manually.',
          textAlign: TextAlign.center,
          fontSize: 18.sp,
          color: const Color(0xFF1B1B1B),
          variant: AppTextVariant.noEllipsis,
        ),
        SizedBox(height: 18.h),
        AppButton(
          label: 'Manually Search & Notify Parent',
          variant: AppButtonVariant.outlined,
          onPressed: onManualSearchPressed,
        ),
        SizedBox(height: 12.h),
        AppButton(
          label: 'Contact Pet Shelters',
          onPressed: onContactSheltersPressed,
        ),
      ],
    );
  }
}
