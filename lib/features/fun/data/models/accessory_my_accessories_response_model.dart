import 'package:poochcare/core/utils/parser_utils.dart';

class AccessoryOrderItemAccessoryModel {
  const AccessoryOrderItemAccessoryModel({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.isPremium,
    required this.accessoryCategory,
  });

  final String id;
  final String name;
  final String? thumbnail;
  final bool isPremium;
  final String accessoryCategory;

  factory AccessoryOrderItemAccessoryModel.fromMap(Map<String, dynamic> map) {
    return AccessoryOrderItemAccessoryModel(
      accessoryCategory: ParserUtils.readString(map['accessoryCategory']),
      id: ParserUtils.readString(map['id']),
      name: ParserUtils.readString(map['name']),
      thumbnail: ParserUtils.readNullableString(map['thumbnail']),
      isPremium: ParserUtils.readBool(map['isPremium']),
    );
  }
}

class AccessoryOrderItemModel {
  const AccessoryOrderItemModel({
    required this.id,
    required this.accessory,
    required this.quantity,
    required this.price,
    required this.status,
    required this.orderDate,
    required this.orderNumber,
    required this.orderStatus,
    required this.deliveryStatus,
    required this.paymentStatus,
    required this.currency,
  });

  final String id;
  final AccessoryOrderItemAccessoryModel accessory;
  final int quantity;
  final String price;
  final String status;
  final String orderDate;
  final String orderNumber;
  final String orderStatus;
  final String deliveryStatus;
  final String paymentStatus;
  final String currency;

  factory AccessoryOrderItemModel.fromMap(Map<String, dynamic> map) {
    return AccessoryOrderItemModel(
      currency: ParserUtils.readString(map['currency']),
      id: ParserUtils.readString(map['id']),
      accessory: AccessoryOrderItemAccessoryModel.fromMap(
        ParserUtils.readMap(map['accessory']),
      ),
      quantity: ParserUtils.readInt(map['quantity']),
      price: ParserUtils.readString(map['price']),
      status: ParserUtils.readString(map['status']),
      orderDate: ParserUtils.readString(map['orderDate']),
      orderNumber: ParserUtils.readString(map['orderNumber']),
      orderStatus: ParserUtils.readString(map['orderStatus']),
      deliveryStatus: ParserUtils.readString(map['deliveryStatus']),
      paymentStatus: ParserUtils.readString(map['paymentStatus']),
    );
  }
}

class AccessoryOrderModel {
  const AccessoryOrderModel({
    required this.orderId,
    required this.orderNumber,
    required this.orderDate,
    required this.totalAmount,
    required this.status,
    required this.deliveryStatus,
    required this.paymentStatus,
    required this.items,
  });

  final String orderId;
  final String orderNumber;
  final String orderDate;
  final double totalAmount;
  final String status;
  final String deliveryStatus;
  final String paymentStatus;
  final List<AccessoryOrderItemModel> items;

  factory AccessoryOrderModel.fromMap(Map<String, dynamic> map) {
    return AccessoryOrderModel(
      orderId: ParserUtils.readString(map['orderId']),
      orderNumber: ParserUtils.readString(map['orderNumber']),
      orderDate: ParserUtils.readString(map['orderDate']),
      totalAmount: ParserUtils.readDouble(map['totalAmount']),
      status: ParserUtils.readString(map['status']),
      deliveryStatus: ParserUtils.readString(map['deliveryStatus']),
      paymentStatus: ParserUtils.readString(map['paymentStatus']),
      items: (map['items'] as List? ?? const <dynamic>[])
          .whereType<Map>()
          .map((e) => ParserUtils.readMap(e))
          .map(AccessoryOrderItemModel.fromMap)
          .toList(growable: false),
    );
  }
}

class AccessoryOrdersPaginationModel {
  const AccessoryOrdersPaginationModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  final int page;
  final int limit;
  final int total;
  final int totalPages;

  factory AccessoryOrdersPaginationModel.fromMap(Map<String, dynamic> map) {
    return AccessoryOrdersPaginationModel(
      page: ParserUtils.readInt(map['page']),
      limit: ParserUtils.readInt(map['limit']),
      total: ParserUtils.readInt(map['total']),
      totalPages: ParserUtils.readInt(map['totalPages']),
    );
  }
}

class MyAccessoriesResponseModel {
  const MyAccessoriesResponseModel({
    required this.accessories,
    required this.pagination,
  });

  final List<AccessoryOrderModel> accessories;
  final AccessoryOrdersPaginationModel pagination;

  factory MyAccessoriesResponseModel.fromMap(Map<String, dynamic> map) {
    return MyAccessoriesResponseModel(
      accessories: (map['accessories'] as List? ?? const <dynamic>[])
          .whereType<Map>()
          .map((e) => ParserUtils.readMap(e))
          .map(AccessoryOrderModel.fromMap)
          .toList(growable: false),
      pagination: AccessoryOrdersPaginationModel.fromMap(
        ParserUtils.readMap(map['pagination']),
      ),
    );
  }
}
