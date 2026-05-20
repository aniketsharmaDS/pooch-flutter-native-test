import 'package:poochcare/features/medical_history/data/models/vaccination_type_response.dart';
import 'package:poochcare/features/medical_history/domain/models/vaccination_type.dart';

class VaccinationTypeMapper {
  const VaccinationTypeMapper._();

  static VaccinationType toDomain(VaccinationTypeResponse response) {
    return VaccinationType(
      id: response.id,
      species: response.species,
      vaccineCode: response.vaccineCode,
      vaccineName: response.vaccineName,
      vaccineNameAr: response.vaccineNameAr,
      isCore: response.isCore,
      mandatory: response.mandatory,
      lifestyleBased: response.lifestyleBased,
      countrySpecific: response.countrySpecific,
      minAgeWeeks: response.minAgeWeeks,
      maxAgeWeeks: response.maxAgeWeeks,
      repeatType: response.repeatType,
      notes: response.notes,
    );
  }
}
