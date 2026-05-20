import 'package:dio/dio.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/core/errors/error_mapper.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/fun/data/models/accessory_booking_summary_response_model.dart';
import 'package:poochcare/features/fun/data/models/accessory_marketplace_response_model.dart';
import 'package:poochcare/features/fun/data/models/accessory_my_accessories_response_model.dart';
import 'package:poochcare/features/fun/data/models/accessory_purchase_response_model.dart';
import 'package:poochcare/features/fun/data/models/leaderboard_response_model.dart';

class AccessoriesApiService {
  const AccessoriesApiService(this._dio);

  final Dio _dio;

  static const String _marketplaceAccessoriesPath = '/marketplace/accessories';
  static const String _myAccessoriesPath = '/accessories/my-accessories';
  static const String _bookingSummaryPath = '/accessories/booking-summary';
  static const String _purchasePath = '/accessories/purchase';
  static const String _leaderboardPath = '/leaderboard';

  Future<AccessoryMarketplaceResponseModel> getMarketplaceAccessories({
    int page = 1,
    int limit = 10,
    String? couponCode,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        _marketplaceAccessoriesPath,
        queryParameters: {
          'page': page,
          'limit': limit,
          'couponCode': ?couponCode,
        },
      );

      final dynamic body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to fetch accessories',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body;

      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return AccessoryMarketplaceResponseModel.fromMap(payload);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<MyAccessoriesResponseModel> getMyAccessories({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        _myAccessoriesPath,
        queryParameters: {'page': page, 'limit': limit},
      );

      final dynamic body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to fetch accessories',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body;

      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return MyAccessoriesResponseModel.fromMap(payload);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<AccessoryBookingSummaryModel> getBookingSummary({
    required String accessoryId,
    required String petId,
    required int quantity,
    required String country,
    String? couponCode,
    String langCode = '',
  }) async {
    try {
      final data = <String, dynamic>{
        'accessoryId': accessoryId,
        'petId': petId,
        'quantity': quantity,
        'country': country,
      };

      if ((couponCode ?? '').trim().isNotEmpty) {
        data['couponCode'] = couponCode;
      }

      if (langCode.trim().isNotEmpty) {
        data['langCode'] = langCode;
      }

      final response = await _dio.post<dynamic>(
        _bookingSummaryPath,
        data: data,
      );

      final dynamic body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to fetch booking summary',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body;

      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return AccessoryBookingSummaryModel.fromMap(payload);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<AccessoryPurchaseResponseModel> purchaseAccessory({
    required String accessoryId,
    required String petId,
    required int quantity,
    required String country,
    String? couponCode,
    String? langCode,
  }) async {
    try {
      final data = <String, dynamic>{
        'accessoryId': accessoryId,
        'petId': petId,
        'quantity': quantity,
        'country': country,
      };

      if ((couponCode ?? '').trim().isNotEmpty) {
        data['couponCode'] = couponCode;
      }

      if ((langCode ?? '').trim().isNotEmpty) {
        data['langCode'] = langCode;
      }

      final response = await _dio.post<dynamic>(_purchasePath, data: data);

      final dynamic body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to purchase accessory',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body;

      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return AccessoryPurchaseResponseModel.fromMap(payload);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<LeaderboardResponseModel> getLeaderboard({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        _leaderboardPath,
        queryParameters: {'page': page, 'limit': limit},
      );

      final dynamic body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to fetch leaderboard',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body;

      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return LeaderboardResponseModel.fromMap(payload);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }
}
