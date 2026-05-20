import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class DeliverySection extends StatelessWidget {
  final String address;
  final String status;
  final VoidCallback onValidationTap;

  const DeliverySection({
    super.key,
    required this.address,
    required this.status,
    required this.onValidationTap,
  });

  bool get _isOutForDelivery => status.toLowerCase() == 'out_for_delivery';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: AppColors.white),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.h1(
            'Delivery Address',
            color: AppColors.p4_900,
            fontSize: AppFontSize.fs16,
          ),

          AppSpacing.s10.hBox,

          AppText.h4(address, maxLines: 5, color: AppColors.messageInfo),

          // 👇 Show button only if out_for_delivery
          if (_isOutForDelivery) ...[
            AppSpacing.s15.hBox,

            AppButton(
              label: 'Validation Code',
              variant: AppButtonVariant.outlined,
              onPressed: onValidationTap,
              width: 178.w,
              height: AppSize.cs48,
            ),
          ],
        ],
      ),
    );
  }
}
