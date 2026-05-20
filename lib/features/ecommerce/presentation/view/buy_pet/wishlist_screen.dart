import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet_landing/buy_pet_landing_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_state.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/product_grid_item_card.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/shimmers/product_grid_item_card_shimmer.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late TextEditingController _searchController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    // 🔥 Initial fetch
    context.read<WishlistBloc>().add(FetchWishlistEvent());
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPrimaryBgContainer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PoochScreenAppBar(title: 'Wishlist'),
                AppSpacing.s12.hBox,

                /// 🔍 Search (optional - you can remove later)
                BlocBuilder<WishlistBloc, WishlistState>(
                  builder: (context, state) {
                    return AppTextField(
                      label: 'Search in wishlist',
                      controller: _searchController,
                      enabled: state.products.isNotEmpty,
                      onChanged: (value) {
                        if (_debounce?.isActive ?? false) _debounce!.cancel();

                        _debounce = Timer(
                          const Duration(milliseconds: 300),
                          () {
                            context.read<WishlistBloc>().add(
                              SearchWishlistEvent(value),
                            );
                          },
                        );
                      },
                      suffixWidget: Padding(
                        padding: EdgeInsets.only(right: AppSpacing.s6.w),
                        child: AppIcon(
                          AppIcons.svg.generic.search,
                          size: AppIconSize.is20,
                        ),
                      ),
                    );
                  },
                ),

                AppSpacing.s12.hBox,

                /// 🧠 MAIN LIST
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<WishlistBloc>().add(FetchWishlistEvent());
                    },
                    child: BlocBuilder<WishlistBloc, WishlistState>(
                      builder: (context, state) {
                        /// 🔄 Loading
                        if (state.isLoading && state.products.isEmpty) {
                          return GridView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: 6,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 0.65,
                                ),
                            itemBuilder: (_, _) =>
                                const ProductGridItemCardShimmer(),
                          );
                        }

                        /// ❌ Empty
                        if (state.products.isEmpty) {
                          return LayoutBuilder(
                            builder: (context, constraints) {
                              return ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                children: [
                                  SizedBox(
                                    height: constraints.maxHeight,
                                    child: Center(
                                      child: AppText.h2('No items in wishlist'),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }

                        /// ✅ LIST
                        return NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            if (!state.isLoading &&
                                state.hasNextPage &&
                                scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent) {
                              context.read<WishlistBloc>().add(
                                FetchWishlistEvent(page: state.page + 1),
                              );
                            }
                            return false;
                          },
                          child: GridView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: state.products.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 0.65,
                                ),
                            itemBuilder: (context, index) {
                              final product = state.products[index];

                              /// 🔁 Convert Product → ProductItem (IMPORTANT)
                              final petItem = ProductItem(
                                id: product.id,
                                name:
                                    (product.petDetails?.breedName ?? '')
                                        .trim()
                                        .isEmpty
                                    ? product.name
                                    : (product.petDetails?.breedName ?? ''),
                                age: product.petDetails?.age ?? '',
                                price:
                                    (product.finalDiscountedPrice ??
                                            product.price)
                                        .toInt(),
                                originalPrice:
                                    product.finalDiscountedPrice != null
                                    ? product.price.toInt()
                                    : null,
                                isVaccinated:
                                    product.petDetails?.isVaccinated ?? false,
                                isWishlisted: context
                                    .watch<WishlistBloc>()
                                    .state
                                    .wishlistIds
                                    .contains(product.id),
                                image: product.tileImage.isNotEmpty
                                    ? product.tileImage.first
                                    : '',
                              );

                              return ProductGridCard(
                                product: petItem,
                                onWishlistTap: () {
                                  context.read<WishlistBloc>().add(
                                    ToggleWishlistEvent(product.id),
                                  );
                                },
                                onTap: () async {
                                  await context.router.push(
                                    BuyPetDetailRoute(productId: product.id),
                                  );
                                  if (!context.mounted) return;

                                  // AFTER coming back from detail, refresh recently viewed to reflect any changes
                                  context.read<BuyPetLandingBloc>().add(
                                    const FetchRecentlyViewedOnly(),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),

                AppSpacing.s24.hBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
