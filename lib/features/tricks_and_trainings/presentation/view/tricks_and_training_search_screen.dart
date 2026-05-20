import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/Tabs/app_default_tab_bar.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_search_field.dart';
import 'package:poochcare/features/tricks_and_trainings/domain/ui_models/tricks_and_training_ui_model.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/bloc/tricks_and_trainings_bloc.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/bloc/tricks_and_trainings_event.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/bloc/tricks_and_trainings_state.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/cards/tricks_and_training_search_list_item_card.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/shimmers/tip_and_training_list_item_card_shimmer.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class TricksAndTrainingSearchScreen extends StatefulWidget {
  const TricksAndTrainingSearchScreen({super.key, required this.query});

  final String query;

  @override
  State<TricksAndTrainingSearchScreen> createState() =>
      _TricksAndTrainingSearchScreenState();

  static Widget _buildList(
    BuildContext context,
    List<TricksAndTrainingUIModel> items,
  ) {
    if (items.isEmpty) {
      return const Center(child: Text('No results found'));
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
      itemCount: items.length,
      separatorBuilder: (_, _) => AppSpacing.s12.hBox,
      itemBuilder: (_, index) {
        final item = items[index];
        return TricksAndTrainingSearchListItemCard(
          imageUrl: item.thumbnail.isNotEmpty ? item.thumbnail : item.image,
          badgeTitle: item.contentType == 'video'
              ? 'Videos'
              : item.contentType == 'training'
              ? 'Training Guide'
              : 'Tips',
          title: item.title,
          description: item.shortDescription,
          onTap: () {
            switch (item.contentType) {
              case 'video':
                context.router.push(VideoDetailsRoute(contentId: item.id));
                break;

              case 'training':
                context.router.push(TrainingDetailsRoute(contentId: item.id));
                break;

              case 'tip':
                context.router.push(TipDetailsRoute(contentId: item.id));
                break;
            }
          },
        );
      },
    );
  }
}

class _TricksAndTrainingSearchScreenState
    extends State<TricksAndTrainingSearchScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController(text: widget.query);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<TricksAndTrainingsBloc>()
            ..add(SearchContent(query: widget.query)),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: AppPrimaryBgContainer(
              child: SafeArea(
                child: Column(
                  children: [
                    /// App Bar
                    const PoochScreenAppBar(title: 'Search'),

                    AppSpacing.s16.hBox,

                    /// Search
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16,
                      ),
                      child: AppSearchField(
                        controller: _searchController,
                        onChanged: (_) {},
                        onSubmitted: (value) {
                          final query = value.trim();

                          if (query.isEmpty) return;

                          context.read<TricksAndTrainingsBloc>().add(
                            SearchContent(query: query),
                          );
                        },
                      ),
                    ),

                    AppSpacing.s20.hBox,

                    /// Tabs
                    Expanded(
                      child:
                          BlocBuilder<
                            TricksAndTrainingsBloc,
                            TricksAndTrainingsState
                          >(
                            builder: (context, state) {
                              if (state.isSearching &&
                                  state.searchResults.isEmpty) {
                                return ListView.separated(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.s16,
                                  ),

                                  itemCount: 12,

                                  separatorBuilder: (_, _) =>
                                      AppSpacing.s12.hBox,

                                  itemBuilder: (_, _) =>
                                      const TipAndTrainingListItemCardShimmer(),
                                );
                              }
                              final allResults = state.searchResults;

                              final videos = allResults
                                  .where((e) => e.contentType == 'video')
                                  .toList();

                              final trainings = allResults
                                  .where((e) => e.contentType == 'training')
                                  .toList();

                              final tips = allResults
                                  .where((e) => e.contentType == 'tip')
                                  .toList();
                              return AppDefaultRouteTabs(
                                isScrollable: true,
                                tabNames: const [
                                  'Top Results',
                                  'Videos',
                                  'Training Guide',
                                  'Tips',
                                ],

                                children: [
                                  TricksAndTrainingSearchScreen._buildList(
                                    context,
                                    allResults,
                                  ),
                                  TricksAndTrainingSearchScreen._buildList(
                                    context,
                                    videos,
                                  ),
                                  TricksAndTrainingSearchScreen._buildList(
                                    context,
                                    trainings,
                                  ),
                                  TricksAndTrainingSearchScreen._buildList(
                                    context,
                                    tips,
                                  ),
                                ],
                              );
                            },
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
