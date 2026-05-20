import 'package:equatable/equatable.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/cancellation_tracking_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';

class OrderDetailModel extends Equatable {
  final String orderId;
  final String orderNumber;

  final String status;
  final String paymentStatus;
  final String deliveryStatus;

  final String createdAt;

  final int totalAmount;
  final int taxAmount;
  final int deliveryCharge;

  final List<OrderItemModel> items;

  final String? refundPolicy;
  final List<CancellationTrackingModel> cancellationTracking;

  final String customerName;
  final String customerPhone;

  final String address;

  const OrderDetailModel({
    required this.orderId,
    required this.orderNumber,
    required this.status,
    required this.paymentStatus,
    required this.deliveryStatus,
    this.refundPolicy,
    this.cancellationTracking = const [],
    required this.createdAt,
    required this.totalAmount,
    required this.taxAmount,
    required this.deliveryCharge,
    required this.items,
    required this.customerName,
    required this.customerPhone,
    required this.address,
  });

  /// 🔥 copyWith (CRITICAL for reactive updates)
  OrderDetailModel copyWith({
    String? status,
    String? paymentStatus,
    String? deliveryStatus,
    List<OrderItemModel>? items,
    List<CancellationTrackingModel>? cancellationTracking,
  }) {
    return OrderDetailModel(
      orderId: orderId,
      orderNumber: orderNumber,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      createdAt: createdAt,
      totalAmount: totalAmount,
      taxAmount: taxAmount,
      deliveryCharge: deliveryCharge,
      items: items ?? this.items,
      refundPolicy: refundPolicy,
      cancellationTracking: cancellationTracking ?? this.cancellationTracking,
      customerName: customerName,
      customerPhone: customerPhone,
      address: address,
    );
  }

  @override
  List<Object?> get props => [
    orderId,
    orderNumber,
    status,
    paymentStatus,
    deliveryStatus,
    createdAt,
    totalAmount,
    taxAmount,
    deliveryCharge,
    items,
    refundPolicy,
    cancellationTracking,
    customerName,
    customerPhone,
    address,
  ];
}
