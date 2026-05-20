import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class CloseMissingPoochBottom extends StatelessWidget {
  final VoidCallback? onKeepOpenPressed;
  final VoidCallback? onCloseReportPressed;
  final bool isPrimaryLoader;
  final bool isSecondaryLoader;

  const CloseMissingPoochBottom({
    super.key,
    this.onKeepOpenPressed,
    this.onCloseReportPressed,
    this.isPrimaryLoader = false,
    this.isSecondaryLoader = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppText.support(
          'Would you like to close the\nmissing report?',
          textAlign: TextAlign.center,
          fontSize: 18.sp,
          color: const Color(0xFF1B1B1B),
          variant: AppTextVariant.noEllipsis,
        ),
        SizedBox(height: 18.h),
        AppButton(
          isLoading: isSecondaryLoader,
          isDisabled: (isPrimaryLoader || isSecondaryLoader),
          label: 'Keep It Open',
          variant: AppButtonVariant.outlined,
          onPressed: onKeepOpenPressed,
        ),
        SizedBox(height: 12.h),
        AppButton(
          isLoading: isPrimaryLoader,
          isDisabled: (isPrimaryLoader || isSecondaryLoader),
          label: 'Close Report',
          onPressed: onCloseReportPressed,
        ),
      ],
    );
  }
}
