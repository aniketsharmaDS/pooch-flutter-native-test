import 'package:equatable/equatable.dart';
import 'package:poochcare/features/ecommerce/domain/models/product.dart';
import 'package:poochcare/features/ecommerce/presentation/view/buy_pet/common_pet_listing_screen.dart';

const _noChange = Object();

class BuyPetLandingState extends Equatable {
  const BuyPetLandingState({
    // Landing sections
    this.recentlyViewed = const <Product>[],
    this.popular = const <Product>[],
    this.featuredDogs = const <Product>[],
    this.featuredCats = const <Product>[],

    // Landing loading/errors
    this.isLoading = false,
    this.error,
    this.recentlyViewedError,
    this.popularError,
    this.featuredDogsError,
    this.featuredCatsError,

    // Listing
    this.allProducts = const <Product>[],
    this.currentPage = 1,
    this.hasNextPage = true,
    this.isLoadingMore = false,
    this.searchQuery,
    this.productListError,

    // Context
    this.currentListingType,
    this.listingPetType,
  });

  // ---------------- LANDING ----------------
  final List<Product> recentlyViewed;
  final List<Product> popular;
  final List<Product> featuredDogs;
  final List<Product> featuredCats;

  final bool isLoading;
  final String? error;

  final String? recentlyViewedError;
  final String? popularError;
  final String? featuredDogsError;
  final String? featuredCatsError;

  // ---------------- LISTING ----------------
  final List<Product> allProducts;
  final int currentPage;
  final bool hasNextPage;
  final bool isLoadingMore;
  final String? searchQuery;
  final String? productListError;

  // ---------------- CONTEXT ----------------
  final ListingType? currentListingType;
  final String? listingPetType;

  // ---------------- COPY ----------------
  BuyPetLandingState copyWith({
    // landing
    List<Product>? recentlyViewed,
    List<Product>? popular,
    List<Product>? featuredDogs,
    List<Product>? featuredCats,

    bool? isLoading,
    String? error,
    bool clearError = false,

    String? recentlyViewedError,
    String? popularError,
    String? featuredDogsError,
    String? featuredCatsError,
    bool clearSectionErrors = false,

    // listing
    List<Product>? allProducts,
    int? currentPage,
    bool? hasNextPage,
    bool? isLoadingMore,
    Object? searchQuery = _noChange,
    String? productListError,

    // context
    ListingType? currentListingType,
    String? listingPetType,
  }) {
    return BuyPetLandingState(
      recentlyViewed: recentlyViewed ?? this.recentlyViewed,
      popular: popular ?? this.popular,
      featuredDogs: featuredDogs ?? this.featuredDogs,
      featuredCats: featuredCats ?? this.featuredCats,

      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),

      recentlyViewedError: clearSectionErrors
          ? null
          : (recentlyViewedError ?? this.recentlyViewedError),
      popularError: clearSectionErrors
          ? null
          : (popularError ?? this.popularError),
      featuredDogsError: clearSectionErrors
          ? null
          : (featuredDogsError ?? this.featuredDogsError),
      featuredCatsError: clearSectionErrors
          ? null
          : (featuredCatsError ?? this.featuredCatsError),

      allProducts: allProducts ?? this.allProducts,
      currentPage: currentPage ?? this.currentPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,

      // 🔥 FIXED
      searchQuery: searchQuery == _noChange
          ? this.searchQuery
          : searchQuery as String?,

      productListError: productListError ?? this.productListError,

      currentListingType: currentListingType ?? this.currentListingType,
      listingPetType: listingPetType ?? this.listingPetType,
    );
  }

  @override
  List<Object?> get props => [
    recentlyViewed,
    popular,
    featuredDogs,
    featuredCats,
    isLoading,
    error,
    recentlyViewedError,
    popularError,
    featuredDogsError,
    featuredCatsError,
    allProducts,
    currentPage,
    hasNextPage,
    isLoadingMore,
    searchQuery,
    productListError,
    currentListingType,
    listingPetType,
  ];
}
