import 'package:equatable/equatable.dart';

class PaginationState<T> extends Equatable {
  const PaginationState({
    // scope based logic
    this.scopedItems = const {},
    this.currentScope = '',

    this.items = const [],
    this.currentPage = 1,
    this.hasMore = true,
    this.isLoading = false,
    this.isFetchingMore = false,
    this.errorMessage,
    this.isRefreshing = false,
    this.isSearching = false,
    this.searchQuery = '',
    this.filters,
    this.totalPages = 0,
    this.totalItems = 0,

    // ✅ DETAIL SUPPORT
    this.selectedItem,
    this.isDetailLoading = false,
    this.isDetailRefreshing = false,
    this.isDetailsUpdating = false,
    this.detailError,

    // ✅ NEW (ACTION PROCESSING)
    this.processingMap = const <String, Set<String>>{},
  });

  // scope based logic
  final Map<String, List<T>> scopedItems;
  final String currentScope;

  final List<T> items;
  final int currentPage;
  final bool hasMore;
  final bool isLoading;
  final bool isFetchingMore;
  final String? errorMessage;
  final bool isRefreshing;
  final bool isSearching;
  final String searchQuery;
  final Map<String, dynamic>? filters;
  final int totalPages;
  final int totalItems;

  // ✅ DETAIL STATE
  final T? selectedItem;
  final bool isDetailLoading;
  final bool isDetailRefreshing;
  final String? detailError;
  final bool isDetailsUpdating;

  // ✅ ACTION STATE (VERY IMPORTANT)
  final Map<String, Set<String>> processingMap;

  PaginationState<T> copyWith({
    // scope based logic
    Map<String, List<T>>? scopedItems,
    String? currentScope,

    List<T>? items,
    int? currentPage,
    bool? hasMore,
    bool? isLoading,
    bool? isFetchingMore,
    String? errorMessage,
    bool clearError = false,
    bool? isRefreshing,
    bool? isSearching,
    String? searchQuery,
    Map<String, dynamic>? filters,
    bool clearFilters = false,
    int? totalPages,
    int? totalItems,

    // ✅ DETAIL
    T? selectedItem,
    bool clearSelectedItem = false,
    bool? isDetailLoading,
    bool? isDetailRefreshing,
    String? detailError,
    bool clearDetailError = false,
    bool? isDetailsUpdating,

    // ✅ NEW
    Map<String, Set<String>>? processingMap,
  }) {
    return PaginationState<T>(
      // scope based logic
      scopedItems: scopedItems ?? this.scopedItems,
      currentScope: currentScope ?? this.currentScope,

      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isSearching: isSearching ?? this.isSearching,
      searchQuery: searchQuery ?? this.searchQuery,
      filters: clearFilters ? null : (filters ?? this.filters),
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,

      // ✅ DETAIL HANDLING
      selectedItem: clearSelectedItem
          ? null
          : (selectedItem ?? this.selectedItem),
      isDetailLoading: isDetailLoading ?? this.isDetailLoading,
      isDetailRefreshing: isDetailRefreshing ?? this.isDetailRefreshing,
      detailError: clearDetailError ? null : (detailError ?? this.detailError),
      isDetailsUpdating: isDetailsUpdating ?? this.isDetailsUpdating,

      // ✅ IMPORTANT
      processingMap: processingMap ?? this.processingMap,
    );
  }

  // 👇👇👇 ADD HERE 👇👇👇
  bool isProcessing(String? id, String action) {
    if (id == null) return false;
    return processingMap[id]?.contains(action) ?? false;
  }

  @override
  List<Object?> get props => <Object?>[
    // scope based logic
    scopedItems,
    currentScope,

    items,
    currentPage,
    hasMore,
    isLoading,
    isFetchingMore,
    errorMessage,
    isRefreshing,
    isSearching,
    searchQuery,
    filters,
    totalPages,
    totalItems,

    // ✅ IMPORTANT (UI rebuild)
    selectedItem,
    isDetailLoading,
    isDetailRefreshing,
    detailError,
    isDetailsUpdating,

    // ✅ VERY IMPORTANT (without this UI won't update)
    processingMap,
  ];
}
