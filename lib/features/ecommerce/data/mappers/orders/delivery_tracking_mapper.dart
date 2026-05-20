import 'package:poochcare/core/widgets/stepper/app_vertical_stepper.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_details_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';
import 'package:poochcare/features/ecommerce/domain/utils/tracking_utils.dart';

class DeliveryTrackingMapper {
  static (List<AppVerticalStepperItem>, int) map({
    required OrderDetailModel order,
    required OrderItemModel item,
  }) {
    final history = item.itemDeliveryHistory ?? [];

    final Map<String, List<AppVerticalStepperEvent>> grouped = {
      'Ordered': [],
      'Ready to leave': [],
      'Shipped': [],
      'Delivered': [],
    };

    grouped['Ordered']!.add(
      AppVerticalStepperEvent(
        text: 'Your order has been placed',
        timestamp: TrackingUtils.format(order.createdAt),
      ),
    );

    for (final h in history) {
      final status = h.toStatus.toLowerCase();

      final event = AppVerticalStepperEvent(
        text: TrackingUtils.mapEventText(status, h.notes),
        timestamp: TrackingUtils.format(h.createdAt),
      );

      if (status == 'picked_up') {
        grouped['Ready to leave']!.add(event);
      } else if (status == 'in_transit' || status == 'out_for_delivery') {
        grouped['Shipped']!.add(event);
      } else if (status == 'delivered') {
        grouped['Delivered']!.add(event);
      }
    }

    int currentStep = 0;

    if (history.isNotEmpty) {
      final latestStatus = history.last.toStatus.toLowerCase();

      if (latestStatus == 'picked_up') {
        currentStep = 1;
      } else if (latestStatus == 'in_transit' ||
          latestStatus == 'out_for_delivery') {
        currentStep = 2;
      } else if (latestStatus == 'delivered') {
        currentStep = 3;
      }
    }

    final steps = <AppVerticalStepperItem>[
      AppVerticalStepperItem(
        title: 'Ordered ${TrackingUtils.formatTitleDate(order.createdAt)}',
        events: grouped['Ordered']!,
      ),
      AppVerticalStepperItem(
        title: 'Ready to leave',
        events: grouped['Ready to leave']!,
      ),
    ];

    if (currentStep >= 1) {
      steps.add(
        AppVerticalStepperItem(title: 'Shipped', events: grouped['Shipped']!),
      );
    }

    if (currentStep >= 2) {
      steps.add(
        AppVerticalStepperItem(
          title: 'Delivered',
          events: grouped['Delivered']!,
        ),
      );
    }

    return (steps, currentStep);
  }
}
