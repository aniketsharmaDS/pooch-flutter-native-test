import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';

class PaginatedOrders {
  final List<OrderItemModel> orders;
  final int total;
  final int page;
  final int pages;

  const PaginatedOrders({
    required this.orders,
    required this.total,
    required this.page,
    required this.pages,
  });
}
