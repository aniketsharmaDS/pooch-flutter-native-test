import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/feedback/app_snack_bar.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class OrderIdRow extends StatelessWidget {
  final String orderId;
  final VoidCallback? onCopy;

  const OrderIdRow({super.key, required this.orderId, this.onCopy});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white_50,
      height: AppSize.cs48,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.s16.w,
          vertical: AppSpacing.s6.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.h1(
              'Order Id: $orderId',
              fontSize: AppFontSize.fs16,
              color: AppColors.p4_900,
            ),
            InkWell(
              onTap:
                  onCopy ??
                  () async {
                    await Clipboard.setData(ClipboardData(text: orderId));

                    AppSnackBar.show(
                      'Order ID copied',
                      type: SnackbarType.success,
                    );
                  },
              child: Row(
                children: [
                  AppIcon(AppIcons.svg.generic.copy),
                  AppSpacing.s12.wBox,
                  AppText.h3(
                    'Copy',
                    fontSize: AppFontSize.fs12,
                    color: AppColors.textPrimary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
