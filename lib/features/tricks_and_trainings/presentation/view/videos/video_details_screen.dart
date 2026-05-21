import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/bloc/tricks_and_trainings_bloc.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/bloc/tricks_and_trainings_event.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/bloc/tricks_and_trainings_state.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/cards/tip_list_item_card.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/cards/training_list_item_card.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/cards/video_list_item_card.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/sections/more_like_this_section.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/sections/related_content_tabs_section.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/shimmers/more_like_this_section_shimmer.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/shimmers/tip_and_training_list_item_card_shimmer.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/shimmers/video_detail_screen_shimmer.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class VideoDetailsScreen extends StatelessWidget {
  const VideoDetailsScreen({super.key, required this.contentId});

  final String contentId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TricksAndTrainingsBloc>()
        ..add(LoadContentDetails(contentId))
        ..add(LoadMoreLikeThis(contentId, 'video'))
        ..add(LoadRelatedContent(parentId: contentId, contentType: 'tip')),
      child: Scaffold(
        body: AppPrimaryBgContainer(
          child: SafeArea(
            child: Column(
              children: [
                /// App Bar
                const PoochScreenAppBar(title: ''),

                /// Scrollable Content
                Expanded(
                  child: BlocBuilder<TricksAndTrainingsBloc, TricksAndTrainingsState>(
                    builder: (context, state) {
                      /// Loading
                      if (state.isDetailsLoading) {
                        return const VideoDetailsScreenShimmer();
                      }

                      /// Error
                      if (state.error != null) {
                        return Center(child: Text(state.error!));
                      }

                      final item = state.selectedContent;

                      if (item == null) {
                        return const Center(child: Text('No content found'));
                      }

                      final isLoading = state.isDetailsLoading;

                      return RefreshIndicator(
                        onRefresh: () async {
                          getIt<TricksAndTrainingsBloc>().add(
                            LoadContentDetails(contentId),
                          );

                          getIt<TricksAndTrainingsBloc>().add(
                            LoadMoreLikeThis(contentId, 'video'),
                          );

                          getIt<TricksAndTrainingsBloc>().add(
                            LoadRelatedContent(
                              parentId: contentId,
                              contentType: 'tip',
                            ),
                          );
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Video Player
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: isLoading
                                    ? Container(color: Colors.grey.shade300)
                                    : Container(
                                        color: Colors.black87,
                                        child: const Center(
                                          child: Icon(
                                            Icons.play_circle_fill,
                                            color: Colors.white,
                                            size: 64,
                                          ),
                                        ),
                                      ),
                              ),

                              AppSpacing.s16.hBox,

                              /// Title + Description
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSpacing.s16.w,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText.h1(item.title),

                                    AppSpacing.s8.hBox,

                                    AppText.bodyL(
                                      item.shortDescription,
                                      color: AppColors.p5_700,
                                      variant: AppTextVariant.noEllipsis,
                                    ),
                                  ],
                                ),
                              ),

                              AppSpacing.s24.hBox,

                              /// More Like This
                              if (state.isMoreLikeThisLoading)
                                const MoreLikeThisSectionShimmer()
                              else if (state.moreLikeThis.isNotEmpty)
                                MoreLikeThisSection(
                                  itemCount: state.moreLikeThis.length,
                                  height: 256,
                                  itemBuilder: (_, index) {
                                    final related = state.moreLikeThis[index];
                                    return VideoListItemCard(
                                      width: 200.w,
                                      imageHeight: 112.h,
                                      imageUrl: related.thumbnail.isNotEmpty
                                          ? related.thumbnail
                                          : related.image,
                                      title: related.title,
                                      description: related.shortDescription,
                                      duration: related.formattedDuration,
                                      onTap: () {
                                        context.router.push(
                                          VideoDetailsRoute(
                                            contentId: related.id,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),

                              AppSpacing.s24.hBox,

                              /// Related Tabs + Content
                              Column(
                                children: [
                                  RelatedContentTabsSection(
                                    leftTitle: 'Tips',
                                    rightTitle: 'Training Steps',

                                    onTabChanged: (value) {
                                      if (value == 0) {
                                        context
                                            .read<TricksAndTrainingsBloc>()
                                            .add(
                                              LoadRelatedContent(
                                                parentId: contentId,
                                                contentType: 'tip',
                                              ),
                                            );
                                      } else {
                                        context
                                            .read<TricksAndTrainingsBloc>()
                                            .add(
                                              LoadRelatedContent(
                                                parentId: contentId,
                                                contentType: 'training',
                                              ),
                                            );
                                      }
                                    },
                                  ),

                                  AppSpacing.s16.hBox,

                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: AppSpacing.s16.w,
                                    ),
                                    child: SizedBox(
                                      height: 420.h,
                                      child: state.isRelatedContentLoading
                                          /// LOADING
                                          ? ListView.separated(
                                              itemCount: 3,
                                              separatorBuilder: (_, _) =>
                                                  AppSpacing.s12.hBox,
                                              itemBuilder: (_, _) =>
                                                  const TipAndTrainingListItemCardShimmer(),
                                            )
                                          /// TRAININGS
                                          : state.selectedRelatedTab ==
                                                'training'
                                          ? ListView.separated(
                                              padding: EdgeInsets.zero,
                                              itemCount:
                                                  state.relatedContent.length,
                                              separatorBuilder: (_, _) =>
                                                  AppSpacing.s12.hBox,
                                              itemBuilder: (_, index) {
                                                final item =
                                                    state.relatedContent[index];

                                                return TrainingListItemCard(
                                                  imageUrl: item.image,
                                                  title: item.title,
                                                  description:
                                                      item.shortDescription,
                                                  steps:
                                                      '${item.sessionSteps.length} Step',
                                                  onTap: () {
                                                    context.router.push(
                                                      TrainingDetailsRoute(
                                                        contentId: item.id,
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            )
                                          /// TIPS
                                          : ListView.separated(
                                              padding: EdgeInsets.zero,
                                              itemCount:
                                                  state.relatedContent.length,
                                              separatorBuilder: (_, _) =>
                                                  AppSpacing.s12.hBox,
                                              itemBuilder: (_, index) {
                                                final item =
                                                    state.relatedContent[index];

                                                return TipListItemCard(
                                                  imageUrl: item.image,
                                                  title: item.title,
                                                  description:
                                                      item.shortDescription,
                                                  onTap: () {
                                                    context.router.push(
                                                      TipDetailsRoute(
                                                        contentId: item.id,
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                    ),
                                  ),
                                ],
                              ),

                              AppSpacing.s24.hBox,
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
