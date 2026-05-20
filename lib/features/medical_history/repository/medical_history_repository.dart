import 'dart:developer';

import 'package:poochcare/core/utils/document_file_type_utils.dart';
import 'package:poochcare/features/medical_history/data/api/medical_history_api_service.dart';
import 'package:poochcare/features/medical_history/data/mappers/diagnosis_type_mapper.dart';
import 'package:poochcare/features/medical_history/data/mappers/lab_report_type_mapper.dart';
import 'package:poochcare/features/medical_history/data/mappers/vaccination_type_mapper.dart';
import 'package:poochcare/features/medical_history/domain/models/diagnosis_type.dart';
import 'package:poochcare/features/medical_history/domain/models/lab_report_type.dart';
import 'package:poochcare/features/medical_history/domain/models/medical_history_record.dart';
import 'package:poochcare/features/medical_history/domain/models/vaccination_type.dart';

class MedicalHistoryRepository {
  const MedicalHistoryRepository(this._api);

  final MedicalHistoryApiService _api;

  Future<PaginatedMedicalHistoryRecords> getMedicalHistoryRecords({
    String? petId,
    String? recordType,
    DateTime? startDate,
    DateTime? endDate,
    required int page,
    required int limit,
  }) async {
    final response = await _api.getMedicalHistoryRecordsPage(
      petId: petId,
      recordType: recordType,
      startDate: startDate == null ? null : _formatDate(startDate),
      endDate: endDate == null ? null : _formatDate(endDate),
      page: page,
      limit: limit,
    );

    return PaginatedMedicalHistoryRecords(
      records: response.records.map(_toDomainRecord).toList(growable: false),
      hasMore: response.hasMore,
    );
  }

  Future<List<VaccinationType>> getVaccinationTypes() async {
    final responses = await _api.getVaccinationTypes();
    return responses
        .map(VaccinationTypeMapper.toDomain)
        .where((item) => item.vaccineName.trim().isNotEmpty)
        .toList(growable: false);
  }

  Future<List<DiagnosisType>> getDiagnosisTypes() async {
    final responses = await _api.getDiagnosisTypes();
    return responses
        .map(DiagnosisTypeMapper.toDomain)
        .where(
          (item) => item.code.trim().isNotEmpty && item.name.trim().isNotEmpty,
        )
        .toList(growable: false);
  }

  Future<List<LabReportType>> getLabReportTypes() async {
    final responses = await _api.getLabReportTypes();
    return responses
        .map(LabReportTypeMapper.toDomain)
        .where(
          (item) => item.code.trim().isNotEmpty && item.name.trim().isNotEmpty,
        )
        .toList(growable: false);
  }

  Future<void> saveMedicalHistoryRecord({
    required String endpoint,
    required dynamic payload,
  }) {
    return _api.saveMedicalHistoryRecord(endpoint: endpoint, payload: payload);
  }

  Future<void> createMedicalRecord({
    required String petId,
    required int vaccinationTypeId,
    required String clinicName,
    required DateTime visitDate,
    String? externalLink,
    required String recordType,
  }) {
    return _api.createMedicalRecord(
      petId: petId,
      vaccinationTypeId: vaccinationTypeId,
      clinicName: clinicName,
      visitDate: visitDate,
      externalLink: externalLink,
      recordType: recordType,
    );
  }

  Future<void> createVaccinationRecord({
    required String petId,
    required String vaccinationName,
    required DateTime vaccinationDate,
    required String otherClinicName,
    required List<Map<String, dynamic>> documentUrls,
  }) {
    return _api.createVaccinationRecord(
      petId: petId,
      vaccinationName: vaccinationName,
      vaccinationDate: vaccinationDate,
      otherClinicName: otherClinicName,
      documentUrls: documentUrls,
    );
  }

  Future<void> createHealthRecord({
    required String petId,
    required String otherClinicName,
    required DateTime recordedDate,
    required String healthIssue,
    required List<Map<String, dynamic>> documentUrls,
  }) {
    return _api.createHealthRecord(
      petId: petId,
      otherClinicName: otherClinicName,
      recordedDate: recordedDate,
      healthIssue: healthIssue,
      documentUrls: documentUrls,
    );
  }

  MedicalHistoryRecord _toDomainRecord(Map<String, dynamic> map) {
    final recordType = _asText(map['recordType'])
        .ifEmpty(_asText(map['type']).ifEmpty(_asText(map['category'])))
        .toLowerCase();

    final title = _asText(map['title'])
        .ifEmpty(
          _asText(map['recordTitle'])
              .ifEmpty(
                _asText(map['vaccinationName'])
                    .ifEmpty(_asText(map['labReportName']))
                    .ifEmpty(_asText(map['reportType']))
                    .ifEmpty(_asText(map['diagnosisName']))
                    .ifEmpty(_asText(map['documentType']))
                    .ifEmpty(_asText(map['medicalRecordType'])),
              )
              .trim(),
        )
        .trim();

    final primaryText = _asText(map['clinicName'])
        .ifEmpty(_asText(map['hospitalName']))
        .ifEmpty(_asText(map['doctorName']))
        .ifEmpty(_asText(map['issuedBy']))
        .ifEmpty(_asText(map['otherClinicName']))
        .trim();

    final secondaryText = _asText(map['consultationDate'])
        .ifEmpty(_asText(map['vaccinationDate']))
        .ifEmpty(_asText(map['reportDate']))
        .ifEmpty(_asText(map['documentDate']))
        .ifEmpty(_asText(map['issuedOn']))
        .ifEmpty(_asText(map['startDate']))
        .ifEmpty(_asText(map['visitDate']))
        .ifEmpty(_asText(map['recordedDate']))
        .ifEmpty(_asText(map['createdAt']))
        .ifEmpty(_asText(map['date']))
        .trim();

    final tertiaryText = _asText(map['amount'])
        .ifEmpty(_asText(map['fee']))
        .ifEmpty(_asText(map['cost']))
        .ifEmpty(_asText(map['notes']))
        .ifEmpty(_asText(map['description']))
        .trim();

    final id = _asText(map['id']).ifEmpty(_asText(map['_id']));
    final recordId = _asText(map['id']).ifEmpty(_asText(map['_id']));
    final appointmentId = _asText(
      map['appointmentId'],
    ).ifEmpty(_asText(map['appointmentId']));

    log(
      'Fetching details for medical history record with id: $recordId, appointmentId: $appointmentId',
    );

    final documents = _extractDocuments(map);
    log('recordType-->$recordType, ');
    return MedicalHistoryRecord(
      id: id,
      recordType: recordType,
      title: title,
      primaryText: primaryText,
      secondaryText: secondaryText,
      tertiaryText: tertiaryText,
      documents: documents,
      recordId: recordId,
      appointmentId: appointmentId,
    );
  }

  List<MedicalHistoryRecordDocument> _extractDocuments(
    Map<String, dynamic> map,
  ) {
    final dynamic docsRaw = map['documentUrls'] ?? map['documents'];
    if (docsRaw is! List) {
      return const <MedicalHistoryRecordDocument>[];
    }

    return docsRaw
        .whereType<Map<String, dynamic>>()
        .map((doc) {
          final fileName = _asText(doc['fileName'])
              .ifEmpty(_asText(doc['name']))
              .ifEmpty(_asText(doc['title']))
              .ifEmpty('Document');

          final fileSize = _asText(
            doc['fileSize'],
          ).ifEmpty(_asText(doc['size']));
          final url = _asText(doc['url']).ifEmpty(_asText(doc['link']));

          final fileType = inferDocumentFileType(url: url);
          return MedicalHistoryRecordDocument(
            fileName: fileName,
            fileType: fileType,
            fileSize: fileSize,
            url: url.trim().isEmpty ? null : url,
          );
        })
        .toList(growable: false);
  }

  String _asText(dynamic value) {
    if (value == null) {
      return '';
    }
    return value.toString();
  }

  String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}

extension on String {
  String ifEmpty(String other) {
    return trim().isEmpty ? other : this;
  }
}
