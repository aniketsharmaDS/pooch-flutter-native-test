import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/widgets/list_grid/app_paginated_grid_view.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/product_grid_item_card.dart';

/// =============================
/// SCREEN
/// =============================

@RoutePage()
class AppGridScreen extends StatefulWidget {
  const AppGridScreen({super.key});

  @override
  State<AppGridScreen> createState() => _AppGridScreenState();
}

class _AppGridScreenState extends State<AppGridScreen> {
  final List<ProductItem> _items = [];

  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  int _page = 1;

  @override
  void initState() {
    super.initState();
    _loadInitial();
  }

  /// =============================
  /// DATA METHODS
  /// =============================

  Future<void> _loadInitial() async {
    setState(() {
      _isLoading = true;
      _page = 1;
      _items.clear();
      _hasMore = true;
    });

    // ignore: inference_failure_on_instance_creation
    await Future.delayed(const Duration(seconds: 1));

    final data = _mockData(_page);

    setState(() {
      _items.addAll(data);
      _isLoading = false;
      _page++;
    });
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || !_hasMore) return;

    setState(() => _isLoadingMore = true);

    // ignore: inference_failure_on_instance_creation
    await Future.delayed(const Duration(seconds: 1));

    final data = _mockData(_page);

    setState(() {
      _items.addAll(data);
      _isLoadingMore = false;
      _page++;
      _hasMore = _page <= 3;
    });
  }

  Future<void> _refresh() async {
    await _loadInitial();
  }

  /// =============================
  /// MOCK DATA
  /// =============================

  List<ProductItem> _mockData(int page) {
    return List.generate(10, (index) {
      return ProductItem(
        id: 'demo-${index + (page - 1) * 10}',
        name: 'Buddy ${index + (page - 1) * 10}',
        age: '${2 + index} months',
        price: 5000 + index * 200,
        originalPrice: 6000 + index * 200,
        isVaccinated: index % 2 == 0,
        // isWishlisted: false,
        isPopular: index % 3 == 0,
        image:
            'https://fastly.picsum.photos/id/237/536/354.jpg?hmac=i0yVXW1ORpyCZpQ-CknuyV-jbtU7_x9EBQVhvT5aRr0', // make sure exists
      );
    });
  }

  /// =============================
  /// UI
  /// =============================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: const Text('Products')),
      body: SafeArea(
        child: AppPaginatedGridView<ProductItem>(
          items: _items,
          isLoading: _isLoading,
          isLoadingMore: _isLoadingMore,
          hasMore: _hasMore,
          childAspectRatio: 0.64,
          onLoadMore: _loadMore,
          onRefresh: _refresh,
          onRetry: _loadInitial,

          itemBuilder: (product, index) {
            return ProductGridCard(
              product: product,
              onTap: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(product.name)));
              },

              onWishlistTap: () {
                setState(() {
                  _items[index] = ProductItem(
                    id: product.id,
                    name: product.name,
                    age: product.age,
                    price: product.price,
                    originalPrice: product.originalPrice,
                    isVaccinated: product.isVaccinated,
                    isPopular: product.isPopular,
                    isWishlisted: !(product.isWishlisted ?? false),
                    image: product.image,
                  );
                });
              },
            );
          },
        ),
      ),
    );
  }
}
