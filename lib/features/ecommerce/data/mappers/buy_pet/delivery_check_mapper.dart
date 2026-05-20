import 'package:poochcare/features/ecommerce/data/models/buy_pet/delivery_check_model.dart';
import 'package:poochcare/features/ecommerce/domain/models/delivery_check.dart';

class DeliveryCheckMapper {
  const DeliveryCheckMapper._();

  static DeliveryCheck toDomain(DeliveryCheckModel model) {
    return DeliveryCheck(
      productId: model.productId,
      pincode: model.pincode,
      isDeliverable: model.isDeliverable,
      reason: model.reason,
      deliveryType: model.deliveryType,
      maxDistance: model.maxDistance,
      distanceValue: model.distanceValue,
      distanceUnit: model.distanceUnit,
      pincodeAddress: model.pincodeAddress,
    );
  }
}
