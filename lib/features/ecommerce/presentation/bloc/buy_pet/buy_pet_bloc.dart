import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/features/ecommerce/data/models/buy_pet/product_filters_model.dart';
import 'package:poochcare/features/ecommerce/domain/models/paginated_products.dart';
import 'package:poochcare/features/ecommerce/domain/models/product.dart';
import 'package:poochcare/features/ecommerce/domain/repository/buy_pet_repository.dart';
import 'package:poochcare/features/pets/domain/models/breed.dart';

part 'buy_pet_event.dart';
part 'buy_pet_state.dart';

class BuyPetBloc extends Bloc<BuyPetEvent, BuyPetState> {
  BuyPetBloc({required BuyPetRepository repository})
    : _repository = repository,
      super(const BuyPetState()) {
    on<FetchProducts>(_onFetchProducts);
    on<SearchProducts>(_onSearchProducts);
    on<ChangePetType>(_onChangePetType);
    on<ChangeSort>(_onChangeSort);
    on<OpenFilterDialogEvent>(_onOpenFilterDialog);
    on<ResetFilterDialogEvent>(_onResetFilterDialog);
    on<ApplyFiltersEvent>(_onApplyFilters);
    on<ClearFiltersEvent>(_onClearFilters);
    on<ClearSort>(_onClearSort);
  }

  final BuyPetRepository _repository;

  String _sortType = 'Price: Low to High';

  Future<void> _onFetchProducts(
    FetchProducts event,
    Emitter<BuyPetState> emit,
  ) async {
    // Guard against invalid states
    if (event.isLoadMore && !state.hasNextPage) return;
    if (state.isLoading || state.isLoadingMore) return;

    // String? mapValue(String key) {
    //   final values = state.appliedFilters[key];
    //   if (values == null || values.isEmpty) return null;
    //   return values.join(',');
    // }

    String? mapSingle(Map<String, Set<String>> source, String key) {
      final values = source[key];
      if (values == null || values.isEmpty) return null;
      return values.first;
    }

    List<String>? mapMulti(Map<String, Set<String>> source, String key) {
      final values = source[key];
      if (values == null || values.isEmpty) return null;
      return values.toList();
    }

    emit(
      state.copyWith(
        isLoading: state.page == 1 && !event.isLoadMore,
        isLoadingMore: event.isLoadMore,
        clearError: true,
      ),
    );

    try {
      final PaginatedProducts result = await _repository.getProducts(
        page: state.page,
        petType: state.petType,
        search: state.search,
        sortBy: state.sortBy,
        sortOrder: state.sortOrder,
        gender: mapMulti(state.appliedFilters, 'gender'),
        breed: mapMulti(state.appliedFilters, 'breed'),
        size: mapSingle(state.appliedFilters, 'size'),
        lifeStage: mapMulti(state.appliedFilters, 'lifeStage'),
        energyLevel: mapMulti(state.appliedFilters, 'energyLevel'),
        grooming: mapMulti(state.appliedFilters, 'grooming'),
        temperament: mapMulti(state.appliedFilters, 'temperament'),
        subcategory: mapMulti(state.appliedFilters, 'subcategory'),
        allergy: mapMulti(state.appliedFilters, 'allergy'),
      );
      final List<Product> updatedProducts = event.isLoadMore
          ? <Product>[...state.products, ...result.products]
          : result.products;

      emit(
        state.copyWith(
          products: updatedProducts,
          page: state.page + 1,
          hasNextPage: result.hasNextPage,
          isLoading: false,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          error: _mapError(e),
        ),
      );
    }
  }

  void _onSearchProducts(SearchProducts event, Emitter<BuyPetState> emit) {
    emit(
      state.copyWith(
        search: event.query,
        products: const <Product>[],
        page: 1,
        hasNextPage: true,
        clearError: true,
        isLoading: false,
        isLoadingMore: false,
      ),
    );
  }

  void _onChangePetType(ChangePetType event, Emitter<BuyPetState> emit) {
    final savedFilters = state.filtersByPetType[event.petType] ?? {};
    final savedBreeds = state.breedsByPetType[event.petType] ?? [];
    emit(
      state.copyWith(
        petType: event.petType,
        appliedFilters: savedFilters,
        breeds: savedBreeds,
        products: const <Product>[],
        page: 1,
        hasNextPage: true,
        clearError: true,
        isLoading: false,
        isLoadingMore: false,
      ),
    );
  }

  void _onChangeSort(ChangeSort event, Emitter<BuyPetState> emit) {
    _sortType = event.sortType;
    final (String sortBy, String sortOrder) = _getSortParams();

    emit(
      state.copyWith(
        sortBy: sortBy,
        sortOrder: sortOrder,
        selectedSort: event.sortType,
        products: const <Product>[],
        page: 1,
        hasNextPage: true,
        clearError: true,
        isLoading: false,
        isLoadingMore: false,
      ),
    );
  }

  Future<void> _onClearSort(ClearSort event, Emitter<BuyPetState> emit) async {
    const defaultSort = 'Price: Low to High';
    _sortType = defaultSort;

    final (sortBy, sortOrder) = _getSortParams();

    emit(
      state.copyWith(
        clearSelectedSort: true, // ✅ also clear indicator
        sortBy: sortBy,
        sortOrder: sortOrder,
        page: 1,
        products: [],
        isLoading: true,
      ),
    );

    try {
      final result = await _repository.getProducts(
        page: 1,
        petType: state.petType,
        search: state.search,
        sortBy: sortBy,
        sortOrder: sortOrder,
      );

      emit(
        state.copyWith(
          isLoading: false,
          products: result.products,
          hasNextPage: result.hasNextPage,
          page: 1,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onOpenFilterDialog(
    OpenFilterDialogEvent event,
    Emitter<BuyPetState> emit,
  ) async {
    // already have filters → open immediately

    final hasFilters = state.filtersByPetType.containsKey(state.petType);
    final hasBreeds = state.breedsByPetType.containsKey(state.petType);
    // final isSamePetType = state.filterPetType == state.petType;

    if (hasFilters && hasBreeds) {
      emit(
        state.copyWith(
          breeds: state.breedsByPetType[state.petType] ?? [],
          shouldOpenFilterDialog: true,
        ),
      );
      return;
    }

    emit(state.copyWith(isFiltersLoading: true, isBreedsLoading: true));

    try {
      final filters = await _repository.getProductFilters(
        petType: state.petType,
      );

      final breeds = await _repository.getBreeds(petType: state.petType);

      final updatedBreedsMap = Map<String, List<Breed>>.from(
        state.breedsByPetType,
      );

      updatedBreedsMap[state.petType] = breeds;
      emit(
        state.copyWith(
          isFiltersLoading: false,
          filters: filters,
          // filterPetType: state.petType,
          breedsByPetType: updatedBreedsMap,
          breeds: breeds,
          isBreedsLoading: false,
          shouldOpenFilterDialog: true, // 🔥 trigger UI
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isFiltersLoading: false,
          isBreedsLoading: false,
          filtersError: e.toString(),
        ),
      );
    }
  }

  void _onResetFilterDialog(
    ResetFilterDialogEvent event,
    Emitter<BuyPetState> emit,
  ) {
    emit(state.copyWith(shouldOpenFilterDialog: false));
  }

  Future<void> _onApplyFilters(
    ApplyFiltersEvent event,
    Emitter<BuyPetState> emit,
  ) async {
    final filters = event.selectedValues;

    // Convert Set → comma separated string
    // String? mapValue(String key) {
    //   final values = filters[key];
    //   if (values == null || values.isEmpty) return null;
    //   return values.join(',');
    // }

    String? mapSingle(Map<String, Set<String>> source, String key) {
      final values = source[key];
      if (values == null || values.isEmpty) return null;
      return values.first;
    }

    List<String>? mapMulti(Map<String, Set<String>> source, String key) {
      final values = source[key];
      if (values == null || values.isEmpty) return null;
      return values.toList();
    }

    // final mappedFilters = {
    //   'petType': mapValue('petType') ?? state.petType,
    //   'gender': mapValue('gender'),
    //   'breed': mapValue('breed'),
    //   'size': mapValue('size'),
    //   'lifeStage': mapValue('lifeStage'),
    //   'energyLevel': mapValue('energyLevel'),
    //   'grooming': mapValue('grooming'),
    //   'temperament': mapValue('temperament'),
    //   'subcategory': mapValue('subcategory'),
    //   'allergy': mapValue('allergy'),
    // };

    final updatedMap = Map<String, Map<String, Set<String>>>.from(
      state.filtersByPetType,
    );

    updatedMap[state.petType] = event.selectedValues;

    emit(
      state.copyWith(
        page: 1,
        products: [],
        appliedFilters: event.selectedValues,
        filtersByPetType: updatedMap,
        isLoading: true,
      ),
    );

    try {
      final result = await _repository.getProducts(
        page: 1,
        petType: mapSingle(filters, 'petType') ?? state.petType,
        search: state.search,
        sortBy: state.sortBy,
        sortOrder: state.sortOrder,
        gender: mapMulti(filters, 'gender'),
        breed: mapMulti(filters, 'breed'),
        size: mapSingle(filters, 'size'),
        lifeStage: mapMulti(filters, 'lifeStage'),
        energyLevel: mapMulti(filters, 'energyLevel'),
        grooming: mapMulti(filters, 'grooming'),
        temperament: mapMulti(filters, 'temperament'),
        subcategory: mapMulti(filters, 'subcategory'),
        allergy: mapMulti(filters, 'allergy'),
      );
      emit(
        state.copyWith(
          isLoading: false,
          products: result.products,
          hasNextPage: result.hasNextPage,
          page: 1,
          appliedFilters: event.selectedValues,
          filtersByPetType: updatedMap, // ensure saved
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onClearFilters(
    ClearFiltersEvent event,
    Emitter<BuyPetState> emit,
  ) async {
    final updatedMap = Map<String, Map<String, Set<String>>>.from(
      state.filtersByPetType,
    );

    updatedMap[state.petType] = {};

    emit(
      state.copyWith(
        appliedFilters: {},
        filtersByPetType: updatedMap,
        page: 1,
        products: [],
        isLoading: true,
      ),
    );

    try {
      final result = await _repository.getProducts(
        page: 1,
        petType: state.petType,
        search: state.search,
        sortBy: state.sortBy,
        sortOrder: state.sortOrder,
        // ❌ no filters passed
      );
      emit(
        state.copyWith(
          isLoading: false,
          products: result.products,
          hasNextPage: result.hasNextPage,
          page: 1,
          appliedFilters: {}, // ensure clean
          filtersByPetType: updatedMap, // ensure saved
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  /// EXACT function required by spec.
  (String, String) _getSortParams() {
    switch (_sortType.trim().toLowerCase()) {
      case 'youngest to oldest':
        return ('age', 'ASC');
      case 'oldest to youngest':
        return ('age', 'DESC');
      case 'near to far':
        return ('distance', 'ASC');
      case 'far to near':
        return ('distance', 'DESC');
      case 'price: high to low':
        return ('price', 'DESC');
      case 'most popular':
        return ('popularity', 'DESC');
      case 'price: low to high':
      default:
        return ('price', 'ASC');
    }
  }

  String _mapError(Object error) {
    if (error is ApiException) return error.message;
    final text = error.toString();
    if (text.isNotEmpty) return text;
    return 'Something went wrong. Please try again.';
  }
}
