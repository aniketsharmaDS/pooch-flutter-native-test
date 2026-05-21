import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/core/errors/error_handler.dart';
import 'package:poochcare/core/errors/error_mapper.dart';
import 'package:poochcare/core/errors/failure.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/ecommerce/data/models/address/address_model.dart';
import 'package:poochcare/features/ecommerce/data/models/cart/cart_item_model.dart';
import 'package:poochcare/features/ecommerce/data/models/coupon/apply_coupon_response.dart';
import 'package:poochcare/features/ecommerce/data/models/coupon/coupon_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/place_order_model.dart';
import 'package:poochcare/features/invites/data/models/invite_action_api_result.dart';

class CartApiService {
  const CartApiService(this._dio);

  final Dio _dio;

  static const String _cartPath = '/cart';
  static const String _cartCountPath = '/cart/count';
  static const String _cartAddPath = '/cart/add';
  static const String _cartRemovePath = '/cart/remove';
  static const String _couponsPath = '/coupons';
  static const String _addressesPath = '/addresses';
  static const String _applyCouponPath = '/coupon-cart/apply-coupon';
  static const String _removeCouponPath = '/coupon-cart/remove-coupon';
  static const String _placeOrderPath = '/orders/place-order';

  /// Get cart items
  Future<CartData> getCart() async {
    try {
      final response = await _dio.get<dynamic>(_cartPath);
      final payload = _unwrapEnvelope(response.data);

      return CartData.fromJson(payload as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  /// Get cart item count
  Future<Either<Failure, int>> getCartCount() async {
    try {
      final response = await _dio.get<dynamic>(_cartCountPath);
      final payload = _unwrapEnvelope(response.data);

      // return Either.right((payload['count'] as int?) ?? 0);
      if (payload is int) {
        return Either.right(payload);
      }

      if (payload is Map<String, dynamic>) {
        return Either.right((payload['count'] as int?) ?? 0);
      }

      return Either.right(0);
    } on DioException catch (e) {
      return Either.left(ErrorHandler.handleDioError(e));
    } catch (e) {
      return Either.left(UnknownFailure(e.toString()));
    }
  }

  /// Add items to cart
  Future<CartOrderSummary> addToCart(List<String> productIds) async {
    try {
      final response = await _dio.post<dynamic>(
        _cartAddPath,
        data: {'product_ids': productIds},
      );
      final payload = _unwrapEnvelope(response.data);

      return CartOrderSummary.fromJson(
        payload['order_summary'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  /// Remove item from cart
  Future<CartOrderSummary> removeFromCart(String productId) async {
    try {
      final response = await _dio.delete<dynamic>(
        '$_cartRemovePath/$productId',
      );
      final payload = _unwrapEnvelope(response.data);

      return CartOrderSummary.fromJson(
        payload['order_summary'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  /// Get available coupons
  Future<List<Coupon>> getCoupons({int page = 1, String? couponsType}) async {
    try {
      final response = await _dio.get<dynamic>(
        _couponsPath,
        queryParameters: {'page': page, 'targetProductTypes': ?couponsType},
      );
      final payload = _unwrapEnvelope(response.data);
      final couponsList = payload['coupons'] as List<dynamic>?;

      return couponsList
              ?.map((e) => Coupon.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  /// Apply coupon to cart
  Future<ApplyCouponResponse> applyCoupon(String couponCode) async {
    try {
      final response = await _dio.post<dynamic>(
        _applyCouponPath,
        data: {'couponCode': couponCode},
      );
      final payload = _unwrapEnvelope(response.data);

      return ApplyCouponResponse.fromJson(payload as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  /// Remove coupon from cart
  Future<InviteActionApiResult> removeCoupon(String couponCode) async {
    try {
      final response = await _dio.post<dynamic>(
        _removeCouponPath,
        data: {'couponCode': couponCode},
      );
      final body = response.data as Map<String, dynamic>;

      return InviteActionApiResult(
        success: (body['success'] as bool?) ?? false,
        status: (body['status'] as int?) ?? 200,
        message: (body['message'] as String?) ?? '',
      );
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  /// Get all addresses
  Future<List<Address>> getAddresses() async {
    try {
      final response = await _dio.get<dynamic>(_addressesPath);
      final payload = _unwrapEnvelope(response.data);

      if (payload is! List) return [];
      return payload
          .map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  /// Create new address
  Future<Address> createAddress(CreateAddressRequest request) async {
    try {
      final response = await _dio.post<dynamic>(
        _addressesPath,
        data: {
          'address_line': request.addressLine,
          'address_details': request.addressDetails,
          'pincode': request.pincode,
          'emirate': request.emirate,
          'city': request.city,
          'country': request.country,
          'latitude': request.latitude,
          'longitude': request.longitude,
          'resident_name': request.residentName,
          'resident_phone': request.residentPhone,
          'address_type': request.addressType,
        },
      );
      final payload = _unwrapEnvelope(response.data);

      return Address.fromJson(payload as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  /// Update address
  Future<Address> updateAddress(
    String addressId,
    UpdateAddressRequest request,
  ) async {
    try {
      final response = await _dio.put<dynamic>(
        '$_addressesPath/$addressId',
        data: {
          'address_line': request.addressLine,
          'address_details': request.addressDetails,
          'pincode': request.pincode,
          'emirate': request.emirate,
          'city': request.city,
          'country': request.country,
          'latitude': request.latitude,
          'longitude': request.longitude,
          'resident_name': request.residentName,
          'resident_phone': request.residentPhone,
          'address_type': request.addressType,
        },
      );
      final payload = _unwrapEnvelope(response.data);

      return Address.fromJson(payload as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  /// Delete address
  Future<DeleteAddressResponse> deleteAddress(String addressId) async {
    try {
      final response = await _dio.delete<dynamic>('$_addressesPath/$addressId');
      final payload = _unwrapEnvelope(response.data);

      return DeleteAddressResponse.fromJson(payload as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  Future<void> makeAddressPrimary({required String addressId}) async {
    try {
      await _dio.patch<dynamic>('$_addressesPath/$addressId/primary');
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  /// Place order from cart
  Future<PlaceOrderData> placeOrder(PlaceOrderRequest request) async {
    try {
      final response = await _dio.post<dynamic>(
        _placeOrderPath,
        data: request.toMap(),
      );
      final payload = _unwrapEnvelope(response.data);

      return PlaceOrderData.fromMap(payload as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  // Helper Methods for clean code

  dynamic _unwrapEnvelope(dynamic body) {
    if (body is! Map<String, dynamic>) return body;

    final ApiResponse? envelope =
        body.containsKey('success') && body.containsKey('data')
        ? ApiResponseMapper.fromMap(body)
        : null;

    if (envelope != null && !envelope.success) {
      throw ApiException(
        envelope.message.isNotEmpty
            ? envelope.message
            : 'Unable to fetch products',
        code: 'API_ERROR',
        statusCode: envelope.status,
      );
    }

    return envelope?.data ?? body;
  }
}
