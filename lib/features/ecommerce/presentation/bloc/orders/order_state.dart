import 'package:equatable/equatable.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/place_order_model.dart';

class OrderState extends Equatable {
  final List<OrderItemModel> orders;
  final Map<String?, List<OrderItemModel>> cache;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasReachedMax;
  final int page;
  final String? status;
  final String? error;
  final bool isPlacingOrder;
  final String? placeOrderError;
  final PlaceOrderData? placedOrder;

  const OrderState({
    this.orders = const [],
    this.cache = const {},
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
    this.page = 1,
    this.status,
    this.error,
    this.isPlacingOrder = false,
    this.placeOrderError,
    this.placedOrder,
  });

  OrderState copyWith({
    List<OrderItemModel>? orders,
    Map<String?, List<OrderItemModel>>? cache,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasReachedMax,
    int? page,
    String? status,
    String? error,
    bool? isPlacingOrder,
    String? placeOrderError,
    PlaceOrderData? placedOrder,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      cache: cache ?? this.cache,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      status: status ?? this.status,
      error: error,
      isPlacingOrder: isPlacingOrder ?? this.isPlacingOrder,
      placeOrderError: placeOrderError,
      placedOrder: placedOrder ?? this.placedOrder,
    );
  }

  @override
  List<Object?> get props => [
    orders,
    cache,
    isLoading,
    isLoadingMore,
    hasReachedMax,
    page,
    status,
    error,
    isPlacingOrder,
    placeOrderError,
    placedOrder,
  ];
}
