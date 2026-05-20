import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/headers/primary_widget_header.dart';
import 'package:poochcare/features/tricks_and_trainings/domain/ui_models/tricks_and_training_ui_model.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/cards/video_list_item_card.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/shimmers/video_list_item_card_shimmer.dart';
import 'package:poochcare/router/app_router.dart';

class VideosSection extends StatelessWidget {
  final PrimaryWidgetHeaderVariant headerVariant;
  final List<TricksAndTrainingUIModel> videos;
  final String? petId;
  final bool isLoading;
  final String? error;

  const VideosSection({
    super.key,
    this.headerVariant = PrimaryWidgetHeaderVariant.standard,
    required this.videos,
    this.petId,
    this.isLoading = false,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryWidgetHeader(
          title: 'Videos',
          buttonTitle: 'View All',
          onButtonTap: () {
            context.router.push(VideosListingRoute(petId: petId));
          },
          variant: headerVariant,
        ),

        if (isLoading && videos.isEmpty)
          SizedBox(
            height: 220.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
              itemCount: 3,
              separatorBuilder: (_, _) => SizedBox(width: AppSpacing.s12.w),
              itemBuilder: (_, _) => const VideoListItemCardShimmer(
                imageHeight: AppSize.cs120,
                width: 230,
              ),
            ),
          ) // 🔹 ERROR
        else if (error != null && videos.isEmpty)
          SizedBox(
            height: 220.h,
            child: Center(child: Text(error!)),
          )
        /// 🔹 EMPTY
        else if (videos.isEmpty)
          SizedBox(
            height: 220.h,
            child: const Center(child: Text('No videos found')),
          )
        else
          SizedBox(
            height: 220.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
              itemCount: videos.length,
              separatorBuilder: (_, _) => SizedBox(width: AppSpacing.s12.w),
              itemBuilder: (_, index) {
                final item = videos[index];
                return VideoListItemCard(
                  width: 230.w,
                  imageUrl: item.thumbnail.isNotEmpty
                      ? item.thumbnail
                      : item.image,

                  title: item.title,

                  description: item.shortDescription,

                  duration: item.formattedDuration,
                  onTap: () {
                    context.router.push(VideoDetailsRoute(contentId: item.id));
                  },
                  imageHeight: AppSize.cs120,
                );
              },
            ),
          ),
      ],
    );
  }
}
