import 'package:poochcare/features/pets/data/models/pet_model.dart';
import 'package:poochcare/features/pets/domain/models/pet.dart';

extension PetModelMapper on PetModel {
  Pet toDomain() {
    return Pet(
      profilePicture: profilePicture,
      bcsScore: bcsScore,
      name: name,
      type: type,
      breedId: breedId,
      gender: gender,
      dob: dob,
      size: size,
      weight: weight,
      height: height,
      heightUnit: heightUnit,
      weightUnit: weightUnit,
      healthInfo: healthInfo,
    );
  }
}
