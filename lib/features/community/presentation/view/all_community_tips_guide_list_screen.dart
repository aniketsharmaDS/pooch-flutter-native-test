import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/pagination/pagination_state.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/store/community/community_store_bloc.dart';
import 'package:poochcare/core/store/community/community_store_state.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/bottom_sheet/comment_bottom_sheet/comment_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/list_grid/app_paginated_list_view.dart';
import 'package:poochcare/core/widgets/list_items/tips_info_list_item_card.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_search_field.dart';
import 'package:poochcare/features/community/data/models/tips_category_model.dart';
import 'package:poochcare/features/community/data/models/tips_info_item_model.dart';
import 'package:poochcare/features/community/presentation/bloc/categories/categories_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/categories/categories_event.dart';
import 'package:poochcare/features/community/presentation/bloc/categories/categories_state.dart';
import 'package:poochcare/features/community/presentation/bloc/tips/tips_guide_bloc.dart';
import 'package:poochcare/features/community/presentation/view/my_tip_guide_form_screen.dart';
import 'package:poochcare/features/community/presentation/widgets/category_selector.dart';
import 'package:poochcare/router/app_router.dart';

/// =============================
/// SCREEN
/// =============================

@RoutePage()
class AllCommunityTipsGuideListScreen extends StatefulWidget
    implements AutoRouteWrapper {
  const AllCommunityTipsGuideListScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TipsGuideBloc>.value(value: getIt<TipsGuideBloc>()),
        BlocProvider<CommunityStoreBloc>.value(
          value: getIt<CommunityStoreBloc>(),
        ),
        BlocProvider<CategoriesBloc>.value(value: getIt<CategoriesBloc>()),
      ],
      child: this,
    );
  }

  @override
  State<AllCommunityTipsGuideListScreen> createState() =>
      _AllCommunityTipsGuideListScreenState();
}

class _AllCommunityTipsGuideListScreenState
    extends State<AllCommunityTipsGuideListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategoryId = 'all';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  void fetchInitialData() {
    CommunityStoreBloc store = context.read<CommunityStoreBloc>();
    if (store.state.categoriesById.isEmpty) {
      context.read<CategoriesBloc>().add(const FetchCategories());
    }
    context.read<TipsGuideBloc>().fetchInitialTips(
      search: _searchQuery,
      categoryId: _selectedCategoryId,
      type: TipsGuideType.allTipsGuides,
    );
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
      _searchQuery = query;
    });
    context.read<TipsGuideBloc>().fetchInitialTips(
      type: TipsGuideType.allTipsGuides,
      search: query,
      categoryId: _selectedCategoryId,
    );
  }

  void _onCategorySelected(TipsCategoryModel category) {
    String categoryId = category.id == 'all' ? 'all' : category.id;
    setState(() {
      _selectedCategoryId = categoryId;
    });

    context.read<TipsGuideBloc>().fetchInitialTips(
      type: TipsGuideType.allTipsGuides,
      search: _searchQuery,
      categoryId: categoryId,
    );
  }

  Future<void> _onRefresh() async {
    context.read<TipsGuideBloc>().refreshTips();
  }

  void _onLoadMore() {
    context.read<TipsGuideBloc>().loadMoreTips();
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
        // final isDefaultTab = _selectedCategoryId == '';
        // final hasSearch = _searchController.text.isNotEmpty;
        // final hasFilter =
        //     _selectedCategoryId != null && _selectedCategoryId != '';

        // final shouldRefresh = !isDefaultTab || hasSearch || hasFilter;
        // context.router.pop(shouldRefresh); // ✅ send refresh signal
      },
      child: AppPrimaryBgContainer(
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: PoochScreenAppBar(
            title: 'community.allCommunityTipsGuideListScreen.title'.tr(),
            actions: [
              AppCircleButton(
                variant: AppCircleButtonVariant.secondary,
                bgColor: AppColors.transparent,
                iconSize: AppIconSize.is20,
                showShadow: false,
                icon: AppIcons.svg.generic.plusSign,
                onTap: () => {
                  context.pushRoute(
                    MyTipGuideFormRoute(type: MyTipFormType.create),
                  ),
                },
              ),
            ],
            onBack: _handleBack,
          ),
          body: SafeArea(
            child:
                BlocBuilder<TipsGuideBloc, PaginationState<TipsInfoItemModel>>(
                  builder: (context, state) {
                    String scopeKey = buildScope(
                      type: TipsGuideType.allTipsGuides,
                      categoryId: _selectedCategoryId,
                    );
                    List<TipsInfoItemModel> listItems =
                        state.scopedItems[scopeKey] ?? [];

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
                        BlocBuilder<CategoriesBloc, CategoriesState>(
                          builder: (context, state) {
                            if (state is CategoriesLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return BlocBuilder<
                              CommunityStoreBloc,
                              CommunityStoreState
                            >(
                              builder: (context, storeState) {
                                final categories = storeState.categoryIds
                                    .map((id) => storeState.categoriesById[id]!)
                                    .toList();

                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: AppSpacing.s16.h,
                                  ),
                                  child: CategorySelector(
                                    categories: categories,
                                    selectedCategoryId: _selectedCategoryId,
                                    onCategorySelected: _onCategorySelected,
                                  ),
                                );
                              },
                            );
                          },
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
                                'community.loadingDataError'.tr(),
                            onLoadMore: _onLoadMore,
                            onRefresh: _onRefresh,
                            onRetry: () {
                              fetchInitialData();
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
          ),
        ),
      ),
    );
  }

  void _handleBack() {
    final isDefaultTab = _selectedCategoryId == '';
    final hasSearch = _searchController.text.isNotEmpty;
    final hasFilter = _selectedCategoryId != '';

    final shouldRefresh = !isDefaultTab || hasSearch || hasFilter;
    context.router.pop(shouldRefresh); // ✅ SAME as PopScope
  }

  String buildScope({
    required TipsGuideType type,
    String? userId,
    String? categoryId,
    bool? upcoming,
    String? search,
  }) {
    return [
      type.name,
      if (userId != null) 'user:$userId',
      if (categoryId != null) 'cat:$categoryId',
      if (upcoming != null) 'upcoming:$upcoming',
      if (search != null && search.isNotEmpty) 'q:$search',
    ].join('|');
  }
}
