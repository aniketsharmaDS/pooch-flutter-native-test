import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/widgets/list_grid/app_paginated_list_view.dart';
import 'package:poochcare/core/widgets/list_items/product_list_item_card.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';

/// =============================
/// SCREEN
/// =============================

@RoutePage()
class AppListScreen extends StatefulWidget {
  const AppListScreen({super.key});

  @override
  State<AppListScreen> createState() => _AppListScreenState();
}

class _AppListScreenState extends State<AppListScreen> {
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
        name: 'Buddy ${index + (page - 1) * 10}',
        age: '${2 + index} months',
        gender: index % 2 == 0 ? 'Male' : 'Female',
        isVaccinated: index % 2 == 0,
        price: 5000 + index * 200,
        deliveryText: 'Free delivery available',
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
    return AppPrimaryBgContainer(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: AppBar(
          title: const Text('Products'),
          backgroundColor: AppColors.transparent,
        ),
        body: SafeArea(
          child: AppPaginatedListView<ProductItem>(
            items: _items,
            isLoading: _isLoading,
            isLoadingMore: _isLoadingMore,
            hasMore: _hasMore,
            hasError: false,
            error: 'An error occurred while loading data.',
            onLoadMore: _loadMore,
            onRefresh: _refresh,
            onRetry: _loadInitial,

            itemBuilder: (product, index) {
              return ProductListItemCard(
                product: product,

                onTap: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(product.name)));
                },

                onDelete: () {
                  setState(() {
                    _items.removeAt(index);
                  });

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Deleted')));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
