import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/pagination/pagination_state.dart';
import 'package:poochcare/core/store/community/community_store_bloc.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/list_grid/app_paginated_list_view.dart';
import 'package:poochcare/core/widgets/texts/app_search_field.dart';
import 'package:poochcare/features/community/data/models/my_submitted_posts_model.dart';
import 'package:poochcare/features/community/presentation/bloc/categories/categories_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/events/my_live_posts_bloc.dart';
import 'package:poochcare/features/community/presentation/widgets/my_post_event_card.dart';
import 'package:poochcare/features/community/presentation/widgets/my_post_tips_card.dart';

/// =============================
/// SCREEN
/// =============================

@RoutePage()
class MyPostLiveTabScreen extends StatefulWidget implements AutoRouteWrapper {
  const MyPostLiveTabScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CommunityStoreBloc>.value(
          value: getIt<CommunityStoreBloc>(),
        ),
        BlocProvider<MyLivePostsBloc>.value(value: getIt<MyLivePostsBloc>()),
        BlocProvider<CategoriesBloc>.value(value: getIt<CategoriesBloc>()),
      ],
      child: this,
    );
  }

  @override
  State<MyPostLiveTabScreen> createState() => _MyPostLiveTabScreenState();
}

class _MyPostLiveTabScreenState extends State<MyPostLiveTabScreen> {
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MyLivePostsBloc>().fetchInitialPosts(search: searchQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// =============================
  /// SEARCH & FILTER METHODS
  /// =============================

  void _onSearch(String query) {
    setState(() {
      searchQuery = query;
    });
    context.read<MyLivePostsBloc>().fetchInitialPosts(search: searchQuery);
  }

  Future<void> _onRefresh() async {
    context.read<MyLivePostsBloc>().fetchInitialPosts(search: searchQuery);
  }

  void _onLoadMore() {
    context.read<MyLivePostsBloc>().loadMorePosts();
  }

  /// =============================
  /// UI
  /// =============================

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          BlocBuilder<MyLivePostsBloc, PaginationState<MySubmittedPostsModel>>(
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.s16.w,
                      vertical: AppSpacing.s10.h,
                    ).copyWith(bottom: 0),
                    child: AppSearchField(
                      controller: _searchController,
                      isLoading: state.isSearching,
                      onChanged: (value) {
                        _onSearch(value);
                      },
                      onSubmitted: (value) {
                        _onSearch(value);
                      },
                    ),
                  ),

                  AppSpacing.s10.hBox,

                  /// 📦 LIST
                  Expanded(
                    child: AppPaginatedListView<MySubmittedPostsModel>(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16.w,
                      ).copyWith(bottom: AppSpacing.s16.h),
                      items: state.items,
                      isLoading: state.isLoading,
                      isLoadingMore: state.isFetchingMore,
                      hasMore: state.hasMore,
                      hasError: state.errorMessage != null,
                      error:
                          state.errorMessage ??
                          'community.loadingDataError'.tr(),
                      onLoadMore: _onLoadMore,
                      onRefresh: _onRefresh,
                      onRetry: () {
                        context.read<MyLivePostsBloc>().fetchInitialPosts(
                          search: _searchController.text,
                        );
                      },
                      itemBuilder: (item, index) {
                        if (item.type == 'event') {
                          return MyPostEventCard(postItem: item);
                        } else if (item.type == 'tip') {
                          return MyPostTipsCard(postItem: item);
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
    );
  }
}
