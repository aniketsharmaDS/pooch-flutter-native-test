import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/core/errors/error_mapper.dart';
import 'package:poochcare/features/medical_history/data/models/medical_details_response_model.dart';
import 'package:poochcare/features/medical_history/data/models/medical_record_details_response_model.dart';

class MedicalDetailsApiService {
  const MedicalDetailsApiService(this._dio);

  final Dio _dio;

  Future<MedicalDetailsData> getAppointmentDetails({
    required String appointmentId,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        '/vet-clinic/appointments//$appointmentId',
      );

      final dynamic body = response.data;

      if (body is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }
      log('API Response for appointment details: $body');
      final medicalDetailsResponse = MedicalDetailsResponseModelMapper.fromMap(
        body,
      );
      log('API Response for appointment details: $medicalDetailsResponse');

      if (!medicalDetailsResponse.success) {
        throw ApiException(
          medicalDetailsResponse.message.isNotEmpty
              ? medicalDetailsResponse.message
              : 'Unable to fetch appointment details',
          code: 'API_ERROR',
          statusCode: medicalDetailsResponse.status,
        );
      }
      return medicalDetailsResponse.data;
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }

  Future<MedicalRecordData> getMedicalRecordsDetails({
    required String medicalRecordId,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        '/medical-history/$medicalRecordId',
      );

      final dynamic body = response.data;

      if (body is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      final medicalRecordResponse =
          MedicalRecordDetailsResponseModelMapper.fromMap(body);

      if (!medicalRecordResponse.success) {
        throw ApiException(
          medicalRecordResponse.message.isNotEmpty
              ? medicalRecordResponse.message
              : 'Unable to fetch medical records details',
          code: 'API_ERROR',
          statusCode: medicalRecordResponse.status,
        );
      }
      return medicalRecordResponse.data;
    } on DioException catch (error) {
      throw ErrorMapper.mapDioError(error);
    }
  }
}
