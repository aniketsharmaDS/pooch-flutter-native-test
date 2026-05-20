import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/pagination/pagination_state.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/list_grid/app_paginated_list_view.dart';
import 'package:poochcare/core/widgets/list_items/found_pooch_list_item_card.dart';
import 'package:poochcare/core/widgets/menus/app_popup_menu.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/community/data/models/found_pet_model.dart';
import 'package:poochcare/features/community/data/models/tips_category_model.dart';
import 'package:poochcare/features/community/presentation/bloc/found_pet/found_pet_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/router/app_router.dart';

/// =============================
/// SCREEN
/// =============================

@RoutePage()
class MyPostedFoundPetsScreen extends StatefulWidget
    implements AutoRouteWrapper {
  const MyPostedFoundPetsScreen({super.key});

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
  State<MyPostedFoundPetsScreen> createState() =>
      _MyPostedFoundPetsScreenState();
}

class _MyPostedFoundPetsScreenState extends State<MyPostedFoundPetsScreen> {
  bool wasHomeTabActive = false;
  List<TipsCategoryModel> allPets = [
    const TipsCategoryModel(id: 'all', name: 'All Pets'),
  ];

  TipsCategoryModel _selectedCategory = const TipsCategoryModel(
    id: 'all',
    name: 'All Pets',
  );
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final pets = context.read<UserProfileBloc>().state.pets;

    allPets = [
      const TipsCategoryModel(id: 'all', name: 'All Pets'),
      ...pets.map((pet) => TipsCategoryModel(id: pet.id, name: pet.name)),
    ];

    _onCategorySelected(allPets.first);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onCategorySelected(TipsCategoryModel category) {
    setState(() {
      _selectedCategory = category;
    });
    context.read<FoundPetBloc>().fetchInitialFoundPets(
      scopeType: FoundPetScopeType.allMyFoundPets,
      // petType: _selectedCategory.id,
      petId: _selectedCategory.id,
      search: searchQuery,
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<FoundPetBloc, PaginationState<FoundPetModel>>(
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
                    AppPopupMenu(
                      headerTitle: 'Select Category',
                      showCloseIcon: true,
                      iconPath: AppIcons.svg.generic.sortDescending,
                      iconSize: AppIconSize.is16,
                      onClose: () {},
                      items: allPets.map((item) {
                        return AppPopupMenuItem(
                          title: item.name,
                          onTap: () {
                            _onCategorySelected(item);
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              /// 📦 LIST
              Expanded(
                child: AppPaginatedListView<FoundPetModel>(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.s16.w,
                  ).copyWith(bottom: AppSpacing.s16.h),
                  items:
                      state.scopedItems[FoundPetScopeType
                          .allMyFoundPets
                          .name] ??
                      [],
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
    );
  }
}
