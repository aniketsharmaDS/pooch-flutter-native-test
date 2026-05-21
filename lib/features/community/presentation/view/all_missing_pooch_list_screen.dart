import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/pagination/pagination_state.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/list_grid/app_paginated_list_view.dart';
import 'package:poochcare/core/widgets/list_items/missing_pooch_list_item_card.dart';
import 'package:poochcare/core/widgets/others/generic_categpry_selector.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/core/widgets/texts/app_search_field.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/community/data/models/missing_pet_model.dart';
import 'package:poochcare/features/community/data/models/tips_category_model.dart';
import 'package:poochcare/features/community/presentation/bloc/missing_pet/all_missing_pets_bloc.dart';
import 'package:poochcare/features/community/presentation/view/report_missing_pet_form_screen.dart';
import 'package:poochcare/router/app_router.dart';

/// =============================
/// SCREEN
/// =============================

@RoutePage()
class AllMissingPoochListScreen extends StatefulWidget
    implements AutoRouteWrapper {
  final String listType;
  final String? petType;
  final String? petGender;

  const AllMissingPoochListScreen({
    super.key,
    this.listType = 'default',
    this.petType,
    this.petGender,
  });

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AllMissingPetsBloc>.value(
          value: getIt<AllMissingPetsBloc>(),
        ),
      ],
      child: this,
    );
  }

  @override
  State<AllMissingPoochListScreen> createState() =>
      _AllMissingPoochListScreenState();
}

class _AllMissingPoochListScreenState extends State<AllMissingPoochListScreen> {
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

    if (widget.listType == 'manual_found_pet') {
      if (widget.petType != null) {
        _selectedCategory = allPets.firstWhere(
          (category) => category.id == widget.petType,
          orElse: () => allPets.first,
        );
      }
    } else {
      _selectedCategory = allPets.first;
    }

    log(
      'Selected category on init: ${_selectedCategory.name} widget.petType: ${widget.petType} widget.petGender: ${widget.petGender}',
    );

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

    if (_selectedCategory.id == 'all') {
      context.read<AllMissingPetsBloc>().fetchInitialMissingPets(
        search: searchQuery,
      );
    } else {
      context.read<AllMissingPetsBloc>().fetchInitialMissingPets(
        search: searchQuery,
        petType: _selectedCategory.id,
        petGender: widget.petGender,
      );
    }
  }

  Future<void> _onRefresh() async {
    _onCategorySelected(_selectedCategory);
    // if (_selectedCategory.id == 'all') {
    //   context.read<AllMissingPetsBloc>().fetchInitialMissingPets(
    //     search: _searchController.text,
    //   );
    // } else {
    //   context.read<AllMissingPetsBloc>().fetchInitialMissingPets(
    //     search: searchQuery,
    //     petType: _selectedCategory.id,
    //   );
    // }
  }

  void _onLoadMore() {
    context.read<AllMissingPetsBloc>().loadMoreMissingPets();
  }

  /// =============================
  /// UI
  /// =============================
  ///

  void _handleBack() {
    final isDefaultTab = _selectedCategory.id == 'all';
    final hasSearch = _searchController.text.isNotEmpty;

    final shouldRefresh = !isDefaultTab || hasSearch;
    if (shouldRefresh) {
      context.read<AllMissingPetsBloc>().fetchInitialMissingPets();
    }
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
        title: 'community.allMissingPoochListScreen.title'.tr(),
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
          child: BlocBuilder<AllMissingPetsBloc, PaginationState<MissingPetModel>>(
            builder: (context, state) {
              return Column(
                children: [
                  if (widget.listType != 'manual_found_pet') ...[
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
                  ],

                  if (widget.listType != 'manual_found_pet') ...[
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
                        allItem: const TipsCategoryModel(
                          id: 'all',
                          name: 'All',
                        ),

                        /// Normal selection
                        onItemSelected: (item) {
                          _onCategorySelected(item);
                        },
                      ),
                    ),
                  ],
                  if (widget.listType == 'manual_found_pet' &&
                      !state.isLoading) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.s10.w,
                        vertical: AppSpacing.s20.h,
                      ),
                      child: AppText.h1(
                        state.items.isNotEmpty
                            ? 'community.allMissingPoochListScreen.matchingPetsFound'
                                  .tr()
                            : 'community.allMissingPoochListScreen.noMatchingPetsFound'
                                  .tr(),
                        fontSize: AppFontSize.fs16,
                        style: const TextStyle(height: 1.2),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],

                  /// 📦 LIST
                  Expanded(
                    child: AppPaginatedListView<MissingPetModel>(
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
                        context
                            .read<AllMissingPetsBloc>()
                            .fetchInitialMissingPets(
                              search: _searchController.text,
                            );
                      },
                      itemBuilder: (item, index) {
                        return MissingPoochListItemCard(
                          item: item,
                          onCardTap: () {
                            context.pushRoute<bool>(
                              MissingPetDetailsRoute(
                                listType: widget.listType,
                                reportId: item.id,
                                isOwnPost: item.isAuthor,
                              ),
                            );
                          },
                          // onLikeChanged: (bool isLiked) {
                          //   context.read<EventsBloc>().toggleEventLike(
                          //     eventId: item.id,
                          //     targetIsLiked: isLiked,
                          //   );
                          // },
                          // onCardTap: () {
                          //   // Handle card tap here
                          //   bool isOwnPost =
                          //       false; // 👈 Assume it's own post for now
                          //   final userId = context
                          //       .read<AuthStoreBloc>()
                          //       .state
                          //       .user
                          //       ?.id;
                          //   if (userId != null && userId == item.organizer!.id) {
                          //     isOwnPost = true;
                          //   }
                          //   context.pushRoute(
                          //     CommunityEventDetailsRoute(
                          //       eventId: item.id,
                          //       isOwnPost: isOwnPost,
                          //     ),
                          //   );
                          // },
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
}
