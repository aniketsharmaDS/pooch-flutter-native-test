import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/features/ecommerce/domain/models/paginated_products.dart';
import 'package:poochcare/features/ecommerce/domain/models/product.dart';
import 'package:poochcare/features/ecommerce/domain/repository/buy_pet_repository.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet_landing/buy_pet_landing_state.dart';
import 'package:poochcare/features/ecommerce/presentation/view/buy_pet/common_pet_listing_screen.dart';

part 'buy_pet_landing_event.dart';

class BuyPetLandingBloc extends Bloc<BuyPetLandingEvent, BuyPetLandingState> {
  String? _mergeErrors(List<String?> errors) {
    final items = errors.whereType<String>().where((e) => e.trim().isNotEmpty);
    final list = items.toList(growable: false);

    if (list.isEmpty) return null;
    if (list.length == 1) return list.first;

    return 'Some sections failed to load.';
  }

  String _mapError(Object error) {
    if (error is ApiException) return error.message;

    final text = error.toString();
    if (text.isNotEmpty) return text;

    return 'Something went wrong. Please try again.';
  }

  BuyPetLandingBloc({required BuyPetRepository repository})
    : _repository = repository,
      super(const BuyPetLandingState()) {
    on<FetchLandingData>(_onFetchLandingData);
    on<FetchProducts>(_onFetchProducts);
    on<LoadMoreProducts>(_onLoadMoreProducts);
    on<SearchProducts>(_onSearchProducts);
    on<SetListingContext>(_onSetListingContext);
    on<FetchRecentlyViewedOnly>(_onFetchRecentlyViewedOnly);
  }
  // --- Product Listing Logic ---
  Future<void> _onFetchProducts(
    FetchProducts event,
    Emitter<BuyPetLandingState> emit,
  ) async {
    final isFirstPage = event.page == 1;
    final isSearch = event.search != null;

    if (!isSearch && (state.isLoading || state.isLoadingMore)) return;

    if (isFirstPage) {
      emit(
        state.copyWith(
          isLoading: true,
          allProducts: [],
          currentPage: 1,
          hasNextPage: true,
        ),
      );
    } else {
      emit(state.copyWith(isLoadingMore: true));
    }

    try {
      late PaginatedProducts result;

      switch (state.currentListingType) {
        case ListingType.recentlyViewed:
          result = await _repository.getRecentlyViewed(
            page: event.page,
            search: event.search ?? state.searchQuery,
          );
          break;

        case ListingType.mostPopular:
          result = await _repository.getPopularProducts(
            page: event.page,
            search: event.search ?? state.searchQuery,
          );
          break;

        case ListingType.featuredDogs:
          result = await _repository.getFeaturedProducts(
            page: event.page,
            search: event.search ?? state.searchQuery,
            petType: 'dog',
          );
          break;

        case ListingType.featuredCats:
          result = await _repository.getFeaturedProducts(
            page: event.page,
            search: event.search ?? state.searchQuery,
            petType: 'cat',
          );
          break;

        case null:
          result = await _repository.getProducts(
            page: event.page,
            petType: event.petType,
            search: event.search ?? state.searchQuery,
            sortBy: event.sortBy,
            sortOrder: event.sortOrder,
          );
          break;
        case ListingType.all:
          result = await _repository.getProducts(
            page: event.page,
            petType: event.petType,
            search: event.search ?? state.searchQuery,
            sortBy: event.sortBy,
            sortOrder: event.sortOrder,
          );
          break;
      }
      final List<Product> newList = isFirstPage
          ? result.products
          : [...state.allProducts, ...result.products];
      emit(
        state.copyWith(
          allProducts: newList,
          currentPage: result.currentPage,
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
          productListError: _mapError(e),
        ),
      );
    }
  }

  Future<void> _onLoadMoreProducts(
    LoadMoreProducts event,
    Emitter<BuyPetLandingState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasNextPage) return;
    add(FetchProducts(page: state.currentPage + 1, search: state.searchQuery));
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<BuyPetLandingState> emit,
  ) async {
    emit(
      state.copyWith(
        searchQuery: event.query,
        currentPage: 1,
        hasNextPage: true,
        allProducts: [],
      ),
    );
    add(FetchProducts(search: event.query));
  }

  final BuyPetRepository _repository;

  Future<void> _onFetchLandingData(
    FetchLandingData event,
    Emitter<BuyPetLandingState> emit,
  ) async {
    if (state.isLoading) return;

    emit(
      state.copyWith(
        isLoading: true,
        clearError: true,
        clearSectionErrors: true,
      ),
    );

    String? recentlyViewedError;
    String? popularError;
    String? featuredDogsError;
    String? featuredCatsError;

    final futures = <Future<PaginatedProducts>>[
      _repository.getRecentlyViewed(page: 1).catchError((
        Object e,
        StackTrace _,
      ) {
        recentlyViewedError = _mapError(e);
        return const PaginatedProducts(
          products: [],
          currentPage: 1,
          hasNextPage: false,
        );
      }),

      _repository.getPopularProducts(page: 1).catchError((
        Object e,
        StackTrace _,
      ) {
        popularError = _mapError(e);
        return const PaginatedProducts(
          products: [],
          currentPage: 1,
          hasNextPage: false,
        );
      }),

      _repository.getFeaturedProducts(page: 1, petType: 'dog').catchError((
        Object e,
        StackTrace _,
      ) {
        featuredDogsError = _mapError(e);
        return const PaginatedProducts(
          products: [],
          currentPage: 1,
          hasNextPage: false,
        );
      }),

      _repository.getFeaturedProducts(page: 1, petType: 'cat').catchError((
        Object e,
        StackTrace _,
      ) {
        featuredCatsError = _mapError(e);
        return const PaginatedProducts(
          products: [],
          currentPage: 1,
          hasNextPage: false,
        );
      }),
    ];

    final results = await Future.wait(futures);

    final mergedError = _mergeErrors([
      recentlyViewedError,
      popularError,
      featuredDogsError,
      featuredCatsError,
    ]);

    emit(
      state.copyWith(
        recentlyViewed: results[0].products.take(10).toList(),
        popular: results[1].products.take(10).toList(),
        featuredDogs: results[2].products.take(10).toList(),
        featuredCats: results[3].products.take(10).toList(),
        isLoading: false,
        error: mergedError,
        recentlyViewedError: recentlyViewedError,
        popularError: popularError,
        featuredDogsError: featuredDogsError,
        featuredCatsError: featuredCatsError,
      ),
    );
  }

  Future<void> _onSetListingContext(
    SetListingContext event,
    Emitter<BuyPetLandingState> emit,
  ) async {
    emit(
      state.copyWith(
        currentListingType: event.type,
        listingPetType: event.petType,
        //  RESET SEARCH
        searchQuery: null,

        // reset listing state
        allProducts: [],
        currentPage: 1,
        hasNextPage: true,
        isLoadingMore: false,
      ),
    );

    // 🔥 Trigger first fetch automatically
    add(const FetchProducts());
  }

  Future<void> _onFetchRecentlyViewedOnly(
    FetchRecentlyViewedOnly event,
    Emitter<BuyPetLandingState> emit,
  ) async {
    try {
      final result = await _repository.getRecentlyViewed(page: 1);

      emit(state.copyWith(recentlyViewed: result.products));
    } catch (e) {
      emit(state.copyWith(recentlyViewedError: _mapError(e)));
    }
  }
}
