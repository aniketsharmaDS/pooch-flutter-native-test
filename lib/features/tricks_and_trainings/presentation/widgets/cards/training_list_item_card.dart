import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_cached_widget.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class TrainingListItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String steps;
  final VoidCallback? onTap;
  final int? descriptionMaxLines;
  final bool? needStartButton;

  const TrainingListItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.steps,
    this.onTap,
    this.descriptionMaxLines,
    this.needStartButton,
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
                    maxLines: descriptionMaxLines ?? 1,
                  ),

                  AppSpacing.s6.hBox,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.bodyL(
                        steps,
                        fontSize: AppFontSize.fs12,
                        color: AppColors.p4_900,
                        maxLines: 1,
                      ),
                      if (needStartButton == true)
                        InkWell(
                          onTap: onTap,
                          child: Row(
                            children: [
                              AppText.bodyL(
                                'Start',
                                fontSize: AppFontSize.fs12,
                                // color: AppColors.p4_900,
                                maxLines: 1,
                              ),
                              AppSpacing.s5.wBox,
                              AppIcon(
                                AppIcons.svg.generic.chevronRight,
                                size: AppIconSize.is10,
                                color: AppColors.textPrimary,
                              ),
                            ],
                          ),
                        ),
                    ],
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
