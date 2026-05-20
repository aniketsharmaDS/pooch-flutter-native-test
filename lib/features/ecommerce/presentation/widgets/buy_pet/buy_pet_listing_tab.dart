import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/list_grid/app_error_view.dart';
import 'package:poochcare/core/widgets/menus/app_popup_menu.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/ecommerce/domain/models/product.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet/buy_pet_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet_landing/buy_pet_landing_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_event.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/product_grid_item_card.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/shimmers/product_grid_item_card_shimmer.dart';
import 'package:poochcare/router/app_router.dart';

class BuyPetListingTab extends StatefulWidget {
  final String title;

  final List<Product> products;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasNextPage;
  final String? error;

  final VoidCallback onRetry;
  final VoidCallback onLoadMore;
  final VoidCallback onRefresh;
  final ValueChanged<String> onSortSelected;
  final BuyPetLandingBloc landingBloc;

  const BuyPetListingTab({
    super.key,
    required this.title,
    required this.products,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasNextPage,
    required this.error,
    required this.onRetry,
    required this.onLoadMore,
    required this.onRefresh,
    required this.onSortSelected,
    required this.landingBloc,
  });

  @override
  State<BuyPetListingTab> createState() => _BuyPetListingTabState();
}

class _BuyPetListingTabState extends State<BuyPetListingTab> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (widget.products.isEmpty || widget.error != null) return;
    if (!widget.hasNextPage || widget.isLoading || widget.isLoadingMore) return;

    final position = _scrollController.position;
    // Trigger load more when user scrolls to 70% of the list
    if (position.pixels >= position.maxScrollExtent * 0.7) {
      if (!widget.isLoadingMore) {
        widget.onLoadMore();
      }
    }
  }

  bool _hasActiveFilters(Map<String, Set<String>> filters) {
    return filters.values.any((set) => set.isNotEmpty);
  }

  void _showFilterDialog() {
    context.read<BuyPetBloc>().add(OpenFilterDialogEvent());
  }

  int _countFilters(Map<String, Set<String>> filters) {
    int count = 0;
    for (final set in filters.values) {
      count += set.length;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final wishlistedIds = widget.products
          .where((p) => p.inWishlist == true)
          .map((p) => p.id)
          .toList();

      if (wishlistedIds.isNotEmpty) {
        context.read<WishlistBloc>().add(SyncWishlistEvent(wishlistedIds));
      }
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpacing.s20.hBox,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.h4(widget.title, fontSize: AppFontSize.fs24),
              Row(
                children: [
                  BlocBuilder<BuyPetBloc, BuyPetState>(
                    builder: (context, state) {
                      final hasSort = state.selectedSort != null;
                      return AppPopupMenu(
                        headerTitle: 'Sort by',
                        showCloseIcon: true,
                        iconPath: AppIcons.svg.generic.sortDescending,
                        iconSize: AppIconSize.is16,
                        onClose: () {
                          final bloc = context.read<BuyPetBloc>();

                          if (state.selectedSort != null) {
                            bloc.add(ClearSort()); // ✅ clear sort
                          }
                          // else → do nothing (menu just closes)
                        },
                        iconColor: hasSort
                            ? AppColors
                                  .activeColor // 🟢 active state
                            : null, // ⚪ default state
                        items: [
                          AppPopupMenuItem(
                            title: 'Youngest to Oldest',
                            onTap: () =>
                                widget.onSortSelected('Youngest to Oldest'),
                          ),
                          AppPopupMenuItem(
                            title: 'Oldest to Youngest',
                            onTap: () =>
                                widget.onSortSelected('Oldest to Youngest'),
                          ),
                          AppPopupMenuItem(
                            title: 'Near to Far',
                            onTap: () => widget.onSortSelected('Near to Far'),
                          ),
                          AppPopupMenuItem(
                            title: 'Far to Near',
                            onTap: () => widget.onSortSelected('Far to Near'),
                          ),
                          AppPopupMenuItem(
                            title: 'Price: Low to High',
                            onTap: () =>
                                widget.onSortSelected('Price: Low to High'),
                          ),
                          AppPopupMenuItem(
                            title: 'Price: High to Low',
                            onTap: () =>
                                widget.onSortSelected('Price: High to Low'),
                          ),
                          AppPopupMenuItem(
                            title: 'Most Popular',
                            onTap: () => widget.onSortSelected('Most Popular'),
                          ),
                        ],
                      );
                    },
                  ),
                  BlocBuilder<BuyPetBloc, BuyPetState>(
                    builder: (context, state) {
                      final hasFilters = _hasActiveFilters(
                        state.appliedFilters,
                      );
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          AppCircleButton(
                            icon: AppIcons.svg.generic.filter,
                            variant: AppCircleButtonVariant.secondary,
                            showShadow: false,
                            iconColor: hasFilters
                                ? AppColors
                                      .activeColor // 🟢 active state
                                : null, // ⚪ default state
                            onTap: _showFilterDialog, // keep this
                          ),
                          // 🔴 Badge dot
                          if (hasFilters)
                            Positioned(
                              right: 6,
                              top: 3,
                              child: Container(
                                width: 18,
                                height: 18,
                                alignment: Alignment.center,
                                // padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: AppColors.activeColor,
                                  shape: BoxShape.circle,
                                  // borderRadius: BorderRadius.circular(10),
                                ),
                                child: AppText.support(
                                  _countFilters(
                                    state.appliedFilters,
                                  ).toString(),
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        AppSpacing.s20.hBox,
        Expanded(child: _buildContent()),
      ],
      // ),
    );
  }

  Widget _buildContent() {
    // Loading state - show skeleton loaders
    if (widget.isLoading && widget.products.isEmpty) {
      return GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.65,
        ),
        itemCount: 6,
        itemBuilder: (context, _) => const ProductGridItemCardShimmer(),
      );
    }

    // Error state - show error message with retry
    if (widget.error != null && widget.products.isEmpty) {
      return SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.55,
        child: AppErrorView(message: widget.error!, onRetry: widget.onRetry),
      );
    }

    // Empty state
    if (widget.products.isEmpty) {
      return Center(
        child: AppText.h2('No products found', textAlign: TextAlign.center),
      );
    }

    final itemCount = widget.products.length + (widget.isLoadingMore ? 2 : 0);

    // Products loaded - show grid with pagination
    return RefreshIndicator(
      onRefresh: () async {
        widget.onRefresh();
        // Wait a bit for the refresh to complete
        // ignore: inference_failure_on_instance_creation
        // await Future.delayed(const Duration(milliseconds: 500));
      },
      child: GridView.builder(
        controller: _scrollController,
        // padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.65,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          // Show loading shimmers at the end while fetching next page
          if (index >= widget.products.length) {
            return const ProductGridItemCardShimmer();
          }

          final Product product = widget.products[index];
          final ProductItem pet = ProductItem(
            id: product.id,
            name: (product.petDetails?.breedName ?? '').trim().isEmpty
                ? product.name
                : (product.petDetails?.breedName ?? ''),
            age: product.petDetails?.age ?? '',
            price: product.price.round(),
            originalPrice: product.finalDiscountedPrice?.round(),
            isVaccinated: product.petDetails?.isVaccinated ?? false,
            isWishlisted: product.inWishlist,
            image: product.tileImage.isNotEmpty ? product.tileImage.first : '',
          );

          return ProductGridCard(
            product: pet,
            onTap: () async {
              await context.router.push(
                BuyPetDetailRoute(productId: product.id),
              );

              if (!context.mounted) return;

              // AFTER coming back from detail, refresh recently viewed to reflect any changes
              widget.landingBloc.add(const FetchRecentlyViewedOnly());
            },
            onWishlistTap: () {
              context.read<WishlistBloc>().add(ToggleWishlistEvent(product.id));
            },
          );
        },
      ),
    );
  }
}
