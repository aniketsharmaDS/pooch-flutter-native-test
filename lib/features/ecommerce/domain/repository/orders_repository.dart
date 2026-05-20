import 'dart:io';

import 'package:poochcare/features/ecommerce/data/models/orders/order_details_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_preview_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/paginated_orders.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/sections/reason_for_cancellation_section.dart';

abstract class OrderRepository {
  Future<OrderPreviewModel> previewOrder({required String productId});

  Future<PaginatedOrders> getOrders({required int page, String? status});

  Future<OrderDetailModel> getOrderById(String orderId, String itemId);

  Future<void> submitNeedHelp({
    required String issue,
    String? orderId,
    String? itemId,
  });

  Future<(List<CancellationReasonOption>, String)> getCancellationReasons();

  Future<void> cancelOrder({
    required String orderId,
    required String itemId,
    required String reason,
    List<File> images,
  });
}
