import 'package:dio/dio.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/core/network/api_endpoints.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/medical_history/data/models/diagnosis_type_response.dart';
import 'package:poochcare/features/medical_history/data/models/lab_report_type_response.dart';
import 'package:poochcare/features/medical_history/data/models/medical_history_records_page_response.dart';
import 'package:poochcare/features/medical_history/data/models/vaccination_type_response.dart';

class MedicalHistoryApiService {
  const MedicalHistoryApiService(this._dio);

  final Dio _dio;

  static const String _vaccinationTypesPath =
      '/medical-history/vaccination-types';
  static const String _labReportTypesPath = '/medical-history/lab-report-types';
  static const String _diagnosisTypesPath = '/medical-history/diagnosis-types';

  static const String _createMedicalRecordPath = '/medical-history';
  static const String _createVaccinationRecordPath =
      '/medical-history/vaccinations';
  static const String _healthRecordsPath = '/medical-history/health-records';

  static const String _medicalHistoryPath = ApiEndpoints.medicalHistoryPath;

  Future<MedicalHistoryRecordsPageResponse> getMedicalHistoryRecords({
    String? petId,
    String? recordType,
    String? startDate,
    String? endDate,
    required int page,
    required int limit,
  }) async {
    try {
      final query = <String, dynamic>{'page': page, 'limit': limit};

      if (petId != null && petId.trim().isNotEmpty) {
        query['petId'] = petId.trim();
      }

      if (recordType != null && recordType.trim().isNotEmpty) {
        query['recordType'] = recordType.trim();
      }
      if (startDate != null && startDate.trim().isNotEmpty) {
        query['startDate'] = startDate.trim();
      }
      if (endDate != null && endDate.trim().isNotEmpty) {
        query['endDate'] = endDate.trim();
      }

      final Response<dynamic> response = await _dio.post<dynamic>(
        _medicalHistoryPath,
        data: query,
      );

      final dynamic body = response.data;
      if (body is! Map<String, dynamic>) {
        return MedicalHistoryRecordsPageResponse.fromPayload(
          body,
          page: page,
          limit: limit,
        );
      }

      final ApiResponse envelope = ApiResponseMapper.fromMap(body);
      if (!envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to fetch medical history records',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      return MedicalHistoryRecordsPageResponse.fromPayload(
        envelope.data,
        page: page,
        limit: limit,
      );
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<MedicalHistoryRecordsPageResponse> getMedicalHistoryRecordsPage({
    String? petId,
    String? recordType,
    String? startDate,
    String? endDate,
    required int page,
    required int limit,
  }) {
    return getMedicalHistoryRecords(
      petId: petId,
      recordType: recordType,
      startDate: startDate,
      endDate: endDate,
      page: page,
      limit: limit,
    );
  }

  Future<List<VaccinationTypeResponse>> getVaccinationTypes() async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        _vaccinationTypesPath,
      );
      final dynamic body = response.data;

      if (body is! Map<String, dynamic>) {
        return const <VaccinationTypeResponse>[];
      }

      final ApiResponse envelope = ApiResponseMapper.fromMap(body);
      if (!envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to fetch vaccination types',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope.data;
      if (payload is! List) {
        return const <VaccinationTypeResponse>[];
      }

      return payload
          .whereType<Map<String, dynamic>>()
          .map(VaccinationTypeResponse.fromMap)
          .where((item) => item.id > 0)
          .toList(growable: false);
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<List<DiagnosisTypeResponse>> getDiagnosisTypes() async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        _diagnosisTypesPath,
      );
      final dynamic body = response.data;

      if (body is! Map<String, dynamic>) {
        return const <DiagnosisTypeResponse>[];
      }

      final ApiResponse envelope = ApiResponseMapper.fromMap(body);
      if (!envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to fetch diagnosis types',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope.data;
      if (payload is! Map<String, dynamic>) {
        return const <DiagnosisTypeResponse>[];
      }

      final dynamic diagnosisTypes = payload['diagnosisTypes'];
      if (diagnosisTypes is! List) {
        return const <DiagnosisTypeResponse>[];
      }

      return diagnosisTypes
          .whereType<Map<String, dynamic>>()
          .map(DiagnosisTypeResponse.fromMap)
          .where((item) => item.code.trim().isNotEmpty)
          .toList(growable: false);
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<List<LabReportTypeResponse>> getLabReportTypes() async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        _labReportTypesPath,
      );
      final dynamic body = response.data;

      if (body is! Map<String, dynamic>) {
        return const <LabReportTypeResponse>[];
      }

      final ApiResponse envelope = ApiResponseMapper.fromMap(body);
      if (!envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to fetch lab report types',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope.data;
      if (payload is! Map<String, dynamic>) {
        return const <LabReportTypeResponse>[];
      }

      final dynamic labReportTypes = payload['labReportTypes'];
      if (labReportTypes is! List) {
        return const <LabReportTypeResponse>[];
      }

      return labReportTypes
          .whereType<Map<String, dynamic>>()
          .map(LabReportTypeResponse.fromMap)
          .where((item) => item.code.trim().isNotEmpty)
          .toList(growable: false);
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<void> saveMedicalHistoryRecord({
    required String endpoint,
    required dynamic payload,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        endpoint,
        data: payload,
      );

      final dynamic body = response.data;
      if (body is Map<String, dynamic> && body.containsKey('success')) {
        final ApiResponse envelope = ApiResponseMapper.fromMap(body);
        if (!envelope.success) {
          throw ApiException(
            envelope.message.isNotEmpty
                ? envelope.message
                : 'Unable to save medical record',
            code: 'API_ERROR',
            statusCode: envelope.status,
          );
        }
      }
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<void> createMedicalRecord({
    required String petId,
    required int vaccinationTypeId,
    required String clinicName,
    required DateTime visitDate,
    String? externalLink,
    required String recordType,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        _createMedicalRecordPath,
        data: <String, dynamic>{
          'petId': petId,
          'vaccinationTypeId': vaccinationTypeId,
          'clinicName': clinicName.trim(),
          'visitDate': visitDate.toIso8601String(),
          'externalLink': (externalLink ?? '').trim(),
          'recordType': recordType,
        },
      );

      final dynamic body = response.data;
      if (body is Map<String, dynamic> && body.containsKey('success')) {
        final ApiResponse envelope = ApiResponseMapper.fromMap(body);
        if (!envelope.success) {
          throw ApiException(
            envelope.message.isNotEmpty
                ? envelope.message
                : 'Unable to save medical record',
            code: 'API_ERROR',
            statusCode: envelope.status,
          );
        }
      }
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<void> createVaccinationRecord({
    required String petId,
    required String vaccinationName,
    required DateTime vaccinationDate,
    required String otherClinicName,
    required List<Map<String, dynamic>> documentUrls,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        _createVaccinationRecordPath,
        data: <String, dynamic>{
          'petId': petId,
          'vaccinationName': vaccinationName.trim(),
          'vaccinationDate': _formatDateYyyyMmDd(vaccinationDate),
          'otherClinicName': otherClinicName.trim(),
          'documentUrls': documentUrls,
        },
      );

      final dynamic body = response.data;
      if (body is Map<String, dynamic> && body.containsKey('success')) {
        final ApiResponse envelope = ApiResponseMapper.fromMap(body);
        if (!envelope.success) {
          throw ApiException(
            envelope.message.isNotEmpty
                ? envelope.message
                : 'Unable to save vaccination record',
            code: 'API_ERROR',
            statusCode: envelope.status,
          );
        }
      }
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<void> createHealthRecord({
    required String petId,
    required String otherClinicName,
    required DateTime recordedDate,
    required String healthIssue,
    required List<Map<String, dynamic>> documentUrls,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        _healthRecordsPath,
        data: <String, dynamic>{
          'petId': petId,
          'otherClinicName': otherClinicName.trim(),
          'recordedDate': _formatDateYyyyMmDd(recordedDate),
          'healthIssue': healthIssue.trim(),
          'documentUrls': documentUrls,
        },
      );

      final dynamic body = response.data;
      if (body is Map<String, dynamic> && body.containsKey('success')) {
        final ApiResponse envelope = ApiResponseMapper.fromMap(body);
        if (!envelope.success) {
          throw ApiException(
            envelope.message.isNotEmpty
                ? envelope.message
                : 'Unable to save vaccination record',
            code: 'API_ERROR',
            statusCode: envelope.status,
          );
        }
      }
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  ApiException _mapDioError(DioException error) {
    final int statusCode = error.response?.statusCode ?? 0;
    final dynamic responseData = error.response?.data;

    if (responseData is Map<String, dynamic>) {
      final String? message = responseData['message'] as String?;
      final String? code = responseData['code'] as String?;
      if (message != null && message.trim().isNotEmpty) {
        return ApiException(
          message,
          code: code ?? 'API_ERROR',
          statusCode: statusCode,
        );
      }
    }

    if (statusCode == 401) {
      return const ApiException(
        'Unauthorized request.',
        code: 'UNAUTHORIZED',
        statusCode: 401,
      );
    }

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return const ApiException(
        'Request timed out. Please try again.',
        code: 'TIMEOUT',
        statusCode: 408,
      );
    }

    if (error.type == DioExceptionType.connectionError) {
      return const ApiException('Something went wrong', code: 'NO_INTERNET');
    }

    return ApiException(
      'Something went wrong. Please try again.',
      code: 'API_ERROR',
      statusCode: statusCode,
    );
  }

  String _formatDateYyyyMmDd(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}
