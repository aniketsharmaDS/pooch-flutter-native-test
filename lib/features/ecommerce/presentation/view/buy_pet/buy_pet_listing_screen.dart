import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/tabs/app_top_tab_bar.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet/buy_pet_bloc.dart'
    as buy_pet;
import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet_landing/buy_pet_landing_bloc.dart'
    as landing;
import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/buy_pet_filters_dialog.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/buy_pet_listing_tab.dart';

@RoutePage()
class BuyPetListingScreen extends StatefulWidget {
  const BuyPetListingScreen({super.key});

  // final landing.BuyPetLandingBloc landingBloc;

  @override
  State<BuyPetListingScreen> createState() => _BuyPetListingScreenState();
}

class _BuyPetListingScreenState extends State<BuyPetListingScreen> {
  final _searchController = TextEditingController();
  Timer? _searchDebounce;

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  /// =============================
  /// UI
  /// =============================
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<buy_pet.BuyPetBloc>(
          create: (context) =>
              getIt<buy_pet.BuyPetBloc>()..add(const buy_pet.FetchProducts()),
        ),
        // BlocProvider.value(value),
      ],
      child: BlocConsumer<buy_pet.BuyPetBloc, buy_pet.BuyPetState>(
        listener: (context, state) async {
          if (state.shouldOpenFilterDialog) {
            // RESET FIRST
            context.read<buy_pet.BuyPetBloc>().add(
              buy_pet.ResetFilterDialogEvent(),
            );

            final result = await BuyPetFiltersDialog.show(context);

            if (!context.mounted) return;

            if (result != null) {
              if (result.selectedValues.isEmpty) {
                //  CLEAR CASE
                context.read<buy_pet.BuyPetBloc>().add(
                  buy_pet.ClearFiltersEvent(),
                );
              } else {
                //  APPLY CASE
                context.read<buy_pet.BuyPetBloc>().add(
                  buy_pet.ApplyFiltersEvent(result.selectedValues),
                );
              }
            }

            // context.read<buy_pet.BuyPetBloc>().add(ResetFilterDialogEvent());
          }
        },
        builder: (context, state) => Stack(
          children: [
            Scaffold(
              backgroundColor: const Color(0xFFEEEAE0),
              appBar: const PoochScreenAppBar(title: 'All Pets'),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s16,
                    vertical: AppSpacing.s16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _searchController,
                        builder: (context, value, child) => AppTextField(
                          label: 'What are you looking for?',
                          controller: _searchController,
                          textInputAction: TextInputAction.search,
                          onChanged: (value) {
                            _searchDebounce?.cancel();
                            _searchDebounce = Timer(
                              const Duration(milliseconds: 300),
                              () {
                                if (!mounted) return;
                                // Trigger search with the current text value
                                context.read<buy_pet.BuyPetBloc>().add(
                                  buy_pet.SearchProducts(value),
                                );
                                // Fetch products with the search query
                                context.read<buy_pet.BuyPetBloc>().add(
                                  const buy_pet.FetchProducts(),
                                );
                              },
                            );
                          },
                          suffixWidget: Padding(
                            padding: EdgeInsets.only(right: AppSpacing.s6.w),
                            child: value.text.isEmpty
                                ? AppIcon(
                                    AppIcons.svg.generic.search,
                                    size: AppIconSize.is20,
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      _searchController.clear();
                                      context.read<buy_pet.BuyPetBloc>()
                                        ..add(const buy_pet.SearchProducts(''))
                                        ..add(const buy_pet.FetchProducts());
                                    },
                                    child: AppIcon(
                                      AppIcons.svg.generic.close,
                                      size: AppIconSize.is20,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      AppSpacing.s16.hBox,
                      Expanded(
                        child:
                            BlocBuilder<
                              buy_pet.BuyPetBloc,
                              buy_pet.BuyPetState
                            >(
                              builder: (context, state) {
                                return AppTopTabBar(
                                  leftTitle: 'Dog',
                                  rightTitle: 'Cat',
                                  onTabChanged: (index) {
                                    final String petType = index == 0
                                        ? 'dog'
                                        : 'cat';
                                    context.read<buy_pet.BuyPetBloc>()
                                      ..add(buy_pet.ChangePetType(petType))
                                      ..add(const buy_pet.FetchProducts());
                                  },
                                  leftScreen: BuyPetListingTab(
                                    title: 'Pooch Dogs',
                                    products: state.products,
                                    isLoading: state.isLoading,
                                    isLoadingMore: state.isLoadingMore,
                                    hasNextPage: state.hasNextPage,
                                    landingBloc: context
                                        .read<landing.BuyPetLandingBloc>(),
                                    error: state.error,
                                    onRetry: () => context
                                        .read<buy_pet.BuyPetBloc>()
                                        .add(const buy_pet.FetchProducts()),
                                    onLoadMore: () =>
                                        context.read<buy_pet.BuyPetBloc>().add(
                                          const buy_pet.FetchProducts(
                                            isLoadMore: true,
                                          ),
                                        ),
                                    onRefresh: () => context
                                        .read<buy_pet.BuyPetBloc>()
                                        .add(const buy_pet.FetchProducts()),
                                    onSortSelected: (sortType) {
                                      context.read<buy_pet.BuyPetBloc>()
                                        ..add(buy_pet.ChangeSort(sortType))
                                        ..add(const buy_pet.FetchProducts());
                                    },
                                  ),
                                  rightScreen: BuyPetListingTab(
                                    title: 'Pooch Cats',
                                    products: state.products,
                                    isLoading: state.isLoading,
                                    isLoadingMore: state.isLoadingMore,
                                    hasNextPage: state.hasNextPage,
                                    landingBloc: context
                                        .read<landing.BuyPetLandingBloc>(),
                                    error: state.error,
                                    onRetry: () => context
                                        .read<buy_pet.BuyPetBloc>()
                                        .add(const buy_pet.FetchProducts()),
                                    onLoadMore: () =>
                                        context.read<buy_pet.BuyPetBloc>().add(
                                          const buy_pet.FetchProducts(
                                            isLoadMore: true,
                                          ),
                                        ),
                                    onRefresh: () => context
                                        .read<buy_pet.BuyPetBloc>()
                                        .add(const buy_pet.FetchProducts()),
                                    onSortSelected: (sortType) {
                                      context.read<buy_pet.BuyPetBloc>()
                                        ..add(buy_pet.ChangeSort(sortType))
                                        ..add(const buy_pet.FetchProducts());
                                    },
                                  ),
                                );
                              },
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // 🔥 THIS IS THE LOADER (MAIN FIX)
            if (state.isFiltersLoading && !state.shouldOpenFilterDialog)
              Container(
                color: Colors.black.withValues(alpha: 0.2),
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}
