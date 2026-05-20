import 'package:flutter/material.dart';
import 'package:poochcare/core/widgets/list_grid/app_empty_view.dart';
import 'package:poochcare/core/widgets/list_grid/app_error_view.dart';

typedef GridItemBuilder<T> = Widget Function(T item, int index);

class AppPaginatedGridView<T> extends StatefulWidget {
  final List<T> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;

  final VoidCallback onLoadMore;
  final Future<void> Function() onRefresh;
  final VoidCallback onRetry;

  final GridItemBuilder<T> itemBuilder;

  /// GRID CONFIG
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;

  const AppPaginatedGridView({
    super.key,
    required this.items,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasMore,
    required this.itemBuilder,
    required this.onLoadMore,
    required this.onRefresh,
    required this.onRetry,
    this.error,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 12,
    this.crossAxisSpacing = 12,
    this.childAspectRatio = 0.75,
  });

  @override
  State<AppPaginatedGridView<T>> createState() =>
      _AppPaginatedGridViewState<T>();
}

class _AppPaginatedGridViewState<T> extends State<AppPaginatedGridView<T>> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_controller.hasClients) return;

    final threshold = _controller.position.maxScrollExtent - 200;

    if (_controller.position.pixels >= threshold) {
      if (!widget.isLoadingMore && widget.hasMore) {
        widget.onLoadMore();
      }
    }
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// 🔵 INITIAL LOADING
    if (widget.isLoading && widget.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    /// 🔴 ERROR
    if (widget.error != null && widget.items.isEmpty) {
      return AppErrorView(message: widget.error!, onRetry: widget.onRetry);
    }

    /// 🟡 EMPTY
    if (widget.items.isEmpty) {
      return const AppEmptyView();
    }

    /// 🟢 CONTENT
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: GridView.builder(
        controller: _controller,

        /// 🔥 IMPORTANT FIX (same as list)
        physics: const AlwaysScrollableScrollPhysics(),

        padding: const EdgeInsets.all(16),

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          mainAxisSpacing: widget.mainAxisSpacing,
          crossAxisSpacing: widget.crossAxisSpacing,
          childAspectRatio: widget.childAspectRatio,
        ),

        itemCount: widget.items.length + (widget.isLoadingMore ? 1 : 0),

        itemBuilder: (context, index) {
          /// 🔽 BOTTOM LOADER (FULL WIDTH)
          if (index >= widget.items.length) {
            return const Center(child: CircularProgressIndicator());
          }

          return widget.itemBuilder(widget.items[index], index);
        },
      ),
    );
  }
}
