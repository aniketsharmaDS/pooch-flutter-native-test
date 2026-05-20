import 'package:equatable/equatable.dart';
import 'package:poochcare/core/domain/models/pet.dart';

sealed class PetsStoreEvent extends Equatable {
  const PetsStoreEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class PetsRefreshed extends PetsStoreEvent {
  const PetsRefreshed(this.pets);

  final List<Pet> pets;

  @override
  List<Object?> get props => <Object?>[pets];
}

class PetUpserted extends PetsStoreEvent {
  const PetUpserted(this.pet);

  final Pet pet;

  @override
  List<Object?> get props => <Object?>[pet];
}

class PetRemoved extends PetsStoreEvent {
  const PetRemoved(this.petId);

  final String petId;

  @override
  List<Object?> get props => <Object?>[petId];
}

class PetsCleared extends PetsStoreEvent {
  const PetsCleared();
}
