import 'package:poochcare/features/medical_history/data/models/lab_report_type_response.dart';
import 'package:poochcare/features/medical_history/domain/models/lab_report_type.dart';

class LabReportTypeMapper {
  const LabReportTypeMapper._();

  static LabReportType toDomain(LabReportTypeResponse response) {
    return LabReportType(
      code: response.code,
      name: response.name,
      species: response.species,
    );
  }
}
