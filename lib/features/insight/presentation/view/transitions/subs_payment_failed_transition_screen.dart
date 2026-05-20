import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/features/test_screen/transition_screen/transition_screen.dart';
import 'package:poochcare/router/app_router.dart';

/// Provides options to continue to home or view pet details.
@RoutePage()
class SubsPaymentFailedTransitionScreen extends StatelessWidget {
  const SubsPaymentFailedTransitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TransitionScreen(
      variant: TransitionScreenVariant.retryPayment,
      petName: 'petName',
      onPrimaryPressed: () {
        Navigator.pop(context);
        // context.router.replace(const OrdersListingRoute());
      },

      onSecondaryPressed: () {
        // Navigator.pop(context);
        context.router.popUntilRouteWithName(ClinicSlotSelectionRoute.name);
        // context.router.replace(TrackOrderRoute(order: order));
      },
    );
  }
}
