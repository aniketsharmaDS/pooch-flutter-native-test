import 'package:intl/intl.dart';
import 'package:poochcare/core/widgets/stepper/app_vertical_stepper.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';

class OrderStepperMapper {
  static (List<AppVerticalStepperItem>, int) map(OrderItemModel order) {
    final history = order.itemDeliveryHistory ?? [];
    final status = order.status.toLowerCase();

    /// 🔹 STEP GROUPS
    final Map<String, List<AppVerticalStepperEvent>> grouped = {
      'Ordered': [],
      'Ready to leave': [],
      'Shipped': [],
      'Delivered': [],
    };

    /// 🔹 STEP 1: Order Created (always)
    grouped['Ordered']!.add(
      AppVerticalStepperEvent(
        text: 'Your order has been placed',
        timestamp: _format(order.dateTime),
      ),
    );

    /// 🔹 MAP HISTORY INTO GROUPS
    for (final h in history) {
      final hStatus = h.toStatus.toLowerCase();

      final event = AppVerticalStepperEvent(
        text: _mapEventText(hStatus, h.notes),
        timestamp: _format(h.createdAt),
      );

      if (hStatus == 'picked_up') {
        grouped['Ready to leave']!.add(event);
      } else if (hStatus == 'in_transit') {
        grouped['Shipped']!.add(event);
      } else if (hStatus == 'out_for_delivery') {
        grouped['Shipped']!.add(event);
      } else if (hStatus == 'delivered') {
        grouped['Delivered']!.add(event);
      }
    }

    /// 🔹 CURRENT STEP
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
    } else {
      currentStep = _resolveStep(status);
    }

    /// 🔹 BUILD FINAL STEPS
    final steps = <AppVerticalStepperItem>[];

    // 1️⃣ Ordered (always)
    steps.add(
      AppVerticalStepperItem(
        title: 'Ordered ${_formatTitleDate(order.dateTime)}',
        events: grouped['Ordered']!,
      ),
    );

    // 2️⃣ Next step (always show next)
    steps.add(
      AppVerticalStepperItem(
        title: 'Ready to leave',
        events: grouped['Ready to leave']!,
      ),
    );

    // 3️⃣ Show shipped only if progress reached
    if (currentStep >= 1) {
      steps.add(
        AppVerticalStepperItem(title: 'Shipped', events: grouped['Shipped']!),
      );
    }

    // 4️⃣ Show delivered only near completion
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

  static String _mapEventText(String status, String? notes) {
    if (notes != null && notes.isNotEmpty) return notes;

    switch (status) {
      case 'picked_up':
        return 'Your pooch has been picked up';
      case 'in_transit':
        return 'Your pooch is in transit';
      case 'out_for_delivery':
        return 'Your pooch is out for delivery';
      case 'delivered':
        return 'Your pooch has been delivered';
      default:
        return 'Order status updated';
    }
  }

  static String _format(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';

    try {
      final parsed = DateTime.parse(dateStr);
      return DateFormat('dd MMM, hh:mm a').format(parsed);
    } catch (e) {
      return dateStr;
    }
  }

  static String _formatTitleDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';

    try {
      final parsed = DateTime.parse(dateStr);
      return DateFormat("MMM d'th, yyyy").format(parsed);
    } catch (e) {
      return dateStr;
    }
  }

  static int _resolveStep(String status) {
    switch (status) {
      case 'delivered':
        return 3;
      case 'out for delivery':
      case 'in transit':
        return 2;
      case 'picked_up':
        return 1;
      case 'pending':
      default:
        return 0;
    }
  }
}
