import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/pagination/pagination_state.dart';
import 'package:poochcare/core/services/secure_storage_service.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/list_grid/app_paginated_list_view.dart';
import 'package:poochcare/core/widgets/list_items/missing_pooch_list_item_card.dart';
import 'package:poochcare/core/widgets/menus/app_popup_menu.dart';
import 'package:poochcare/core/widgets/tab_notifier.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/community/data/models/missing_pet_model.dart';
import 'package:poochcare/features/community/data/models/tips_category_model.dart';
import 'package:poochcare/features/community/presentation/bloc/missing_pet/my_missing_pets_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/router/app_router.dart';

/// =============================
/// SCREEN
/// =============================

@RoutePage()
class MyPostedMissingPetsScreen extends StatefulWidget
    implements AutoRouteWrapper {
  const MyPostedMissingPetsScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MyMissingPetsBloc>.value(
          value: getIt<MyMissingPetsBloc>(),
        ),
      ],
      child: this,
    );
  }

  @override
  State<MyPostedMissingPetsScreen> createState() =>
      _MyPostedMissingPetsScreenState();
}

class _MyPostedMissingPetsScreenState extends State<MyPostedMissingPetsScreen> {
  bool wasHomeTabActive = false;
  List<TipsCategoryModel> allPets = [
    const TipsCategoryModel(id: 'All Pets', name: 'All Pets'),
  ];

  TipsCategoryModel _selectedCategory = const TipsCategoryModel(
    id: 'All Pets',
    name: 'All Pets',
  );
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final pets = context.read<UserProfileBloc>().state.pets;

    allPets = [
      const TipsCategoryModel(id: 'All Pets', name: 'All Pets'),
      ...pets.map((pet) => TipsCategoryModel(id: pet.id, name: pet.name)),
    ];

    _onCategorySelected(allPets.first);
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
  //   context.read<AnyBlock>().AnyMethod();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final scope = TabScope.of(context);

    if (scope == null) return;

    if (scope.index == 3) {
      _onTabVisible();
    }

    if (scope.index == 0) {
      _onHomeTabVisible();
    }
  }

  void _onTabVisible() {
    debugPrint('Event tab active again opened');
    if (_selectedCategory.id != 'All Pets' && wasHomeTabActive) {
      wasHomeTabActive = false;
      context.read<MyMissingPetsBloc>().fetchInitialMissingPets(
        search: searchQuery,
        petId: _selectedCategory.id,
        // upcoming: _selectedCategory.id == 'upcoming' ? true : null,
      );
    }
  }

  void _onHomeTabVisible() {
    if (_selectedCategory.id != 'All Pets') {
      wasHomeTabActive = true;
      context.read<MyMissingPetsBloc>().fetchInitialMissingPets(
        search: _searchController.text,
        // upcoming: null,
      );
    }
  }

  void _onCategorySelected(TipsCategoryModel category) {
    setState(() {
      _selectedCategory = category;
    });

    if (_selectedCategory.id == 'All Pets') {
      context.read<MyMissingPetsBloc>().fetchInitialMissingPets(
        search: _searchController.text,
        // upcoming: null,
      );
    } else {
      context.read<MyMissingPetsBloc>().fetchInitialMissingPets(
        search: searchQuery,
        petId: _selectedCategory.id,
      );
    }
  }

  Future<void> _onRefresh() async {
    if (_selectedCategory.id == 'All Pets') {
      context.read<MyMissingPetsBloc>().fetchInitialMissingPets(
        search: _searchController.text,
        // upcoming: null,
      );
    } else {
      context.read<MyMissingPetsBloc>().fetchInitialMissingPets(
        search: searchQuery,
        petId: _selectedCategory.id,
        // upcoming: _selectedCategory.id == 'upcoming' ? true : null,
      );
    }
  }

  void _onLoadMore() {
    context.read<MyMissingPetsBloc>().loadMoreMissingPets();
  }

  /// =============================
  /// UI
  /// =============================

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<MyMissingPetsBloc, PaginationState<MissingPetModel>>(
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
                      'An error occurred while loading data.',
                  onLoadMore: _onLoadMore,
                  onRefresh: _onRefresh,
                  onRetry: () {
                    context.read<MyMissingPetsBloc>().fetchInitialMissingPets(
                      search: _searchController.text,
                      // categoryId: _selectedCategory.id,
                      // upcoming: _selectedCategory.id == 'upcoming'
                      //     ? true
                      //     : null,
                    );
                  },
                  itemBuilder: (item, index) {
                    return MissingPoochListItemCard(
                      item: item,
                      onCardTap: () {
                        final secureStorage = getIt<SecureStorageService>();
                        secureStorage.writeChatJourney(
                          ChatReturnType.allMissingPetUserList.name,
                        );
                        context.pushRoute<bool>(
                          MissingPetDetailsRoute(
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
    );
  }
}
