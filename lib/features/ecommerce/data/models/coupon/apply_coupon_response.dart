import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'apply_coupon_response.mapper.dart';

@MappableClass()
class ApplyCouponResponse with ApplyCouponResponseMappable {
  const ApplyCouponResponse({
    this.subtotal,
    this.discount,
    this.finalTotal,
    this.discountBreakdown,
  });

  factory ApplyCouponResponse.fromJson(Map<String, dynamic> json) =>
      ApplyCouponResponseMapper.fromMap(json);

  final double? subtotal;
  final double? discount;
  final double? finalTotal;
  final DiscountBreakdown? discountBreakdown;
}

@MappableClass()
class DiscountBreakdown with DiscountBreakdownMappable {
  const DiscountBreakdown({
    this.type,
    this.value,
    this.applied,
    this.itemDiscounts,
  });

  factory DiscountBreakdown.fromJson(Map<String, dynamic> json) =>
      DiscountBreakdownMapper.fromMap(json);

  final String? type;
  final double? value;
  final double? applied;
  final List<ItemDiscount>? itemDiscounts;
}

@MappableClass()
class ItemDiscount with ItemDiscountMappable {
  const ItemDiscount({
    this.productId,
    this.originalPrice,
    this.discountAmount,
    this.finalPrice,
  });

  factory ItemDiscount.fromJson(Map<String, dynamic> json) =>
      ItemDiscountMapper.fromMap(json);

  @MappableField(hook: SafeStringHook())
  final String? productId;
  final double? originalPrice;
  final double? discountAmount;
  final double? finalPrice;
}
