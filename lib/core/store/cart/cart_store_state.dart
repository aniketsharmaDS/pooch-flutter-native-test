import 'package:equatable/equatable.dart';
import 'package:poochcare/core/domain/models/cart.dart';

class CartStoreState extends Equatable {
  const CartStoreState({this.cart});

  final Cart? cart;

  CartStoreState copyWith({Cart? cart, bool clearCart = false}) {
    return CartStoreState(cart: clearCart ? null : (cart ?? this.cart));
  }

  @override
  List<Object?> get props => <Object?>[cart];
}
