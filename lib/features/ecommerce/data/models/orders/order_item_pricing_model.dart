import 'package:poochcare/core/utils/parser_utils.dart';

class OrderItemPricingModel {
  final int basePrice;
  final int quantity;
  final int itemSubtotal;
  final int taxAmount;
  final double deliveryFee;
  final double discountAmount;
  final double originalAmount;
  final double finalPrice;

  const OrderItemPricingModel({
    required this.basePrice,
    required this.quantity,
    required this.itemSubtotal,
    required this.taxAmount,
    required this.deliveryFee,
    required this.discountAmount,
    required this.originalAmount,
    required this.finalPrice,
  });

  factory OrderItemPricingModel.fromMap(Map<String, dynamic> map) {
    return OrderItemPricingModel(
      basePrice: ParserUtils.readInt(map['basePrice']),
      quantity: ParserUtils.readInt(map['quantity']),
      itemSubtotal: ParserUtils.readInt(map['itemSubtotal']),
      taxAmount: ParserUtils.readInt(map['taxAmount']),
      deliveryFee: ParserUtils.readDouble(map['deliveryFee']),
      discountAmount: ParserUtils.readDouble(map['discountAmount']),
      originalAmount: ParserUtils.readDouble(map['originalAmount']),
      finalPrice: ParserUtils.readDouble(map['finalPrice']),
    );
  }

  void operator [](String other) {}
}
