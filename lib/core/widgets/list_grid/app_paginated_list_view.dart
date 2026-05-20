import 'package:flutter/material.dart';
import 'package:poochcare/core/widgets/list_grid/app_empty_view.dart';
import 'package:poochcare/core/widgets/list_grid/app_error_view.dart';

typedef ItemBuilder<T> = Widget Function(T item, int index);

class AppPaginatedListView<T> extends StatefulWidget {
  final List<T> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final bool hasError;
  final String? error;

  final VoidCallback onLoadMore;
  final Future<void> Function() onRefresh;
  final VoidCallback onRetry;

  final ItemBuilder<T> itemBuilder;
  final EdgeInsetsGeometry? padding;

  const AppPaginatedListView({
    super.key,
    required this.items,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasMore,
    required this.itemBuilder,
    required this.onLoadMore,
    required this.onRefresh,
    required this.onRetry,
    this.padding,
    required this.hasError,
    this.error,
  });

  @override
  State<AppPaginatedListView<T>> createState() =>
      _AppPaginatedListViewState<T>();
}

class _AppPaginatedListViewState<T> extends State<AppPaginatedListView<T>> {
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

    /// 🔴 ERROR (ONLY when NO data)
    if (widget.error != null && widget.items.isEmpty && widget.hasError) {
      return AppErrorView(message: widget.error!, onRetry: widget.onRetry);
    }

    /// 🟡 EMPTY STATE
    if (widget.items.isEmpty) {
      return const AppEmptyView();
    }

    /// 🟢 CONTENT
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: ListView.separated(
        controller: _controller,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: widget.padding ?? EdgeInsets.zero,

        /// 🔥 FIXED: only show loader when loading more
        itemCount: widget.items.length + (widget.isLoadingMore ? 1 : 0),

        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 12),

        itemBuilder: (BuildContext context, int index) {
          /// 🔽 BOTTOM LOADER
          if (index >= widget.items.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return widget.itemBuilder(widget.items[index], index);
        },
      ),
    );
  }
}
