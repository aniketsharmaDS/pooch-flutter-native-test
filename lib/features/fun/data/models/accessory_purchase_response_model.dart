import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/fun/data/models/accessory_pricing_models.dart';

class AccessoryPurchaseOrderModel {
  const AccessoryPurchaseOrderModel({
    required this.id,
    required this.orderNumber,
    required this.totalAmount,
    required this.paymentStatus,
  });

  final String id;
  final String orderNumber;
  final double totalAmount;
  final String paymentStatus;

  factory AccessoryPurchaseOrderModel.fromMap(Map<String, dynamic> map) {
    return AccessoryPurchaseOrderModel(
      id: ParserUtils.readString(map['id']),
      orderNumber: ParserUtils.readString(map['orderNumber']),
      totalAmount: ParserUtils.readDouble(map['totalAmount']),
      paymentStatus: ParserUtils.readString(map['paymentStatus']),
    );
  }
}

class AccessoryPurchaseResponseModel {
  const AccessoryPurchaseResponseModel({
    required this.order,
    required this.accessory,
    required this.quantity,
    required this.pricing,
    required this.pointsAwarded,
  });

  final AccessoryPurchaseOrderModel order;
  final AccessorySummaryModel accessory;
  final int quantity;
  final AccessoryPricingModel pricing;
  final int pointsAwarded;

  factory AccessoryPurchaseResponseModel.fromMap(Map<String, dynamic> map) {
    return AccessoryPurchaseResponseModel(
      order: AccessoryPurchaseOrderModel.fromMap(
        ParserUtils.readMap(map['order']),
      ),
      accessory: AccessorySummaryModel.fromMap(
        ParserUtils.readMap(map['accessory']),
      ),
      quantity: ParserUtils.readInt(map['quantity']),
      pricing: AccessoryPricingModel.fromMap(
        ParserUtils.readMap(map['pricing']),
      ),
      pointsAwarded: ParserUtils.readInt(map['pointsAwarded']),
    );
  }
}
