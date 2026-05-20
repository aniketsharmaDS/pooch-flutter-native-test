import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/store/products/products_store_event.dart';
import 'package:poochcare/core/store/products/products_store_state.dart';
import 'package:poochcare/features/ecommerce/domain/models/product.dart';

class ProductsStoreBloc extends Bloc<ProductsStoreEvent, ProductsStoreState> {
  ProductsStoreBloc() : super(const ProductsStoreState()) {
    on<ProductsRefreshed>(_onProductsRefreshed);
    on<ProductUpserted>(_onProductUpserted);
    on<ProductsCleared>(_onProductsCleared);
  }

  void _onProductsRefreshed(
    ProductsRefreshed event,
    Emitter<ProductsStoreState> emit,
  ) {
    final Map<String, Product> byId = <String, Product>{
      for (final Product product in event.products) product.id: product,
    };
    final List<String> ids = event.products.map((Product p) => p.id).toList();
    emit(state.copyWith(productsById: byId, productIds: ids));
  }

  void _onProductUpserted(
    ProductUpserted event,
    Emitter<ProductsStoreState> emit,
  ) {
    final Map<String, Product> byId = Map<String, Product>.from(
      state.productsById,
    );
    final List<String> ids = List<String>.from(state.productIds);

    byId[event.product.id] = event.product;
    if (!ids.contains(event.product.id)) {
      ids.add(event.product.id);
    }

    emit(state.copyWith(productsById: byId, productIds: ids));
  }

  void _onProductsCleared(
    ProductsCleared event,
    Emitter<ProductsStoreState> emit,
  ) {
    emit(const ProductsStoreState());
  }
}
