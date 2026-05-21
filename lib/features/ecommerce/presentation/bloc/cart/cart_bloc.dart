import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/ecommerce/data/models/cart/cart_item_model.dart';
import 'package:poochcare/features/ecommerce/domain/repository/cart_repository.dart';
import 'package:poochcare/features/ecommerce/domain/repository/orders_repository.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/cart/cart_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/cart/cart_state.dart';
import 'package:poochcare/features/ecommerce/presentation/view/cart/cart_screen.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;
  final OrderRepository _orderRepo;

  CartBloc(this.repository, this._orderRepo) : super(const CartState()) {
    on<FetchCartEvent>(_onFetchCart);
    on<FetchCartCountEvent>(_onFetchCartCount);
    on<AddItemToCartEvent>(_onAddItemToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<ResetCartEvent>(_onReset);
  }

  Future<void> _onFetchCart(
    FetchCartEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CartStatus.loading));

      final isBuynow =
          event.productId != null && (event.productId ?? '').isNotEmpty;
      final cartData = isBuynow ? null : await repository.getCart();
      final orderData = isBuynow
          ? await _orderRepo.previewOrder(productId: event.productId ?? '')
          : null;
      final buyNowPetData = isBuynow
          ? (orderData?.items ?? []).isNotEmpty
                ? orderData?.items.first
                : null
          : null;

      final totalAmount = isBuynow
          ? orderData?.pricing.subtotal
          : cartData?.orderSummary?.subTotal;
      final deliveryFee = isBuynow
          ? orderData?.pricing.deliveryCharge
          : cartData?.orderSummary?.deliveryFee ?? 0;
      final tax = isBuynow
          ? orderData?.pricing.taxAmount
          : cartData?.orderSummary?.tax ?? 0;
      final couponDiscount = isBuynow
          ? orderData?.pricing.discountAmount
          : cartData?.orderSummary?.discount ?? 0;
      final items = isBuynow
          ? [
              CartPetItemModel(
                petName: buyNowPetData?.petDetails?.breedInfo?.breedName ?? '',
                petAge: buyNowPetData?.petDetails?.ageDisplay ?? '',
                petGender: buyNowPetData?.petDetails?.gender ?? '',
                isVaccinated: buyNowPetData?.petDetails?.isVaccinated ?? false,
                basePrice: buyNowPetData?.price ?? '',
                deliveryFee: deliveryFee,
                productImages: buyNowPetData?.productImages ?? [],
                productId: buyNowPetData?.productId ?? '',
                id: buyNowPetData?.productId ?? '',
              ),
            ]
          : getCartItems(cartData).toList();

      final count = isBuynow ? state.cartCount : items.length;

      emit(
        state.copyWith(
          orderPreviewData: orderData,
          totalAmount: totalAmount,
          deliveryFee: deliveryFee,
          tax: tax,
          couponDiscount: couponDiscount,
          status: CartStatus.success,
          cartData: cartData,
          cartCount: count,
          actionId: state.actionId + 1,
          cartItems: items,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CartStatus.failure,
          errorMessage: e.toString(),
          actionId: state.actionId + 1,
        ),
      );
    }
  }

  Iterable<CartPetItemModel> getCartItems(CartData? cartData) {
    return (cartData?.items ?? []).map((item) {
      final petDetails = item.product?.petDetails;
      final petName = petDetails?.breedInfo?.breedName ?? '';
      final petAge = petDetails?.ageDisplay ?? 'N/A';
      final petGender = (petDetails?.gender ?? 'Unknown').toUpperCase();
      final isVaccinated = petDetails?.isVaccinated ?? false;
      final basePrice = item.pricing?.basePrice ?? '';
      final deliveryFee = item.pricing?.deliveryFee ?? 0;
      final productImages = item.product?.productImages ?? [];
      final productId = item.productId;
      final id = item.id;
      return CartPetItemModel(
        petName: petName,
        petAge: petAge,
        petGender: petGender,
        isVaccinated: isVaccinated,
        basePrice: basePrice,
        deliveryFee: deliveryFee,
        productImages: productImages,
        productId: productId,
        id: id,
      );
    });
  }

  Future<void> _onFetchCartCount(
    FetchCartCountEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await repository.getCartCount();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: CartStatus.failure,
            errorMessage: failure.message,
            actionId: state.actionId + 1,
          ),
        );
      },
      (count) {
        emit(state.copyWith(cartCount: count, actionId: state.actionId + 1));
      },
    );
  }

  Future<void> _onAddItemToCart(
    AddItemToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final previousCartData = state.cartData;
    final previousCount = state.cartCount;

    emit(
      state.copyWith(
        addingProductIds: [...state.addingProductIds, ...event.productIds],
        actionId: state.actionId + 1,
      ),
    );

    try {
      final orderSummary = await repository.addToCart(event.productIds);
      final updatedCount = previousCount + event.productIds.length;
      final updatedCartData = _cartDataAfterAdd(
        cartData: previousCartData,
        productIds: event.productIds,
        orderSummary: orderSummary,
        totalItems: updatedCount,
      );

      emit(
        state.copyWith(
          totalAmount: orderSummary.subTotal ?? 0,
          deliveryFee: orderSummary.deliveryFee ?? 0,
          tax: orderSummary.tax ?? 0,
          couponDiscount: orderSummary.discount ?? 0,
          cartData: updatedCartData,
          cartCount: updatedCount,
          successMessage: 'Item added to cart successfully',
          addingProductIds: state.addingProductIds
              .where((id) => !event.productIds.contains(id))
              .toList(),
          actionId: state.actionId + 1,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to add item to cart',
          cartData: previousCartData,
          cartCount: previousCount,
          addingProductIds: state.addingProductIds
              .where((id) => !event.productIds.contains(id))
              .toList(),
          actionId: state.actionId + 1,
        ),
      );
    }
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final previousCartData = state.cartData;
    final previousCount = state.cartItems?.length ?? 0;

    // Optimistic update: remove from UI immediately
    if (state.cartItems != null) {
      final updatedCartItems = (state.cartItems ?? [])
          .where((element) => event.productId != element.productId)
          .toList();

      final updatedCartData = (state.cartData?.items ?? [])
          .where((element) => element.productId != event.productId)
          .toList();

      emit(
        state.copyWith(
          cartData: state.cartData?.copyWith(items: updatedCartData),
          cartItems: updatedCartItems,
          cartCount: _clampCount(previousCount - 1),
          actionId: state.actionId + 1,
        ),
      );
    }

    try {
      final orderSummary = await repository.removeFromCart(event.productId);

      // Update with the actual data from response
      if (state.cartData != null) {
        final finalCartData = state.cartData!.copyWith(
          orderSummary: orderSummary,
          totalItems: orderSummary.items?.length ?? 0,
        );
        final updatedItems = (state.cartData?.items ?? [])
            .where((element) => element.id != event.productId)
            .toList();

        emit(
          state.copyWith(
            totalAmount: orderSummary.subTotal ?? 0,
            deliveryFee: orderSummary.deliveryFee ?? 0,
            tax: orderSummary.tax ?? 0,
            cartData: finalCartData.copyWith(items: updatedItems),
            cartCount: finalCartData.totalItems ?? 0,
            successMessage: 'Item removed from cart successfully',
            actionId: state.actionId + 1,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          cartData: previousCartData,
          cartCount: previousCount,
          totalAmount: previousCartData?.orderSummary?.subTotal ?? 0,
          deliveryFee: previousCartData?.orderSummary?.deliveryFee ?? 0,
          tax: previousCartData?.orderSummary?.tax ?? 0,
          errorMessage: 'Failed to remove item',
          actionId: state.actionId + 1,
        ),
      );
    }
  }

  void _onReset(ResetCartEvent event, Emitter<CartState> emit) {
    emit(const CartState());
  }

  int _clampCount(int count) => count < 0 ? 0 : count;

  CartData _cartDataAfterAdd({
    required CartData? cartData,
    required List<String> productIds,
    required CartOrderSummary orderSummary,
    required int totalItems,
  }) {
    final existingItems = <CartItem>[...(cartData?.items ?? [])];
    final existingProductIds = existingItems
        .map((item) => item.productId)
        .whereType<String>()
        .toSet();

    for (final productId in productIds) {
      if (existingProductIds.contains(productId)) {
        continue;
      }

      existingItems.add(
        CartItem(
          id: productId,
          userId: cartData?.userId ?? '',
          productId: productId,
        ),
      );
    }

    if (cartData == null) {
      return CartData(
        userId: '',
        items: existingItems,
        totalItems: totalItems,
        orderSummary: orderSummary,
      );
    }

    return cartData.copyWith(
      items: existingItems,
      totalItems: totalItems,
      orderSummary: orderSummary,
    );
  }
}

extension CartDataCopyWith on CartData {
  CartData copyWith({
    String? userId,
    List<CartItem>? items,
    int? totalItems,
    int? currentPage,
    int? totalPages,
    bool? hasNextPage,
    bool? hasPreviousPage,
    CartPricing? pricing,
    double? totalAmount,
    CartOrderSummary? orderSummary,
  }) {
    return CartData(
      userId: userId ?? this.userId,
      items: items ?? this.items,
      totalItems: totalItems ?? this.totalItems,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
      pricing: pricing ?? this.pricing,
      totalAmount: totalAmount ?? this.totalAmount,
      orderSummary: orderSummary ?? this.orderSummary,
    );
  }
}
