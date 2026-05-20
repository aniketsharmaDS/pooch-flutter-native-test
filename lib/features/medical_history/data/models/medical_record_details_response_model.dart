import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_annotations.dart';

part 'medical_record_details_response_model.mapper.dart';

@MappableClass()
class MedicalRecordDetailsResponseModel
    with MedicalRecordDetailsResponseModelMappable {
  @SafeBool()
  final bool success;

  @SafeString()
  final String message;

  @SafeInt()
  final int status;

  final MedicalRecordData data;

  final Meta meta;

  const MedicalRecordDetailsResponseModel({
    this.success = false,
    this.message = '',
    this.status = 0,
    this.data = const MedicalRecordData(),
    this.meta = const Meta(),
  });
}

@MappableClass()
class MedicalRecordData with MedicalRecordDataMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String historyRecordId;

  @SafeString()
  final String? appointmentId;

  @SafeString()
  final String petId;

  @SafeString()
  final String? clinicId;

  @SafeString()
  final String? userId;

  @SafeString()
  final String otherClinicName;

  @SafeString()
  final String? vetId;

  @SafeString()
  final String consultationDate;

  @SafeString()
  final String reasonForVisit;

  @SafeString()
  final String? symptomsObserved;

  @SafeString()
  final String? diagnosis;

  @SafeString()
  final String? diagnosisType;

  @SafeString()
  final String? treatmentProvided;

  @SafeString()
  final String notes;

  @SafeString()
  final String consultationStatus;

  @SafeString()
  final String? healthIssue;

  @SafeString()
  final String? observation;

  @SafeString()
  final String? recordedDate;

  @SafeString()
  final String? severity;

  @SafeString()
  final String? status;

  @SafeString()
  final String? createdBy;

  @SafeString()
  final String createdAt;

  @SafeString()
  final String updatedAt;

  @SafeString()
  final String sourceType;

  @SafeString()
  final String? appointmentTime;

  @SafeString()
  final String? appointmentDate;

  @SafeString()
  final String recordType;

  final Clinic? clinic;

  final Pet? pet;

  @MappableField(hook: SafeListHook())
  final List<DocumentUrl> documentUrls;

  const MedicalRecordData({
    this.id = '',
    this.historyRecordId = '',
    this.appointmentId,
    this.petId = '',
    this.clinicId,
    this.userId,
    this.otherClinicName = '',
    this.vetId,
    this.consultationDate = '',
    this.reasonForVisit = '',
    this.symptomsObserved,
    this.diagnosis,
    this.diagnosisType,
    this.treatmentProvided,
    this.notes = '',
    this.consultationStatus = '',
    this.healthIssue,
    this.observation,
    this.recordedDate,
    this.severity,
    this.status,
    this.createdBy,
    this.createdAt = '',
    this.updatedAt = '',
    this.sourceType = '',
    this.appointmentTime,
    this.appointmentDate,
    this.recordType = '',
    this.clinic,
    this.documentUrls = const [],
    this.pet = const Pet(),
  });
}

@MappableClass()
class Clinic with ClinicMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String clinicName;

  const Clinic({this.id = '', this.clinicName = ''});
}

@MappableClass()
class DocumentUrl with DocumentUrlMappable {
  @SafeString()
  final String? id;

  @SafeString()
  final String url;

  @SafeString()
  final String name;

  @SafeString()
  final String? createdAt;

  @SafeString()
  final String? prescriptionId;

  @SafeBool()
  final bool? isFromPrescription;

  @SafeString()
  final String? size;

  const DocumentUrl({
    this.id,
    this.url = '',
    this.name = '',
    this.createdAt,
    this.prescriptionId,
    this.isFromPrescription,
    this.size,
  });
}

@MappableClass()
class Meta with MetaMappable {
  @SafeString()
  final String lang;

  @SafeString()
  final String timestamp;

  const Meta({this.lang = '', this.timestamp = ''});
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class Pet with PetMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String name;

  @SafeString()
  final String type;

  @SafeString()
  final String profilePicture;

  const Pet({
    this.id = '',
    this.name = '',
    this.type = '',
    this.profilePicture = '',
  });
}
