import 'package:poochcare/features/ecommerce/domain/models/product.dart';

class WishlistState {
  final Set<String> wishlistIds;
  final Set<String> loadingIds;
  final String searchQuery;
  final List<Product> allProducts; // full data
  final List<Product> products; // UI data
  final int actionId;
  final int wishlistCount;
  final String? actionMessage;
  final int page;
  final bool hasNextPage;
  final bool isLoading;

  const WishlistState({
    this.wishlistIds = const {},
    this.loadingIds = const {},
    this.searchQuery = '',
    this.products = const [],
    this.allProducts = const [],
    this.page = 1,
    this.hasNextPage = false,
    this.isLoading = false,
    this.actionId = 0,
    this.wishlistCount = 0,
    this.actionMessage,
  });

  WishlistState copyWith({
    Set<String>? wishlistIds,
    Set<String>? loadingIds,
    String? searchQuery,
    List<Product>? products,
    List<Product>? allProducts,
    int? page,
    bool? hasNextPage,
    bool? isLoading,
    int? wishlistCount,
    int? actionId,
    String? actionMessage,
  }) {
    return WishlistState(
      wishlistIds: wishlistIds ?? this.wishlistIds,
      loadingIds: loadingIds ?? this.loadingIds,
      searchQuery: searchQuery ?? this.searchQuery,
      products: products ?? this.products,
      allProducts: allProducts ?? this.allProducts,
      page: page ?? this.page,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isLoading: isLoading ?? this.isLoading,
      actionId: actionId ?? this.actionId,
      actionMessage: actionMessage,
      wishlistCount: wishlistCount ?? this.wishlistCount,
    );
  }
}
