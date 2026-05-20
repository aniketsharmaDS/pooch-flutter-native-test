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
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/cards/video_list_item_card.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/shimmers/video_list_item_card_shimmer.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class VideosListingScreen extends StatefulWidget {
  const VideosListingScreen({super.key, this.petId});

  final String? petId;

  @override
  State<VideosListingScreen> createState() => _VideosListingScreenState();
}

class _VideosListingScreenState extends State<VideosListingScreen> {
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
        ..add(LoadListingContent(contentType: 'video', petId: widget.petId)),
      child: Scaffold(
        body: AppPrimaryBgContainer(
          child: SafeArea(
            child: Column(
              children: [
                const PoochScreenAppBar(title: 'Videos'),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: AppSearchField(
                    controller: searchController,
                    onChanged: (value) {
                      // _onSearch(value);
                    },
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
                const SizedBox(height: 20),

                /// Sections
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
                                horizontal: 16,
                              ),
                              itemCount: 6,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(height: 20),
                              itemBuilder: (_, _) =>
                                  const VideoListItemCardShimmer(
                                    imageHeight: AppSize.cs180,
                                  ),
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
                                      LoadListingContent(contentType: 'video'),
                                    ),
                              ),
                            );
                          }

                          /// Empty
                          if (state.listingItems.isEmpty) {
                            return Center(child: AppText.h3('No videos found'));
                          }

                          return RefreshIndicator(
                            onRefresh: () async {
                              context.read<TricksAndTrainingsBloc>().add(
                                LoadListingContent(contentType: 'video'),
                              );
                            },
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              itemCount: state.listingItems.length,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(height: 20),
                              itemBuilder: (_, index) {
                                final item = state.listingItems[index];

                                return VideoListItemCard(
                                  imageUrl: item.thumbnail.isNotEmpty
                                      ? item.thumbnail
                                      : item.image,
                                  title: item.title,
                                  description: item.shortDescription,
                                  duration: item.formattedDuration,
                                  imageHeight: AppSize.cs180,
                                  onTap: () {
                                    context.router.push(
                                      VideoDetailsRoute(contentId: item.id),
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
