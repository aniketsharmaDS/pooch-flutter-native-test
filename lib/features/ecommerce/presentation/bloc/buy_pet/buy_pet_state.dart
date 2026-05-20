part of 'buy_pet_bloc.dart';

class BuyPetState extends Equatable {
  const BuyPetState({
    this.products = const <Product>[],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasNextPage = true,
    this.page = 1,
    this.petType = 'dog',
    this.search = '',
    this.sortBy = 'price',
    this.sortOrder = 'ASC',
    this.selectedSort,
    this.error,
    this.isFiltersLoading = false,
    this.shouldOpenFilterDialog = false,
    this.filters,
    this.filterPetType,
    this.filtersByPetType = const {},
    this.breedsByPetType = const {},
    this.filtersError,

    this.appliedFilters = const {},
    this.breeds = const [],
    this.isBreedsLoading = false,
  });

  final List<Product> products;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isFiltersLoading;
  final ProductFilters? filters;
  final String? filterPetType;
  final Map<String, Map<String, Set<String>>> filtersByPetType;
  final Map<String, List<Breed>> breedsByPetType;
  final String? filtersError;
  final bool shouldOpenFilterDialog;
  final Map<String, Set<String>> appliedFilters;
  final List<Breed> breeds;
  final bool isBreedsLoading;
  final bool hasNextPage;
  final int page;
  final String petType;
  final String search;
  final String sortBy;
  final String sortOrder;
  final String? selectedSort;
  final String? error;

  BuyPetState copyWith({
    List<Product>? products,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasNextPage,
    int? page,
    String? petType,
    String? search,
    String? sortBy,
    String? sortOrder,
    String? selectedSort,
    bool clearSelectedSort = false,
    String? error,
    bool clearError = false,
    bool? isFiltersLoading,
    ProductFilters? filters,
    String? filterPetType,
    Map<String, Map<String, Set<String>>>? filtersByPetType,
    Map<String, List<Breed>>? breedsByPetType,
    String? filtersError,
    bool clearFiltersError = false,
    bool? shouldOpenFilterDialog,
    Map<String, Set<String>>? appliedFilters,
    List<Breed>? breeds,
    bool? isBreedsLoading,
  }) {
    return BuyPetState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isFiltersLoading: isFiltersLoading ?? this.isFiltersLoading,
      filters: filters ?? this.filters,
      filterPetType: filterPetType ?? this.filterPetType,
      filtersByPetType: filtersByPetType ?? this.filtersByPetType,
      breedsByPetType: breedsByPetType ?? this.breedsByPetType,
      filtersError: clearFiltersError
          ? null
          : (filtersError ?? this.filtersError),
      selectedSort: clearSelectedSort
          ? null
          : (selectedSort ?? this.selectedSort),
      page: page ?? this.page,
      petType: petType ?? this.petType,
      search: search ?? this.search,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
      error: clearError ? null : (error ?? this.error),
      shouldOpenFilterDialog:
          shouldOpenFilterDialog ?? this.shouldOpenFilterDialog,
      appliedFilters: appliedFilters ?? this.appliedFilters,
      breeds: breeds ?? this.breeds,
      isBreedsLoading: isBreedsLoading ?? this.isBreedsLoading,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    products,
    isLoading,
    isLoadingMore,
    hasNextPage,
    page,
    petType,
    search,
    sortBy,
    sortOrder,
    selectedSort,
    error,
    isFiltersLoading,
    filters,
    filterPetType,
    filtersByPetType,
    filtersError,
    shouldOpenFilterDialog,
    appliedFilters,
    breedsByPetType,
    breeds,
    isBreedsLoading,
  ];
}
