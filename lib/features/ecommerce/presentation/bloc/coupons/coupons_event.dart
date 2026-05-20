import 'package:equatable/equatable.dart';
import 'package:poochcare/features/ecommerce/data/models/coupon/apply_coupon_response.dart';
import 'package:poochcare/features/fun/data/models/accessory_booking_summary_response_model.dart';

sealed class CouponsEvent extends Equatable {
  const CouponsEvent();

  @override
  List<Object?> get props => [];
}

class FetchCouponsEvent extends CouponsEvent {
  final int page;

  const FetchCouponsEvent({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class ApplyCouponEvent extends CouponsEvent {
  final String couponCode;

  const ApplyCouponEvent(this.couponCode);

  @override
  List<Object?> get props => [couponCode];
}

class ApplyAccessoryCouponEvent extends CouponsEvent {
  final String couponCode;
  final String accessoryId;
  final String petId;
  final String country;

  const ApplyAccessoryCouponEvent(
    this.couponCode,
    this.accessoryId,
    this.country,
    this.petId,
  );

  @override
  List<Object?> get props => [couponCode, accessoryId, country, petId];
}

class RemoveCouponEvent extends CouponsEvent {
  final String couponCode;

  const RemoveCouponEvent(this.couponCode);

  @override
  List<Object?> get props => [couponCode];
}

class ResetCouponsEvent extends CouponsEvent {
  const ResetCouponsEvent();
}

class ApplyCouponLocally extends CouponsEvent {
  final ApplyCouponResponse applyCouponResponse;
  final String couponCode;
  const ApplyCouponLocally(this.applyCouponResponse, this.couponCode);

  @override
  List<Object?> get props => [applyCouponResponse, couponCode];
}

class ApplyAccessoryCouponLocally extends CouponsEvent {
  final AccessoryBookingCouponModel? applyCouponResponse;
  final String couponCode;
  const ApplyAccessoryCouponLocally(this.applyCouponResponse, this.couponCode);

  @override
  List<Object?> get props => [applyCouponResponse, couponCode];
}

class RemoveCouponLocallyEvent extends CouponsEvent {
  const RemoveCouponLocallyEvent();
}
