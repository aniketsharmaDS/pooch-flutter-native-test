import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_image_frame.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';

class OrderItemBasicCard extends StatelessWidget {
  const OrderItemBasicCard({super.key, required this.order, this.padding});

  final OrderItemModel order;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: AppSpacing.s10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppImageFrame(width: 46.w, height: 35.h, imageUrl: order.image),

          const SizedBox(width: 12),

          /// Title
          Expanded(
            child: AppText.h4(
              order.title,
              color: const Color(0xFF49454F),
              fontSize: AppFontSize.fs14,
              maxLines: 2,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),

          /// Price + Subtitle
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText.h1(
                'INR ${order.price}',
                color: const Color(0xFF49454F),
                fontSize: AppFontSize.fs14,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 4),

              if (order.subtitle.isNotEmpty) ...[
                AppText.bodyS(order.subtitle, color: const Color(0xFF49454F)),
                const SizedBox(height: 4),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
