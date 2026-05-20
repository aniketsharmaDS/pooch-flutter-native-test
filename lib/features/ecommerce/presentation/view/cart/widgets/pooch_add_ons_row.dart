import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/utils/app_extensions/price_formatter_extension.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class PoochAddOnsRow extends StatelessWidget {
  final String title;
  final double price;
  const PoochAddOnsRow({required this.price, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText.h3(
          title,
          color: AppColors.secondary,
          fontSize: AppFontSize.fs14,
        ),
        AppText.h3(
          'INR ${price.formatPrice()}',
          color: AppColors.secondary,

          fontSize: AppFontSize.fs18,
        ),
      ],
    );
  }
}
