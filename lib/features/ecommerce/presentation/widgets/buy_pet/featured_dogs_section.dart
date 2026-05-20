import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_size.dart';
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

class FeaturedDogsSection extends StatelessWidget {
  final List<Product> products;
  final bool isLoading;
  final String? error;
  final VoidCallback onRetry;

  const FeaturedDogsSection({
    super.key,
    required this.products,
    required this.isLoading,
    required this.error,
    required this.onRetry,
  });

  // List<ProductItem> _toProductItems(List<Product> products) {
  //   return products.map(_toProductItem).toList(growable: false);
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryWidgetHeader(
          title: 'Featured Dogs',
          buttonTitle: products.isNotEmpty ? 'View All' : null,
          onButtonTap: products.isNotEmpty
              ? () {
                  context.router.push(
                    CommonPetListingRoute(
                      title: 'Featured Dogs',
                      type: ListingType.featuredDogs,
                      bloc: context.read<BuyPetLandingBloc>(),
                    ),
                  );
                }
              : null,
        ),
        if (isLoading && products.isEmpty)
          SizedBox(
            height: AppSize.cs250.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: 3,
              separatorBuilder: (_, _) => SizedBox(width: 10.w),
              itemBuilder: (context, index) {
                return const SizedBox(
                  width: AppSize.cs165,
                  child: ProductGridItemCardShimmer(),
                );
              },
            ),
          )
        else if (error != null && products.isEmpty)
          SizedBox(
            height: AppSize.cs250.h,
            child: AppErrorView(message: error!, onRetry: onRetry),
          )
        else if (products.isEmpty)
          SizedBox(
            height: AppSize.cs250.h,
            child: Center(
              child: Text(
                'No products found',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          )
        else
          SizedBox(
            height: AppSize.cs260.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: products.length,
              separatorBuilder: (_, _) => SizedBox(width: 10.w),
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
                  isVaccinated:
                      product.petDetails?.isVaccinated ?? false, // ✅ FIXED
                  isWishlisted: isWishlisted, // ✅ FIXED
                  image: product.tileImage.isNotEmpty
                      ? product.tileImage.first
                      : '',
                );
                return SizedBox(
                  width: AppSize.cs165,
                  child: ProductGridCard(
                    product: pet,
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
                    onWishlistTap: () {
                      context.read<WishlistBloc>().add(
                        ToggleWishlistEvent(product.id),
                      );
                    },
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
