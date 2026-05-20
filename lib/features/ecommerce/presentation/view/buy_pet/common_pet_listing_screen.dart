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
import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet_landing/buy_pet_landing_state.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_event.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/product_grid_item_card.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/shimmers/product_grid_item_card_shimmer.dart';
import 'package:poochcare/router/app_router.dart';

enum ListingType {
  recentlyViewed,
  mostPopular,
  featuredDogs,
  featuredCats,
  all,
}

@RoutePage()
class CommonPetListingScreen extends StatefulWidget {
  final String title;
  final ListingType type;
  final String? petType;
  final BuyPetLandingBloc bloc;

  const CommonPetListingScreen({
    super.key,
    required this.title,
    required this.type,
    this.petType,
    required this.bloc,
  });

  @override
  State<CommonPetListingScreen> createState() => _CommonPetListingScreenState();
}

class _CommonPetListingScreenState extends State<CommonPetListingScreen> {
  late TextEditingController _searchController;
  bool _isInitialized = false;
  Timer? _debounce;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    // ✅ Trigger listing setup
    // context.read<BuyPetLandingBloc>().add(
    //   SetListingContext(type: widget.type, petType: widget.petType),
    // );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      _isInitialized = true;

      widget.bloc.add(
        SetListingContext(type: widget.type, petType: widget.petType),
      );
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Builder(
        builder: (context) {
          return Scaffold(
            // backgroundColor: Colors.grey.shade100,
            // appBar: PoochScreenAppBar(title: widget.title),
            body: AppPrimaryBgContainer(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PoochScreenAppBar(title: widget.title),
                      AppSpacing.s12.hBox,
                      AppTextField(
                        label: 'What are you looking for?',
                        controller: _searchController,
                        onChanged: (value) {
                          if (_debounce?.isActive ?? false) _debounce!.cancel();

                          _debounce = Timer(
                            const Duration(milliseconds: 400),
                            () {
                              widget.bloc.add(SearchProducts(value));
                            },
                          );
                        },
                        suffixWidget: ValueListenableBuilder(
                          valueListenable: _searchController,
                          builder: (context, TextEditingValue value, _) {
                            if (value.text.isEmpty) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  right: AppSpacing.s6.w,
                                ),
                                child: AppIcon(
                                  AppIcons.svg.generic.search,
                                  size: AppIconSize.is20,
                                ),
                              );
                            }

                            return Padding(
                              padding: EdgeInsets.only(right: AppSpacing.s6.w),
                              child: GestureDetector(
                                onTap: () {
                                  _searchController.clear();

                                  widget.bloc.add(const SearchProducts(''));
                                },
                                child: AppIcon(
                                  AppIcons.svg.generic.close,
                                  size: AppIconSize.is20,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      AppSpacing.s12.hBox,
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            // 🔥 reset + reload
                            final currentState = widget.bloc.state;

                            widget.bloc.add(
                              FetchProducts(search: currentState.searchQuery),
                            );
                          },
                          child: BlocBuilder<BuyPetLandingBloc, BuyPetLandingState>(
                            builder: (context, state) {
                              if (state.isLoading &&
                                  state.allProducts.isEmpty) {
                                return GridView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
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

                              if (state.allProducts.isEmpty) {
                                return ListView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(), // 👈 important
                                  children: [
                                    SizedBox(
                                      height: 300,
                                      child: Center(
                                        child: AppText.h2('No products found'),
                                      ),
                                    ),
                                  ],
                                );
                              }

                              return NotificationListener<ScrollNotification>(
                                onNotification: (scrollInfo) {
                                  if (!state.isLoadingMore &&
                                      state.hasNextPage &&
                                      scrollInfo.metrics.pixels ==
                                          scrollInfo.metrics.maxScrollExtent) {
                                    context.read<BuyPetLandingBloc>().add(
                                      const LoadMoreProducts(),
                                    );
                                  }
                                  return false;
                                },
                                child: GridView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount:
                                      state.allProducts.length +
                                      (state.isLoadingMore ? 2 : 0),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 12,
                                        crossAxisSpacing: 12,
                                        childAspectRatio: 0.64,
                                      ),
                                  itemBuilder: (context, index) {
                                    if (index >= state.allProducts.length) {
                                      return const ProductGridItemCardShimmer();
                                    }

                                    final pet = state.allProducts[index];

                                    final petItem = ProductItem(
                                      id: pet.id,
                                      name:
                                          (pet.petDetails?.breedName ?? '')
                                              .trim()
                                              .isEmpty
                                          ? pet.name
                                          : (pet.petDetails?.breedName ?? ''),

                                      // from petDetails
                                      age: pet.petDetails?.age ?? '',

                                      // pricing
                                      price:
                                          (pet.finalDiscountedPrice ??
                                                  pet.price)
                                              .toInt(),

                                      originalPrice:
                                          pet.finalDiscountedPrice != null
                                          ? pet.price.toInt()
                                          : null,

                                      isVaccinated:
                                          pet.petDetails?.isVaccinated ??
                                          false, // ✅ FIXED
                                      // wishlist
                                      isWishlisted: pet.inWishlist,
                                      // image
                                      image: pet.tileImage.isNotEmpty
                                          ? pet.tileImage.first
                                          : '',
                                    );

                                    return ProductGridCard(
                                      product: petItem,
                                      onWishlistTap: () {
                                        context.read<WishlistBloc>().add(
                                          ToggleWishlistEvent(pet.id),
                                        );
                                      },
                                      // onWishlistTap: () {},
                                      onTap: () async {
                                        await context.router.push(
                                          BuyPetDetailRoute(productId: pet.id),
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
        },
      ),
    );
  }
}
