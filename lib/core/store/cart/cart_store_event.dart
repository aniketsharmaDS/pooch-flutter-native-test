import 'package:equatable/equatable.dart';
import 'package:poochcare/core/domain/models/cart.dart';

sealed class CartStoreEvent extends Equatable {
  const CartStoreEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class CartUpdated extends CartStoreEvent {
  const CartUpdated(this.cart);

  final Cart cart;

  @override
  List<Object?> get props => <Object?>[cart];
}

class CartCleared extends CartStoreEvent {
  const CartCleared();
}
