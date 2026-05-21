import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/headers/primary_widget_header.dart';
import 'package:poochcare/core/widgets/list_grid/app_error_view.dart';
import 'package:poochcare/core/widgets/list_items/most_popular_hlist_item_card.dart';
import 'package:poochcare/features/ecommerce/domain/models/product.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet_landing/buy_pet_landing_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/view/buy_pet/common_pet_listing_screen.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/shimmers/product_grid_item_card_shimmer.dart';
import 'package:poochcare/router/app_router.dart';

class MostPopularSection extends StatelessWidget {
  final String title;
  final void Function(String symptom)? onTap;
  final void Function(String symptom)? onViewAllTap;
  final List<Product> products;
  final bool isLoading;
  final String? error;
  final VoidCallback onRetry;

  const MostPopularSection({
    super.key,
    this.title = 'Most Popular',
    this.onTap,
    this.onViewAllTap,
    required this.products,
    required this.isLoading,
    required this.error,
    required this.onRetry,
  });

  int _parseAgeInMonths(String? age) {
    final raw = (age ?? '').trim();
    if (raw.isEmpty) return 0;
    final match = RegExp(r'(\d+)').firstMatch(raw);
    if (match == null) return 0;
    return int.tryParse(match.group(1) ?? '') ?? 0;
  }

  MostPopularHlistItem _toHListItem(Product product) {
    final int ageInMonths = _parseAgeInMonths(product.petDetails?.age);
    final String image = product.tileImage.isNotEmpty
        ? product.tileImage.first
        : '';

    return MostPopularHlistItem(
      id: product.id,
      name: (product.petDetails?.breedName ?? '').trim().isEmpty
          ? product.name
          : (product.petDetails?.breedName ?? ''),
      ageInMonths: ageInMonths > 0 ? ageInMonths : 1,
      price: product.price,
      originalPrice: product.finalDiscountedPrice,
      isVaccinated: product.petDetails?.isVaccinated ?? false, // map later
      image: image.trim().isEmpty ? null : image,
    );
  }

  // ProductItem _toProductItem(Product product) {
  //   return ProductItem(
  //     name: (product.petDetails?.breedName ?? '').trim().isEmpty
  //         ? product.name
  //         : (product.petDetails?.breedName ?? ''),
  //     age: product.petDetails?.age ?? '',
  //     price: product.price.round(),
  //     originalPrice: product.finalDiscountedPrice?.round(),
  //     isVaccinated: true, // map later
  //     isWishlisted: product.inWishlist,
  //     image: product.productImages.isNotEmpty
  //         ? product.productImages.first
  //         : '',
  //   );
  // }

  // List<ProductItem> _toProductItems(List<Product> products) {
  //   return products.map(_toProductItem).toList(growable: false);
  // }

  @override
  Widget build(BuildContext context) {
    if (!isLoading && (error == null) && products.isEmpty) {
      return SizedBox(
        height: AppSize.cs374.csh,
        child: Center(
          child: Text(
            'No products found',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }

    final popularPetsList = products.map(_toHListItem).toList(growable: false);
    final void Function(String id) handleTap =
        onTap ??
        (String id) async {
          if (id.trim().isEmpty) return;
          await context.router.push(BuyPetDetailRoute(productId: id));

          if (!context.mounted) return;

          // AFTER coming back from detail, refresh recently viewed to reflect any changes
          context.read<BuyPetLandingBloc>().add(
            const FetchRecentlyViewedOnly(),
          );
        };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Builder(
          builder: (innerContext) {
            return PrimaryWidgetHeader(
              title: title,
              buttonTitle: 'View All',
              onButtonTap: products.isNotEmpty
                  ? () {
                      innerContext.router.push(
                        CommonPetListingRoute(
                          title: title,
                          type: ListingType.mostPopular,
                          bloc: innerContext.read<BuyPetLandingBloc>(),
                        ),
                      );
                    }
                  : null,
            );
          },
        ),
        AppSpacing.s10.hBox,
        if (isLoading && products.isEmpty)
          SizedBox(
            height: AppSize.cs374.csh,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: AppSize.cs16.csw),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 2,
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(width: AppSize.cs280.csw),
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: AppSize.cs280.csw,
                  child: const ProductGridItemCardShimmer(),
                );
              },
            ),
          )
        else if (error != null && products.isEmpty)
          SizedBox(
            height: AppSize.cs374.csh,
            child: AppErrorView(message: error!, onRetry: onRetry),
          )
        else
          SizedBox(
            height: AppSize.cs374.csh,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: AppSize.cs16.csw),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: popularPetsList.length,
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(width: AppSize.cs12.csw),
              itemBuilder: (BuildContext context, int index) {
                final item = popularPetsList[index];
                return AspectRatio(
                  aspectRatio: 280 / 374,
                  child: MostPopularHlistItemCard(item: item, onTap: handleTap),
                );
              },
            ),
          ),
      ],
    );
  }
}
