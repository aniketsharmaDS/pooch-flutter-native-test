import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide TransitionRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/snackbar_service.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/store/auth/auth_store_event.dart';
import 'package:poochcare/core/store/onboarding/onboarding_journey_store_bloc.dart';
import 'package:poochcare/core/store/onboarding/onboarding_journey_store_state.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/app_extensions/price_formatter_extension.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/nudges/pooch_super_offer_nudge.dart';
import 'package:poochcare/core/widgets/others/cart_item_card.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/ecommerce/data/models/address/address_model.dart';
import 'package:poochcare/features/ecommerce/data/models/cart/cart_item_model.dart';
import 'package:poochcare/features/ecommerce/data/models/coupon/apply_coupon_response.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_preview_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/place_order_model.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/address_bloc/address_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/address_bloc/address_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/address_bloc/address_state.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/cart/cart_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/cart/cart_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/cart/cart_state.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_state.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/orders/order_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/orders/order_event.dart';
import 'package:poochcare/features/ecommerce/presentation/view/cart/widgets/address_tile.dart';
import 'package:poochcare/features/ecommerce/presentation/view/cart/widgets/coupons_and_offers.dart';
import 'package:poochcare/features/ecommerce/presentation/view/cart/widgets/price_details_section.dart';
import 'package:poochcare/features/test_screen/transition_screen/transition_screen.dart';
import 'package:poochcare/router/app_router.dart';

class CartPetItemModel {
  final String petName;
  final String petAge;
  final String petGender;
  final bool isVaccinated;
  final String? basePrice;
  final double? deliveryFee;
  final List<String>? productImages;
  final String? productId;
  final String id;

  CartPetItemModel({
    required this.petName,
    required this.petAge,
    required this.petGender,
    required this.isVaccinated,
    required this.basePrice,
    required this.deliveryFee,
    required this.productImages,
    required this.productId,
    required this.id,
  });
}

@RoutePage()
class CartScreen extends StatefulWidget {
  final String? productId;
  const CartScreen({super.key, this.productId});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  static const String _defaultPaymentMethod = 'cash_on_delivery'; //card

  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(FetchCartEvent(widget.productId));
    context.read<AddressBloc>().add(const FetchAddressesEvent());
    context.read<CouponsBloc>().add(
      const FetchCouponsEvent(couponType: 'products'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppPrimaryBgContainer(
        child: SafeArea(
          child: Column(
            children: [
              PoochScreenAppBar(title: 'cart.myCart'.tr()),
              const SizedBox(height: AppSpacing.s10),
              cartItems(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s8),
        child: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, addressState) {
            return BlocConsumer<CartBloc, CartState>(
              listener: (context, state) {
                if (state.status == CartStatus.failure) {
                  CustomSnackbar.show(
                    state.errorMessage ?? '',
                    SnackbarType.error,
                  );
                }
              },
              builder: (context, cartState) {
                final isBuyNow = widget.productId != null;
                final itemAvailable = isBuyNow ? true : cartState.cartCount > 0;
                final selectedAddress = addressState.selectedAddress;

                return AppButton(
                  label: itemAvailable
                      ? selectedAddress != null
                            ? 'cart.payNow'.tr()
                            : 'cart.selectAddress'.tr()
                      : 'cart.addItemsToCart'.tr(),
                  size: AppButtonSize.medium,
                  onPressed: () {
                    if (itemAvailable) {
                      if (selectedAddress != null) {
                        _showJourneyDialog(
                          context,
                          selectedAddress,
                          cartState.cartData,
                          isBuyNow ? cartState.orderPreviewData : null,
                        );
                      } else {
                        _showAddressBottomSheet();
                      }
                    } else {
                      context.router.navigate(
                        const HomeRoute(children: [BuyPetLandingRoute()]),
                      );
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  BlocConsumer<CartBloc, CartState> cartItems() {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state.status == CartStatus.success) {
          final data = state.cartData;
          applyExistingCoupon(data, state.orderPreviewData, context);
        }
      },
      builder: (context, state) {
        if (state.status == CartStatus.loading) {
          return const Expanded(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final items = state.cartItems ?? [];

        if (items.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s8),
            child: PoochSuperOfferNudge(
              discountTitle: 'Get 10%',
              discountSubText: 'On next 5 purchases.',
              btnTitle: 'Add',
              price: 'INR 500',
              onAdd: () {},
            ),
          );
        }

        return Expanded(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(childCount: items.length, (
                  context,
                  index,
                ) {
                  final item = items[index];
                  final petName = item.petName;
                  final petAge = item.petAge;
                  final petGender = item.petGender;
                  final isVaccinated = item.isVaccinated;
                  final basePrice = item.basePrice ?? '';
                  final deliveryFee = item.deliveryFee ?? 0;
                  final productImages = item.productImages ?? [];
                  final productId = item.productId;
                  final id = item.id;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.s10),
                    child: PetItemCard(
                      id: id,
                      age: petAge,
                      gender: petGender,
                      basePrice: basePrice,
                      isVaccinated: isVaccinated,
                      name: petName,
                      productId: productId ?? '',
                      deliveryFee: deliveryFee,
                      productImages: productImages,
                      hidDeleteButton: widget.productId != null,
                    ),
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.productId == null &&
                        (widget.productId ?? '').isEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s8,
                        ),
                        child: PoochSuperOfferNudge(onAdd: () {}),
                      ),
                      const SizedBox(height: AppSpacing.s10),
                    ],

                    const CouponsAndOffers(),
                    addressSection(),
                    const SizedBox(height: AppSpacing.s10),

                    BlocBuilder<CouponsBloc, CouponsState>(
                      builder: (context, couponsState) {
                        final isApplied =
                            couponsState.appliedCouponCodeInCart != null &&
                            couponsState.appliedCouponCodeInCart!.isNotEmpty;
                        final discount = isApplied
                            ? (couponsState.applyCouponResponse?.discount ??
                                  0.0)
                            : 0.0;

                        return PriceDetailsSection(
                          itemCount: items.length,
                          deliveryFee: state.deliveryFee,
                          tax: state.tax,
                          totalMrp: state.totalAmount,
                          isCouponApplied: isApplied,
                          discount: discount,
                        );
                      },
                    ),
                    const SizedBox(height: AppSpacing.s100),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  BlocBuilder<AddressBloc, AddressState> addressSection() {
    return BlocBuilder<AddressBloc, AddressState>(
      builder: (context, state) {
        final address = state.selectedAddress?.addressLine ?? '';
        if (address.isNotEmpty) {
          return Column(
            children: [
              const SizedBox(height: AppSpacing.s10),
              SelectedAddressBar(
                address: address,
                onTap: () {
                  _showAddressBottomSheet();
                },
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void applyExistingCoupon(
    CartData? cartData,
    OrderPreviewModel? orderData,
    BuildContext context,
  ) {
    if (widget.productId != null && (widget.productId ?? '').isNotEmpty) {
      context.read<CouponsBloc>().add(const ResetCouponsEvent());
    } else {
      if (cartData?.appliedCoupon != null) {
        final appliedCouponData = cartData?.appliedCoupon;
        final couponData = ApplyCouponResponse(
          discount: appliedCouponData?.totalDiscountApplied ?? 0,
          finalTotal: cartData?.orderSummary?.total ?? 0,
          subtotal: cartData?.orderSummary?.subTotal ?? 0,
        );
        context.read<CouponsBloc>().add(
          ApplyCouponLocally(
            couponData,
            cartData?.appliedCoupon?.couponCode ?? '',
          ),
        );
      }
    }
  }

  void applyExistingPreviewCoupon(
    OrderPreviewModel data,
    BuildContext context,
  ) {
    final appliedCoupon = data.appliedCoupon;
    if (appliedCoupon == null || !appliedCoupon.applied) {
      return;
    }

    final appliedCode = appliedCoupon.code.trim();
    if (appliedCode.isEmpty) {
      return;
    }

    final couponsState = context.read<CouponsBloc>().state;
    if (couponsState.appliedCouponCodeInCart == appliedCode) {
      return;
    }

    final couponData = ApplyCouponResponse(
      discount: data.pricing.discountAmount,
      finalTotal: data.pricing.totalAmount,
      subtotal: data.pricing.subtotal,
    );

    context.read<CouponsBloc>().add(
      ApplyCouponLocally(couponData, appliedCode),
    );
  }

  void _showAddressBottomSheet() {
    AppBottomSheet.show<void>(
      context: context,
      actionBackgroundColor: AppColors.white,
      backgroundColor: const Color(0xFFFEF3E6),
      title: 'cart.selectAddress'.tr(),
      contentPadding: EdgeInsets.zero,
      content: BlocBuilder<AddressBloc, AddressState>(
        builder: (context, state) {
          final addresses = state.addresses;

          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 500,
              maxWidth: MediaQuery.sizeOf(context).width,
              minWidth: MediaQuery.sizeOf(context).width,
            ),
            child: addresses.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.s16),
                      child: AppText.bodyS('cart.noAddress'.tr()),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: AppSpacing.s10),
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      final address = addresses[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.s8),
                        child: AddressTile(
                          address: address,
                          onTap: () {
                            context.read<AddressBloc>().add(
                              SelectAddressEvent(address: address),
                            );
                            Navigator.pop(context);

                            // _showJourneyDialog(
                            //   parentContext,
                            //   address,
                            //   state.cartData,
                            // );
                          },
                          onSetAsPrimary: () {
                            context.read<AddressBloc>().add(
                              MakeAddressPrimaryEvent(address.id),
                            );
                          },
                          onEditPressed: () {
                            Navigator.pop(context); // Close bottom sheet
                            context.router.push(
                              AddNewAddressRoute(address: address),
                            );
                          },
                          onDeletePressed: () {
                            context.read<AddressBloc>().add(
                              DeleteAddressEvent(address.id),
                            );
                            // Refresh addresses after deletion
                            Future.delayed(
                              const Duration(milliseconds: 500),
                              () {
                                if (!context.mounted) return;
                                context.read<AddressBloc>().add(
                                  const FetchAddressesEvent(),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
          );
        },
      ),
      actions: [
        AppButton(
          backgroundColor: AppColors.white,
          variant: AppButtonVariant.outlined,
          label: 'cart.addNewAddress'.tr(),
          size: AppButtonSize.medium,
          onPressed: () {
            Navigator.pop(context); // Close bottom sheet
            context.router.push(AddNewAddressRoute()).then((_) {
              if (!mounted) return;
              context.read<AddressBloc>().add(const FetchAddressesEvent());
            });
          },
        ),
      ],
    );
  }

  Future<void> _showJourneyDialog(
    BuildContext context,
    Address address,
    CartData? cartData,
    OrderPreviewModel? orderPreviewData,
  ) async {
    final result = await AppDialog.show<bool>(
      context: context,
      title: 'cart.chooseJourney'.tr(),
      content: 'cart.checkoutJourneyText'.tr(),
      primaryLabel: 'cart.success'.tr(),
      secondaryLabel: 'cart.failure'.tr(),
      onPrimary: () async {
        await _placeOrder(context, address.id, cartData, orderPreviewData);
        return true;
      },
      onSecondary: () async => false,
    );

    if (!context.mounted || result == null) {
      return;
    }

    if (result) {
      final journeyType = getIt<OnboardingJourneyStoreBloc>().state.journeyType;
      if (journeyType == OnboardingJourneyType.buyPet) {
        final authStoreBloc = getIt<AuthStoreBloc>();
        authStoreBloc.add(const BuyPetJourneyCompleted());
        authStoreBloc.add(const PetOnboardingCompleted());
        authStoreBloc.add(const InviteSheetSkipped());

        final currentState = authStoreBloc.state;
        final alreadyCompleted =
            currentState.user?.hasBoughtPet == true &&
            currentState.user?.isPetOnboarded == true &&
            currentState.inviteSheetSkipped == true;

        if (!alreadyCompleted) {
          await authStoreBloc.stream
              .firstWhere(
                (element) =>
                    element.user?.hasBoughtPet == true &&
                    element.user?.isPetOnboarded == true &&
                    element.inviteSheetSkipped == true,
              )
              .timeout(const Duration(seconds: 10));
        }
      }
      if (widget.productId == null) {
        if (!context.mounted) return;
        context.read<CartBloc>().add(const ResetCartEvent());
      }
      if (!context.mounted) return;
      context.router.replaceAll([const OrderSuccessTransitionRoute()]);
      return;
    }

    context.router.push(
      TransitionRoute(
        variant: TransitionScreenVariant.retryPayment,
        onPrimaryPressed: () {
          Navigator.pop(context);
        },
        onSecondaryPressed: () {
          context.router.replaceAll([const HomeRoute()]);
        },
      ),
    );
  }

  Future<void> _placeOrder(
    BuildContext context,
    String shippingAddressId,
    CartData? cartData,
    OrderPreviewModel? orderPreviewData,
  ) async {
    final buyNowItem = (orderPreviewData?.items ?? []).isNotEmpty
        ? orderPreviewData?.items.first
        : null;
    final rawPrice = orderPreviewData?.pricing.basePrice ?? 0;

    final items = widget.productId != null
        ? [
            PlaceOrderItemRequest(
              id: (orderPreviewData?.items ?? []).isNotEmpty
                  ? orderPreviewData?.items.first.productId ?? ''
                  : '',
              price: rawPrice.formatPrice(),
              productId: buyNowItem?.productId ?? '',
              productName: buyNowItem?.productName ?? '',
              productType: buyNowItem?.productType ?? '',
              quantity: 1,
              taxAmount: orderPreviewData?.pricing.taxAmount ?? 0,
            ),
          ]
        : _buildPlaceOrderItems(cartData);

    final orderBloc = getIt<OrderBloc>();
    final completer = Completer<PlaceOrderData>();

    try {
      orderBloc.add(
        PlaceOrderFromCart(
          request: PlaceOrderRequest(
            productId: widget.productId,
            couponCode:
                context.read<CouponsBloc>().state.appliedCouponCodeInCart ?? '',
            type: widget.productId != null ? 'buy_now' : 'cart',
            shippingAddressId: shippingAddressId,
            paymentMethod: _defaultPaymentMethod,
            items: items,
          ),
          completer: completer,
        ),
      );

      await completer.future;
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
      rethrow;
    } finally {
      await orderBloc.close();
    }
  }

  List<PlaceOrderItemRequest> _buildPlaceOrderItems(CartData? cartData) {
    final items = cartData?.items ?? const <CartItem>[];

    return items
        .map((item) {
          final productId = item.productId ?? item.id;
          if (productId.isEmpty) {
            return null;
          }

          final productName =
              item.product?.petDetails?.translations?.firstOrNull?.name ??
              'Product';

          return PlaceOrderItemRequest(
            id: productId,
            productType: item.productType ?? 'product',
            productId: productId,
            productName: productName,
            price: _itemPrice(item),
            quantity: item.quantity ?? item.pricing?.quantity ?? 1,
            taxAmount: 0.0,
          );
        })
        .whereType<PlaceOrderItemRequest>()
        .toList(growable: false);
  }

  String _itemPrice(CartItem item) {
    final rawPrice =
        item.pricing?.basePrice ?? item.product?.price ?? item.originalPrice;
    final parsedPrice = double.tryParse(rawPrice ?? '0') ?? 0;
    return parsedPrice.toStringAsFixed(2);
  }
}

class PetItemCard extends StatelessWidget {
  const PetItemCard({
    super.key,
    required this.name,
    required this.age,
    required this.isVaccinated,
    required this.basePrice,
    this.deliveryFee,
    this.productImages,
    required this.productId,
    required this.gender,
    required this.id,
    this.hidDeleteButton = false,
  });

  final String name;
  final String age;
  final bool isVaccinated;
  final String basePrice;
  final double? deliveryFee;
  final List<String>? productImages;
  final String productId;
  final String gender;
  final String id;
  final bool hidDeleteButton;

  @override
  Widget build(BuildContext context) {
    return CartItemCard(
      hideDeleteButton: hidDeleteButton,
      item: CartItemModel(
        id: id,
        name: name,
        age: age,
        gender: gender,
        isVaccinated: isVaccinated,
        price: int.tryParse((basePrice).split('.')[0]) ?? 0,
        deliveryText:
            'Delivery Fee ₹${(deliveryFee ?? 0).toStringAsFixed(0)} • Expected ',
        imageUrl: (productImages ?? []).isNotEmpty && productImages != null
            ? productImages![0]
            : AppIcons.png.generic.poochPet,
        expectedDeliveryTime: 'Tomorrow 8 AM - 12 PM',
      ),
      onTap: () {
        context.router.push(BuyPetDetailRoute(productId: productId));
      },
      onDelete: () {
        context.read<CartBloc>().add(RemoveFromCartEvent(productId));
      },
    );
  }
}

class SelectedAddressBar extends StatelessWidget {
  final String address;
  final VoidCallback? onTap;

  const SelectedAddressBar({
    required this.onTap,
    super.key,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08), // Light shadow
              blurRadius: 15, // High blur for softness
              offset: const Offset(0, 8), // Push shadow downwards
              spreadRadius: 1, // Slight spread
            ),
          ],
        ),
        child: Row(
          children: [
            AppIcon(
              AppIcons.svg.generic.location,
              size: 20,
              color: Colors.deepOrangeAccent,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Delivering to',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    address,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
