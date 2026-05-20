import 'package:poochcare/features/ecommerce/data/models/buy_pet/product_model.dart';

class ProductResponseModel {
  final List<ProductModel> products;
  final int currentPage;
  final int totalPages;

  const ProductResponseModel({
    required this.products,
    required this.currentPage,
    required this.totalPages,
  });

  factory ProductResponseModel.fromMap(Map<String, dynamic> map) {
    final Map<String, dynamic> pagination =
        _readMap(map['pagination'] ?? map['pageInfo'] ?? map['page_info']) ??
        const <String, dynamic>{};

    final int currentPage = _readInt(
      map['currentPage'] ??
          map['page'] ??
          map['current_page'] ??
          pagination['currentPage'] ??
          pagination['page'] ??
          pagination['current_page'],
    );

    final int totalPages = _readInt(
      map['totalPages'] ??
          map['pages'] ??
          map['total_pages'] ??
          pagination['totalPages'] ??
          pagination['pages'] ??
          pagination['total_pages'],
    );

    final dynamic rawProducts =
        map['products'] ?? map['items'] ?? map['results'] ?? map['data'];

    final List<ProductModel> products = _readListOfMaps(
      rawProducts,
    ).map(ProductModel.fromMap).toList(growable: false);

    return ProductResponseModel(
      products: products,
      currentPage: currentPage,
      totalPages: totalPages,
    );
  }
}

int _readInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value.trim()) ?? 0;
  return 0;
}

Map<String, dynamic>? _readMap(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) {
    return value.map((key, value) => MapEntry(key.toString(), value));
  }
  return null;
}

List<Map<String, dynamic>> _readListOfMaps(dynamic value) {
  if (value is! List) return const <Map<String, dynamic>>[];
  return value
      .whereType<dynamic>()
      .map(_readMap)
      .whereType<Map<String, dynamic>>()
      .toList(growable: false);
}
