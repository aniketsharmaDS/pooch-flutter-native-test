import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/pagination/pagination_state.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/list_grid/app_paginated_list_view.dart';
import 'package:poochcare/core/widgets/list_items/found_pooch_list_item_card.dart';
import 'package:poochcare/core/widgets/others/generic_categpry_selector.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/core/widgets/texts/app_search_field.dart';
import 'package:poochcare/features/community/data/models/found_pet_model.dart';
import 'package:poochcare/features/community/data/models/tips_category_model.dart';
import 'package:poochcare/features/community/presentation/bloc/found_pet/found_pet_bloc.dart';
import 'package:poochcare/features/community/presentation/view/report_missing_pet_form_screen.dart';
import 'package:poochcare/router/app_router.dart';

/// =============================
/// SCREEN
/// =============================

@RoutePage()
class AllFoundPoochListScreen extends StatefulWidget
    implements AutoRouteWrapper {
  const AllFoundPoochListScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FoundPetBloc>.value(value: getIt<FoundPetBloc>()),
      ],
      child: this,
    );
  }

  @override
  State<AllFoundPoochListScreen> createState() =>
      _AllFoundPoochListScreenState();
}

class _AllFoundPoochListScreenState extends State<AllFoundPoochListScreen> {
  bool wasHomeTabActive = false;

  List<TipsCategoryModel> allPets = [
    const TipsCategoryModel(id: 'all', name: 'All'),
    const TipsCategoryModel(id: 'dog', name: 'Dog'),
    const TipsCategoryModel(id: 'cat', name: 'Cat'),
  ];

  TipsCategoryModel _selectedCategory = const TipsCategoryModel(
    id: 'all',
    name: 'All',
  );

  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedCategory = allPets.first;
    _onCategorySelected(_selectedCategory);
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
    _onCategorySelected(_selectedCategory);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _onCategorySelected(TipsCategoryModel category) {
    setState(() {
      _selectedCategory = category;
    });

    context.read<FoundPetBloc>().fetchInitialFoundPets(
      scopeType: FoundPetScopeType.allFoundPets,
      scopePetType: _selectedCategory.id,
      search: searchQuery,
      petType: _selectedCategory.id,
    );
  }

  Future<void> _onRefresh() async {
    _onCategorySelected(_selectedCategory);
  }

  void _onLoadMore() {
    context.read<FoundPetBloc>().loadMoreFoundPets();
  }

  /// =============================
  /// UI
  /// =============================
  ///

  void _handleBack() {
    // final isDefaultTab = _selectedCategory.id == 'all';
    // final hasSearch = _searchController.text.isNotEmpty;

    // final shouldRefresh = !isDefaultTab || hasSearch;
    // if (shouldRefresh) {
    //   context.read<FoundPetBloc>().fetchInitialFoundPets();
    // }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<bool>(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleBack();
      },
      child: AppPrimaryScreenContainer(
        title: 'community.allFoundPoochListScreen.title'.tr(),
        onBack: _handleBack,
        actions: [
          AppCircleButton(
            variant: AppCircleButtonVariant.secondary,
            bgColor: AppColors.transparent,
            iconSize: AppIconSize.is20,
            showShadow: false,
            icon: AppIcons.svg.generic.plusSign,
            onTap: () => {
              context.pushRoute(
                ReportMissingPetFormRoute(
                  type: ReportMissingPetFormType.create,
                ),
              ),
            },
          ),
        ],
        child: SafeArea(
          child: BlocBuilder<FoundPetBloc, PaginationState<FoundPetModel>>(
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

                  // 🏷️ CATEGORY SELECTOR
                  // Padding(
                  //   padding: EdgeInsets.only(bottom: AppSpacing.s16.h),
                  //   child: CategorySelector(
                  //     categories: eventsCategory,
                  //     selectedCategoryId: _selectedCategoryId,
                  //     onCategorySelected: _onCategorySelected,
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(bottom: AppSpacing.s16.h),
                    child: GenericCategorySelector<TipsCategoryModel>(
                      items: allPets,

                      /// REQUIRED
                      getId: (e) => e.id,
                      getLabel: (e) => e.name,

                      /// Selected
                      selectedId: _selectedCategory.id,

                      /// "All" option
                      includeAll: false,
                      allItem: const TipsCategoryModel(id: 'all', name: 'All'),

                      /// Normal selection
                      onItemSelected: (item) {
                        _onCategorySelected(item);
                      },
                    ),
                  ),

                  /// 📦 LIST
                  Expanded(
                    child: AppPaginatedListView<FoundPetModel>(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16.w,
                      ).copyWith(bottom: AppSpacing.s16.h),
                      items:
                          (state.scopedItems[buildScope(
                            scopeType: FoundPetScopeType.allFoundPets,
                            type: _selectedCategory.id,
                          )] ??
                          []),
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
                        _onRefresh;
                      },
                      itemBuilder: (item, index) {
                        return FoundPoochListItemCard(
                          item: item,
                          onCardTap: () {
                            context.pushRoute<bool>(
                              FoundPetDetailsRoute(
                                reportId: item.id,
                                isOwnPost: true,
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
    );
  }

  String buildScope({
    required FoundPetScopeType scopeType,
    String? userId,
    String? categoryId,
    bool? upcoming,
    String? search,
    String? type,
  }) {
    String scope = [
      scopeType.name,
      if (userId != null) 'user:$userId',
      if (categoryId != null) 'cat:$categoryId',
      if (upcoming != null) 'upcoming:$upcoming',
      if (search != null && search.isNotEmpty) 'q:$search',
      if (type != null && type.isNotEmpty) 'type:$type',
    ].join('|');

    log('Built scope: $scope');

    return scope;
  }
}
