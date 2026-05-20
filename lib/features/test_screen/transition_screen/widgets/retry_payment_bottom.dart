import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class RetryPaymentBottom extends StatelessWidget {
  final VoidCallback? onLaterPressed;
  final VoidCallback? onTryAgainPressed;

  const RetryPaymentBottom({
    super.key,
    this.onLaterPressed,
    this.onTryAgainPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppText.support(
          'Retry your payment to\nbuy Pooch.',
          textAlign: TextAlign.center,
          fontSize: 18.sp,
          color: const Color(0xFF1B1B1B),
          variant: AppTextVariant.noEllipsis,
        ),
        SizedBox(height: 18.h),
        AppButton(
          label: 'Later',
          variant: AppButtonVariant.outlined,
          onPressed: onLaterPressed,
        ),
        SizedBox(height: 12.h),
        AppButton(label: 'Try Again', onPressed: onTryAgainPressed),
      ],
    );
  }
}
