import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class OnBoardingSuccessBottom extends StatelessWidget {
  final VoidCallback? onAddAnotherPetPressed;
  final VoidCallback? onContinuePressed;
  final String promptText;
  final String addAnotherLabel;
  final String continueLabel;

  const OnBoardingSuccessBottom({
    super.key,
    this.onAddAnotherPetPressed,
    this.onContinuePressed,
    this.promptText =
        'Do you want to add another pet or\ncontinue to create your profile?',
    this.addAnotherLabel = 'Add Another Pet',
    this.continueLabel = 'Continue',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppText.support(
          promptText,
          textAlign: TextAlign.center,
          fontSize: 18.sp,
          color: const Color(0xFF1B1B1B),
          variant: AppTextVariant.noEllipsis,
        ),
        SizedBox(height: 18.h),
        AppButton(
          label: addAnotherLabel,
          variant: AppButtonVariant.outlined,
          onPressed: onAddAnotherPetPressed,
        ),
        SizedBox(height: 12.h),
        AppButton(label: continueLabel, onPressed: onContinuePressed),
      ],
    );
  }
}
