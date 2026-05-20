import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/ecommerce/domain/models/product.dart';
import 'package:poochcare/features/ecommerce/domain/repository/buy_pet_repository.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final BuyPetRepository repository;

  WishlistBloc(this.repository) : super(const WishlistState()) {
    on<ToggleWishlistEvent>(_onToggle);
    on<SyncWishlistEvent>(_onSync);
    on<FetchWishlistEvent>(_onFetch);
    on<SearchWishlistEvent>(_onSearch);
    on<FetchWishlistCountEvent>(_onFetchCount);
    on<ResetWishlistEvent>(_onReset);
  }

  Future<void> _onToggle(
    ToggleWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    final isWishlisted = state.wishlistIds.contains(event.productId);

    final updatedIds = Set<String>.from(state.wishlistIds);

    if (isWishlisted) {
      // ✅ REMOVE (optimistic)
      final updatedIds = Set<String>.from(state.wishlistIds)
        ..remove(event.productId);

      final updatedProducts = state.products
          .where((p) => p.id != event.productId)
          .toList();

      final updatedAllProducts = state.allProducts
          .where((p) => p.id != event.productId)
          .toList();

      emit(
        state.copyWith(
          wishlistIds: updatedIds,
          products: updatedProducts, // 🔥 REMOVE FROM LIST
          allProducts: updatedAllProducts, // 🔥 ALSO REMOVE FROM MASTER
          // wishlistCount: state.wishlistCount + 1,
          wishlistCount: (state.wishlistCount - 1),
          actionMessage: 'Removed from wishlist',
          actionId: state.actionId + 1,
        ),
      );

      try {
        await repository.removeFromWishlist(event.productId);
      } catch (_) {
        // ❌ rollback
        updatedIds.add(event.productId);
        emit(
          state.copyWith(
            wishlistIds: updatedIds,
            wishlistCount: (state.wishlistCount - 1), // ✅ restore
            actionMessage: 'Failed to add to wishlist', // ✅ correct message
            actionId: state.actionId + 1,
          ),
        );
      }
    } else {
      // ✅ ADD (optimistic)
      updatedIds.add(event.productId);
      emit(
        state.copyWith(
          wishlistIds: updatedIds,
          actionMessage: 'Added to wishlist',
          actionId: state.actionId + 1,
          wishlistCount: state.wishlistCount + 1,
        ),
      );

      try {
        await repository.addToWishlist(event.productId);
      } catch (_) {
        // ❌ rollback
        updatedIds.remove(event.productId);
        emit(
          state.copyWith(
            wishlistIds: updatedIds,
            wishlistCount: state.wishlistCount + 1, // ✅ restore
            actionMessage:
                'Failed to remove from wishlist', // ✅ correct message
            actionId: state.actionId + 1,
          ),
        );
      }
    }
  }

  void _onSync(SyncWishlistEvent event, Emitter<WishlistState> emit) {
    final updated = Set<String>.from(state.wishlistIds)
      ..addAll(event.productIds);

    emit(state.copyWith(wishlistIds: updated));
  }

  Future<void> _onFetch(
    FetchWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    if (state.isLoading) return;

    // Different behavior for refresh vs pagination
    if (event.page == 1) {
      emit(
        state.copyWith(
          isLoading: true,
          products: [], // clear old list on refresh
          page: 1,
        ),
      );
    } else {
      emit(state.copyWith(isLoading: true));
    }

    // emit(state.copyWith(isLoading: true));

    try {
      final res = await repository.getWishlist(page: event.page);

      final List<Product> newProducts = event.page == 1
          ? res.products
          : <Product>[...state.allProducts, ...res.products];

      // Sync wishlist IDs globally
      final updatedIds = Set<String>.from(state.wishlistIds)
        ..addAll(res.products.map((e) => e.id));

      emit(
        state.copyWith(
          isLoading: false,
          products: newProducts,
          allProducts: newProducts, // keep master list updated
          page: event.page,
          hasNextPage: res.hasNextPage,
          wishlistIds: updatedIds,
          // wishlistCount: newProducts.length,
        ),
      );
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onSearch(SearchWishlistEvent event, Emitter<WishlistState> emit) {
    final query = event.query.toLowerCase();

    if (query.isEmpty) {
      emit(
        state.copyWith(
          products: state.allProducts, // ✅ restore full list
          searchQuery: '',
        ),
      );
      return;
    }

    final filteredProducts = state.allProducts.where((product) {
      final name = product.name.toLowerCase();
      final breed = (product.petDetails?.breedName ?? '').toLowerCase();

      return name.contains(query) || breed.contains(query);
    }).toList();

    emit(
      state.copyWith(
        products: filteredProducts, // ✅ ONLY update products
        searchQuery: event.query,
      ),
    );
  }

  Future<void> _onFetchCount(
    FetchWishlistCountEvent event,
    Emitter<WishlistState> emit,
  ) async {
    try {
      final count = await repository.getWishlistCount();

      emit(state.copyWith(wishlistCount: count));
    } catch (_) {
      // ignore or handle silently
    }
  }

  void _onReset(ResetWishlistEvent event, Emitter<WishlistState> emit) {
    emit(const WishlistState());
  }
}
