part of 'buy_pet_detail_bloc.dart';

abstract class BuyPetDetailEvent extends Equatable {
  const BuyPetDetailEvent();

  @override
  List<Object?> get props => const <Object?>[];
}

class BuyPetDetailRequested extends BuyPetDetailEvent {
  const BuyPetDetailRequested(this.productId);

  final String productId;

  @override
  List<Object?> get props => <Object?>[productId];
}

class BuyPetDetailRefreshed extends BuyPetDetailEvent {
  const BuyPetDetailRefreshed(this.productId);

  final String productId;

  @override
  List<Object?> get props => <Object?>[productId];
}

class BuyPetDetailWishlistToggled extends BuyPetDetailEvent {
  const BuyPetDetailWishlistToggled();
}
