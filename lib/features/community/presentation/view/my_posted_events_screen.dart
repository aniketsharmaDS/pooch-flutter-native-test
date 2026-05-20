import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/pagination/pagination_state.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/store/community/community_store_bloc.dart';
import 'package:poochcare/core/store/community/community_store_state.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/list_grid/app_paginated_list_view.dart';
import 'package:poochcare/core/widgets/list_items/event_list_item_card.dart';
import 'package:poochcare/core/widgets/menus/app_popup_menu.dart';
import 'package:poochcare/core/widgets/tab_notifier.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/community/data/models/event_info_item_model.dart';
import 'package:poochcare/features/community/data/models/tips_category_model.dart';
import 'package:poochcare/features/community/presentation/bloc/categories/categories_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/categories/categories_event.dart';
import 'package:poochcare/features/community/presentation/bloc/categories/categories_state.dart';
import 'package:poochcare/features/community/presentation/bloc/events/events_bloc.dart';
import 'package:poochcare/router/app_router.dart';

/// =============================
/// SCREEN
/// =============================

@RoutePage()
class MyPostedEventsScreen extends StatefulWidget implements AutoRouteWrapper {
  const MyPostedEventsScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CommunityStoreBloc>.value(
          value: getIt<CommunityStoreBloc>(),
        ),
        BlocProvider<EventsBloc>.value(value: getIt<EventsBloc>()),
        BlocProvider<CategoriesBloc>.value(value: getIt<CategoriesBloc>()),
      ],
      child: this,
    );
  }

  @override
  State<MyPostedEventsScreen> createState() => _MyPostedEventsScreenState();
}

class _MyPostedEventsScreenState extends State<MyPostedEventsScreen> {
  bool wasHomeTabActive = false;
  final List<TipsCategoryModel> eventsCategory = [
    const TipsCategoryModel(id: 'All Events', name: 'All Events'),
  ];

  TipsCategoryModel _selectedCategory = const TipsCategoryModel(
    id: 'All Events',
    name: 'All Events',
  );
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CategoriesBloc>().add(const FetchCategories());
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

  // void _onSearch(String query) {
  //   setState(() {
  //     searchQuery = query;
  //   });
  //   context.read<AnyBlock>().AnyEvent(
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final scope = TabScope.of(context);

    if (scope == null) return;

    if (scope.index == 2) {
      _onTabVisible();
    }

    if (scope.index == 0) {
      _onHomeTabVisible();
    }
  }

  void _onTabVisible() {
    debugPrint('Event tab active again opened');
    if (_selectedCategory.id != 'All Events' && wasHomeTabActive) {
      wasHomeTabActive = false;
      context.read<EventsBloc>().fetchInitialEvents(
        search: searchQuery,
        categoryId: _selectedCategory.id,
        type: EventsType.allMyEvents,
      );
    }
  }

  void _onHomeTabVisible() {
    // if (_selectedCategory.id != 'All Events') {
    //   wasHomeTabActive = true;
    //   context.read<EventsBloc>().fetchInitialEvents(
    //     search: _searchController.text,
    //     type: EventsType.allMyEvents
    //   );
    // }
  }

  void _onCategorySelected(TipsCategoryModel category) {
    setState(() {
      _selectedCategory = category;
    });

    if (_selectedCategory.id == 'All Events') {
      context.read<EventsBloc>().fetchInitialEvents(
        search: _searchController.text,
        type: EventsType.allMyEvents,
      );
    } else {
      context.read<EventsBloc>().fetchInitialEvents(
        search: searchQuery,
        categoryId: _selectedCategory.id,
        type: EventsType.allMyEvents,
      );
    }
  }

  Future<void> _onRefresh() async {
    if (_selectedCategory.id == 'All Events') {
      context.read<EventsBloc>().fetchInitialEvents(
        search: _searchController.text,
        type: EventsType.allMyEvents,
      );
    } else {
      context.read<EventsBloc>().fetchInitialEvents(
        search: searchQuery,
        categoryId: _selectedCategory.id,
        type: EventsType.allMyEvents,
      );
    }
  }

  void _onLoadMore() {
    context.read<EventsBloc>().loadMoreEvents();
  }

  /// =============================
  /// UI
  /// =============================

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<EventsBloc, PaginationState<EventInfoItemModel>>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: AppText.h1(
                        _selectedCategory.name,
                        fontSize: AppFontSize.fs18,
                        color: const Color(0XFF3F3C36),
                      ),
                    ),
                    BlocBuilder<CategoriesBloc, CategoriesState>(
                      builder: (context, state) {
                        if (state is CategoriesLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        // if (state is CategoriesError) {
                        //   return Text(state.message);
                        // }

                        return BlocBuilder<
                          CommunityStoreBloc,
                          CommunityStoreState
                        >(
                          builder: (context, storeState) {
                            final categories = storeState.categoryIds
                                .map((id) => storeState.categoriesById[id]!)
                                .toList();

                            categories.insert(0, eventsCategory.first);

                            return AppPopupMenu(
                              headerTitle: 'Select Category',
                              showCloseIcon: true,
                              iconPath: AppIcons.svg.generic.sortDescending,
                              iconSize: AppIconSize.is16,
                              onClose: () {},
                              items: categories.map((item) {
                                return AppPopupMenuItem(
                                  title: item.name,
                                  onTap: () {
                                    _onCategorySelected(item);
                                  },
                                );
                              }).toList(),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),

              /// 📦 LIST
              Expanded(
                child: AppPaginatedListView<EventInfoItemModel>(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.s16.w,
                  ).copyWith(bottom: AppSpacing.s16.h),
                  items: state.scopedItems[EventsType.allMyEvents.name] ?? [],
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
                    context.read<EventsBloc>().fetchInitialEvents(
                      search: _searchController.text,
                      type: EventsType.allMyEvents,
                    );
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
                        if (userId != null && userId == item.organizer!.id) {
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
    );
  }
}
