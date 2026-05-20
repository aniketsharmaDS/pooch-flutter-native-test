import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/domain/models/cart.dart';
import 'package:poochcare/core/store/cart/cart_store_bloc.dart';
import 'package:poochcare/core/store/cart/cart_store_state.dart';
import 'package:poochcare/core/widgets/cards/app_card.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartStoreBloc, CartStoreState, Cart?>(
      selector: (CartStoreState state) => state.cart,
      builder: (BuildContext context, Cart? cart) {
        return AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppText.h1(
                'Cart',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              AppText.bodyM('Items: ${cart?.itemsCount ?? 0}'),
              AppText.bodyM(
                'Total: ₹${(cart?.totalAmount ?? 0).toStringAsFixed(2)}',
              ),
            ],
          ),
        );
      },
    );
  }
}
