import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/need_help_button.dart';

enum NeedHelpPosition { top, bottom }

class OrderBottomActions extends StatelessWidget {
  final OrderItemModel order;

  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSecondaryAction;
  final VoidCallback? onCenterAction;

  final String? primaryLabel;
  final String? secondaryLabel;
  final String? centerLabel;

  final NeedHelpPosition needHelpPosition;

  const OrderBottomActions({
    super.key,
    required this.order,
    this.onPrimaryAction,
    this.onSecondaryAction,
    this.onCenterAction,
    this.primaryLabel,
    this.secondaryLabel,
    this.centerLabel,
    this.needHelpPosition = NeedHelpPosition.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final hasCenter = centerLabel != null;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (needHelpPosition == NeedHelpPosition.top) ...[
            NeedHelpButton(orderId: order.orderId, itemId: order.itemId),
            AppSpacing.s6.hBox,
          ],

          if (hasCenter)
            AppButton(
              label: centerLabel!,
              onPressed: onCenterAction,
              height: AppSize.cs48,
            )
          else
            Row(
              children: [
                if (secondaryLabel != null)
                  Expanded(
                    child: AppButton(
                      label: secondaryLabel!,
                      onPressed: onSecondaryAction,
                      variant: AppButtonVariant.outlined,
                      backgroundColor: AppColors.white,
                      height: AppSize.cs48,
                    ),
                  ),

                if (secondaryLabel != null && primaryLabel != null)
                  AppSpacing.s12.wBox,

                if (primaryLabel != null)
                  Expanded(
                    child: AppButton(
                      label: primaryLabel!,
                      onPressed: onPrimaryAction,
                      height: AppSize.cs48,
                    ),
                  ),
              ],
            ),

          if (needHelpPosition == NeedHelpPosition.bottom) ...[
            AppSpacing.s6.hBox,
            NeedHelpButton(orderId: order.orderId, itemId: order.itemId),
          ],
        ],
      ),
    );
  }
}
