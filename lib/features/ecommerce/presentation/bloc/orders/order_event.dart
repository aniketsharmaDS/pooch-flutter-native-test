import 'dart:async';

import 'package:poochcare/features/ecommerce/data/models/orders/place_order_model.dart';

abstract class OrderEvent {}

class LoadOrders extends OrderEvent {
  final String? status; // all, active, completed, cancelled
  final bool isRefresh;

  LoadOrders({this.status, this.isRefresh = false});
}

class LoadMoreOrders extends OrderEvent {
  final String? status;

  LoadMoreOrders({this.status});
}

class UpdateOrderItemStatus extends OrderEvent {
  final String itemId;
  final String newStatus;
  final String newRawStatus;
  final String? cancellationStatus;
  final String? cancellationReason;

  UpdateOrderItemStatus({
    required this.itemId,
    required this.newStatus,
    required this.newRawStatus,
    this.cancellationStatus,
    this.cancellationReason,
  });
}

class PlaceOrderFromCart extends OrderEvent {
  final PlaceOrderRequest request;
  final Completer<PlaceOrderData> completer;

  PlaceOrderFromCart({required this.request, required this.completer});
}

class GetOrderSummaryEvent extends OrderEvent {
  final String productId;

  GetOrderSummaryEvent({required this.productId});
}
