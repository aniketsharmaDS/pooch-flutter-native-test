part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class ProductsFetched extends ProductsEvent {
  const ProductsFetched();
}

class ProductsLoadMoreRequested extends ProductsEvent {
  const ProductsLoadMoreRequested();
}
