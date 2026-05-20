import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/ecommerce/data/mappers/orders/order_mapper.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/cancellation_tracking_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_details_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_model.dart';

class OrderDetailMapper {
  const OrderDetailMapper._();

  static OrderDetailModel toModel(Map<String, dynamic> map) {
    final data = map;

    /// FIX: properly cast list
    final List<OrderItemModel> items = (data['items'] as List? ?? [])
        .map(
          (e) => OrderMapper.toUiList([
            OrderModel.fromMap({
              ...data,
              'items': [ParserUtils.readMap(e)], // ✅ safe
            }),
          ]),
        )
        .expand((e) => e)
        .toList();

    return OrderDetailModel(
      /// FIX ALL STRINGS
      orderId: ParserUtils.readString(data['id']),
      orderNumber: ParserUtils.readString(data['orderNumber']),

      status: ParserUtils.readString(data['status']),
      paymentStatus: ParserUtils.readString(data['paymentStatus']),
      deliveryStatus: ParserUtils.readString(data['deliveryStatus']),

      createdAt: ParserUtils.readString(data['createdAt']),

      totalAmount: ParserUtils.readInt(data['totalAmount']),
      taxAmount: ParserUtils.readInt(data['taxAmount']),
      deliveryCharge: ParserUtils.readInt(data['deliveryCharge']),
      refundPolicy: ParserUtils.readString(data['refund_policy']),

      items: items,
      cancellationTracking: (data['cancellationTracking'] as List? ?? [])
          .map(
            (e) => CancellationTrackingModel.fromJson(ParserUtils.readMap(e)),
          )
          .toList(),

      customerName: ParserUtils.readString(data['customer']?['name']),
      customerPhone: ParserUtils.readString(data['customer']?['phone']),

      address: ParserUtils.readString(data['shippingAddress']?['addressLine']),
    );
  }
}
