import 'package:equatable/equatable.dart';
import 'package:poochcare/features/ecommerce/data/models/cart/cart_item_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_preview_model.dart';
import 'package:poochcare/features/ecommerce/presentation/view/cart/cart_screen.dart';

enum CartStatus { initial, loading, success, failure }

class CartState extends Equatable {
  final CartStatus status;
  final CartData? cartData;
  final int cartCount;
  final String? errorMessage;
  final String? successMessage;
  final int actionId;
  final double totalAmount;
  final double deliveryFee;
  final double tax;
  final double couponDiscount;
  final List<String> addingProductIds;
  final OrderPreviewModel? orderPreviewData;
  final List<CartPetItemModel>? cartItems;

  const CartState({
    this.status = CartStatus.initial,
    this.cartData,
    this.cartCount = 0,
    this.errorMessage,
    this.successMessage,
    this.actionId = 0,
    this.totalAmount = 0,
    this.deliveryFee = 0,
    this.tax = 0,
    this.couponDiscount = 0,
    this.addingProductIds = const [],
    this.orderPreviewData,
    this.cartItems,
  });

  CartState copyWith({
    CartStatus? status,
    CartData? cartData,
    int? cartCount,
    String? errorMessage,
    String? successMessage,
    int? actionId,
    double? totalAmount,
    double? deliveryFee,
    double? tax,
    double? couponDiscount,
    List<String>? addingProductIds,
    OrderPreviewModel? orderPreviewData,
    List<CartPetItemModel>? cartItems,
  }) {
    return CartState(
      orderPreviewData: orderPreviewData ?? this.orderPreviewData,
      totalAmount: totalAmount ?? this.totalAmount,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      tax: tax ?? this.tax,
      couponDiscount: couponDiscount ?? this.couponDiscount,
      status: status ?? this.status,
      cartData: cartData ?? this.cartData,
      cartCount: cartCount ?? this.cartCount,
      errorMessage: errorMessage,
      successMessage: successMessage,
      actionId: (actionId ?? this.actionId),
      addingProductIds: addingProductIds ?? this.addingProductIds,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  @override
  List<Object?> get props => [
    status,
    cartData,
    cartCount,
    errorMessage,
    successMessage,
    actionId,
    totalAmount,
    deliveryFee,
    tax,
    couponDiscount,
    addingProductIds,
    orderPreviewData,
    cartItems,
  ];
}
