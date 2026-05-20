import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_annotations.dart';

part 'appointment_cal_response_model.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class AppointmentCalResponseModel with AppointmentCalResponseModelMappable {
  @SafeBool()
  final bool success;

  @SafeString()
  final String message;

  @SafeInt()
  final int status;

  final AppointmentCalendarData data;

  final Meta meta;

  const AppointmentCalResponseModel({
    this.success = false,
    this.message = '',
    this.status = 0,
    this.data = const AppointmentCalendarData(),
    this.meta = const Meta(),
  });
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class AppointmentCalendarData with AppointmentCalendarDataMappable {
  @MappableField(hook: SafeListHook())
  final List<AppointmentItem> appointments;

  final AppointmentSummary summary;

  const AppointmentCalendarData({
    this.appointments = const [],
    this.summary = const AppointmentSummary(),
  });
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class AppointmentItem with AppointmentItemMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String clinicId;

  @SafeString()
  final String userId;

  @SafeString()
  final String petId;

  @SafeString()
  final String? vetId;

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
  final String? vetAssignedAt;

  @SafeString()
  final String? assignedBy;

  @SafeBool()
  final bool isVetRequested;

  @SafeString()
  final String? requestedVetId;

  @SafeString()
  final String priority;

  @SafeString()
  final String? actualEndTime;

  @SafeString()
  final String? cancellationReason;

  @SafeString()
  final String? cancellationNotes;

  @SafeString()
  final String? cancelledById;

  @MappableField(hook: SafeListHook())
  final List<PreviousTimeLog> previousTimeLogs;

  @SafeString()
  final String? symptoms;

  @SafeString()
  final String? duration;

  @SafeString()
  final String? medication;

  @SafeString()
  final String? medicalNotes;

  @MappableField(hook: SafeListHook())
  final List<AppointmentDocument> documents;

  @SafeBool()
  final bool isFollowup;

  @SafeString()
  final String? followupAppointmentId;

  @SafeString()
  final String createdAt;

  @SafeString()
  final String updatedAt;

  final AppointmentClinic clinic;

  final AssignedVet? assignedVet;

  final AppointmentPet pet;

  @MappableField(hook: SafeListHook())
  final List<MedicalHistoryRecord> medicalHistoryRecords;

  const AppointmentItem({
    this.id = '',
    this.clinicId = '',
    this.userId = '',
    this.petId = '',
    this.vetId,
    this.appointmentDate = '',
    this.startTime = '',
    this.endTime = '',
    this.consultationType = '',
    this.chiefComplaint = '',
    this.appointmentStatus = '',
    this.vetAssignedAt,
    this.assignedBy,
    this.isVetRequested = false,
    this.requestedVetId,
    this.priority = '',
    this.actualEndTime,
    this.cancellationReason,
    this.cancellationNotes,
    this.cancelledById,
    this.previousTimeLogs = const [],
    this.symptoms,
    this.duration,
    this.medication,
    this.medicalNotes,
    this.documents = const [],
    this.isFollowup = false,
    this.followupAppointmentId,
    this.createdAt = '',
    this.updatedAt = '',
    this.clinic = const AppointmentClinic(),
    this.assignedVet,
    this.pet = const AppointmentPet(),
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
class AppointmentDocument with AppointmentDocumentMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String url;

  @SafeString()
  final String fileName;

  const AppointmentDocument({this.id = '', this.url = '', this.fileName = ''});
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class AppointmentClinic with AppointmentClinicMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String clinicName;

  @SafeString()
  final String city;

  const AppointmentClinic({this.id = '', this.clinicName = '', this.city = ''});
}

@MappableClass()
class AssignedVet with AssignedVetMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String name;

  const AssignedVet({this.id = '', this.name = ''});
}

@MappableClass()
class AppointmentPet with AppointmentPetMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String name;

  @SafeString()
  final String type;

  @SafeString()
  final String profilePicture;

  final BreedInfo breedInfo;

  const AppointmentPet({
    this.id = '',
    this.name = '',
    this.type = '',
    this.profilePicture = '',
    this.breedInfo = const BreedInfo(),
  });
}

@MappableClass()
class BreedInfo with BreedInfoMappable {
  @SafeString()
  final String breedName;

  const BreedInfo({this.breedName = ''});
}

@MappableClass()
class AppointmentSummary with AppointmentSummaryMappable {
  @SafeInt()
  final int total;

  @SafeInt()
  final int month;

  @SafeInt()
  final int year;

  const AppointmentSummary({this.total = 0, this.month = 0, this.year = 0});
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
class MedicalHistoryRecord with MedicalHistoryRecordMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String type;

  @SafeString()
  final String consultationDate;

  const MedicalHistoryRecord({
    this.id = '',
    this.type = '',
    this.consultationDate = '',
  });
}
