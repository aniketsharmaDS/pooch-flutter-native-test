part of 'buy_pet_landing_bloc.dart';

abstract class BuyPetLandingEvent extends Equatable {
  const BuyPetLandingEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class FetchLandingData extends BuyPetLandingEvent {
  const FetchLandingData();
}

class FetchProducts extends BuyPetLandingEvent {
  final int page;
  final String? search;
  final String? petType;
  final String? sortBy;
  final String? sortOrder;
  const FetchProducts({
    this.page = 1,
    this.search,
    this.petType,
    this.sortBy,
    this.sortOrder,
  });

  @override
  List<Object?> get props => [page, search, petType, sortBy, sortOrder];
}

class LoadMoreProducts extends BuyPetLandingEvent {
  const LoadMoreProducts();
}

class SearchProducts extends BuyPetLandingEvent {
  final String query;
  const SearchProducts(this.query);

  @override
  List<Object?> get props => [query];
}

class SetListingContext extends BuyPetLandingEvent {
  final ListingType type;
  final String? petType;

  const SetListingContext({required this.type, this.petType});

  @override
  List<Object?> get props => [type, petType];
}

class FetchRecentlyViewedOnly extends BuyPetLandingEvent {
  const FetchRecentlyViewedOnly();
}
