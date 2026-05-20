import 'package:equatable/equatable.dart';
import 'package:poochcare/features/ecommerce/domain/models/product.dart';

class ProductsStoreState extends Equatable {
  const ProductsStoreState({
    this.productsById = const <String, Product>{},
    this.productIds = const <String>[],
  });

  final Map<String, Product> productsById;
  final List<String> productIds;

  List<Product> get products =>
      productIds.map((String id) => productsById[id]!).toList();

  ProductsStoreState copyWith({
    Map<String, Product>? productsById,
    List<String>? productIds,
  }) {
    return ProductsStoreState(
      productsById: productsById ?? this.productsById,
      productIds: productIds ?? this.productIds,
    );
  }

  @override
  List<Object?> get props => <Object?>[productsById, productIds];
}
