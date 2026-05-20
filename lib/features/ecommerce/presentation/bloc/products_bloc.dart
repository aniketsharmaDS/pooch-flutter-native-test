import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/store/products/products_store_bloc.dart';
import 'package:poochcare/core/store/products/products_store_event.dart';
import 'package:poochcare/features/ecommerce/repository/products_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({
    required ProductsRepository repository,
    required ProductsStoreBloc productsStore,
  }) : _repository = repository,
       _productsStore = productsStore,
       super(const ProductsState()) {
    on<ProductsFetched>(_onProductsFetched);
    on<ProductsLoadMoreRequested>(_onProductsLoadMoreRequested);
  }

  final ProductsRepository _repository;
  final ProductsStoreBloc _productsStore;

  Future<void> _onProductsFetched(
    ProductsFetched event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    final products = await _repository.fetchProducts(page: 1);
    _productsStore.add(ProductsRefreshed(products));
    emit(state.copyWith(isLoading: false, currentPage: 1, hasMore: true));
  }

  Future<void> _onProductsLoadMoreRequested(
    ProductsLoadMoreRequested event,
    Emitter<ProductsState> emit,
  ) async {
    if (!state.hasMore || state.isFetchingMore) {
      return;
    }
    emit(state.copyWith(isFetchingMore: true));
    final products = await _repository.fetchProducts(
      page: state.currentPage + 1,
    );
    _productsStore.add(ProductsRefreshed(products));
    emit(
      state.copyWith(
        isFetchingMore: false,
        currentPage: state.currentPage + 1,
        hasMore: state.currentPage < 3,
      ),
    );
  }
}
