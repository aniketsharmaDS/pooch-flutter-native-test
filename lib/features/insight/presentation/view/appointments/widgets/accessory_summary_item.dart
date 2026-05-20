import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_image_frame.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class AccessorySummaryItem extends StatelessWidget {
  final String accessoryCategory;
  final String price;
  final String imageUrl;
  const AccessorySummaryItem({
    super.key,
    required this.accessoryCategory,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadiusSize.r10),
            ),
            width: 91.w,
            height: 77.h,
            child: AppImageFrame(
              width: 91.w,
              height: 77.h,
              imageUrl: imageUrl,
              // fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: AppSpacing.s10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.h4(
                  'Virtual Accessory',
                  fontSize: AppFontSize.fs14,
                  maxLines: 2,
                ),
                const SizedBox(height: AppSpacing.s5),

                AppText.h4(
                  accessoryCategory,
                  fontSize: AppFontSize.fs10,
                  color: AppColors.p4_300,
                ),
                const SizedBox(height: AppSpacing.s14),
                AppText.h1(price, fontSize: AppFontSize.fs14, maxLines: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
