import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/headers/primary_widget_header.dart';
import 'package:poochcare/core/widgets/list_grid/app_error_view.dart';

import 'package:poochcare/features/ecommerce/domain/models/product.dart';

import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet_landing/buy_pet_landing_bloc.dart';

import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_event.dart';

import 'package:poochcare/features/ecommerce/presentation/view/buy_pet/common_pet_listing_screen.dart';

import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/product_grid_item_card.dart';

import 'package:poochcare/features/ecommerce/presentation/widgets/shimmers/product_grid_item_card_shimmer.dart';

import 'package:poochcare/router/app_router.dart';

class CommonPetSection extends StatelessWidget {
  final String title;

  final ListingType listingType;

  final List<Product> products;

  final bool isLoading;

  final String? error;

  final VoidCallback onRetry;

  final PrimaryWidgetHeaderVariant headerVariant;

  final bool showTopSpacing;

  final String emptyMessage;

  const CommonPetSection({
    super.key,
    required this.title,
    required this.listingType,
    required this.products,
    required this.isLoading,
    required this.error,
    required this.onRetry,

    this.headerVariant = PrimaryWidgetHeaderVariant.standard,
    this.showTopSpacing = false,
    this.emptyMessage = 'No products found',
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final shortestSide = MediaQuery.of(context).size.shortestSide;

        double aspectRatio;

        if (shortestSide < 360) {
          aspectRatio = 170 / 255;
        } else if (shortestSide < 400) {
          aspectRatio = 170 / 265;
        } else if (shortestSide < 500) {
          aspectRatio = 170 / 280;
        } else {
          aspectRatio = 170 / 285;
        }

        final cardWidth = (constraints.maxWidth * 0.42).clamp(160.0, 200.0);

        final cardHeight = cardWidth / aspectRatio;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showTopSpacing) AppSpacing.s40.hBox,

            PrimaryWidgetHeader(
              title: title,

              buttonTitle:
                  (headerVariant == PrimaryWidgetHeaderVariant.standard &&
                      products.isNotEmpty)
                  ? 'View All'
                  : null,

              onButtonTap:
                  (headerVariant == PrimaryWidgetHeaderVariant.standard &&
                      products.isNotEmpty)
                  ? () {
                      context.router.push(
                        CommonPetListingRoute(
                          title: title,
                          type: listingType,
                          bloc: context.read<BuyPetLandingBloc>(),
                        ),
                      );
                    }
                  : null,

              variant: headerVariant,
            ),

            /// LOADING
            if (isLoading && products.isEmpty)
              SizedBox(
                height: cardHeight,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),

                  itemCount: 3,

                  separatorBuilder: (_, _) => AppSpacing.s10.wBox,

                  itemBuilder: (_, _) {
                    return SizedBox(
                      width: cardWidth,
                      child: const ProductGridItemCardShimmer(),
                    );
                  },
                ),
              )
            /// ERROR
            else if (error != null && products.isEmpty)
              SizedBox(
                height: cardHeight,
                child: AppErrorView(message: error!, onRetry: onRetry),
              )
            /// EMPTY
            else if (products.isEmpty)
              SizedBox(
                height: cardHeight,
                child: Center(
                  child: Text(
                    emptyMessage,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              )
            /// SUCCESS
            else
              SizedBox(
                height: cardHeight,

                child: ListView.separated(
                  scrollDirection: Axis.horizontal,

                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),

                  itemCount: products.length,

                  separatorBuilder: (_, _) => AppSpacing.s10.wBox,

                  itemBuilder: (context, index) {
                    final product = products[index];

                    final isWishlisted = context
                        .watch<WishlistBloc>()
                        .state
                        .wishlistIds
                        .contains(product.id);

                    final pet = ProductItem(
                      id: product.id,

                      name: (product.petDetails?.breedName ?? '').trim().isEmpty
                          ? product.name
                          : (product.petDetails?.breedName ?? ''),

                      age: product.petDetails?.age ?? '',

                      price: product.price.round(),

                      originalPrice: product.finalDiscountedPrice?.round(),

                      isVaccinated: product.petDetails?.isVaccinated ?? false,

                      isWishlisted: isWishlisted,

                      image: product.tileImage.isNotEmpty
                          ? product.tileImage.first
                          : '',
                    );

                    return SizedBox(
                      width: cardWidth,

                      child: AspectRatio(
                        aspectRatio: aspectRatio,

                        child: ProductGridCard(
                          product: pet,

                          onTap: () async {
                            await context.router.push(
                              BuyPetDetailRoute(productId: product.id),
                            );

                            if (!context.mounted) return;

                            context.read<BuyPetLandingBloc>().add(
                              const FetchRecentlyViewedOnly(),
                            );
                          },

                          onWishlistTap: () {
                            context.read<WishlistBloc>().add(
                              ToggleWishlistEvent(product.id),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
