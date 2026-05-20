import 'package:dio/dio.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/core/errors/error_mapper.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/ecommerce/data/models/buy_pet/delivery_check_model.dart';
import 'package:poochcare/features/ecommerce/data/models/buy_pet/product_detail_model.dart';
import 'package:poochcare/features/ecommerce/data/models/buy_pet/product_filters_model.dart';
import 'package:poochcare/features/ecommerce/data/models/buy_pet/product_response_model.dart';

class BuyPetApiService {
  const BuyPetApiService(this._dio);

  final Dio _dio;

  static const String _productsPath = '/products';

  static const String _recentlyViewedPath = '/products/recently-viewed';
  static const String _popularPath = '/products/popular';
  static const String _featuredPath = '/products/featured';
  static const String _checkDeliveryPath = '/products/check-delivery';
  static const String _productFilters = 'products/browse/filters';

  static const String _wishlistAdd = '/wishlist/add';
  static const String _wishlistRemove = '/wishlist';
  static const String _wishlistGet = '/wishlist';
  static const String _wishlistCount = '/wishlist/count';

  Future<ProductResponseModel> getAllProducts({
    required int page,
    String? petType,
    String? search,
    String? sortBy,
    String? sortOrder,
    List<String>? gender,
    List<String>? breed,
    String? size,
    List<String>? lifeStage,
    List<String>? energyLevel,
    List<String>? grooming,
    List<String>? temperament,
    List<String>? subcategory,
    List<String>? allergy,
    String? couponCode,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        _productsPath,
        queryParameters: <String, dynamic>{'page': page},
        data: <String, dynamic>{
          if (petType != null && petType.trim().isNotEmpty)
            'petType': petType.trim(),

          if (search != null && search.trim().isNotEmpty)
            'search': search.trim(),

          if (sortBy != null && sortBy.trim().isNotEmpty)
            'sortBy': sortBy.trim(),

          if (sortOrder != null && sortOrder.trim().isNotEmpty)
            'sortOrder': sortOrder.trim(),

          if (gender != null && gender.isNotEmpty) 'gender': gender,

          if (size != null && size.trim().isNotEmpty) 'size': size,

          if (breed != null && breed.isNotEmpty) 'breed': breed,

          if (lifeStage != null && lifeStage.isNotEmpty) 'lifeStage': lifeStage,

          if (energyLevel != null && energyLevel.isNotEmpty)
            'energyLevel': energyLevel,

          if (grooming != null && grooming.isNotEmpty) 'grooming': grooming,

          if (temperament != null && temperament.isNotEmpty)
            'temperament': temperament,

          if (subcategory != null && subcategory.isNotEmpty)
            'subcategory': subcategory,

          if (allergy != null && allergy.isNotEmpty) 'allergy': allergy,

          if (couponCode != null && couponCode.trim().isNotEmpty)
            'couponCode': couponCode.trim(),

          // 'couponCode': couponCode ?? '',
          // if (couponCode != null && couponCode.trim().isNotEmpty)
          // 'couponCode': couponCode.trim(),
        },
      );

      final dynamic body = response.data;
      if (body is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

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

      final dynamic payload = envelope?.data ?? body;
      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return ProductResponseModel.fromMap(payload);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<ProductResponseModel> getRecentlyViewedProducts({
    required int page,
    String? search,
  }) async {
    final Response response = await _dio.get(
      _recentlyViewedPath,
      queryParameters: {'page': page, 'search': search},
    );

    final payload = _unwrapEnvelope(response.data);

    if (payload is! Map<String, dynamic>) {
      throw const ApiException('Invalid server response', statusCode: 500);
    }

    return ProductResponseModel.fromMap(payload);
  }

  Future<ProductResponseModel> getPopularProducts({
    required int page,
    String? search,
  }) async {
    final Response response = await _dio.get(
      _popularPath,
      queryParameters: {'page': page, 'search': search},
    );

    final dynamic payload = _unwrapEnvelope(response.data);

    if (payload is! Map<String, dynamic>) {
      throw const ApiException('Invalid server response', statusCode: 500);
    }

    return ProductResponseModel.fromMap(payload);
  }

  Future<ProductResponseModel> getFeaturedProducts({
    required int page,
    String? search,
    required String petType,
  }) async {
    final Response response = await _dio.get(
      _featuredPath,
      queryParameters: {'page': page, 'petType': petType, 'search': search},
    );

    final dynamic payload = _unwrapEnvelope(response.data);

    if (payload is! Map<String, dynamic>) {
      throw const ApiException('Invalid server response', statusCode: 500);
    }

    return ProductResponseModel.fromMap(payload);
  }

  Future<ProductDetailModel> getProductDetail({
    required String productId,
  }) async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        '$_productsPath/$productId',
      );

      final dynamic body = response.data;
      final dynamic payload = _unwrapEnvelope(body);
      final Map<String, dynamic>? map = _asMap(payload);

      if (map == null) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return ProductDetailModel.fromMap(map);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<DeliveryCheckModel> checkDelivery({
    required String productId,
    required String pincode,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        _checkDeliveryPath,
        data: <String, dynamic>{'productId': productId, 'pincode': pincode},
      );

      final dynamic body = response.data;
      final dynamic payload = _unwrapEnvelope(body);
      final Map<String, dynamic>? map = _asMap(payload);

      if (map == null) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return DeliveryCheckModel.fromMap(map);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<ProductFilters> getProductFilters(String petType) async {
    try {
      final Response<dynamic> response = await _dio.get(
        _productFilters,
        queryParameters: <String, dynamic>{'petType': petType},
      );

      final dynamic body = response.data;
      final dynamic payload = _unwrapEnvelope(body);

      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return ProductFilters.fromJson(payload);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  // Wishlist APIs

  // Add to wishlist using product ID (returns wishlist item ID)
  Future<dynamic> addToWishlist(String productId) async {
    try {
      final response = await _dio.post<dynamic>(
        _wishlistAdd,
        data: {'productId': productId},
      );

      final payload = _unwrapEnvelope(response.data);
      return payload;
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  // Remove from wishlist using wishlist item ID (not product ID)
  Future<void> removeFromWishlist(String productId) async {
    try {
      await _dio.delete<void>('$_wishlistRemove/$productId');
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<dynamic> getWishlist({required int page}) async {
    final response = await _dio.get<dynamic>(
      _wishlistGet,
      queryParameters: {'page': page},
    );

    return _unwrapEnvelope(response.data);
  }

  Future<int> getWishlistCount() async {
    final response = await _dio.get<dynamic>(_wishlistCount);

    final payload = _unwrapEnvelope(response.data);

    return payload['count'] as int;
  }

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

  // dynamic _extractProductsList(dynamic payload) {
  //   if (payload is List) return payload;
  //   if (payload is Map<String, dynamic>) {
  //     final direct =
  //         payload['products'] ?? payload['items'] ?? payload['results'];
  //     if (direct != null) return direct;

  //     final nested = payload['data'];
  //     if (nested != null) return _extractProductsList(nested);

  //     return const <dynamic>[];
  //   }
  //   return const <dynamic>[];
  // }
}

Map<String, dynamic>? _asMap(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) {
    return value.map((key, value) => MapEntry(key.toString(), value));
  }
  return null;
}

// List<Map<String, dynamic>> _readListOfMaps(dynamic value) {
//   if (value is! List) return const <Map<String, dynamic>>[];
//   return value
//       .whereType<dynamic>()
//       .map(_asMap)
//       .whereType<Map<String, dynamic>>()
//       .toList(growable: false);
// }
