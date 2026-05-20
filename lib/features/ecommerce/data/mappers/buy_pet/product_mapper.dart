import 'package:poochcare/features/ecommerce/data/models/buy_pet/product_response.dart';
import 'package:poochcare/features/ecommerce/domain/models/product.dart';

class ProductMapper {
  const ProductMapper._();

  static Product toDomain(ProductResponse response) =>
      Product(id: response.id, name: response.name, price: response.price);

  static List<Product> listToDomain(List<ProductResponse> responses) =>
      responses.map(toDomain).toList();
}
