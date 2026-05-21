import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/bloc/tricks_and_trainings_bloc.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/bloc/tricks_and_trainings_event.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/bloc/tricks_and_trainings_state.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/bottom_sheets/tips_and_training_bottom_sheet.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/cards/tip_list_item_card.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/cards/training_list_item_card.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/cards/video_list_item_card.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/sections/more_like_this_section.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/sections/related_content_tabs_section.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/shimmers/more_like_this_section_shimmer.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/shimmers/tip_and_training_list_item_card_shimmer.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/shimmers/training_detail_screen_shimmer.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/shimmers/video_list_item_card_shimmer.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/training_vertical_stepper.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class TrainingDetailsScreen extends StatelessWidget {
  const TrainingDetailsScreen({super.key, required this.contentId});

  final String contentId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TricksAndTrainingsBloc>()
        ..add(LoadContentDetails(contentId))
        ..add(LoadMoreLikeThis(contentId, 'training'))
        ..add(LoadRelatedContent(parentId: contentId, contentType: 'tip')),
      child: Scaffold(
        body: AppPrimaryBgContainer(
          child: SafeArea(
            child: BlocBuilder<TricksAndTrainingsBloc, TricksAndTrainingsState>(
              builder: (context, state) {
                /// Loading
                final isLoading = state.isDetailsLoading;
                final item = state.selectedContent;

                if (isLoading || item == null) {
                  return const TrainingDetailsScreenShimmer();
                }

                /// Error
                if (state.error != null) {
                  return Center(child: Text(state.error!));
                }

                // final item = state.selectedContent;

                // if (item == null) {
                //   return const Center(child: Text('No content found'));
                // }
                return Column(
                  children: [
                    /// App Bar
                    PoochScreenAppBar(
                      title: state.selectedContent?.title ?? '',
                    ),

                    /// Scrollable Content
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          context.read<TricksAndTrainingsBloc>().add(
                            LoadContentDetails(contentId),
                          );

                          context.read<TricksAndTrainingsBloc>().add(
                            LoadMoreLikeThis(contentId, 'training'),
                          );

                          context.read<TricksAndTrainingsBloc>().add(
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
                              /// Vertical Stepper
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSpacing.s16.w,
                                ),
                                child: TrainingVerticalStepper(
                                  steps: item.sessionSteps.map((e) {
                                    return TrainingStepData(
                                      imageUrl: e.image,

                                      title: e.title,

                                      description: e.description,

                                      isCompleted: e.stepNumber < 3,
                                      onTap: () {
                                        TipsAndTrainingBottomSheet.show(
                                          context: context,
                                          carousels: item.sessionSteps,
                                          initialPage: item.sessionSteps
                                              .indexOf(e),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),

                              AppSpacing.s8.hBox,

                              /// More Like This
                              if (state.isMoreLikeThisLoading)
                                const MoreLikeThisSectionShimmer()
                              else if (state.moreLikeThis.isNotEmpty)
                                MoreLikeThisSection(
                                  itemCount: state.moreLikeThis.length,
                                  height: 86.h,
                                  itemBuilder: (_, index) {
                                    final related = state.moreLikeThis[index];
                                    return SizedBox(
                                      width: 320.w,
                                      child: TrainingListItemCard(
                                        imageUrl: related.image,
                                        title: related.title,
                                        description: related.shortDescription,
                                        steps:
                                            '${related.sessionSteps.length} Step',
                                        onTap: () {
                                          context.router.push(
                                            TrainingDetailsRoute(
                                              contentId: related.id,
                                            ),
                                          );
                                        },
                                        needStartButton: true,
                                      ),
                                    );
                                  },
                                ),

                              AppSpacing.s24.hBox,

                              /// Related Content Tabs
                              Column(
                                children: [
                                  RelatedContentTabsSection(
                                    leftTitle: 'Tips',
                                    rightTitle: 'Videos',

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
                                                contentType: 'video',
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
                                          ? (state.selectedRelatedTab == 'video'
                                                ? ListView.separated(
                                                    itemCount: 3,
                                                    separatorBuilder: (_, _) =>
                                                        AppSpacing.s12.hBox,
                                                    itemBuilder: (_, _) =>
                                                        const VideoListItemCardShimmer(
                                                          imageHeight: 120,
                                                        ),
                                                  )
                                                : ListView.separated(
                                                    itemCount: 3,
                                                    separatorBuilder: (_, _) =>
                                                        AppSpacing.s12.hBox,
                                                    itemBuilder: (_, _) =>
                                                        const TipAndTrainingListItemCardShimmer(),
                                                  ))
                                          /// VIDEOS
                                          : state.selectedRelatedTab == 'video'
                                          ? ListView.separated(
                                              padding: EdgeInsets.zero,
                                              itemCount:
                                                  state.relatedContent.length,
                                              separatorBuilder: (_, _) =>
                                                  AppSpacing.s12.hBox,
                                              itemBuilder: (_, index) {
                                                final item =
                                                    state.relatedContent[index];

                                                return VideoListItemCard(
                                                  imageUrl: item.image,
                                                  title: item.title,
                                                  description:
                                                      item.shortDescription,
                                                  duration:
                                                      item.formattedDuration,
                                                  imageHeight: 120.h,
                                                  onTap: () {
                                                    context.router.push(
                                                      VideoDetailsRoute(
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
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
