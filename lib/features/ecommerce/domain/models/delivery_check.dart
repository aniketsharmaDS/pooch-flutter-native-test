import 'package:equatable/equatable.dart';

class DeliveryCheck extends Equatable {
  const DeliveryCheck({
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

  @override
  List<Object?> get props => <Object?>[
    productId,
    pincode,
    isDeliverable,
    reason,
    deliveryType,
    maxDistance,
    distanceValue,
    distanceUnit,
    pincodeAddress,
  ];
}
