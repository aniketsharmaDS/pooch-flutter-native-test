import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/store/cart/cart_store_event.dart';
import 'package:poochcare/core/store/cart/cart_store_state.dart';

class CartStoreBloc extends Bloc<CartStoreEvent, CartStoreState> {
  CartStoreBloc() : super(const CartStoreState()) {
    on<CartUpdated>(_onCartUpdated);
    on<CartCleared>(_onCartCleared);
  }

  void _onCartUpdated(CartUpdated event, Emitter<CartStoreState> emit) {
    emit(state.copyWith(cart: event.cart));
  }

  void _onCartCleared(CartCleared event, Emitter<CartStoreState> emit) {
    emit(state.copyWith(clearCart: true));
  }
}
