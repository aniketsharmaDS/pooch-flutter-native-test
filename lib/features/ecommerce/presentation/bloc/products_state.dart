part of 'products_bloc.dart';

class ProductsState extends Equatable {
  const ProductsState({
    this.isLoading = false,
    this.errorMessage,
    this.currentPage = 0,
    this.hasMore = true,
    this.isFetchingMore = false,
  });

  final bool isLoading;
  final String? errorMessage;
  final int currentPage;
  final bool hasMore;
  final bool isFetchingMore;

  ProductsState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    int? currentPage,
    bool? hasMore,
    bool? isFetchingMore,
  }) {
    return ProductsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    isLoading,
    errorMessage,
    currentPage,
    hasMore,
    isFetchingMore,
  ];
}
