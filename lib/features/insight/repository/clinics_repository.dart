import 'package:poochcare/features/appointments/data/models/appointments_response_model.dart';
import 'package:poochcare/features/insight/data/api/clinics_api_service.dart';
import 'package:poochcare/features/insight/data/models/appointment_cal_response_model.dart';
import 'package:poochcare/features/insight/data/models/clinic_details_response_model.dart';
import 'package:poochcare/features/insight/data/models/clinic_list_request_model.dart';
import 'package:poochcare/features/insight/data/models/clinic_list_response_model.dart';
import 'package:poochcare/features/insight/data/models/clinic_subs_plans_response_model.dart';
import 'package:poochcare/features/insight/data/models/clinic_subs_preview_response_model.dart';
import 'package:poochcare/features/insight/data/models/subscribed_clinics_response_model.dart';
import 'package:poochcare/features/insight/data/models/symptom_response.dart';

class ClinicsRepository {
  ClinicsRepository(this._api);

  final ClinicsApiService _api;
  SubscribedClinicsResponseModel? _subscribedClinicsCache;
  AppointmentsResponseModel? _appointmentsCache;

  Future<ClinicListResponseModel> getAllClinics({
    required ClinicListRequestModel request,
  }) async {
    final response = await _api.getAllClinics(request: request);

    return response;
  }

  Future<ClinicDetailsResponseModel> getClinicDetails({
    required String clinicId,
  }) {
    return _api.getClinicDetails(clinicId: clinicId);
  }

  Future<ClinicListResponseModel> getPopularClinics({
    int page = 1,
    int limit = 10,
  }) {
    return _api.getPopularClinics(page: page, limit: limit);
  }

  Future<ClinicSubsPlansResponseModel> getClinicPlans({
    required String clinicId,
    required String petId,
  }) {
    return _api.getClinicPlans(clinicId: clinicId, petId: petId);
  }

  Future<SubscribedClinicsResponseModel> getSubscribedClinics({
    int page = 1,
    int limit = 10,
    bool isForceRefresh = false,
  }) async {
    if (_subscribedClinicsCache != null && !isForceRefresh) {
      return _subscribedClinicsCache!;
    }
    final response = await _api.getSubscribedClinics(page: page, limit: limit);
    _subscribedClinicsCache = response;
    return response;
  }

  Future<ClinicSubsPreviewResponseModel> getSubsPreview({
    required String clinicId,
    required String petId,
    required String subscriptionPlanId,
    required String consultationType,
    String promotionId = '',
    String couponCode = '',
  }) {
    return _api.getSubsPreview(
      clinicId: clinicId,
      petId: petId,
      subscriptionPlanId: subscriptionPlanId,
      consultationType: consultationType,
      promotionId: promotionId,
      couponCode: couponCode,
    );
  }

  Future<void> purchaseSubscription({
    required String clinicId,
    required String planId,
    required String petId,
  }) async {
    await _api.purchaseSubscription(
      clinicId: clinicId,
      planId: planId,
      petId: petId,
    );
    _subscribedClinicsCache = null;
  }

  Future<ClinicAvailableFiltersModel> getFilterOptions() {
    return _api.getFilterOptions();
  }

  Future<AppointmentsResponseModel> getAllAppointments({
    int page = 1,
    int limit = 10,
    bool isForceRefresh = false,
  }) async {
    if (_appointmentsCache != null && !isForceRefresh) {
      return _appointmentsCache!;
    }
    final response = await _api.getAllAppointments(page: page, limit: limit);
    _appointmentsCache = response;
    return response;
  }

  Future<List<AppointmentItem>> getAllCalendarAppointments({
    required String selectedDate,
  }) async {
    return await _api.getAllCalendarAppointments(selectedDate: selectedDate);
  }

  Future<AppointmentApiModel> getAppointmentDetails({
    required String appointmentId,
  }) async {
    try {
      return _api.getAppointmentDetails(appointmentId: appointmentId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createAppointment({
    required String petId,
    required String clinicId,
    required String appointmentDate,
    required String appointmentTime,
    required String consultationType,
    required String chiefComplaint,
    String priority = 'normal',
    int durationMinutes = 30,
    Map<String, dynamic>? findPayload,
  }) async {
    await _api.createAppointment(
      petId: petId,
      clinicId: clinicId,
      appointmentDate: appointmentDate,
      appointmentTime: appointmentTime,
      consultationType: consultationType,
      chiefComplaint: chiefComplaint,
      priority: priority,
      durationMinutes: durationMinutes,
      findPayload: findPayload,
    );
    _appointmentsCache = null;
  }

  /// Get all symptoms
  Future<SymptomResponse> getSymptoms() {
    return _api.getSymptoms();
  }
}
