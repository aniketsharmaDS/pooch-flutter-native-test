import 'package:equatable/equatable.dart';
import 'package:poochcare/features/ecommerce/domain/models/product.dart';

sealed class ProductsStoreEvent extends Equatable {
  const ProductsStoreEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class ProductsRefreshed extends ProductsStoreEvent {
  const ProductsRefreshed(this.products);

  final List<Product> products;

  @override
  List<Object> get props => <Object>[products];
}

class ProductUpserted extends ProductsStoreEvent {
  const ProductUpserted(this.product);

  final Product product;

  @override
  List<Object> get props => <Object>[product];
}

class ProductsCleared extends ProductsStoreEvent {
  const ProductsCleared();
}
