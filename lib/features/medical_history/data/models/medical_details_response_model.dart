import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_annotations.dart';

part 'medical_details_response_model.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class MedicalDetailsResponseModel with MedicalDetailsResponseModelMappable {
  @SafeBool()
  final bool success;

  @SafeString()
  final String message;

  @SafeInt()
  final int status;

  final MedicalDetailsData data;

  final Meta meta;

  const MedicalDetailsResponseModel({
    this.success = false,
    this.message = '',
    this.status = 0,
    this.data = const MedicalDetailsData(),
    this.meta = const Meta(),
  });
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class MedicalDetailsData with MedicalDetailsDataMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String clinicId;

  @SafeString()
  final String userId;

  @SafeString()
  final String petId;

  @SafeString()
  final String vetId;

  @SafeString()
  final String appointmentDate;

  @SafeString()
  final String startTime;

  @SafeString()
  final String endTime;

  @SafeString()
  final String consultationType;

  @SafeString()
  final String chiefComplaint;

  @SafeString()
  final String appointmentStatus;

  @SafeString()
  final String vetAssignedAt;

  @SafeString()
  final String? assignedBy;

  @SafeBool()
  final bool isVetRequested;

  @SafeString()
  final String? requestedVetId;

  @SafeString()
  final String priority;

  @SafeString()
  final String actualEndTime;

  @SafeString()
  final String? cancellationReason;

  @SafeString()
  final String? cancellationNotes;

  @SafeString()
  final String? cancelledById;

  @MappableField(hook: SafeListHook())
  final List<PreviousTimeLog> previousTimeLogs;

  @SafeString()
  final String symptoms;

  @SafeString()
  final String duration;

  @SafeString()
  final String medication;

  @SafeString()
  final String medicalNotes;

  @SafeBool()
  final bool isFollowup;

  @SafeString()
  final String? followupAppointmentId;

  @SafeString()
  final String createdAt;

  @SafeString()
  final String updatedAt;

  final Clinic clinic;

  final AssignedVet assignedVet;

  final PetOwner petOwner;

  final Pet pet;

  @MappableField(
    key: 'medicalHistoryRecords',
    hook: MedicalHistoryRecordListHook(),
  )
  final List<MedicalHistoryRecord> medicalHistoryRecords;

  const MedicalDetailsData({
    this.id = '',
    this.clinicId = '',
    this.userId = '',
    this.petId = '',
    this.vetId = '',
    this.appointmentDate = '',
    this.startTime = '',
    this.endTime = '',
    this.consultationType = '',
    this.chiefComplaint = '',
    this.appointmentStatus = '',
    this.vetAssignedAt = '',
    this.assignedBy,
    this.isVetRequested = false,
    this.requestedVetId,
    this.priority = '',
    this.actualEndTime = '',
    this.cancellationReason,
    this.cancellationNotes,
    this.cancelledById,
    this.previousTimeLogs = const [],
    this.symptoms = '',
    this.duration = '',
    this.medication = '',
    this.medicalNotes = '',
    this.isFollowup = false,
    this.followupAppointmentId,
    this.createdAt = '',
    this.updatedAt = '',
    this.clinic = const Clinic(),
    this.assignedVet = const AssignedVet(),
    this.petOwner = const PetOwner(),
    this.pet = const Pet(),
    this.medicalHistoryRecords = const [],
  });
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class PreviousTimeLog with PreviousTimeLogMappable {
  @SafeString()
  final String reason;

  @SafeString()
  final String endTime;

  @SafeString()
  final String startTime;

  @SafeString()
  final String rescheduledAt;

  @SafeString()
  final String appointmentDate;

  const PreviousTimeLog({
    this.reason = '',
    this.endTime = '',
    this.startTime = '',
    this.rescheduledAt = '',
    this.appointmentDate = '',
  });
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class Clinic with ClinicMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String clinicName;

  @SafeString()
  final String address;

  @SafeString()
  final String phone;

  @SafeString()
  final String clinicImage;

  const Clinic({
    this.id = '',
    this.clinicName = '',
    this.address = '',
    this.phone = '',
    this.clinicImage = '',
  });
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class AssignedVet with AssignedVetMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String name;

  @MappableField(hook: SafeListHook())
  final List<String> specialization;

  @SafeString()
  final String consultationFee;

  @SafeString()
  final String profilePicture;

  const AssignedVet({
    this.id = '',
    this.name = '',
    this.specialization = const [],
    this.consultationFee = '',
    this.profilePicture = '',
  });
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class PetOwner with PetOwnerMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String name;

  @SafeString()
  final String phone;

  const PetOwner({this.id = '', this.name = '', this.phone = ''});
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

  final BreedInfo breedInfo;

  const Pet({
    this.id = '',
    this.name = '',
    this.type = '',
    this.profilePicture = '',
    this.breedInfo = const BreedInfo(),
  });
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class BreedInfo with BreedInfoMappable {
  @SafeString()
  final String breedName;

  const BreedInfo({this.breedName = ''});
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class Meta with MetaMappable {
  @SafeString()
  final String lang;

  @SafeString()
  final String timestamp;

  const Meta({this.lang = '', this.timestamp = ''});
}

@MappableClass(caseStyle: CaseStyle.snakeCase, ignoreNull: true)
class MedicalHistoryRecord with MedicalHistoryRecordMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String type;

  @SafeString()
  final String consultationDate;

  final dynamic clinic;
  final List<dynamic> documentUrls;

  @SafeString()
  final String? reasonForVisit;

  @SafeString()
  final String? diagnosis;

  const MedicalHistoryRecord({
    this.id = '',
    this.type = '',
    this.consultationDate = '',
    this.clinic,
    this.documentUrls = const [],
    this.reasonForVisit,
    this.diagnosis,
  });
}

class MedicalHistoryRecordListHook extends MappingHook {
  const MedicalHistoryRecordListHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is List) return value;
    return [];
  }

  @override
  Object? afterDecode(Object? value) {
    // value is already List<dynamic> here
    return value;
  }
}
