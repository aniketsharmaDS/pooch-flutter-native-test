import 'package:equatable/equatable.dart';
import 'package:poochcare/features/ecommerce/data/types/orders/orders.dart';

class OrderItemModel extends Equatable {
  final String orderId;
  final String orderNumber;

  final String itemId;

  final String title;
  final String subtitle;
  final String dateTime;

  final int price;
  final int? originalPrice;

  final int finalPrice;
  final int basePrice;
  final int deliveryFee;
  final double? discountAmount;
  final double? originalAmount;
  final int taxAmount;

  final bool? isVaccinated;

  /// UI display status (e.g. Cancelled, Delivered)
  final String status;

  /// Raw backend status (e.g. cancelled_by_user, delivered)
  final String rawStatus;

  final String image;
  final String? deliveryOtp;

  final OrderType orderType;

  final String? cancellationStatus;
  final String? cancellationReason;

  final List<ItemDeliveryHistoryModel>? itemDeliveryHistory;

  const OrderItemModel({
    required this.orderId,
    required this.orderNumber,
    required this.itemId,
    required this.title,
    required this.subtitle,
    required this.rawStatus,
    required this.dateTime,
    required this.price,
    required this.finalPrice,
    required this.basePrice,
    required this.deliveryFee,
    this.discountAmount,
    this.originalAmount,
    required this.taxAmount,
    this.originalPrice,
    required this.status,
    this.isVaccinated,
    required this.image,
    this.deliveryOtp,
    this.cancellationStatus,
    this.cancellationReason,
    this.orderType = OrderType.product,
    this.itemDeliveryHistory,
  });

  /// 🔥 Correct & safe copyWith
  OrderItemModel copyWith({
    String? status,
    String? rawStatus,
    String? cancellationStatus,
    String? cancellationReason,
    int? finalPrice,
    int? basePrice,
    int? deliveryFee,
    double? discountAmount,
    double? originalAmount,
    bool? isVaccinated,
    int? taxAmount,
    String? deliveryOtp,
    List<ItemDeliveryHistoryModel>? itemDeliveryHistory,
  }) {
    return OrderItemModel(
      orderId: orderId,
      orderNumber: orderNumber,
      itemId: itemId,
      title: title,
      subtitle: subtitle,
      dateTime: dateTime,
      price: price,
      finalPrice: finalPrice ?? this.finalPrice,
      basePrice: basePrice ?? this.basePrice,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      discountAmount: discountAmount ?? this.discountAmount,
      originalAmount: originalAmount ?? this.originalAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      originalPrice: originalPrice,
      status: status ?? this.status,
      isVaccinated: isVaccinated ?? this.isVaccinated,
      rawStatus: rawStatus ?? this.rawStatus,
      image: image,
      deliveryOtp: deliveryOtp ?? this.deliveryOtp,
      cancellationStatus: cancellationStatus ?? this.cancellationStatus,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      orderType: orderType,
      itemDeliveryHistory: itemDeliveryHistory ?? this.itemDeliveryHistory,
    );
  }

  /// 🔥 Helpful derived states (VERY useful in UI & logic)
  bool get isCancelled => rawStatus.toLowerCase().contains('cancel');

  bool get isDelivered => rawStatus.toLowerCase().contains('deliver');

  bool get isActive => !isCancelled && !isDelivered;

  /// Optional: factory if data comes from API
  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      orderId: json['orderId']?.toString() ?? '',
      orderNumber: json['orderNumber']?.toString() ?? '',
      itemId: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      subtitle: json['subtitle']?.toString() ?? '',
      dateTime: json['dateTime']?.toString() ?? '',
      price: (json['price'] ?? 0) as int,

      /// 🔥 ADD THESE DEFAULTS
      finalPrice: (json['finalPrice'] ?? 0) as int,
      basePrice: (json['basePrice'] ?? 0) as int,
      deliveryFee: (json['deliveryFee'] ?? 0) as int,
      taxAmount: (json['taxAmount'] ?? 0) as int,
      discountAmount: json['discountAmount'] != null
          ? (json['discountAmount'] as num).toDouble()
          : null,
      originalAmount: json['originalAmount'] != null
          ? (json['originalAmount'] as num).toDouble()
          : null,

      originalPrice: json['originalPrice'] != null
          ? json['originalPrice'] as int
          : null,
      status: json['status']?.toString() ?? '',
      rawStatus: json['rawStatus']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      deliveryOtp: json['deliveryOtp']?.toString(),
      cancellationStatus: json['cancellationStatus']?.toString(),
      cancellationReason: json['cancellationReason']?.toString(),
      itemDeliveryHistory: (json['itemDeliveryHistory'] as List?)
          ?.map(
            (e) => ItemDeliveryHistoryModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
    orderId,
    orderNumber,
    itemId,
    title,
    subtitle,
    dateTime,
    price,
    originalPrice,
    finalPrice,
    basePrice,
    deliveryFee,
    discountAmount,
    originalAmount,
    taxAmount,
    status,
    rawStatus,
    image,
    deliveryOtp,
    cancellationStatus,
    cancellationReason,
    orderType,
    itemDeliveryHistory,
  ];
}

class ItemDeliveryHistoryModel extends Equatable {
  final String toStatus;
  final String createdAt;
  final String? notes;

  const ItemDeliveryHistoryModel({
    required this.toStatus,
    required this.createdAt,
    this.notes,
  });

  factory ItemDeliveryHistoryModel.fromJson(Map<String, dynamic> json) {
    return ItemDeliveryHistoryModel(
      toStatus: json['toStatus']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      notes: json['notes']?.toString(),
    );
  }

  @override
  List<Object?> get props => [toStatus, createdAt, notes];
}
