import 'package:poochcare/features/medical_history/data/api/medical_details_api_service.dart';
import 'package:poochcare/features/medical_history/data/models/medical_details_response_model.dart';
import 'package:poochcare/features/medical_history/data/models/medical_record_details_response_model.dart';

class MedicalDetailsRepository {
  MedicalDetailsRepository(this._api);
  final MedicalDetailsApiService _api;

  Future<MedicalDetailsData> getAppointmentDetails({
    required String appointmentId,
  }) async {
    try {
      return _api.getAppointmentDetails(appointmentId: appointmentId);
    } catch (e) {
      rethrow;
    }
  }

  Future<MedicalRecordData> getMedicalRecordsDetails({
    required String medicalRecordId,
  }) async {
    try {
      return _api.getMedicalRecordsDetails(medicalRecordId: medicalRecordId);
    } catch (e) {
      rethrow;
    }
  }
}
