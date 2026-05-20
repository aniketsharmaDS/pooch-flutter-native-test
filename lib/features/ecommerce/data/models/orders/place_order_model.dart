import 'package:poochcare/core/utils/parser_utils.dart';

class PlaceOrderRequest {
  final String type;
  final String shippingAddressId;
  final String paymentMethod;
  final List<PlaceOrderItemRequest> items;
  final String? couponCode;
  final String? productId;

  const PlaceOrderRequest({
    required this.type,
    required this.shippingAddressId,
    required this.paymentMethod,
    required this.items,
    required this.couponCode,
    this.productId,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'shipping_address_id': shippingAddressId,
      'payment_method': paymentMethod,
      'items': items.map((item) => item.toMap()).toList(growable: false),
      'couponCode': couponCode,
      if (productId != null) 'product_id': productId,
    };
  }
}

class PlaceOrderItemRequest {
  final String id;
  final String productType;
  final String productId;
  final String productName;
  final String price;
  final int quantity;
  final double taxAmount;

  const PlaceOrderItemRequest({
    required this.id,
    required this.productType,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.taxAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productType': productType,
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'taxAmount': taxAmount,
    };
  }
}

class PlaceOrderResponse {
  final PlaceOrderData data;
  final String message;
  final int status;
  final bool success;

  const PlaceOrderResponse({
    required this.data,
    required this.message,
    required this.status,
    required this.success,
  });

  factory PlaceOrderResponse.fromMap(Map<String, dynamic> map) {
    return PlaceOrderResponse(
      data: PlaceOrderData.fromMap(ParserUtils.readMap(map['data'])),
      message: ParserUtils.readString(map['message']),
      status: ParserUtils.readInt(map['status']),
      success: ParserUtils.readBool(map['success']),
    );
  }
}

class PlaceOrderData {
  final String orderId;
  final String orderNumber;
  final String orderType;
  final String shippingAddressId;
  final double totalAmount;
  final String paymentMethod;
  final String status;

  const PlaceOrderData({
    required this.orderId,
    required this.orderNumber,
    required this.orderType,
    required this.shippingAddressId,
    required this.totalAmount,
    required this.paymentMethod,
    required this.status,
  });

  factory PlaceOrderData.fromMap(Map<String, dynamic> map) {
    return PlaceOrderData(
      orderId: ParserUtils.readString(map['orderId']),
      orderNumber: ParserUtils.readString(map['orderNumber']),
      orderType: ParserUtils.readString(map['orderType']),
      shippingAddressId: ParserUtils.readString(map['shippingAddressId']),
      totalAmount: ParserUtils.readDouble(map['totalAmount']),
      paymentMethod: ParserUtils.readString(map['paymentMethod']),
      status: ParserUtils.readString(map['status']),
    );
  }
}
