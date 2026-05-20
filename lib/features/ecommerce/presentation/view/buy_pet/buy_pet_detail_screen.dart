import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/snackbar_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/app_loader.dart';
import 'package:poochcare/core/widgets/appbar/pooch_assistant_app_bar.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/headers/primary_widget_header.dart';
import 'package:poochcare/core/widgets/list_grid/app_error_view.dart';
import 'package:poochcare/core/widgets/others/app_info_tile.dart';
import 'package:poochcare/core/widgets/others/pincode_validate_view.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/features/ecommerce/domain/models/delivery_check.dart';
import 'package:poochcare/features/ecommerce/domain/models/product_detail.dart';
import 'package:poochcare/features/ecommerce/domain/repository/buy_pet_repository.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet_detail/buy_pet_detail_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet_landing/buy_pet_landing_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet_landing/buy_pet_landing_state.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/cart/cart_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/cart/cart_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/cart/cart_state.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_event.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/pet_details_widget.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/recently_viewed_section.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class BuyPetDetailScreen extends StatefulWidget {
  const BuyPetDetailScreen({
    super.key,
    required this.productId,
    this.isFromGetHelp = false,
  });

  final String productId;
  final bool isFromGetHelp;
  // final BuyPetLandingBloc landingBloc;

  @override
  State<BuyPetDetailScreen> createState() => _BuyPetDetailScreenState();
}

class _BuyPetDetailScreenState extends State<BuyPetDetailScreen> {
  // late Future<PaginatedProducts> _recentlyViewedFuture;

  @override
  void initState() {
    super.initState();
    // final repo = getIt<BuyPetRepository>();
    // _recentlyViewedFuture = repo.getRecentlyViewed(page: 1);
  }

  Future<void> _refresh(BuildContext context) async {
    context.read<BuyPetDetailBloc>().add(
      BuyPetDetailRefreshed(widget.productId),
    );

    // context.read<BuyPetLandingBloc>().add(const FetchRecentlyViewedOnly());
    // await Future<void>.delayed(const Duration(milliseconds: 300));

    // setState(() {
    //   _recentlyViewedFuture = getIt<BuyPetRepository>().getRecentlyViewed(
    //     page: 1,
    //   );
    // });
  }

  Future<DeliveryCheck> _checkDelivery(String pincode) async {
    final repository = getIt<BuyPetRepository>();
    final DeliveryCheck result = await repository.checkDelivery(
      productId: widget.productId,
      pincode: pincode,
    );

    if (!result.isDeliverable && result.reason.trim().isNotEmpty) {
      ScaffoldMessenger.maybeOf(
        // ignore: use_build_context_synchronously
        context,
      )?.showSnackBar(SnackBar(content: Text(result.reason)));
    }

    return result;
  }

  PetDetailsModel _buildPetDetailsModel(ProductDetail detail) {
    final pet = detail.petDetails;
    final String ageLabel = _buildAgeLabel(pet?.dateOfBirth);
    final String displayName = _firstNonEmpty(<String?>[
      pet?.name,
      detail.name,
    ]);
    final String gender = pet?.gender ?? detail.gender;
    final String description = _firstNonEmpty(<String?>[
      pet?.description,
      detail.description,
      'Description unavailable.',
    ]);

    final String price = _formatCurrency(
      detail.currencyCode,
      detail.finalDiscountedPrice ?? detail.price,
    );
    final String? oldPrice = detail.finalDiscountedPrice == null
        ? null
        : _formatCurrency(detail.currencyCode, detail.price);

    final String? discountLabel = (detail.couponApplied ?? '').trim().isEmpty
        ? null
        : 'Coupon ${detail.couponApplied}';

    return PetDetailsModel(
      tagText: detail.tags.isNotEmpty ? detail.tags.first : '',
      imageUrls: detail.productImages,
      inWishlist: false,
      gender: gender,
      title: displayName,
      location: _buildLocation(detail),
      price: price,
      oldPrice: oldPrice,
      discountLabel: discountLabel,
      description: description,
      descriptionMaxLines: 3,
      age: ageLabel,
      infoItems: _buildInfoItems(detail),
    );
  }

  List<PetInfoItem> _buildInfoItems(ProductDetail detail) {
    final pet = detail.petDetails;
    final items = <PetInfoItem>[];

    if (pet != null) {
      final isVaccinated = pet.isVaccinated;

      items.add(
        PetInfoItem(
          label: 'Vaccinated',
          iconPath: AppIcons.svg.generic.vaccination,
          iconColor: isVaccinated ? AppColors.messageSuccess : AppColors.error,
        ),
      );

      final energyLabel = pet.energyLevel.trim();
      if (energyLabel.isNotEmpty) {
        items.add(
          PetInfoItem(
            label: energyLabel,
            iconPath: AppIcons.svg.generic.heart,
            iconColor: const Color(0xFFE8A3A4),
          ),
        );
      }

      final heightLabel = _joinValueUnit(pet.height, pet.heightUnit);
      if (heightLabel.isNotEmpty) {
        items.add(
          PetInfoItem(
            label: heightLabel,
            iconPath: AppIcons.svg.generic.scale,
            iconColor: const Color(0xFF404041),
          ),
        );
      }

      final weightLabel = _joinValueUnit(pet.weight, pet.weightUnit);
      if (weightLabel.isNotEmpty) {
        items.add(
          PetInfoItem(
            label: weightLabel,
            iconPath: AppIcons.svg.generic.barbell,
            iconColor: const Color(0xFF404041),
          ),
        );
      }
    }

    return items;
  }

  String _buildLocation(ProductDetail detail) {
    final parts = <String>[];
    final country = detail.countryCode.trim();
    if (country.isNotEmpty) {
      parts.add(country.toUpperCase());
    }

    final distance = (detail.deliveryDistance ?? '').trim();
    if (distance.isNotEmpty) {
      parts.add('$distance km');
    }

    return parts.join(' • ');
  }

  String _formatCurrency(String code, double value) {
    final symbol = code.trim().isEmpty ? 'INR' : code.toUpperCase();
    return '$symbol ${value.round()}';
  }

  String _joinValueUnit(String value, String unit) {
    final v = value.trim();
    final u = unit.trim();

    if (v.isEmpty && u.isEmpty) return '';
    if (v.isEmpty) return u;

    // 👇 Convert to double safely
    final parsed = double.tryParse(v);

    // 👇 If parsing fails, fallback to original value
    final displayValue = parsed != null ? parsed.round().toString() : v;

    if (u.isEmpty) return displayValue;

    return '$displayValue $u';
  }

  String _buildAgeLabel(String? rawDob) {
    if (rawDob == null || rawDob.trim().isEmpty) {
      return '';
    }

    final DateTime? dob = DateTime.tryParse(rawDob.trim());
    if (dob == null) return '';

    final DateTime now = DateTime.now();
    final bool hasBirthdayPassed =
        now.month > dob.month || (now.month == dob.month && now.day >= dob.day);
    final int years = now.year - dob.year - (hasBirthdayPassed ? 0 : 1);

    if (years > 0) {
      return '$years ${years == 1 ? 'yr' : 'yrs'}';
    }

    int months = (now.year - dob.year) * 12 + (now.month - dob.month);
    if (now.day < dob.day) {
      months -= 1;
    }

    if (months > 0) {
      return '$months ${months == 1 ? 'mo' : 'mos'}';
    }

    final int days = now.difference(dob).inDays;
    if (days <= 0) {
      return '0 d';
    }
    if (days < 7) {
      return '$days ${days == 1 ? 'd' : 'ds'}';
    }

    final int weeks = (days / 7).floor();
    return '$weeks ${weeks == 1 ? 'wk' : 'wks'}';
  }

  String _firstNonEmpty(List<String?> values) {
    for (final value in values) {
      final v = value?.trim() ?? '';
      if (v.isNotEmpty) return v;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BuyPetDetailBloc>(
          create: (_) =>
              getIt<BuyPetDetailBloc>()
                ..add(BuyPetDetailRequested(widget.productId)),
        ),
        // BlocProvider.value(value: widget.landingBloc),
        // BlocProvider<BuyPetLandingBloc>(
        //   create: (_) =>
        //       getIt<BuyPetLandingBloc>()..add(const FetchRecentlyViewedOnly()),
        // ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CartBloc, CartState>(
            listenWhen: (previous, current) =>
                previous.actionId != current.actionId,
            listener: (context, state) {
              if (state.successMessage != null) {
                CustomSnackbar.show(
                  state.successMessage ?? 'Pet Added to cart',
                  SnackbarType.success,
                );
              }
              if (state.errorMessage != null) {
                CustomSnackbar.show(
                  state.errorMessage ?? 'Something went wrong',
                  SnackbarType.error,
                );
              }
            },
          ),
        ],
        child: BlocBuilder<BuyPetDetailBloc, BuyPetDetailState>(
          builder: (context, state) {
            final isWishlisted = context
                .watch<WishlistBloc>()
                .state
                .wishlistIds
                .contains(widget.productId);
            final detail = state.detail;

            final model = detail != null ? _buildPetDetailsModel(detail) : null;

            if (model != null) {
              model.inWishlist = isWishlisted;
            }
            final title =
                detail?.petDetails?.breedInfo?.breedName ?? 'Pet Details';

            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: AppPrimaryBgContainer(
                child: SafeArea(
                  child: Column(
                    children: [
                      // PoochScreenAppBar(title: title),
                      widget.isFromGetHelp
                          ? const PoochAssistantAppBar()
                          : PoochScreenAppBar(title: title),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () => _refresh(context),
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            children: [
                              if (state.status == BuyPetDetailStatus.loading &&
                                  detail == null)
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.65,
                                  child: const AppLoader(
                                    overlayColor: Colors.transparent,
                                  ),
                                )
                              else if (state.status ==
                                      BuyPetDetailStatus.failure &&
                                  detail == null)
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.65,
                                  child: AppErrorView(
                                    message:
                                        state.error ??
                                        'Unable to load details. Please try again.',
                                    onRetry: () {
                                      context.read<BuyPetDetailBloc>().add(
                                        BuyPetDetailRequested(widget.productId),
                                      );
                                    },
                                  ),
                                )
                              else if (state.status ==
                                      BuyPetDetailStatus.empty ||
                                  detail == null)
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.5,
                                  child: const Center(
                                    child: Text('No pet details found'),
                                  ),
                                )
                              else
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: AppSpacing.s12,
                                        top: AppSpacing.s16,
                                        right: AppSpacing.s15,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.circular(
                                            AppRadiusSize.r16,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            PetDetailsWidget(
                                              petDetailsData: model!,
                                              isFromGetHelp:
                                                  widget.isFromGetHelp,
                                              // petDetailsData:
                                              //     _buildPetDetailsModel(detail),
                                              onWishlistTap: () {
                                                context
                                                    .read<WishlistBloc>()
                                                    .add(
                                                      ToggleWishlistEvent(
                                                        widget.productId,
                                                      ),
                                                    );
                                              },
                                            ),

                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if ((detail
                                                            .petDetails
                                                            ?.temperament ??
                                                        '')
                                                    .trim()
                                                    .isNotEmpty)
                                                  AppInfoTile(
                                                    model: AppInfoTileModel(
                                                      id: 'temperament',
                                                      title: 'Temperament',
                                                      description: detail
                                                          .petDetails!
                                                          .temperament,
                                                    ),
                                                  ),
                                                if ((detail
                                                            .petDetails
                                                            ?.groomingNeeds ??
                                                        '')
                                                    .trim()
                                                    .isNotEmpty)
                                                  AppInfoTile(
                                                    model: AppInfoTileModel(
                                                      id: 'grooming',
                                                      title: 'Grooming Needs',
                                                      description: detail
                                                          .petDetails!
                                                          .groomingNeeds,
                                                    ),
                                                  ),
                                                if ((detail
                                                            .petDetails
                                                            ?.energyLevel ??
                                                        '')
                                                    .trim()
                                                    .isNotEmpty)
                                                  AppInfoTile(
                                                    model: AppInfoTileModel(
                                                      id: 'energy',
                                                      title: 'Energy Level',
                                                      description: detail
                                                          .petDetails!
                                                          .energyLevel,
                                                    ),
                                                  ),
                                                if ((detail
                                                            .petDetails
                                                            ?.lifeStage ??
                                                        '')
                                                    .trim()
                                                    .isNotEmpty)
                                                  AppInfoTile(
                                                    model: AppInfoTileModel(
                                                      id: 'life_stage',
                                                      title: 'Life Stage',
                                                      description: detail
                                                          .petDetails!
                                                          .lifeStage,
                                                    ),
                                                  ),
                                                if (_buildDeliveryDetails(
                                                  detail,
                                                ).trim().isNotEmpty)
                                                  AppInfoTile(
                                                    model: AppInfoTileModel(
                                                      id: 'delivery',
                                                      title: 'Delivery Details',
                                                      description:
                                                          _buildDeliveryDetails(
                                                            detail,
                                                          ),
                                                    ),
                                                  ),
                                                AppSpacing.s20.hBox,
                                                PincodeValidateView(
                                                  onCheckPincode: (pincode) =>
                                                      _checkDelivery(pincode),
                                                ),
                                                AppSpacing.s24.hBox,
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    AppSpacing.s32.hBox,

                                    // BlocBuilder<
                                    //   BuyPetLandingBloc,
                                    //   BuyPetLandingState
                                    // >(
                                    //   builder: (context, landingState) {
                                    //     return RecentlyViewedSection(
                                    //       headerVariant:
                                    //           PrimaryWidgetHeaderVariant.centered,
                                    //       products: landingState.recentlyViewed,
                                    //       isLoading: landingState.isLoading,
                                    //       error: landingState.recentlyViewedError,
                                    //       onRetry: () => context
                                    //           .read<BuyPetLandingBloc>()
                                    //           .add(const FetchRecentlyViewedOnly()),
                                    //     );
                                    //   },
                                    // ),
                                    // FutureBuilder<PaginatedProducts>(
                                    //   future: _recentlyViewedFuture,
                                    //   builder: (context, snapshot) {
                                    //     if (snapshot.connectionState ==
                                    //         ConnectionState.waiting) {
                                    //       return const RecentlyViewedSection(
                                    //         headerVariant:
                                    //             PrimaryWidgetHeaderVariant
                                    //                 .centered,
                                    //         isLoading: true,
                                    //         // products: const [],
                                    //       );
                                    //     }

                                    //     if (snapshot.hasError) {
                                    //       return RecentlyViewedSection(
                                    //         headerVariant:
                                    //             PrimaryWidgetHeaderVariant
                                    //                 .centered,
                                    //         error: snapshot.error.toString(),
                                    //         // products: const [],
                                    //         onRetry: () {
                                    //           setState(() {
                                    //             _recentlyViewedFuture =
                                    //                 getIt<BuyPetRepository>()
                                    //                     .getRecentlyViewed(
                                    //                       page: 1,
                                    //                     );
                                    //           });
                                    //         },
                                    //       );
                                    //     }

                                    //     final data = snapshot.data;

                                    //     return RecentlyViewedSection(
                                    //       headerVariant:
                                    //           PrimaryWidgetHeaderVariant
                                    //               .centered,
                                    //       products: data?.products ?? [],
                                    //       // isLoading: false,
                                    //     );
                                    //   },
                                    // ),
                                    if (!widget.isFromGetHelp) ...[
                                      BlocBuilder<
                                        BuyPetLandingBloc,
                                        BuyPetLandingState
                                      >(
                                        builder: (context, landingState) {
                                          return RecentlyViewedSection(
                                            headerVariant:
                                                PrimaryWidgetHeaderVariant
                                                    .centered,
                                            products:
                                                landingState.recentlyViewed,
                                            isLoading: landingState.isLoading,
                                            error: landingState
                                                .recentlyViewedError,
                                            onRetry: () => context
                                                .read<BuyPetLandingBloc>()
                                                .add(
                                                  const FetchRecentlyViewedOnly(),
                                                ),
                                          );
                                        },
                                      ),
                                      AppSpacing.s24.hBox,
                                    ],
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                      if (detail != null)
                        ClipRect(
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(
                              sigmaX: 6.0,
                              sigmaY: 6.0,
                            ),
                            child: Container(
                              color: const Color(
                                0xFFFCF3DA,
                              ).withValues(alpha: 0.8),
                              padding: EdgeInsets.fromLTRB(
                                AppSpacing.s10.w,
                                AppSpacing.s10.h,
                                AppSpacing.s10.w,
                                AppSpacing.s16.h,
                              ),
                              child: BlocBuilder<CartBloc, CartState>(
                                builder: (context, cartState) {
                                  final isAdding = cartState.addingProductIds
                                      .contains(widget.productId);
                                  final isInCart =
                                      (cartState.cartData?.items?.any(
                                        (cartItem) =>
                                            cartItem.productId ==
                                            widget.productId,
                                      ) ??
                                      detail.inCart);

                                  // 👇 🔥 SWITCH HERE
                                  if (widget.isFromGetHelp) {
                                    return SizedBox(
                                      width: double.infinity,
                                      child: AppButton(
                                        label: 'Buy Now',
                                        onPressed: () {
                                          context.router.push(
                                            CartRoute(
                                              productId: widget.productId,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }

                                  return Row(
                                    children: [
                                      Expanded(
                                        child: AppButton(
                                          isLoading: isAdding,
                                          label: isInCart
                                              ? 'Go to Cart'
                                              : 'Add to Cart',
                                          variant: AppButtonVariant.outlined,
                                          onPressed: () {
                                            if (isInCart) {
                                              context.router.push(CartRoute());
                                            } else {
                                              context.read<CartBloc>().add(
                                                AddItemToCartEvent([
                                                  widget.productId,
                                                ]),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      AppSpacing.s12.wBox,
                                      Expanded(
                                        child: AppButton(
                                          label: 'Buy Now',
                                          onPressed: () {
                                            context.router.push(
                                              CartRoute(
                                                productId: widget.productId,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _buildDeliveryDetails(ProductDetail detail) {
    final parts = <String>[];
    final type = (detail.deliveryType ?? '').trim();
    if (type.isNotEmpty) {
      parts.add('Type: $type');
    }
    final method = (detail.deliveryMethod ?? '').trim();
    if (method.isNotEmpty) {
      parts.add('Method: $method');
    }
    final distance = (detail.deliveryDistance ?? '').trim();
    if (distance.isNotEmpty) {
      parts.add('Distance: $distance km');
    }
    return parts.join('\n');
  }
}
