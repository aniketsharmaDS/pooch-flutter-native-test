import 'package:equatable/equatable.dart';
import 'package:poochcare/core/domain/models/pet.dart';

class PetsStoreState extends Equatable {
  const PetsStoreState({
    this.petsById = const <String, Pet>{},
    this.petIds = const <String>[],
  });

  final Map<String, Pet> petsById;
  final List<String> petIds;

  PetsStoreState copyWith({Map<String, Pet>? petsById, List<String>? petIds}) {
    return PetsStoreState(
      petsById: petsById ?? this.petsById,
      petIds: petIds ?? this.petIds,
    );
  }

  @override
  List<Object?> get props => <Object?>[petsById, petIds];
}
