import 'package:poochcare/features/ecommerce/data/api/product_api_service.dart';
import 'package:poochcare/features/ecommerce/data/mappers/buy_pet/product_mapper.dart';
import 'package:poochcare/features/ecommerce/domain/models/product.dart';

class ProductsRepository {
  const ProductsRepository(this._api);

  final ProductApiService _api;

  Future<List<Product>> fetchProducts({required int page}) async {
    final responses = await _api.getProducts(page: page);
    return ProductMapper.listToDomain(responses);
  }
}
