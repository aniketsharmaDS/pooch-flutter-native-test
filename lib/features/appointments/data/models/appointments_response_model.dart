import 'package:poochcare/core/utils/parser_utils.dart';

class AppointmentClinicSummaryApiModel {
  const AppointmentClinicSummaryApiModel({
    required this.id,
    required this.clinicName,
    required this.city,
    this.clinicImage = '',
    this.address = '',
    this.phoneNumber = '',
  });

  final String id;
  final String clinicName;
  final String city;
  final String? clinicImage;
  final String? address;
  final String? phoneNumber;
  factory AppointmentClinicSummaryApiModel.fromMap(Map<String, dynamic> map) {
    return AppointmentClinicSummaryApiModel(
      id: ParserUtils.readString(map['id']),
      clinicName: ParserUtils.readString(map['clinic_name']),
      city: ParserUtils.readString(map['city']),
      clinicImage: ParserUtils.readString(map['clinic_image']),
      address: ParserUtils.readString(map['address']),
      phoneNumber: ParserUtils.readString(map['phone']),
    );
  }
}

class AppointmentVetSummaryApiModel {
  const AppointmentVetSummaryApiModel({required this.id, required this.name});

  final String id;
  final String name;

  factory AppointmentVetSummaryApiModel.fromMap(Map<String, dynamic> map) {
    return AppointmentVetSummaryApiModel(
      id: ParserUtils.readString(map['id']),
      name: ParserUtils.readString(map['name']),
    );
  }
}

class AppointmentBreedInfoApiModel {
  const AppointmentBreedInfoApiModel({required this.breedName});

  final String breedName;

  factory AppointmentBreedInfoApiModel.fromMap(Map<String, dynamic> map) {
    return AppointmentBreedInfoApiModel(
      breedName: ParserUtils.readString(map['breedName']),
    );
  }
}

class AppointmentPetSummaryApiModel {
  const AppointmentPetSummaryApiModel({
    required this.id,
    required this.name,
    required this.type,
    required this.profilePicture,
    required this.breedInfo,
  });

  final String id;
  final String name;
  final String type;
  final String profilePicture;
  final AppointmentBreedInfoApiModel? breedInfo;

  factory AppointmentPetSummaryApiModel.fromMap(Map<String, dynamic> map) {
    final breedInfoMap = ParserUtils.readMap(map['breedInfo']);

    return AppointmentPetSummaryApiModel(
      id: ParserUtils.readString(map['id']),
      name: ParserUtils.readString(map['name']),
      type: ParserUtils.readString(map['type']),
      profilePicture: ParserUtils.readString(map['profilePicture']),
      breedInfo: breedInfoMap.isEmpty
          ? null
          : AppointmentBreedInfoApiModel.fromMap(breedInfoMap),
    );
  }
}

class AppointmentTimeLogApiModel {
  const AppointmentTimeLogApiModel({
    required this.reason,
    required this.endTime,
    required this.startTime,
    required this.rescheduledAt,
    required this.appointmentDate,
  });

  final String reason;
  final String endTime;
  final String startTime;
  final String rescheduledAt;
  final String appointmentDate;

  factory AppointmentTimeLogApiModel.fromMap(Map<String, dynamic> map) {
    return AppointmentTimeLogApiModel(
      reason: ParserUtils.readString(map['reason']),
      endTime: ParserUtils.readString(map['end_time']),
      startTime: ParserUtils.readString(map['start_time']),
      rescheduledAt: ParserUtils.readString(map['rescheduled_at']),
      appointmentDate: ParserUtils.readString(map['appointment_date']),
    );
  }
}

class AppointmentApiModel {
  const AppointmentApiModel({
    required this.id,
    required this.clinicId,
    required this.userId,
    required this.petId,
    required this.vetId,
    required this.appointmentDate,
    required this.startTime,
    required this.endTime,
    required this.consultationType,
    required this.chiefComplaint,
    required this.appointmentStatus,
    required this.vetAssignedAt,
    required this.assignedBy,
    required this.isVetRequested,
    required this.requestedVetId,
    required this.priority,
    required this.actualEndTime,
    required this.cancellationReason,
    required this.cancellationNotes,
    required this.cancelledById,
    required this.previousTimeLogs,
    required this.symptoms,
    required this.duration,
    required this.medication,
    required this.medicalNotes,
    required this.documents,
    required this.isFollowup,
    required this.followupAppointmentId,
    required this.createdAt,
    required this.updatedAt,
    required this.clinic,
    required this.assignedVet,
    required this.pet,
  });

  final String id;
  final String clinicId;
  final String userId;
  final String petId;
  final String? vetId;
  final String appointmentDate;
  final String startTime;
  final String endTime;
  final String consultationType;
  final String chiefComplaint;
  final String appointmentStatus;
  final String? vetAssignedAt;
  final String? assignedBy;
  final bool isVetRequested;
  final String? requestedVetId;
  final String priority;
  final String? actualEndTime;
  final String? cancellationReason;
  final String? cancellationNotes;
  final String? cancelledById;
  final List<AppointmentTimeLogApiModel> previousTimeLogs;
  final String symptoms;
  final String duration;
  final String medication;
  final String medicalNotes;
  final List<String> documents;
  final bool isFollowup;
  final String? followupAppointmentId;
  final String createdAt;
  final String updatedAt;
  final AppointmentClinicSummaryApiModel? clinic;
  final AppointmentVetSummaryApiModel? assignedVet;
  final AppointmentPetSummaryApiModel? pet;

  factory AppointmentApiModel.fromMap(Map<String, dynamic> map) {
    final clinicMap = ParserUtils.readMap(map['clinic']);
    final assignedVetMap = ParserUtils.readMap(map['assignedVet']);
    final petMap = ParserUtils.readMap(map['pet']);

    return AppointmentApiModel(
      id: ParserUtils.readString(map['id']),
      clinicId: ParserUtils.readString(map['clinic_id']),
      userId: ParserUtils.readString(map['user_id']),
      petId: ParserUtils.readString(map['pet_id']),
      vetId: ParserUtils.readNullableString(map['vet_id']),
      appointmentDate: ParserUtils.readString(map['appointment_date']),
      startTime: ParserUtils.readString(map['start_time']),
      endTime: ParserUtils.readString(map['end_time']),
      consultationType: ParserUtils.readString(map['consultation_type']),
      chiefComplaint: ParserUtils.readString(map['chief_complaint']),
      appointmentStatus: ParserUtils.readString(map['appointment_status']),
      vetAssignedAt: ParserUtils.readNullableString(map['vet_assigned_at']),
      assignedBy: ParserUtils.readNullableString(map['assigned_by']),
      isVetRequested: ParserUtils.readBool(map['is_vet_requested']),
      requestedVetId: ParserUtils.readNullableString(map['requested_vet_id']),
      priority: ParserUtils.readString(map['priority']),
      actualEndTime: ParserUtils.readNullableString(map['actual_end_time']),
      cancellationReason: ParserUtils.readNullableString(
        map['cancellation_reason'],
      ),
      cancellationNotes: ParserUtils.readNullableString(
        map['cancellation_notes'],
      ),
      cancelledById: ParserUtils.readNullableString(map['cancelled_by_id']),
      previousTimeLogs:
          (map['previous_time_logs'] as List? ?? const <dynamic>[])
              .whereType<Map>()
              .map(
                (e) =>
                    AppointmentTimeLogApiModel.fromMap(ParserUtils.readMap(e)),
              )
              .toList(growable: false),
      symptoms: ParserUtils.readString(map['symptoms']),
      duration: ParserUtils.readString(map['duration']),
      medication: ParserUtils.readString(map['medication']),
      medicalNotes: ParserUtils.readString(map['medical_notes']),
      documents: ParserUtils.readStringList(map['documents']),
      isFollowup: ParserUtils.readBool(map['is_followup']),
      followupAppointmentId: ParserUtils.readNullableString(
        map['followup_appointment_id'],
      ),
      createdAt: ParserUtils.readString(map['created_at']),
      updatedAt: ParserUtils.readString(map['updated_at']),
      clinic: clinicMap.isEmpty
          ? null
          : AppointmentClinicSummaryApiModel.fromMap(clinicMap),
      assignedVet: assignedVetMap.isEmpty
          ? null
          : AppointmentVetSummaryApiModel.fromMap(assignedVetMap),
      pet: petMap.isEmpty
          ? null
          : AppointmentPetSummaryApiModel.fromMap(petMap),
    );
  }
}

class AppointmentsPaginationModel {
  const AppointmentsPaginationModel({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  final int total;
  final int page;
  final int limit;
  final int totalPages;

  factory AppointmentsPaginationModel.fromMap(Map<String, dynamic> map) {
    return AppointmentsPaginationModel(
      total: ParserUtils.readInt(map['total']),
      page: ParserUtils.readInt(map['page']),
      limit: ParserUtils.readInt(map['limit']),
      totalPages: ParserUtils.readInt(map['totalPages']),
    );
  }
}

class AppointmentsResponseModel {
  const AppointmentsResponseModel({
    required this.appointments,
    required this.pagination,
  });

  final List<AppointmentApiModel> appointments;
  final AppointmentsPaginationModel pagination;

  factory AppointmentsResponseModel.fromMap(Map<String, dynamic> map) {
    return AppointmentsResponseModel(
      appointments: (map['appointments'] as List? ?? const <dynamic>[])
          .whereType<Map>()
          .map((e) => AppointmentApiModel.fromMap(ParserUtils.readMap(e)))
          .toList(growable: false),
      pagination: AppointmentsPaginationModel.fromMap(
        ParserUtils.readMap(map['pagination']),
      ),
    );
  }
}
