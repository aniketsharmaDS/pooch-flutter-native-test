import 'package:dio/dio.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/core/errors/error_mapper.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/ecommerce/data/mappers/orders/order_details_mapper.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_details_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_preview_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/orders_reponse_model.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/sections/reason_for_cancellation_section.dart';

class OrdersApiService {
  const OrdersApiService(this._dio);

  final Dio _dio;

  static const String _ordersPath = '/orders';
  static const String _needHelpPath = '/need-help';

  Future<OrderPreviewModel> previewOrder({required String productId}) async {
    try {
      final response = await _dio.post<dynamic>(
        '$_ordersPath/preview',
        data: {
          'type': 'buy_now',
          'product_id': productId,
          // 'shipping_address_id': addressId,
          // 'couponCode': couponCode,
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
              : 'Unable to preview order',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body;

      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return OrderPreviewModel.fromMap(payload);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<OrderResponseModel> getOrders({
    required int page,
    String? status,
    int limit = 10,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        _ordersPath,
        queryParameters: {
          'page': page,
          'limit': limit,
          if (status != null && status.isNotEmpty) 'status': status,
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
              : 'Unable to fetch orders',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body;

      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return OrderResponseModel.fromMap(payload);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<OrderDetailModel> getOrderById(String orderId, String itemId) async {
    try {
      final url = '$_ordersPath/$orderId';
      final response = await _dio.get<dynamic>(
        url,
        queryParameters: {'itemId': itemId},
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
              : 'Unable to fetch order details',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body;

      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return OrderDetailMapper.toModel(payload);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<void> submitNeedHelp({
    required String issue,
    String? orderId,
    String? itemId,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        _needHelpPath,
        data: {'issue': issue, 'orderId': orderId, 'itemId': itemId},
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
              : 'Unable to submit request',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<void> cancelOrder({
    required String orderId,
    required String itemId,
    required String reason,
    List<String> images = const [],
  }) async {
    try {
      final url = '$_ordersPath/$orderId/items/$itemId/cancellation';

      final response = await _dio.post<dynamic>(
        url,
        data: {'reason': reason, if (images.isNotEmpty) 'images': images},
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
              : 'Unable to cancel order',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<(List<CancellationReasonOption>, String)>
  getCancellationReasons() async {
    try {
      final response = await _dio.get<dynamic>(
        '$_ordersPath/codes/cancellation-reasons',
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
              : 'Unable to fetch cancellation reasons',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body;

      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response');
      }

      final reasonsRaw = payload['reasons'] as List? ?? [];
      final refundPolicy = payload['refundPolicy']?.toString() ?? '';

      final reasons = reasonsRaw.map((e) {
        final map = e as Map<String, dynamic>;
        return CancellationReasonOption(
          id: map['code']?.toString() ?? '',
          label: map['reason']?.toString() ?? '',
        );
      }).toList();

      return (reasons, refundPolicy);
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }
}
