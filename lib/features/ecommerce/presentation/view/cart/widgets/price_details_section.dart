import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/ecommerce/presentation/view/cart/widgets/pooch_add_ons_row.dart';
import 'package:poochcare/features/ecommerce/presentation/view/cart/widgets/title_price_row.dart';

class PriceDetailsSection extends StatelessWidget {
  final bool isCouponApplied;
  final bool isAddOnsApplied;
  final double totalMrp;
  final double deliveryFee;
  final double tax;
  final double discount;
  final int itemCount;

  const PriceDetailsSection({
    this.isAddOnsApplied = false,
    this.isCouponApplied = false,
    required this.deliveryFee,
    required this.tax,
    required this.totalMrp,
    this.discount = 0,
    required this.itemCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double total = totalMrp + deliveryFee + tax - discount;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s16,
        vertical: AppSpacing.s16,
      ),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.h1(
            'Price Details ($itemCount items)',
            fontSize: AppFontSize.fs16,
          ),
          const SizedBox(height: AppSpacing.s15),
          TitlePriceRow(price: totalMrp, title: 'Total MRP'),
          const SizedBox(height: AppSpacing.s11),
          TitlePriceRow(price: deliveryFee, title: 'Delivery Fee'),
          const SizedBox(height: AppSpacing.s11),
          TitlePriceRow(price: tax, title: 'Tax 2%'),
          const SizedBox(height: AppSpacing.s11),
          if (isCouponApplied) ...[
            TitlePriceRow(
              isCouponRow: true,
              price: -discount,
              title: 'Coupon Discount',
            ),
            const SizedBox(height: AppSpacing.s11),
          ],
          if (isAddOnsApplied) ...[
            const PoochAddOnsRow(price: 500, title: 'Pooch Super (Add Ons)'),
            const SizedBox(height: AppSpacing.s11),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.h1('Total', fontSize: AppFontSize.fs20),
              AppText.h1(
                'INR ${total.toStringAsFixed(2)}',
                fontSize: AppFontSize.fs20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
