class PaginationResult<T> {
  const PaginationResult({
    required this.items,
    required this.currentPage,
    required this.hasMore,
    this.totalPages = 0,
    this.totalItems = 0,
  });

  final List<T> items;
  final int currentPage;
  final bool hasMore;
  final int totalPages;
  final int totalItems;
}
