import 'package:poochcare/core/utils/date_time_formattter.dart';
import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/core/utils/validators.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_api_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_model.dart';
import 'package:poochcare/features/ecommerce/data/types/orders/orders.dart';

class OrderMapper {
  const OrderMapper._();

  static List<OrderItemModel> toUiList(List<OrderModel> orders) {
    final List<OrderItemModel> result = [];

    for (final order in orders) {
      final orderType = order.orderType?.toLowerCase();

      /// 🔹 PRODUCT ORDERS
      if (orderType == 'product' || orderType == 'accessory') {
        for (final item in order.items) {
          result.add(_mapProductItem(order, item));
        }
      }

      /// 🔹 SUBSCRIPTION ORDERS
      if (orderType == 'vet_subscription' ||
          orderType == 'pooch_subscription') {
        for (final sub in order.subscriptionDetails) {
          result.add(_mapSubscription(order, sub));
        }
      }
    }

    return result;
  }

  /// PRODUCT
  static OrderItemModel _mapProductItem(
    OrderModel order,
    OrderItemApiModel item,
  ) {
    final pricing = item.pricing;

    final isVaccinated = item.product?.petDetails?.isVaccinated;

    return OrderItemModel(
      orderId: order.orderId,
      orderNumber: order.orderNumber,
      itemId: item.id,

      title: item.productName,
      rawStatus: ParserUtils.readString(
        item.status ?? order.status,
        def: 'pending',
      ),

      /// 🔥 better subtitle
      subtitle: Validators.capitalize(item.product?.petDetails?.gender ?? ''),

      dateTime: formatFancyDate(order.createdAt),
      price: pricing?.finalPrice.toInt() ?? 0,

      // price:
      //     pricing?.finalPrice.toInt() ??
      //     ParserUtils.readInt(item.product?.price ?? '0'),
      finalPrice: pricing?.finalPrice.toInt() ?? 0,
      basePrice: pricing?.basePrice ?? 0,
      deliveryFee: pricing?.deliveryFee.toInt() ?? 0,
      taxAmount: pricing?.taxAmount ?? 0,
      discountAmount: (pricing?.discountAmount ?? 0).toDouble(),
      originalAmount: pricing?.originalAmount,
      originalPrice: pricing?.originalAmount.round(),
      status: _mapStatus(item.status ?? order.status),
      isVaccinated: isVaccinated,
      cancellationStatus: item.cancellationStatus,
      cancellationReason: item.cancellationReason,
      deliveryOtp: item.deliveryOtp,

      /// 🔥 FIXED IMAGE
      image: item.product != null && item.product!.productImages.isNotEmpty
          ? item.product!.productImages.first
          : (item.productImage ?? ''),

      /// ✅ DELIVERY HISTORY
      itemDeliveryHistory: item.itemDeliveryHistory,
      orderType: order.orderType?.toLowerCase() == 'accessory'
          ? OrderType.accessory
          : OrderType.product,
    );
  }

  /// SUBSCRIPTION
  static OrderItemModel _mapSubscription(
    OrderModel order,
    Map<String, dynamic> sub,
  ) {
    final price = ParserUtils.readInt(sub['pricePaid']);

    return OrderItemModel(
      orderId: order.orderId,
      orderNumber: order.orderNumber,
      itemId: sub['id']?.toString() ?? '',
      rawStatus: order.status,

      title: ParserUtils.readString(sub['planName']),

      subtitle: '${ParserUtils.readInt(sub['totalCallCredits'])} free calls',

      dateTime: formatFancyDate(order.createdAt),

      price: price,
      finalPrice: price,
      basePrice: price,
      deliveryFee: 0,
      taxAmount: 0,

      // status: _mapStatus(order.status),
      status: '${ParserUtils.readInt(sub['remainingCallCredits'])} calls left',

      image: '',

      orderType: OrderType.vetSubscription,
    );
  }

  static String _mapStatus(String? raw) {
    if (raw == null || raw.trim().isEmpty) return 'Pending';

    final status = raw.toLowerCase();

    if (status.contains('completed')) return 'Delivered';
    if (status.contains('confirmed')) return 'On time';
    if (status.contains('cancel')) return 'Cancelled';
    if (status.contains('not_started')) return 'On time';

    return raw;
  }
}
