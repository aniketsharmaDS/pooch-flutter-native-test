part of 'buy_pet_bloc.dart';

abstract class BuyPetEvent extends Equatable {
  const BuyPetEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class FetchProducts extends BuyPetEvent {
  const FetchProducts({this.isLoadMore = false});

  final bool isLoadMore;

  @override
  List<Object?> get props => <Object?>[isLoadMore];
}

class SearchProducts extends BuyPetEvent {
  const SearchProducts(this.query);

  final String query;

  @override
  List<Object?> get props => <Object?>[query];
}

class ChangePetType extends BuyPetEvent {
  const ChangePetType(this.petType);

  /// dog / cat
  final String petType;

  @override
  List<Object?> get props => <Object?>[petType];
}

class ChangeSort extends BuyPetEvent {
  const ChangeSort(this.sortType);

  final String sortType;

  @override
  List<Object?> get props => <Object?>[sortType];
}

class ClearSort extends BuyPetEvent {}

class OpenFilterDialogEvent extends BuyPetEvent {}

class ResetFilterDialogEvent extends BuyPetEvent {}

class ApplyFiltersEvent extends BuyPetEvent {
  final Map<String, Set<String>> selectedValues;

  const ApplyFiltersEvent(this.selectedValues);
}

class ClearFiltersEvent extends BuyPetEvent {}
