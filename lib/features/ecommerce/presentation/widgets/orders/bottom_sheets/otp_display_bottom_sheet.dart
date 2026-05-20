import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class OTPDisplayBottomSheet {
  static const String _defaultDescription =
      'You can show this code to the required personal for a seamless experience at delivery/pickup.';

  static Future<void> show({
    required BuildContext context,
    required String otp,
    String description = _defaultDescription,
  }) {
    return AppBottomSheet.show<void>(
      context: context,
      title: 'OTP',
      content: _OTPDisplayBottomSheetContent(
        otp: otp,
        description: description,
      ),
      actions: const [],
      backgroundColor: const Color(0xFFFEF3E6),
      borderRadius: 12.r,
      contentPadding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
    );
  }
}

class _OTPDisplayBottomSheetContent extends StatelessWidget {
  final String otp;
  final String description;

  const _OTPDisplayBottomSheetContent({
    required this.otp,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.h4(
            description,
            maxLines: 4,
            color: AppColors.p3_900,
            fontSize: 16.sp,
          ),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            height: 52.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF9E9),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: AppText.displayS(
              otp,
              color: AppColors.textSecondary,
              style: TextStyle(letterSpacing: 10.sp),
            ),
          ),
          SizedBox(height: 20.h),
          AppButton(
            label: 'Copy',
            height: AppSize.cs48,
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: otp));
              if (!context.mounted) return;
              ToastService.showInfo('Copied to clipboard');
            },
          ),
        ],
      ),
    );
  }
}
