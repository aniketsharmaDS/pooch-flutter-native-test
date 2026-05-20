import 'package:equatable/equatable.dart';
import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/fun/data/models/accessory_pricing_models.dart';

class AccessoryDeliveryInfoModel {
  const AccessoryDeliveryInfoModel({required this.type});

  final String type;

  factory AccessoryDeliveryInfoModel.fromMap(Map<String, dynamic> map) {
    return AccessoryDeliveryInfoModel(
      type: ParserUtils.readString(map['type']),
    );
  }
}

class AccessoryBookingCouponModel extends Equatable {
  const AccessoryBookingCouponModel({
    required this.code,
    required this.discountType,
    required this.discountValue,
    required this.appliedDiscount,
  });

  final String code;
  final String discountType;
  final String discountValue;
  final double appliedDiscount;

  factory AccessoryBookingCouponModel.fromMap(Map<String, dynamic> map) {
    return AccessoryBookingCouponModel(
      code: ParserUtils.readString(map['code']),
      discountType: ParserUtils.readString(map['discountType']),
      discountValue: ParserUtils.readString(map['discountValue']),
      appliedDiscount: ParserUtils.readDouble(map['appliedDiscount']),
    );
  }

  @override
  List<Object?> get props => [
    code,
    discountType,
    discountValue,
    appliedDiscount,
  ];
}

class AccessoryBookingSummaryModel {
  const AccessoryBookingSummaryModel({
    required this.accessory,
    required this.quantity,
    required this.pricing,
    required this.coupon,
    required this.deliveryInfo,
  });

  final AccessorySummaryModel accessory;
  final int quantity;
  final AccessoryPricingModel pricing;
  final AccessoryBookingCouponModel coupon;
  final AccessoryDeliveryInfoModel deliveryInfo;

  factory AccessoryBookingSummaryModel.fromMap(Map<String, dynamic> map) {
    return AccessoryBookingSummaryModel(
      accessory: AccessorySummaryModel.fromMap(
        ParserUtils.readMap(map['accessory']),
      ),
      quantity: ParserUtils.readInt(map['quantity']),
      pricing: AccessoryPricingModel.fromMap(
        ParserUtils.readMap(map['pricing']),
      ),
      coupon: AccessoryBookingCouponModel.fromMap(
        ParserUtils.readMap(map['coupon']),
      ),
      deliveryInfo: AccessoryDeliveryInfoModel.fromMap(
        ParserUtils.readMap(map['deliveryInfo']),
      ),
    );
  }
}
