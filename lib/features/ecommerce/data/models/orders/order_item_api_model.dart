import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/ecommerce/data/models/buy_pet/product_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_pricing_model.dart';

class OrderItemApiModel {
  final String id;

  final String productName;
  final String price;
  final int quantity;
  final int taxAmount;
  final String currencyCode;
  final String? productImage;
  final String? status;
  final String? deliveryOtp;
  final String? cancellationStatus;
  final String? cancellationReason;
  final ProductModel? product;
  final List<ItemDeliveryHistoryModel>? itemDeliveryHistory;
  final OrderItemPricingModel? pricing;

  const OrderItemApiModel({
    required this.id,
    required this.productName,
    required this.price,

    required this.quantity,
    required this.taxAmount,
    required this.currencyCode,
    this.productImage,
    this.product,
    this.status,
    this.deliveryOtp,
    this.cancellationStatus,
    this.cancellationReason,
    this.itemDeliveryHistory,
    this.pricing,
  });

  factory OrderItemApiModel.fromMap(Map<String, dynamic> map) {
    return OrderItemApiModel(
      id: ParserUtils.readString(map['id']),
      productName: ParserUtils.readString(map['productName']),
      price: ParserUtils.readString(map['price'], def: '0'),
      quantity: ParserUtils.readInt(map['quantity']),
      taxAmount: ParserUtils.readInt(map['taxAmount']),
      currencyCode: ParserUtils.readString(map['currencyCode']),
      cancellationStatus: ParserUtils.readString(map['cancellationStatus']),
      cancellationReason: ParserUtils.readString(map['cancellationReason']),
      deliveryOtp: ParserUtils.readString(map['deliveryOtp']),

      productImage: ParserUtils.readString(map['productImage']),
      status: ParserUtils.readString(map['status']),
      product: map['product'] != null
          ? ProductModel.fromMap(ParserUtils.readMap(map['product']))
          : null,
      itemDeliveryHistory: (map['itemDeliveryHistory'] as List? ?? [])
          .map(
            (e) => ItemDeliveryHistoryModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      pricing: map['pricing'] != null
          ? OrderItemPricingModel.fromMap(ParserUtils.readMap(map['pricing']))
          : null,
    );
  }
}
