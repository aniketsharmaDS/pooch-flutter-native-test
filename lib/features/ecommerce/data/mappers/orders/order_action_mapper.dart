import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_action_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_details_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';
import 'package:poochcare/features/ecommerce/data/types/orders/orders.dart';
import 'package:poochcare/router/app_router.dart';

class OrderActionMapper {
  static OrderAction resolve(
    BuildContext context,
    OrderItemModel item, {
    OrderDetailModel? orderDetail,
  }) {
    final status = item.status.toLowerCase();

    // Delivered → View
    if (status == 'delivered') {
      return OrderAction(
        label: 'View',
        onTap: () {
          context.router.push(
            OrderDetailsRoute(orderId: item.orderId, itemId: item.itemId),
          );
        },
      );
    }

    // // 🔥 CANCELLED / CANCELLATION FLOW → VIEW
    // if (status.contains('cancel')) {
    //   return OrderAction(
    //     label: 'View',
    //     onTap: () {
    //       context.router.push(
    //         OrderDetailsRoute(orderId: item.orderId, itemId: item.itemId),
    //       );
    //     },
    //   );
    // }

    // Accessory → View
    if (item.orderType == OrderType.accessory) {
      return OrderAction(
        label: 'View',
        onTap: () {
          context.router.push(
            OrderDetailsRoute(orderId: item.orderId, itemId: item.itemId),
          );
        },
      );
    }

    // Product → Track
    if (item.orderType == OrderType.product) {
      return OrderAction(
        label: 'Track',
        onTap: () {
          context.router.push(
            TrackOrderRoute(orderId: item.orderId, itemId: item.itemId),
          );
        },
      );
    }

    // Subscriptions → View
    return OrderAction(
      label: 'View',
      onTap: () {
        // context.router.push(SubscriptionDetailsRoute(orderId: item.orderId, itemId: item.itemId));
      },
    );
  }
}
