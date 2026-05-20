import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_cached_widget.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class TipListItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final VoidCallback? onTap;

  const TipListItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.s12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppRadiusSize.r20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            imageUrl.isEmpty
                ? Container(
                    width: AppSize.cs70,
                    height: AppSize.cs70,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(AppRadiusSize.r12),
                    ),
                    alignment: Alignment.center,
                    child: AppIcon(AppIcons.svg.generic.poochTail),
                  )
                : AppImageCachedWidget(
                    imageUrl: imageUrl,
                    width: AppSize.cs70,
                    height: AppSize.cs70,
                    borderRadius: BorderRadius.circular(AppRadiusSize.r12),
                  ),

            AppSpacing.s12.wBox,

            /// Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.h1(
                    title,
                    fontSize: AppFontSize.fs14,
                    color: AppColors.p5,
                    maxLines: 1,
                  ),

                  AppSpacing.s4.hBox,

                  AppText.bodyL(
                    description,
                    color: AppColors.p4_200,
                    fontSize: AppFontSize.fs12,
                    maxLines: 2,
                  ),

                  AppSpacing.s6.hBox,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
