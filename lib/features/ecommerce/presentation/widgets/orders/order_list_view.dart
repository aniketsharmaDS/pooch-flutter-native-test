import 'package:flutter/material.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/order_card_factory.dart';

class OrdersListView extends StatelessWidget {
  final List<OrderItemModel> orders;

  const OrdersListView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const Center(child: Text('No Orders'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final item = orders[index];

        return OrderCardFactory(item: item);
      },
    );
  }
}
