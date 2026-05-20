// File: app_otp.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_typography.dart';

class AppOtpField extends StatelessWidget {
  const AppOtpField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.length = 4,
    this.onChanged,
    this.onCompleted,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final int length;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  @override
  Widget build(BuildContext context) {
    const Color borderColor = AppColors.textFieldBorderDefault;
    const Color fillColor = AppColors.textFieldBackgroundDefault;
    // const Color textColor = AppColors.textFieldInputTextDefault;
    const Color focusPinColor = AppColors.textFieldBorderFocus;

    final pinTheme = PinTheme(
      width: 60.w,
      height: 80.h,
      textStyle: AppTypography.inputText.copyWith(
        // color: textColor,
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(65.r),
        border: Border.all(color: borderColor),
      ),
    );

    return Pinput(
      controller: controller,
      focusNode: focusNode,
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      length: length,
      autofocus: true,
      // keyboardType: TextInputType.number,
      // autofillHints: const [AutofillHints.oneTimeCode],
      // showCursor: true,
      // isCursorAnimationEnabled: true,
      // enableSuggestions: true,
      enableIMEPersonalizedLearning: true,
      obscureText: true,
      enableInteractiveSelection: true,
      closeKeyboardWhenCompleted: false,
      defaultPinTheme: pinTheme,
      focusedPinTheme: pinTheme.copyDecorationWith(
        border: Border.all(color: focusPinColor, width: 1.4.w),
      ),
      submittedPinTheme: pinTheme,
      separatorBuilder: (_) => SizedBox(width: 14.w),
      // mainAxisAlignment: MainAxisAlignment.center,
      onChanged: onChanged,
      onCompleted: onCompleted,
    );
  }
}
