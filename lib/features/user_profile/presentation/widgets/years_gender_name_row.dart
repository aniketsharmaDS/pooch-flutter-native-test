import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class YearsGenderNameRow extends StatelessWidget {
  const YearsGenderNameRow({required this.ageGenderText, super.key});

  final String ageGenderText;

  @override
  Widget build(BuildContext context) {
    return AppText.h4(
      ageGenderText,
      fontSize: AppFontSize.fs14,
      color: AppColors.p4_400,
    );
  }
}
