import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class WeAreHereWithYouBottom extends StatelessWidget {
  final VoidCallback? onViewPostPressed;
  final String petName;

  const WeAreHereWithYouBottom({
    super.key,
    this.onViewPostPressed,
    required this.petName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppText.support(
          'Your Missing Pooch report is now\nlive across the community.\nWe\'re hoping $petName finds her way\nhome very soon.',
          textAlign: TextAlign.center,
          fontSize: 18.sp,
          color: const Color(0xFF1B1B1B),
          variant: AppTextVariant.noEllipsis,
        ),
        SizedBox(height: 18.h),
        AppButton(label: 'View Post', onPressed: onViewPostPressed),
      ],
    );
  }
}
