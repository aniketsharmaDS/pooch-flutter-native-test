import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class TricksAndTrainingSearchListItemCard extends StatelessWidget {
  final String imageUrl;
  final String badgeTitle;
  final String title;
  final String description;
  final VoidCallback? onTap;

  const TricksAndTrainingSearchListItemCard({
    super.key,
    required this.imageUrl,
    required this.badgeTitle,
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
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadiusSize.r12),
              child: Image.network(
                imageUrl,
                width: 72.w,
                height: 72.w,
                fit: BoxFit.cover,
              ),
            ),

            AppSpacing.s12.wBox,

            /// Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.p1_50,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: AppText.support(badgeTitle, color: AppColors.p1_800),
                  ),

                  AppSpacing.s6.hBox,

                  /// Title
                  AppText.h1(
                    title,
                    fontSize: AppFontSize.fs14,
                    color: AppColors.p5,
                  ),

                  AppSpacing.s4.hBox,

                  /// Description
                  AppText.bodyL(
                    description,
                    fontSize: AppFontSize.fs12,
                    color: AppColors.p4_200,
                    maxLines: 2,
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
