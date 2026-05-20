class PaginationInfo {
  PaginationInfo({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
  });

  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;

  bool get hasMore => currentPage < totalPages;
}
