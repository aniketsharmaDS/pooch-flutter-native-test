import 'package:equatable/equatable.dart';
import 'package:poochcare/features/ecommerce/domain/models/product.dart';

class PaginatedProducts extends Equatable {
  const PaginatedProducts({
    required this.products,
    required this.currentPage,
    required this.hasNextPage,
  });

  final List<Product> products;
  final int currentPage;
  final bool hasNextPage;

  @override
  List<Object?> get props => <Object?>[products, currentPage, hasNextPage];
}
