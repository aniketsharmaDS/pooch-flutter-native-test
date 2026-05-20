import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_cached_widget.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class VideoListItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String duration;
  final VoidCallback? onTap;
  final double? width;
  final double imageHeight;

  const VideoListItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.duration,
    required this.imageHeight,
    this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(AppSpacing.s15),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppRadiusSize.r15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Thumbnail
            imageUrl.isEmpty
                ? Container(
                    width: double.infinity,
                    height: imageHeight,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(AppRadiusSize.r15),
                    ),
                    alignment: Alignment.center,
                    child: AppIcon(AppIcons.svg.generic.poochTail),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadiusSize.r15),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AppImageCachedWidget(
                          imageUrl: imageUrl,
                          width: double.infinity,
                          height: imageHeight,
                          borderRadius: BorderRadius.circular(
                            AppRadiusSize.r15,
                          ),
                        ),
                        AppIcon(
                          AppIcons.svg.generic.playButton,
                          size: AppIconSize.is28,
                          // color: Colors.white.withOpacity(0.9),
                        ),
                      ],
                    ),
                  ),

            AppSpacing.s10.hBox,

            /// Title
            AppText.h3(
              title,
              fontSize: AppFontSize.fs12,
              color: AppColors.textPrimary,
              maxLines: 1,
            ),

            AppSpacing.s6.hBox,

            /// Description
            AppText.bodyS(description, maxLines: 2, color: AppColors.p5_700),
            AppSpacing.s10.hBox,

            /// Duration
            Row(
              children: [
                AppIcon(
                  AppIcons.svg.generic.clock,
                  size: AppIconSize.is14,
                  color: AppColors.p3_900,
                ),

                // SizedBox(width: 6.w),
                AppSpacing.s6.wBox,

                AppText.support(duration, color: AppColors.p3_900),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
