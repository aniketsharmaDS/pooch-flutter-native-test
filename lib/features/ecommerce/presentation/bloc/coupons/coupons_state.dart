import 'package:equatable/equatable.dart';
import 'package:poochcare/features/ecommerce/data/models/coupon/apply_coupon_response.dart';
import 'package:poochcare/features/ecommerce/data/models/coupon/coupon_model.dart';
import 'package:poochcare/features/fun/data/models/accessory_booking_summary_response_model.dart';

enum CouponsStatus { initial, loading, success, failure }

class CouponsState extends Equatable {
  final CouponsStatus status;
  final List<Coupon> coupons;
  final ApplyCouponResponse? applyCouponResponse;
  final String? errorMessage;
  final String? successMessage;
  final int actionId;
  final String? applyingCouponCodeInCart;
  final String? appliedCouponCodeInCart;
  final String? applyingCouponCodeInAccessory;
  final String? appliedCouponCodeInAccessory;
  final AccessoryBookingCouponModel? accessoryCouponResponse;

  const CouponsState({
    this.status = CouponsStatus.initial,
    this.coupons = const [],
    this.applyCouponResponse,
    this.errorMessage,
    this.successMessage,
    this.actionId = 0,
    this.applyingCouponCodeInCart,
    this.appliedCouponCodeInCart,
    this.appliedCouponCodeInAccessory,
    this.applyingCouponCodeInAccessory,
    this.accessoryCouponResponse,
  });

  CouponsState copyWith({
    CouponsStatus? status,
    List<Coupon>? coupons,
    ApplyCouponResponse? applyCouponResponse,
    String? errorMessage,
    String? successMessage,
    int? actionId,
    String? applyingCouponCodeInCart,
    String? appliedCouponCodeInCart,
    bool clearApplyCouponResponse = false,
    String? appliedCouponCodeInAccessory,
    String? applyingCouponCodeInAccessory,
    AccessoryBookingCouponModel? accessoryCouponResponse,
  }) {
    return CouponsState(
      accessoryCouponResponse:
          accessoryCouponResponse ?? this.accessoryCouponResponse,
      status: status ?? this.status,
      coupons: coupons ?? this.coupons,
      applyCouponResponse: clearApplyCouponResponse
          ? null
          : (applyCouponResponse ?? this.applyCouponResponse),
      errorMessage: errorMessage,
      successMessage: successMessage,
      actionId: actionId ?? this.actionId,
      applyingCouponCodeInCart: applyingCouponCodeInCart,
      appliedCouponCodeInCart:
          appliedCouponCodeInCart ?? this.appliedCouponCodeInCart,
      appliedCouponCodeInAccessory: appliedCouponCodeInAccessory,
      applyingCouponCodeInAccessory:
          applyingCouponCodeInAccessory ?? this.applyingCouponCodeInAccessory,
    );
  }

  @override
  List<Object?> get props => [
    status,
    coupons,
    applyCouponResponse,
    errorMessage,
    successMessage,
    actionId,
    applyingCouponCodeInCart,
    appliedCouponCodeInCart,
    applyingCouponCodeInAccessory,
    appliedCouponCodeInAccessory,
    accessoryCouponResponse,
  ];
}
