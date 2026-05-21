import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/core/errors/error_mapper.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/appointments/data/models/appointments_response_model.dart';
import 'package:poochcare/features/insight/data/models/appointment_cal_response_model.dart';
import 'package:poochcare/features/insight/data/models/clinic_details_response_model.dart';
import 'package:poochcare/features/insight/data/models/clinic_list_request_model.dart';
import 'package:poochcare/features/insight/data/models/clinic_list_response_model.dart';
import 'package:poochcare/features/insight/data/models/clinic_subs_plans_response_model.dart';
import 'package:poochcare/features/insight/data/models/clinic_subs_preview_response_model.dart';
import 'package:poochcare/features/insight/data/models/subscribed_clinics_response_model.dart';
import 'package:poochcare/features/insight/data/models/symptom_response.dart';

class ClinicsApiService {
  const ClinicsApiService(this._dio);

  final Dio _dio;

  static const String _clinicsPath = '/telemedicine/clinics';
  static const String _popularClinicsPath = '/telemedicine/popular-clinics';
  static const String _mySubscribedClinicsPath =
      '/telemedicine/my-subscribed-clinics';
  static const String _purchaseSubscriptionPath = '/subscriptions/purchase';
  static const String _filterOptionsPath = '/telemedicine/filter-options';
  static const String _appointmentsPath = '/vet-clinic/appointments';
  static const String _myAppointmentsPath = '/vet-clinic/appointments/users/me';
  static const String _symptoms = '/medical-history/symptom-types';

  Future<ClinicListResponseModel> getAllClinics({
    required ClinicListRequestModel request,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        _clinicsPath,
        data: request.toMap(),
      );

      final dynamic body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to fetch clinics',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body;

      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return ClinicListResponseModel.fromMap(payload);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<ClinicDetailsResponseModel> getClinicDetails({
    required String clinicId,
  }) async {
    try {
      final response = await _dio.get<dynamic>('$_clinicsPath/$clinicId');

      final dynamic body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to fetch clinic details',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body;

      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return ClinicDetailsResponseModel.fromMap(payload);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<ClinicListResponseModel> getPopularClinics({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        _popularClinicsPath,
        queryParameters: {'page': page, 'limit': limit},
      );

      final dynamic body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to fetch popular clinics',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body;

      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return ClinicListResponseModel.fromMap(payload);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<ClinicSubsPlansResponseModel> getClinicPlans({
    required String clinicId,
    required String petId,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        '/subscriptions/clinics/$clinicId/plans',
        data: {'petId': petId},
      );

      final dynamic body = response.data;

      if (body is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return ClinicSubsPlansResponseModelMapper.fromMap(body);
    } on DioException catch (error) {
      log('Sorted Plans: payload: 2');
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<SubscribedClinicsResponseModel> getSubscribedClinics({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        _mySubscribedClinicsPath,
        queryParameters: {'page': page, 'limit': limit},
      );

      final dynamic body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to fetch subscribed clinics',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body;

      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return SubscribedClinicsResponseModel.fromMap(payload);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<ClinicSubsPreviewResponseModel> getSubsPreview({
    required String clinicId,
    required String petId,
    required String subscriptionPlanId,
    required String consultationType,
    String promotionId = '',
    String couponCode = '',
  }) async {
    try {
      final Map<String, dynamic> data = {
        'clinic_id': clinicId,
        'pet_id': petId,
        'subscription_plan_id': subscriptionPlanId,
        'consultation_type': consultationType,
      };

      if (promotionId.toString().trim().isNotEmpty) {
        data['promotion_id'] = promotionId;
      }

      if (couponCode.toString().trim().isNotEmpty) {
        data['couponCode'] = couponCode;
      }

      final response = await _dio.post<dynamic>(
        '/appointments/booking-summary',
        data: data,
      );

      final dynamic body = response.data;
      if (body is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return ClinicSubsPreviewResponseModelMapper.fromMap(body);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<void> purchaseSubscription({
    required String clinicId,
    required String planId,
    required String petId,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        _purchaseSubscriptionPath,
        data: {'clinicId': clinicId, 'planId': planId, 'petId': petId},
      );

      final dynamic body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to purchase subscription',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
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
    try {
      final Map<String, dynamic> data = {
        'pet_id': petId,
        'clinic_id': clinicId,
        'appointment_date': appointmentDate,
        'appointment_time': appointmentTime,
        'consultation_type': consultationType,
        'chief_complaint': chiefComplaint,
        'priority': priority,
        'duration_minutes': durationMinutes,
      };

      // ✅ Merge Find Vet payload if available
      if (findPayload != null && findPayload.isNotEmpty) {
        data.addAll(findPayload);
      }

      final response = await _dio.post<dynamic>(
        _appointmentsPath,
        data: data,
        // data: {
        //   'pet_id': petId,
        //   'clinic_id': clinicId,
        //   'appointment_date': appointmentDate,
        //   'appointment_time': appointmentTime,
        //   'consultation_type': consultationType,
        //   'chief_complaint': chiefComplaint,
        //   'priority': priority,
        //   'duration_minutes': durationMinutes,

        //   'symptoms': '', // Optional: can be sent based on user input
        //   'duration': '', // Optional: can be sent based on user input
        //   'medication': '', // Optional: can be sent based on user input
        //   'notes': '', // Optional: can be sent based on user input
        //   'documents': [
        //     {
        //       'id': '1778652705783',
        //       'fileName': 'Gaurav_Resume (2).pdf',
        //       'url':
        //           'https://pooch-developments.s3.amazonaws.com/findVets/1ed9d2da-e9f5-4c0a-91a4-7799d5c096ad/otherDocuments/Gaurav_Resume%20%282%29-1778652704784-438da656.pdf?AWSAccessKeyId=AKIAX2HPUGWIASJM2XUV&Expires=1778695904&Signature=RMg7cKdrwymroYW0KufbVFRxNrc%3D',
        //       'type': 'application/pdf',
        //       'fileSize': '130324',
        //     },
        //   ], // Optional: can be sent based on user input (list of document URLs or IDs)
        // },
      );

      final dynamic body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to book appointment',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<ClinicAvailableFiltersModel> getFilterOptions() async {
    try {
      final response = await _dio.get<dynamic>(_filterOptionsPath);

      final dynamic body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to fetch filter options',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body;

      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return ClinicAvailableFiltersModel.fromMap(payload);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<AppointmentsResponseModel> getAllAppointments({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        _myAppointmentsPath,
        queryParameters: {'page': page, 'limit': limit},
      );

      final dynamic body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to fetch appointments',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body;

      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return AppointmentsResponseModel.fromMap(payload);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<List<AppointmentItem>> getAllCalendarAppointments({
    required String selectedDate,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        '/appointments/users/me/month?date=$selectedDate',
      );

      final dynamic body = response.data;

      final AppointmentCalResponseModel result =
          AppointmentCalResponseModelMapper.fromMap(
            body as Map<String, dynamic>,
          );

      if (!result.success) {
        throw ApiException(
          result.message.isNotEmpty
              ? result.message
              : 'Unable to fetch appointments',
          code: 'API_ERROR',
          statusCode: result.status,
        );
      }

      return result.data.appointments;
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    } catch (error) {
      throw ApiException(error.toString(), statusCode: 500);
    }
  }

  Future<AppointmentApiModel> getAppointmentDetails({
    required String appointmentId,
  }) async {
    try {
      final response = await _dio.get<dynamic>('/appointments/$appointmentId');

      final dynamic body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to fetch appointment details',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body;

      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return AppointmentApiModel.fromMap(payload);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  /// Get all symptoms
  Future<SymptomResponse> getSymptoms() async {
    try {
      final response = await _dio.get<dynamic>(_symptoms);

      final dynamic body = response.data;

      if (body is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return SymptomResponse.fromJson(body);
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }
}
