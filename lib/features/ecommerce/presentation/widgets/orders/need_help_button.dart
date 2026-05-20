import 'package:flutter/material.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/bottom_sheets/need_help_bottom_sheet.dart';

class NeedHelpButton extends StatelessWidget {
  final String orderId;
  final String itemId;
  final VoidCallback? onTap;
  final bool fullWidth;

  const NeedHelpButton({
    super.key,
    required this.orderId,
    required this.itemId,
    this.onTap,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    final callback =
        onTap ??
        () =>
            openNeedHelpBottomSheet(context, orderId: orderId, itemId: itemId);

    return AppButton(
      label: 'Need Help?',
      onPressed: callback,
      width: fullWidth ? double.infinity : null,
      variant: AppButtonVariant.text,
    );
  }
}
