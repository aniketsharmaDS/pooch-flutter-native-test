import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_api_model.dart';

class OrderModel {
  final String orderId;
  final String orderNumber;
  final String status;
  final String? orderType;
  final String? userId;
  final String? shippingAddressId;
  final String? totalAmount;
  final String? taxAmount;
  final String? deliveryCharge;
  final String? currencyCode;
  final String? countryCode;
  final String? couponCode;
  final String? discountAmount;
  final String? discountType;
  final String? originalTotal;
  final String? paymentStatus;
  final String? deliveryStatus;
  final String? estimatedDeliveryDate;
  final String? actualDeliveryDate;
  final String? trackingNumber;
  final String? deliveryNotes;
  final bool isDeliveryConfirmed;
  final String? deliveryConfirmedAt;
  final String? createdAt;
  final String? updatedAt;
  final List<Map<String, dynamic>> subscriptionDetails;
  final List<OrderItemApiModel> items;
  final Map<String, dynamic>? payment;
  final List<Map<String, dynamic>> deliveryHistory;
  final bool isReturnSubmitted;

  const OrderModel({
    required this.orderId,
    required this.orderNumber,
    required this.status,
    required this.createdAt,
    required this.items,
    this.orderType,
    this.userId,
    this.shippingAddressId,
    this.totalAmount,
    this.taxAmount,
    this.deliveryCharge,
    this.currencyCode,
    this.countryCode,
    this.couponCode,
    this.discountAmount,
    this.discountType,
    this.originalTotal,
    this.paymentStatus,
    this.deliveryStatus,
    this.estimatedDeliveryDate,
    this.actualDeliveryDate,
    this.trackingNumber,
    this.deliveryNotes,
    this.isDeliveryConfirmed = false,
    this.deliveryConfirmedAt,
    this.updatedAt,
    this.subscriptionDetails = const [],
    this.payment,
    this.deliveryHistory = const [],
    this.isReturnSubmitted = false,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    final orderId = ParserUtils.readString(
      map['id'] ?? map['orderId'] ?? map['order_id'],
    );
    final items = (map['items'] as List? ?? [])
        .map((e) => OrderItemApiModel.fromMap(ParserUtils.readMap(e)))
        .toList(growable: false);

    return OrderModel(
      orderId: orderId,
      orderNumber: ParserUtils.readString(
        map['orderNumber'] ?? map['order_number'],
      ),
      status: ParserUtils.readString(map['status'], def: 'pending'),
      orderType: ParserUtils.readNullableString(map['orderType']),
      userId: ParserUtils.readNullableString(map['userId'] ?? map['user_id']),
      shippingAddressId: ParserUtils.readNullableString(
        map['shippingAddressId'] ?? map['shipping_address_id'],
      ),
      totalAmount: ParserUtils.readNullableString(map['totalAmount']),
      taxAmount: ParserUtils.readNullableString(map['taxAmount']),
      deliveryCharge: ParserUtils.readNullableString(map['deliveryCharge']),
      currencyCode: ParserUtils.readNullableString(map['currencyCode']),
      countryCode: ParserUtils.readNullableString(map['countryCode']),
      couponCode: ParserUtils.readNullableString(map['couponCode']),
      discountAmount: ParserUtils.readNullableString(map['discountAmount']),
      discountType: ParserUtils.readNullableString(map['discountType']),
      originalTotal: ParserUtils.readNullableString(map['originalTotal']),
      paymentStatus: ParserUtils.readNullableString(map['paymentStatus']),
      deliveryStatus: ParserUtils.readNullableString(map['deliveryStatus']),
      estimatedDeliveryDate: ParserUtils.readNullableString(
        map['estimatedDeliveryDate'],
      ),
      actualDeliveryDate: ParserUtils.readNullableString(
        map['actualDeliveryDate'],
      ),
      trackingNumber: ParserUtils.readNullableString(map['trackingNumber']),
      deliveryNotes: ParserUtils.readNullableString(map['deliveryNotes']),
      isDeliveryConfirmed: ParserUtils.readBool(map['isDeliveryConfirmed']),
      deliveryConfirmedAt: ParserUtils.readNullableString(
        map['deliveryConfirmedAt'],
      ),
      createdAt: ParserUtils.readNullableString(
        map['createdAt'] ?? map['created_at'],
      ),
      updatedAt: ParserUtils.readNullableString(map['updatedAt']),
      subscriptionDetails: _readMapList(
        map['subscriptionDetails'] ?? map['subscription_details'],
      ),
      items: items,
      payment: map['payment'] != null
          ? ParserUtils.readMap(map['payment'])
          : null,
      deliveryHistory: _readMapList(
        map['deliveryHistory'] ?? map['delivery_history'],
      ),
      isReturnSubmitted: ParserUtils.readBool(map['isReturnSubmitted']),
    );
  }

  static List<Map<String, dynamic>> _readMapList(dynamic value) {
    if (value is List) {
      return value.map(ParserUtils.readMap).toList(growable: false);
    }

    return const [];
  }
}
