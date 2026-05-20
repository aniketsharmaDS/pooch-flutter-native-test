import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/features/ecommerce/data/mappers/orders/order_action_mapper.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';
import 'package:poochcare/features/ecommerce/data/types/orders/orders.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/consultation_order_list_card.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/order_list_card.dart';
import 'package:poochcare/router/app_router.dart';

class OrderCardFactory extends StatelessWidget {
  final OrderItemModel item;

  const OrderCardFactory({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final action = OrderActionMapper.resolve(context, item);

    VoidCallback? onCardTap;

    // 👇 Only for product & accessory
    if (item.orderType == OrderType.product ||
        item.orderType == OrderType.accessory) {
      onCardTap = () {
        context.router.push(
          OrderDetailsRoute(orderId: item.orderId, itemId: item.itemId),
        );
      };
    }

    switch (item.orderType) {
      case OrderType.product:
      case OrderType.accessory:
        return OrderListCard(
          item: item,
          actionLabel: action.label,
          onAction: action.onTap,
          onTap: onCardTap,
        );

      case OrderType.vetSubscription:
      case OrderType.poochSubscription:
        return ConsultationOrderListCard(
          title: item.title,
          subtitle: item.subtitle,
          dateTime: item.dateTime,
          orderId: item.orderNumber,
          status: item.status,
          image: NetworkImage(item.image),
          onUpgrade: () {},
        );
    }
  }
}
