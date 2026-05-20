import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/bottom_sheets/need_help_bottom_sheet.dart';
import 'package:poochcare/features/test_screen/transition_screen/transition_screen.dart';
import 'package:poochcare/router/app_router.dart';

/// Screen shown after successful order cancellation.
/// Provides options to continue to home or view order details.
@RoutePage()
class CancelOrderTransitionScreen extends StatelessWidget {
  // final OrderItemModel order;
  final String orderId;
  final String itemId;

  const CancelOrderTransitionScreen({
    super.key,
    required this.orderId,
    required this.itemId,
  });

  @override
  Widget build(BuildContext context) {
    return TransitionScreen(
      variant: TransitionScreenVariant.orderCancelled,

      onPrimaryPressed: () {
        context.router.replace(const OrdersListingRoute());
      },

      onSecondaryPressed: () {
        // context.router.replace([OrderDetailsRoute(orderId: order.orderId , itemId: order.itemId),TrackOrderRoute(order: order, )]);

        context.router.replace(
          TrackOrderRoute(orderId: orderId, itemId: itemId),
        );
      },
      onTertiaryPressed: () {
        openNeedHelpBottomSheet(context, orderId: orderId, itemId: itemId);
      },
    );
  }
}
