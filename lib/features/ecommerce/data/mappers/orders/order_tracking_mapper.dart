import 'package:poochcare/core/widgets/stepper/app_vertical_stepper.dart';
import 'package:poochcare/features/ecommerce/data/mappers/orders/cancellation_tracking_mapper.dart';
import 'package:poochcare/features/ecommerce/data/mappers/orders/delivery_tracking_mapper.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_details_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';

class OrderTrackingMapper {
  static (List<AppVerticalStepperItem>, int) map({
    required OrderDetailModel order,
    required OrderItemModel item,
  }) {
    final cancelStatus = item.cancellationStatus?.toLowerCase();

    if (cancelStatus != null && cancelStatus.isNotEmpty) {
      return CancellationTrackingMapper.map(order: order, item: item);
    }

    return DeliveryTrackingMapper.map(order: order, item: item);
  }
}
