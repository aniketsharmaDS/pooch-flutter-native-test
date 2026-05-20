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
import 'package:poochcare/core/widgets/bottom_sheet/comment_bottom_sheet/comment_bottom_sheet.dart';
import 'package:poochcare/core/widgets/list_grid/app_paginated_list_view.dart';
import 'package:poochcare/core/widgets/list_items/tips_info_list_item_card.dart';
import 'package:poochcare/core/widgets/menus/app_popup_menu.dart';
import 'package:poochcare/core/widgets/tab_notifier.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/community/data/models/tips_category_model.dart';
import 'package:poochcare/features/community/data/models/tips_info_item_model.dart';
import 'package:poochcare/features/community/presentation/bloc/categories/categories_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/categories/categories_event.dart';
import 'package:poochcare/features/community/presentation/bloc/categories/categories_state.dart';
import 'package:poochcare/features/community/presentation/bloc/tips/tips_guide_bloc.dart';
import 'package:poochcare/router/app_router.dart';

/// =============================
/// SCREEN
/// =============================

@RoutePage()
class MyPostedTipsGuideScreen extends StatefulWidget
    implements AutoRouteWrapper {
  const MyPostedTipsGuideScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CommunityStoreBloc>.value(
          value: getIt<CommunityStoreBloc>(),
        ),
        BlocProvider<TipsGuideBloc>.value(value: getIt<TipsGuideBloc>()),
        BlocProvider<CategoriesBloc>.value(value: getIt<CategoriesBloc>()),
      ],
      child: this,
    );
  }

  @override
  State<MyPostedTipsGuideScreen> createState() =>
      _MyPostedTipsGuideScreenState();
}

class _MyPostedTipsGuideScreenState extends State<MyPostedTipsGuideScreen> {
  bool wasHomeTabActive = false;
  final List<TipsCategoryModel> eventsCategory = [
    const TipsCategoryModel(id: 'all', name: 'All Tips'),
  ];

  TipsCategoryModel _selectedCategory = const TipsCategoryModel(
    id: 'all',
    name: 'All Tips',
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
  //   context.read<AnyBlock>().anyMothod();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final scope = TabScope.of(context);

    if (scope == null) return;

    if (scope.index == 1) {
      // _onTabVisible();
    }

    if (scope.index == 0) {
      // _onHomeTabVisible();
    }
  }

  // void _onTabVisible() {
  //   debugPrint('Tips tab active again opened');
  //   if (_selectedCategory.id != 'All Tips' && wasHomeTabActive) {
  //     wasHomeTabActive = false;
  //     context.read<TipsGuideBloc>().fetchInitialTips(
  //       search: searchQuery,
  //       categoryId: _selectedCategory.id,
  //       // upcoming: _selectedCategory.id == 'upcoming' ? true : null,
  //     );
  //   }
  // }

  // void _onHomeTabVisible() {
  //   if (_selectedCategory.id != 'All Tips') {
  //     wasHomeTabActive = true;
  //     context.read<TipsGuideBloc>().fetchInitialTips(
  //       search: _searchController.text,
  //       // upcoming: null,
  //     );
  //   }
  // }

  void _onCategorySelected(TipsCategoryModel category) {
    setState(() {
      _selectedCategory = category;
    });
    context.read<TipsGuideBloc>().fetchInitialTips(
      type: TipsGuideType.allMyTipsGuides,
      search: searchQuery,
      categoryId: _selectedCategory.id,
    );
  }

  Future<void> _onRefresh() async {
    context.read<TipsGuideBloc>().fetchInitialTips(
      type: TipsGuideType.allMyTipsGuides,
      search: searchQuery,
      categoryId: _selectedCategory.id,
    );
  }

  void _onLoadMore() {
    context.read<TipsGuideBloc>().loadMoreTips();
  }

  /// =============================
  /// UI
  /// =============================

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<TipsGuideBloc, PaginationState<TipsInfoItemModel>>(
        builder: (context, state) {
          List<TipsInfoItemModel> listItems =
              state.scopedItems[TipsGuideType.allMyTipsGuides.name] ?? [];

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
                child: AppPaginatedListView<TipsInfoItemModel>(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.s16.w,
                  ).copyWith(bottom: AppSpacing.s16.h),
                  items: listItems,
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
                    _onCategorySelected(eventsCategory.first);
                  },
                  itemBuilder: (item, index) {
                    return TipsInfoListItemCard(
                      item: item,
                      onLikeChanged: (bool isLiked) {
                        context.read<TipsGuideBloc>().toggleTipsLike(
                          tipsId: item.id,
                          targetIsLiked: isLiked,
                        );
                      },
                      onCardTap: () {
                        bool isOwnPost =
                            false; // 👈 Assume it's own post for now
                        final userId = context
                            .read<AuthStoreBloc>()
                            .state
                            .user
                            ?.id;
                        if (userId != null && userId == item.userId) {
                          isOwnPost = true;
                        }
                        context.pushRoute(
                          CommunityTipsGuideDetailsRoute(
                            tipId: item.id,
                            isOwnPost: isOwnPost,
                          ),
                        );
                      },
                      onCommentTap: () {
                        CommentsBottomSheet.show(
                          context: context,
                          tipId: item.id,
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
