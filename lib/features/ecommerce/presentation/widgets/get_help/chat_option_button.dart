import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/widgets/chips/app_chip.dart';

class GetHelpOptionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const GetHelpOptionButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppChip(
      label: text,
      isSelected: isSelected,
      selectedBgColor: AppColors.p2_50,
      selectedBorderColor: AppColors.p5_900,
      selectedTextColor: AppColors.textPrimary,
      unselectedTextColor: AppColors.textSecondary,
      unselectedBgColor: Colors.transparent,
      onSelected: isSelected ? null : (_) => onTap(),
      // onSelected: isDisabled
      //     ? null
      //     : (val) {
      //         if (!isSelected) onTap();
      //       },
    );
  }
}
