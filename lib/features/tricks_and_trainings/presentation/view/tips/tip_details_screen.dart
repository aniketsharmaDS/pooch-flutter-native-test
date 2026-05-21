import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/bloc/tricks_and_trainings_bloc.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/bloc/tricks_and_trainings_event.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/bloc/tricks_and_trainings_state.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/bottom_sheets/tips_and_training_bottom_sheet.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/cards/tip_details_card.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/cards/training_list_item_card.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/cards/video_list_item_card.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/sections/more_like_this_section.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/sections/related_content_tabs_section.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/shimmers/more_like_this_section_shimmer.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/shimmers/tip_and_training_list_item_card_shimmer.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/shimmers/tip_details_card_shimmer.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/shimmers/video_list_item_card_shimmer.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class TipDetailsScreen extends StatelessWidget {
  const TipDetailsScreen({super.key, required this.contentId});

  final String contentId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TricksAndTrainingsBloc>()
        ..add(LoadContentDetails(contentId))
        ..add(LoadMoreLikeThis(contentId, 'tip'))
        ..add(LoadRelatedContent(parentId: contentId, contentType: 'video')),

      child: Scaffold(
        body: AppPrimaryBgContainer(
          child: SafeArea(
            child: Column(
              children: [
                /// App Bar
                PoochScreenAppBar(
                  title: '',
                  actions: [
                    AppCircleButton(
                      variant: AppCircleButtonVariant.secondary,
                      bgColor: AppColors.transparent,
                      iconSize: AppIconSize.is20,
                      showShadow: false,
                      icon: AppIcons.svg.generic.flag,
                      onTap: () => {},
                    ),
                    AppCircleButton(
                      variant: AppCircleButtonVariant.secondary,
                      bgColor: AppColors.transparent,
                      iconSize: AppIconSize.is20,
                      showShadow: false,
                      icon: AppIcons.svg.generic.share,
                      onTap: () => {},
                    ),
                  ],
                ),

                AppSpacing.s16.hBox,

                /// Scrollable Content
                Expanded(
                  child: BlocBuilder<TricksAndTrainingsBloc, TricksAndTrainingsState>(
                    builder: (context, state) {
                      /// Loading
                      if (state.isDetailsLoading) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: TipDetailsCardShimmer(),
                        );
                      }

                      /// Error
                      if (state.error != null) {
                        return Center(child: Text(state.error!));
                      }

                      final item = state.selectedContent;

                      if (item == null) {
                        return const Center(child: Text('No content found'));
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<TricksAndTrainingsBloc>().add(
                            LoadContentDetails(contentId),
                          );
                          context.read<TricksAndTrainingsBloc>().add(
                            LoadMoreLikeThis(contentId, 'tip'),
                          );
                          context.read<TricksAndTrainingsBloc>().add(
                            LoadRelatedContent(
                              parentId: contentId,
                              contentType: 'video',
                            ),
                          );
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Tip Details Card
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSpacing.s16.w,
                                ),
                                child: TipDetailsCard(
                                  imageUrl: item.image,
                                  title: item.title,
                                  description: item.description,
                                  showLearnMore: item.carousels.length > 1,
                                  onLearnMoreTap: () {
                                    /// Prevent empty carousel crash
                                    if (item.carousels.isEmpty) {
                                      return;
                                    }

                                    // final carousel = item.carousels.first;
                                    TipsAndTrainingBottomSheet.show(
                                      context: context,
                                      carousels: item.carousels,
                                      initialPage: 0,
                                    );
                                  },
                                ),
                              ),

                              AppSpacing.s24.hBox,

                              /// More Like This
                              if (state.isMoreLikeThisLoading)
                                const MoreLikeThisSectionShimmer()
                              else if (state.moreLikeThis.isNotEmpty)
                                MoreLikeThisSection(
                                  height: 86.h,
                                  itemCount: state.moreLikeThis.length,
                                  itemBuilder: (_, index) {
                                    final related = state.moreLikeThis[index];
                                    return SizedBox(
                                      width: 320.w,
                                      child: TrainingListItemCard(
                                        imageUrl: related.image,
                                        title: related.title,
                                        description: related.shortDescription,
                                        steps:
                                            '${related.carousels.length} Step',
                                        onTap: () {
                                          context.router.push(
                                            TipDetailsRoute(
                                              contentId: related.id,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),

                              AppSpacing.s24.hBox,

                              /// Related Content Tabs + Content
                              Column(
                                children: [
                                  RelatedContentTabsSection(
                                    leftTitle: 'Videos',
                                    rightTitle: 'Training Steps',

                                    onTabChanged: (value) {
                                      if (value == 0) {
                                        context
                                            .read<TricksAndTrainingsBloc>()
                                            .add(
                                              LoadRelatedContent(
                                                parentId: contentId,
                                                contentType: 'video',
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
                                          /// VIDEOS
                                          : ListView.separated(
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
