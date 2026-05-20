import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/pagination/pagination_state.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/list_grid/app_paginated_list_view.dart';
import 'package:poochcare/core/widgets/list_items/event_list_item_card.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_search_field.dart';
import 'package:poochcare/features/community/data/models/event_info_item_model.dart';
import 'package:poochcare/features/community/data/models/tips_category_model.dart';
import 'package:poochcare/features/community/presentation/bloc/events/events_bloc.dart';
import 'package:poochcare/features/community/presentation/widgets/category_selector.dart';
import 'package:poochcare/router/app_router.dart';

/// =============================
/// SCREEN
/// =============================

@RoutePage()
class AllCommunityEventsListScreen extends StatefulWidget
    implements AutoRouteWrapper {
  const AllCommunityEventsListScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<EventsBloc>.value(value: getIt<EventsBloc>())],
      child: this,
    );
  }

  @override
  State<AllCommunityEventsListScreen> createState() =>
      _AllCommunityEventsListScreenState();
}

class _AllCommunityEventsListScreenState
    extends State<AllCommunityEventsListScreen> {
  String? _selectedCategoryId = 'upcoming';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<TipsCategoryModel> eventsCategory = [
    const TipsCategoryModel(id: 'upcoming', name: 'Upcoming'),
  ];

  @override
  void initState() {
    super.initState();
    _onCategorySelected(eventsCategory.first);
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
    context.read<EventsBloc>().fetchInitialEvents(
      search: searchQuery,
      // categoryId: _selectedCategoryId,
      upcoming: _selectedCategoryId == 'upcoming' ? true : null,
      type: EventsType.allEvents,
    );
  }

  void _onCategorySelected(TipsCategoryModel category) {
    setState(() {
      _selectedCategoryId = category.id.isEmpty ? null : category.id;
    });

    context.read<EventsBloc>().fetchInitialEvents(
      search: _searchController.text,
      // categoryId: category.id,
      upcoming: category.id == 'upcoming' ? true : null,
      type: category.id == 'upcoming'
          ? EventsType.allUpcoming
          : EventsType.allEvents,
    );
  }

  Future<void> _onRefresh() async {
    context.read<EventsBloc>().fetchInitialEvents(
      search: searchQuery,
      // categoryId: _selectedCategoryId,
      upcoming: _selectedCategoryId == 'upcoming' ? true : null,
      type: _selectedCategoryId == 'upcoming'
          ? EventsType.allUpcoming
          : EventsType.allEvents,
    );
  }

  void _onLoadMore() {
    context.read<EventsBloc>().loadMoreEvents();
  }

  /// =============================
  /// UI
  /// =============================

  @override
  Widget build(BuildContext context) {
    return PopScope<bool>(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleBack();
        // final isDefaultTab = _selectedCategoryId == 'upcoming';
        // final hasSearch = _searchController.text.isNotEmpty;
        // final hasFilter =
        //     _selectedCategoryId != null && _selectedCategoryId != 'upcoming';
        // final shouldRefresh = !isDefaultTab || hasSearch || hasFilter;
        // context.router.pop(shouldRefresh); // ✅ send refresh signal
      },
      child: AppPrimaryBgContainer(
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: PoochScreenAppBar(
            title: 'Event',
            actions: [
              AppCircleButton(
                variant: AppCircleButtonVariant.secondary,
                bgColor: AppColors.transparent,
                iconSize: AppIconSize.is20,
                showShadow: false,
                icon: AppIcons.svg.generic.plusSign,
                onTap: () => {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Add a new Event')),
                  ),
                },
              ),
            ],
            onBack: _handleBack,
          ),
          body: SafeArea(
            child: BlocBuilder<EventsBloc, PaginationState<EventInfoItemModel>>(
              builder: (context, state) {
                return Column(
                  children: [
                    /// 🔍 SEARCH
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

                    // 🏷️ CATEGORY SELECTOR
                    Padding(
                      padding: EdgeInsets.only(bottom: AppSpacing.s16.h),
                      child: CategorySelector(
                        categories: eventsCategory,
                        selectedCategoryId: _selectedCategoryId,
                        onCategorySelected: _onCategorySelected,
                      ),
                    ),

                    /// 📦 LIST
                    Expanded(
                      child: AppPaginatedListView<EventInfoItemModel>(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.s16.w,
                        ).copyWith(bottom: AppSpacing.s16.h),
                        //  items: state.items,
                        items: state.scopedItems[state.currentScope] ?? [],
                        isLoading: state.isLoading,
                        isLoadingMore: state.isFetchingMore,
                        hasMore: state.hasMore,
                        hasError: state.errorMessage != null,
                        error:
                            state.errorMessage ??
                            'An error occurred while loading data.',
                        onLoadMore: _onLoadMore,
                        onRefresh: _onRefresh,
                        onRetry: () {
                          _onRefresh();
                        },
                        itemBuilder: (item, index) {
                          return EventListItemCard(
                            item: item,
                            onLikeChanged: (bool isLiked) {
                              context.read<EventsBloc>().toggleEventLike(
                                eventId: item.id,
                                targetIsLiked: isLiked,
                              );
                            },
                            onCardTap: () {
                              // Handle card tap here
                              bool isOwnPost =
                                  false; // 👈 Assume it's own post for now
                              final userId = context
                                  .read<AuthStoreBloc>()
                                  .state
                                  .user
                                  ?.id;
                              if (userId != null &&
                                  userId == item.organizer!.id) {
                                isOwnPost = true;
                              }
                              context.pushRoute(
                                CommunityEventDetailsRoute(
                                  eventId: item.id,
                                  isOwnPost: isOwnPost,
                                ),
                              );
                            },
                          );
                        },
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

  void _handleBack() {
    final isDefaultTab = _selectedCategoryId == 'upcoming';
    final hasSearch = _searchController.text.isNotEmpty;
    final hasFilter =
        _selectedCategoryId != null && _selectedCategoryId != 'upcoming';
    final shouldRefresh = !isDefaultTab || hasSearch || hasFilter;
    context.router.pop(shouldRefresh); //✅ SAME as PopScope
  }
}
