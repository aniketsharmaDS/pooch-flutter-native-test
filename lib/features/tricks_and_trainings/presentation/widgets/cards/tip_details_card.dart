import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_cached_widget.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class TipDetailsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final VoidCallback? onLearnMoreTap;
  final bool showLearnMore;

  const TipDetailsCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.onLearnMoreTap,
    this.showLearnMore = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.s12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadiusSize.r20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(AppRadiusSize.r16),
          //   child: Image.network(
          //     imageUrl,
          //     width: double.infinity,
          //     height: 140.h,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          imageUrl.isEmpty
              ? Container(
                  width: 140.w,
                  height: 140.h,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(AppRadiusSize.r12),
                  ),
                  alignment: Alignment.center,
                  child: AppIcon(AppIcons.svg.generic.poochTail),
                )
              : AppImageCachedWidget(
                  width: double.infinity,
                  imageUrl: imageUrl,
                  height: 140.h,
                  borderRadius: BorderRadius.circular(AppRadiusSize.r12),
                ),

          AppSpacing.s16.hBox,

          /// Title
          AppText.bodyL(
            title,
            fontSize: AppFontSize.fs18,
            color: AppColors.textPrimary,
          ),

          AppSpacing.s12.hBox,

          /// Description
          AppText.bodyS(
            description,
            fontSize: AppFontSize.fs12,
            color: AppColors.p5_700,
            maxLines: 10,
          ),

          AppSpacing.s20.hBox,

          /// Learn More
          if (showLearnMore)
            AppButton(label: 'Learn More', onPressed: onLearnMoreTap),
        ],
      ),
    );
  }
}
