import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_model.dart';

class OrderResponseModel {
  final List<OrderModel> orders;
  final int total;
  final int page;
  final int pages;
  final int limit;

  const OrderResponseModel({
    required this.orders,
    required this.total,
    required this.page,
    required this.pages,
    required this.limit,
  });

  factory OrderResponseModel.fromMap(Map<String, dynamic> map) {
    return OrderResponseModel(
      orders: (map['orders'] as List? ?? [])
          .map((e) => OrderModel.fromMap(e as Map<String, dynamic>))
          .toList(growable: false),

      total: ParserUtils.readInt(map['total']),
      page: ParserUtils.readInt(map['page']),
      pages: ParserUtils.readInt(map['pages']),
      limit: ParserUtils.readInt(map['limit']),
    );
  }
}
