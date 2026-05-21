import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/pagination/pagination_state.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/list_grid/app_paginated_list_view.dart';
import 'package:poochcare/core/widgets/list_items/pet_shelter_list_item_card.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/features/community/data/models/pet_shelter_model.dart';
import 'package:poochcare/features/community/presentation/bloc/pet_shelter/pet_shelter_bloc.dart';

/// =============================
/// SCREEN
/// =============================

@RoutePage()
class PoochPetShelterListScreen extends StatefulWidget
    implements AutoRouteWrapper {
  const PoochPetShelterListScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PetShelterBloc>.value(value: getIt<PetShelterBloc>()),
      ],
      child: this,
    );
  }

  @override
  State<PoochPetShelterListScreen> createState() =>
      _PoochPetShelterListScreenState();
}

class _PoochPetShelterListScreenState extends State<PoochPetShelterListScreen> {
  late Map<String, bool> _selectedShelters;
  @override
  void initState() {
    super.initState();
    _selectedShelters = {};
    _onRefresh();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onRefresh() async {
    context.read<PetShelterBloc>().fetchInitialEvents(
      type: PetShelterBlocType.allPetShelters,
    );
  }

  void _onLoadMore() {
    context.read<PetShelterBloc>().loadMoreEvents();
  }

  /// =============================
  /// UI
  /// =============================

  @override
  Widget build(BuildContext context) {
    return AppPrimaryScreenContainer(
      title: 'community.poochPetShelterListScreen.title'.tr(),
      child: BlocBuilder<PetShelterBloc, PaginationState<PetShelterModel>>(
        builder: (context, state) {
          return Column(
            children: [
              /// 📦 LIST
              Expanded(
                child: AppPaginatedListView<PetShelterModel>(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.s16.w,
                  ).copyWith(bottom: AppSpacing.s16.h),
                  items:
                      state.scopedItems[PetShelterBlocType
                          .allPetShelters
                          .name] ??
                      [],
                  isLoading: state.isLoading,
                  isLoadingMore: state.isFetchingMore,
                  hasMore: state.hasMore,
                  hasError: state.errorMessage != null,
                  error:
                      state.errorMessage ?? 'community.loadingDataError'.tr(),
                  onLoadMore: _onLoadMore,
                  onRefresh: _onRefresh,
                  onRetry: () {
                    context.read<PetShelterBloc>().fetchInitialEvents(
                      type: PetShelterBlocType.allPetShelters,
                    );
                  },
                  itemBuilder: (item, index) {
                    return PetShelterListItemCard(
                      item: item,
                      isSelected: _selectedShelters[item.id] ?? false,
                      onSelectionChanged: (value) {
                        setState(() {
                          _selectedShelters[item.id] = value;
                        });
                      },
                      onTap: () {
                        setState(() {
                          final current = _selectedShelters[item.id] ?? false;
                          _selectedShelters[item.id] = !current;
                        });
                      },
                    );
                    // return PetShelterListItemCard(
                    //   item: item,

                    //   isSelected: false,
                    //    onSelectionChanged: (bool isSelected) {}
                    //    );
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
