import 'package:dio/dio.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/ecommerce/data/models/buy_pet/product_response.dart';

class ProductApiService {
  const ProductApiService(this._dio);

  final Dio _dio;

  Future<List<ProductResponse>> getProducts({required int page}) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    _dio.options.baseUrl;
    final Map<String, dynamic> raw = <String, dynamic>{
      'success': true,
      'message': 'Products retrieved successfully',
      'status': 200,
      'data': <Map<String, dynamic>>[
        <String, dynamic>{
          'id': 'prod_1',
          'name': 'Dog Shampoo',
          'price': 14.99,
        },
        <String, dynamic>{'id': 'prod_2', 'name': 'Pet Comb', 'price': 8.50},
      ],
    };
    final ApiResponse envelope = ApiResponseMapper.fromMap(raw);
    final dynamic payload = envelope.data;
    if (payload is! List) {
      return const <ProductResponse>[];
    }
    return payload
        .whereType<Map<String, dynamic>>()
        .map(ProductResponseMapper.fromMap)
        .toList();
  }
}
