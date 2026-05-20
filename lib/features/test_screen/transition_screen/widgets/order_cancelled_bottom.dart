import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class OrderCancelledBottom extends StatelessWidget {
  final VoidCallback? onTrackStatusPressed;
  final VoidCallback? onOkayPressed;
  final VoidCallback? onNeedHelpPressed;

  const OrderCancelledBottom({
    super.key,
    this.onTrackStatusPressed,
    this.onOkayPressed,
    this.onNeedHelpPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppButton(
          label: 'Track Status',
          variant: AppButtonVariant.outlined,
          onPressed: onTrackStatusPressed,
        ),
        SizedBox(height: 12.h),
        AppButton(label: 'Okay', onPressed: onOkayPressed),
        SizedBox(height: 18.h),
        GestureDetector(
          onTap: onNeedHelpPressed,
          child: AppText.support(
            'Need Help?',
            textAlign: TextAlign.center,
            fontSize: 18.sp,
            color: const Color(0xFF1B1B1B),
            variant: AppTextVariant.noEllipsis,
          ),
        ),
      ],
    );
  }
}
