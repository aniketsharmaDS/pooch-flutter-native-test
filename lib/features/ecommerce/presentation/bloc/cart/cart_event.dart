import 'package:equatable/equatable.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class FetchCartEvent extends CartEvent {
  final String? productId;
  const FetchCartEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

class FetchCartCountEvent extends CartEvent {
  const FetchCartCountEvent();
}

class AddItemToCartEvent extends CartEvent {
  final List<String> productIds;

  const AddItemToCartEvent(this.productIds);

  @override
  List<Object?> get props => [productIds];
}

class RemoveFromCartEvent extends CartEvent {
  final String productId;

  const RemoveFromCartEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

class ResetCartEvent extends CartEvent {
  const ResetCartEvent();
}
