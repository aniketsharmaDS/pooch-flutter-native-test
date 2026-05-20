import 'package:poochcare/features/ecommerce/data/api/cart_api_service.dart';
import 'package:poochcare/features/ecommerce/data/models/address/address_model.dart';
import 'package:poochcare/features/ecommerce/data/models/cart/cart_item_model.dart';
import 'package:poochcare/features/ecommerce/data/models/coupon/apply_coupon_response.dart';
import 'package:poochcare/features/ecommerce/data/models/coupon/coupon_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/place_order_model.dart';
import 'package:poochcare/features/ecommerce/domain/repository/cart_repository.dart';
import 'package:poochcare/features/invites/data/models/invite_action_api_result.dart';

class CartRepositoryImpl implements CartRepository {
  final CartApiService _cartApiService;

  CartRepositoryImpl(this._cartApiService);

  @override
  Future<CartData> getCart() async {
    return await _cartApiService.getCart();
  }

  @override
  Future<int> getCartCount() async {
    return await _cartApiService.getCartCount();
  }

  @override
  Future<CartOrderSummary> addToCart(List<String> productIds) async {
    return await _cartApiService.addToCart(productIds);
  }

  @override
  Future<CartOrderSummary> removeFromCart(String productId) async {
    return await _cartApiService.removeFromCart(productId);
  }

  @override
  Future<List<Coupon>> getCoupons({int page = 1, String? couponsType}) async {
    return await _cartApiService.getCoupons(
      page: page,
      couponsType: couponsType,
    );
  }

  @override
  Future<ApplyCouponResponse> applyCoupon(String couponCode) async {
    return await _cartApiService.applyCoupon(couponCode);
  }

  @override
  Future<InviteActionApiResult> removeCoupon(String couponCode) async {
    return await _cartApiService.removeCoupon(couponCode);
  }

  @override
  Future<PlaceOrderData> placeOrder(PlaceOrderRequest request) async {
    return await _cartApiService.placeOrder(request);
  }

  @override
  Future<List<Address>> getAddresses() async {
    return await _cartApiService.getAddresses();
  }

  @override
  Future<Address> createAddress(CreateAddressRequest request) async {
    return await _cartApiService.createAddress(request);
  }

  @override
  Future<Address> updateAddress(
    String addressId,
    UpdateAddressRequest request,
  ) async {
    return await _cartApiService.updateAddress(addressId, request);
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    await _cartApiService.deleteAddress(addressId);
  }

  @override
  Future<void> makeAddressPrimary(String addressId) async {
    await _cartApiService.makeAddressPrimary(addressId: addressId);
  }
}
