abstract class WishlistEvent {}

class ToggleWishlistEvent extends WishlistEvent {
  final String productId;

  ToggleWishlistEvent(this.productId);
}

class SyncWishlistEvent extends WishlistEvent {
  final List<String> productIds;

  SyncWishlistEvent(this.productIds);
}

class FetchWishlistEvent extends WishlistEvent {
  final int page;

  FetchWishlistEvent({this.page = 1});
}

class SearchWishlistEvent extends WishlistEvent {
  final String query;

  SearchWishlistEvent(this.query);
}

class FetchWishlistCountEvent extends WishlistEvent {}

class ResetWishlistEvent extends WishlistEvent {}
