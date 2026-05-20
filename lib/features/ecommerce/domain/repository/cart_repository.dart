import 'package:poochcare/features/ecommerce/data/models/address/address_model.dart';
import 'package:poochcare/features/ecommerce/data/models/cart/cart_item_model.dart';
import 'package:poochcare/features/ecommerce/data/models/coupon/apply_coupon_response.dart';
import 'package:poochcare/features/ecommerce/data/models/coupon/coupon_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/place_order_model.dart';
import 'package:poochcare/features/invites/data/models/invite_action_api_result.dart';

abstract class CartRepository {
  Future<CartData> getCart();
  Future<int> getCartCount();
  Future<CartOrderSummary> addToCart(List<String> productIds);
  Future<CartOrderSummary> removeFromCart(String productId);
  Future<List<Coupon>> getCoupons({int page = 1, String? couponsType});
  Future<ApplyCouponResponse> applyCoupon(String couponCode);
  Future<InviteActionApiResult> removeCoupon(String couponCode);
  Future<PlaceOrderData> placeOrder(PlaceOrderRequest request);
  Future<List<Address>> getAddresses();
  Future<Address> createAddress(CreateAddressRequest request);
  Future<Address> updateAddress(String addressId, UpdateAddressRequest request);
  Future<void> deleteAddress(String addressId);
  Future<void> makeAddressPrimary(String addressId);
}
