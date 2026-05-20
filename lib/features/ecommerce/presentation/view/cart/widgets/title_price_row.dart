import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/utils/app_extensions/price_formatter_extension.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class TitlePriceRow extends StatelessWidget {
  final String title;
  final double price;
  final Color? rowColor;
  final bool isCouponRow;
  const TitlePriceRow({
    required this.price,
    this.rowColor,
    required this.title,
    this.isCouponRow = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText.h4(
          title,
          color: rowColor ?? AppColors.p5_400,
          fontSize: AppFontSize.fs14,
        ),
        AppText.h4(
          'INR ${price.formatPrice()}',
          color: isCouponRow
              ? AppColors.messageSuccess
              : rowColor ?? AppColors.p5_400,

          fontSize: AppFontSize.fs16,
        ),
      ],
    );
  }
}
