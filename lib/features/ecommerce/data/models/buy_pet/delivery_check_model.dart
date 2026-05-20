import 'package:poochcare/core/utils/parser_utils.dart';

class DeliveryCheckModel {
  const DeliveryCheckModel({
    required this.productId,
    required this.pincode,
    required this.isDeliverable,
    required this.reason,
    required this.deliveryType,
    required this.maxDistance,
    required this.distanceValue,
    required this.distanceUnit,
    required this.pincodeAddress,
  });

  final String productId;
  final String pincode;
  final bool isDeliverable;
  final String reason;
  final String deliveryType;
  final double? maxDistance;
  final double? distanceValue;
  final String distanceUnit;
  final String pincodeAddress;

  factory DeliveryCheckModel.fromMap(Map<String, dynamic> map) {
    final delivery = ParserUtils.readMap(
      map['delivery'] ?? map['deliveryInfo'],
    );
    final distance = ParserUtils.readMap(map['distance']);
    final location = ParserUtils.readMap(
      map['pincodeLocation'] ?? map['pincode_location'],
    );

    return DeliveryCheckModel(
      productId: ParserUtils.readString(map['productId'] ?? map['product_id']),
      pincode: ParserUtils.readString(map['pincode']),
      isDeliverable: ParserUtils.readBool(
        delivery['isDeliverable'] ?? delivery['deliverable'],
      ),
      reason: ParserUtils.readString(delivery['reason']),
      deliveryType: ParserUtils.readString(
        delivery['deliveryType'] ?? delivery['delivery_type'],
      ),
      maxDistance: ParserUtils.readNullableDouble(
        delivery['maxDistance'] ?? delivery['max_distance'],
      ),
      distanceValue: ParserUtils.readNullableDouble(
        distance['value'] ?? distance['distance'],
      ),
      distanceUnit: ParserUtils.readString(distance['unit']),
      pincodeAddress: ParserUtils.readString(location['address']),
    );
  }
}
