import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/list_grid/app_error_view.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_search_field.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/bloc/tricks_and_trainings_bloc.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/bloc/tricks_and_trainings_event.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/bloc/tricks_and_trainings_state.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/cards/training_list_item_card.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/shimmers/tip_and_training_list_item_card_shimmer.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class TrainingsListingScreen extends StatefulWidget {
  const TrainingsListingScreen({super.key, this.petId});

  final String? petId;

  @override
  State<TrainingsListingScreen> createState() => _TrainingsListingScreenState();
}

class _TrainingsListingScreenState extends State<TrainingsListingScreen> {
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();

    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TricksAndTrainingsBloc>()
        ..add(LoadListingContent(contentType: 'training', petId: widget.petId)),
      child: Scaffold(
        body: AppPrimaryBgContainer(
          child: SafeArea(
            child: Column(
              children: [
                const PoochScreenAppBar(title: 'Training Sessions'),

                AppSpacing.s16.hBox,

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s16,
                  ),
                  child: AppSearchField(
                    controller: searchController,
                    // isReadOnly: true,
                    // onPressed: () {
                    //   context.router.push(
                    //     TricksAndTrainingSearchRoute(
                    //       query: searchController.text,
                    //     ),
                    //   )
                    //       .then((_) {
                    //         searchController.clear();
                    //       });
                    // },
                    onChanged: (value) {},
                    onSubmitted: (value) {
                      final query = value.trim();

                      if (query.isEmpty) return;

                      context.router
                          .push(TricksAndTrainingSearchRoute(query: query))
                          .then((_) {
                            searchController.clear();
                          });
                    },
                  ),
                ),

                AppSpacing.s20.hBox,

                Expanded(
                  child:
                      BlocBuilder<
                        TricksAndTrainingsBloc,
                        TricksAndTrainingsState
                      >(
                        builder: (context, state) {
                          /// Loading
                          if (state.isListingLoading &&
                              state.listingItems.isEmpty) {
                            return ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.s16,
                              ),
                              itemCount: 12,
                              separatorBuilder: (_, _) => AppSpacing.s12.hBox,
                              itemBuilder: (_, _) =>
                                  const TipAndTrainingListItemCardShimmer(),
                            );
                          }

                          /// Error
                          if (state.error != null) {
                            return SizedBox(
                              height: AppSize.cs250.h,
                              child: AppErrorView(
                                message: state.error!,
                                onRetry: () =>
                                    context.read<TricksAndTrainingsBloc>().add(
                                      LoadListingContent(
                                        contentType: 'training',
                                      ),
                                    ),
                              ),
                            );
                          }

                          /// Empty
                          if (state.listingItems.isEmpty) {
                            return Center(
                              child: AppText.h3('No training sessions found'),
                            );
                          }

                          return RefreshIndicator(
                            onRefresh: () async {
                              context.read<TricksAndTrainingsBloc>().add(
                                LoadListingContent(contentType: 'training'),
                              );
                            },
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.s16,
                              ),
                              itemCount: state.listingItems.length,
                              separatorBuilder: (_, _) => AppSpacing.s12.hBox,
                              itemBuilder: (_, index) {
                                return TrainingListItemCard(
                                  imageUrl:
                                      state
                                          .listingItems[index]
                                          .thumbnail
                                          .isNotEmpty
                                      ? state.listingItems[index].thumbnail
                                      : state.listingItems[index].image,
                                  title: state.listingItems[index].title,
                                  description: state
                                      .listingItems[index]
                                      .shortDescription,
                                  steps: state.listingItems[index].stepsText,
                                  onTap: () {
                                    context.router.push(
                                      TrainingDetailsRoute(
                                        contentId: state.listingItems[index].id,
                                      ),
                                    );
                                  },
                                );
                              },
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
