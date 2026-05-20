import 'package:poochcare/features/medical_history/data/models/medical_history_pet_response.dart';
import 'package:poochcare/features/medical_history/domain/models/medical_history_pet.dart';

class MedicalHistoryPetMapper {
  const MedicalHistoryPetMapper._();

  static MedicalHistoryPet toDomain(MedicalHistoryPetResponse response) {
    return MedicalHistoryPet(
      id: response.id,
      name: response.name,
      species: response.species,
    );
  }
}
