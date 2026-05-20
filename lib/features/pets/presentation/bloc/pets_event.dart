import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:poochcare/features/pets/domain/models/pet.dart';

sealed class PetsEvent extends Equatable {
  const PetsEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class BreedsRequested extends PetsEvent {
  const BreedsRequested({required this.petType});

  final String petType;

  @override
  List<Object?> get props => <Object?>[petType];
}

class UploadPetProfileImageEvent extends PetsEvent {
  const UploadPetProfileImageEvent({required this.imageFile});

  final File imageFile;

  @override
  List<Object?> get props => <Object?>[imageFile];
}

class CreatePetEvent extends PetsEvent {
  const CreatePetEvent(this.pet);

  final Pet pet;

  @override
  List<Object?> get props => <Object?>[pet];
}

class AddPetRequested extends PetsEvent {
  const AddPetRequested(this.pet);

  final Pet pet;

  @override
  List<Object?> get props => <Object?>[pet];
}

class GetPetInsightsEvent extends PetsEvent {
  const GetPetInsightsEvent({required this.petId});

  final String petId;

  @override
  List<Object?> get props => <Object?>[petId];
}

class PetImageCleared extends PetsEvent {
  const PetImageCleared();

  @override
  List<Object?> get props => <Object?>[];
}
