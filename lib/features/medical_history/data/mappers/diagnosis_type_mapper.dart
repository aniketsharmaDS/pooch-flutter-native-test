import 'package:poochcare/features/medical_history/data/models/diagnosis_type_response.dart';
import 'package:poochcare/features/medical_history/domain/models/diagnosis_type.dart';

class DiagnosisTypeMapper {
  const DiagnosisTypeMapper._();

  static DiagnosisType toDomain(DiagnosisTypeResponse response) {
    return DiagnosisType(
      code: response.code,
      name: response.name,
      species: response.species,
    );
  }
}
