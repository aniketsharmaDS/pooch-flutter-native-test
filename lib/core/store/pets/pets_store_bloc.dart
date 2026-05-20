import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/domain/models/pet.dart';
import 'package:poochcare/core/store/pets/pets_store_event.dart';
import 'package:poochcare/core/store/pets/pets_store_state.dart';

class PetsStoreBloc extends Bloc<PetsStoreEvent, PetsStoreState> {
  PetsStoreBloc() : super(const PetsStoreState()) {
    on<PetsRefreshed>(_onPetsRefreshed);
    on<PetUpserted>(_onPetUpserted);
    on<PetRemoved>(_onPetRemoved);
    on<PetsCleared>(_onPetsCleared);
  }

  void _onPetsRefreshed(PetsRefreshed event, Emitter<PetsStoreState> emit) {
    final Map<String, Pet> petsById = {
      for (final Pet pet in event.pets) pet.id: pet,
    };
    emit(state.copyWith(petsById: petsById, petIds: petsById.keys.toList()));
  }

  void _onPetUpserted(PetUpserted event, Emitter<PetsStoreState> emit) {
    final Map<String, Pet> updated = Map<String, Pet>.from(state.petsById);
    updated[event.pet.id] = event.pet;
    final List<String> ids = state.petIds.contains(event.pet.id)
        ? state.petIds
        : [...state.petIds, event.pet.id];
    emit(state.copyWith(petsById: updated, petIds: ids));
  }

  void _onPetRemoved(PetRemoved event, Emitter<PetsStoreState> emit) {
    final Map<String, Pet> updated = Map<String, Pet>.from(state.petsById);
    updated.remove(event.petId);
    final List<String> ids = state.petIds
        .where((String id) => id != event.petId)
        .toList();
    emit(state.copyWith(petsById: updated, petIds: ids));
  }

  void _onPetsCleared(PetsCleared event, Emitter<PetsStoreState> emit) {
    emit(const PetsStoreState());
  }
}
