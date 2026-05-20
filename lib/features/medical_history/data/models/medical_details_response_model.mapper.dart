// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'medical_details_response_model.dart';

class MedicalDetailsResponseModelMapper
    extends ClassMapperBase<MedicalDetailsResponseModel> {
  MedicalDetailsResponseModelMapper._();

  static MedicalDetailsResponseModelMapper? _instance;
  static MedicalDetailsResponseModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = MedicalDetailsResponseModelMapper._(),
      );
      MedicalDetailsDataMapper.ensureInitialized();
      MetaMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MedicalDetailsResponseModel';

  static bool _$success(MedicalDetailsResponseModel v) => v.success;
  static const Field<MedicalDetailsResponseModel, bool> _f$success = Field(
    'success',
    _$success,
    opt: true,
    def: false,
  );
  static String _$message(MedicalDetailsResponseModel v) => v.message;
  static const Field<MedicalDetailsResponseModel, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
    def: '',
  );
  static int _$status(MedicalDetailsResponseModel v) => v.status;
  static const Field<MedicalDetailsResponseModel, int> _f$status = Field(
    'status',
    _$status,
    opt: true,
    def: 0,
  );
  static MedicalDetailsData _$data(MedicalDetailsResponseModel v) => v.data;
  static const Field<MedicalDetailsResponseModel, MedicalDetailsData> _f$data =
      Field('data', _$data, opt: true, def: const MedicalDetailsData());
  static Meta _$meta(MedicalDetailsResponseModel v) => v.meta;
  static const Field<MedicalDetailsResponseModel, Meta> _f$meta = Field(
    'meta',
    _$meta,
    opt: true,
    def: const Meta(),
  );

  @override
  final MappableFields<MedicalDetailsResponseModel> fields = const {
    #success: _f$success,
    #message: _f$message,
    #status: _f$status,
    #data: _f$data,
    #meta: _f$meta,
  };

  static MedicalDetailsResponseModel _instantiate(DecodingData data) {
    return MedicalDetailsResponseModel(
      success: data.dec(_f$success),
      message: data.dec(_f$message),
      status: data.dec(_f$status),
      data: data.dec(_f$data),
      meta: data.dec(_f$meta),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MedicalDetailsResponseModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MedicalDetailsResponseModel>(map);
  }

  static MedicalDetailsResponseModel fromJson(String json) {
    return ensureInitialized().decodeJson<MedicalDetailsResponseModel>(json);
  }
}

mixin MedicalDetailsResponseModelMappable {
  String toJson() {
    return MedicalDetailsResponseModelMapper.ensureInitialized()
        .encodeJson<MedicalDetailsResponseModel>(
          this as MedicalDetailsResponseModel,
        );
  }

  Map<String, dynamic> toMap() {
    return MedicalDetailsResponseModelMapper.ensureInitialized()
        .encodeMap<MedicalDetailsResponseModel>(
          this as MedicalDetailsResponseModel,
        );
  }

  MedicalDetailsResponseModelCopyWith<
    MedicalDetailsResponseModel,
    MedicalDetailsResponseModel,
    MedicalDetailsResponseModel
  >
  get copyWith =>
      _MedicalDetailsResponseModelCopyWithImpl<
        MedicalDetailsResponseModel,
        MedicalDetailsResponseModel
      >(this as MedicalDetailsResponseModel, $identity, $identity);
  @override
  String toString() {
    return MedicalDetailsResponseModelMapper.ensureInitialized().stringifyValue(
      this as MedicalDetailsResponseModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return MedicalDetailsResponseModelMapper.ensureInitialized().equalsValue(
      this as MedicalDetailsResponseModel,
      other,
    );
  }

  @override
  int get hashCode {
    return MedicalDetailsResponseModelMapper.ensureInitialized().hashValue(
      this as MedicalDetailsResponseModel,
    );
  }
}

extension MedicalDetailsResponseModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MedicalDetailsResponseModel, $Out> {
  MedicalDetailsResponseModelCopyWith<$R, MedicalDetailsResponseModel, $Out>
  get $asMedicalDetailsResponseModel => $base.as(
    (v, t, t2) => _MedicalDetailsResponseModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class MedicalDetailsResponseModelCopyWith<
  $R,
  $In extends MedicalDetailsResponseModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  MedicalDetailsDataCopyWith<$R, MedicalDetailsData, MedicalDetailsData>
  get data;
  MetaCopyWith<$R, Meta, Meta> get meta;
  $R call({
    bool? success,
    String? message,
    int? status,
    MedicalDetailsData? data,
    Meta? meta,
  });
  MedicalDetailsResponseModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MedicalDetailsResponseModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MedicalDetailsResponseModel, $Out>
    implements
        MedicalDetailsResponseModelCopyWith<
          $R,
          MedicalDetailsResponseModel,
          $Out
        > {
  _MedicalDetailsResponseModelCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<MedicalDetailsResponseModel> $mapper =
      MedicalDetailsResponseModelMapper.ensureInitialized();
  @override
  MedicalDetailsDataCopyWith<$R, MedicalDetailsData, MedicalDetailsData>
  get data => $value.data.copyWith.$chain((v) => call(data: v));
  @override
  MetaCopyWith<$R, Meta, Meta> get meta =>
      $value.meta.copyWith.$chain((v) => call(meta: v));
  @override
  $R call({
    bool? success,
    String? message,
    int? status,
    MedicalDetailsData? data,
    Meta? meta,
  }) => $apply(
    FieldCopyWithData({
      if (success != null) #success: success,
      if (message != null) #message: message,
      if (status != null) #status: status,
      if (data != null) #data: data,
      if (meta != null) #meta: meta,
    }),
  );
  @override
  MedicalDetailsResponseModel $make(CopyWithData data) =>
      MedicalDetailsResponseModel(
        success: data.get(#success, or: $value.success),
        message: data.get(#message, or: $value.message),
        status: data.get(#status, or: $value.status),
        data: data.get(#data, or: $value.data),
        meta: data.get(#meta, or: $value.meta),
      );

  @override
  MedicalDetailsResponseModelCopyWith<$R2, MedicalDetailsResponseModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MedicalDetailsResponseModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class MedicalDetailsDataMapper extends ClassMapperBase<MedicalDetailsData> {
  MedicalDetailsDataMapper._();

  static MedicalDetailsDataMapper? _instance;
  static MedicalDetailsDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MedicalDetailsDataMapper._());
      PreviousTimeLogMapper.ensureInitialized();
      ClinicMapper.ensureInitialized();
      AssignedVetMapper.ensureInitialized();
      PetOwnerMapper.ensureInitialized();
      PetMapper.ensureInitialized();
      MedicalHistoryRecordMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MedicalDetailsData';

  static String _$id(MedicalDetailsData v) => v.id;
  static const Field<MedicalDetailsData, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$clinicId(MedicalDetailsData v) => v.clinicId;
  static const Field<MedicalDetailsData, String> _f$clinicId = Field(
    'clinicId',
    _$clinicId,
    key: r'clinic_id',
    opt: true,
    def: '',
  );
  static String _$userId(MedicalDetailsData v) => v.userId;
  static const Field<MedicalDetailsData, String> _f$userId = Field(
    'userId',
    _$userId,
    key: r'user_id',
    opt: true,
    def: '',
  );
  static String _$petId(MedicalDetailsData v) => v.petId;
  static const Field<MedicalDetailsData, String> _f$petId = Field(
    'petId',
    _$petId,
    key: r'pet_id',
    opt: true,
    def: '',
  );
  static String _$vetId(MedicalDetailsData v) => v.vetId;
  static const Field<MedicalDetailsData, String> _f$vetId = Field(
    'vetId',
    _$vetId,
    key: r'vet_id',
    opt: true,
    def: '',
  );
  static String _$appointmentDate(MedicalDetailsData v) => v.appointmentDate;
  static const Field<MedicalDetailsData, String> _f$appointmentDate = Field(
    'appointmentDate',
    _$appointmentDate,
    key: r'appointment_date',
    opt: true,
    def: '',
  );
  static String _$startTime(MedicalDetailsData v) => v.startTime;
  static const Field<MedicalDetailsData, String> _f$startTime = Field(
    'startTime',
    _$startTime,
    key: r'start_time',
    opt: true,
    def: '',
  );
  static String _$endTime(MedicalDetailsData v) => v.endTime;
  static const Field<MedicalDetailsData, String> _f$endTime = Field(
    'endTime',
    _$endTime,
    key: r'end_time',
    opt: true,
    def: '',
  );
  static String _$consultationType(MedicalDetailsData v) => v.consultationType;
  static const Field<MedicalDetailsData, String> _f$consultationType = Field(
    'consultationType',
    _$consultationType,
    key: r'consultation_type',
    opt: true,
    def: '',
  );
  static String _$chiefComplaint(MedicalDetailsData v) => v.chiefComplaint;
  static const Field<MedicalDetailsData, String> _f$chiefComplaint = Field(
    'chiefComplaint',
    _$chiefComplaint,
    key: r'chief_complaint',
    opt: true,
    def: '',
  );
  static String _$appointmentStatus(MedicalDetailsData v) =>
      v.appointmentStatus;
  static const Field<MedicalDetailsData, String> _f$appointmentStatus = Field(
    'appointmentStatus',
    _$appointmentStatus,
    key: r'appointment_status',
    opt: true,
    def: '',
  );
  static String _$vetAssignedAt(MedicalDetailsData v) => v.vetAssignedAt;
  static const Field<MedicalDetailsData, String> _f$vetAssignedAt = Field(
    'vetAssignedAt',
    _$vetAssignedAt,
    key: r'vet_assigned_at',
    opt: true,
    def: '',
  );
  static String? _$assignedBy(MedicalDetailsData v) => v.assignedBy;
  static const Field<MedicalDetailsData, String> _f$assignedBy = Field(
    'assignedBy',
    _$assignedBy,
    key: r'assigned_by',
    opt: true,
  );
  static bool _$isVetRequested(MedicalDetailsData v) => v.isVetRequested;
  static const Field<MedicalDetailsData, bool> _f$isVetRequested = Field(
    'isVetRequested',
    _$isVetRequested,
    key: r'is_vet_requested',
    opt: true,
    def: false,
  );
  static String? _$requestedVetId(MedicalDetailsData v) => v.requestedVetId;
  static const Field<MedicalDetailsData, String> _f$requestedVetId = Field(
    'requestedVetId',
    _$requestedVetId,
    key: r'requested_vet_id',
    opt: true,
  );
  static String _$priority(MedicalDetailsData v) => v.priority;
  static const Field<MedicalDetailsData, String> _f$priority = Field(
    'priority',
    _$priority,
    opt: true,
    def: '',
  );
  static String _$actualEndTime(MedicalDetailsData v) => v.actualEndTime;
  static const Field<MedicalDetailsData, String> _f$actualEndTime = Field(
    'actualEndTime',
    _$actualEndTime,
    key: r'actual_end_time',
    opt: true,
    def: '',
  );
  static String? _$cancellationReason(MedicalDetailsData v) =>
      v.cancellationReason;
  static const Field<MedicalDetailsData, String> _f$cancellationReason = Field(
    'cancellationReason',
    _$cancellationReason,
    key: r'cancellation_reason',
    opt: true,
  );
  static String? _$cancellationNotes(MedicalDetailsData v) =>
      v.cancellationNotes;
  static const Field<MedicalDetailsData, String> _f$cancellationNotes = Field(
    'cancellationNotes',
    _$cancellationNotes,
    key: r'cancellation_notes',
    opt: true,
  );
  static String? _$cancelledById(MedicalDetailsData v) => v.cancelledById;
  static const Field<MedicalDetailsData, String> _f$cancelledById = Field(
    'cancelledById',
    _$cancelledById,
    key: r'cancelled_by_id',
    opt: true,
  );
  static List<PreviousTimeLog> _$previousTimeLogs(MedicalDetailsData v) =>
      v.previousTimeLogs;
  static const Field<MedicalDetailsData, List<PreviousTimeLog>>
  _f$previousTimeLogs = Field(
    'previousTimeLogs',
    _$previousTimeLogs,
    key: r'previous_time_logs',
    opt: true,
    def: const [],
    hook: SafeListHook(),
  );
  static String _$symptoms(MedicalDetailsData v) => v.symptoms;
  static const Field<MedicalDetailsData, String> _f$symptoms = Field(
    'symptoms',
    _$symptoms,
    opt: true,
    def: '',
  );
  static String _$duration(MedicalDetailsData v) => v.duration;
  static const Field<MedicalDetailsData, String> _f$duration = Field(
    'duration',
    _$duration,
    opt: true,
    def: '',
  );
  static String _$medication(MedicalDetailsData v) => v.medication;
  static const Field<MedicalDetailsData, String> _f$medication = Field(
    'medication',
    _$medication,
    opt: true,
    def: '',
  );
  static String _$medicalNotes(MedicalDetailsData v) => v.medicalNotes;
  static const Field<MedicalDetailsData, String> _f$medicalNotes = Field(
    'medicalNotes',
    _$medicalNotes,
    key: r'medical_notes',
    opt: true,
    def: '',
  );
  static bool _$isFollowup(MedicalDetailsData v) => v.isFollowup;
  static const Field<MedicalDetailsData, bool> _f$isFollowup = Field(
    'isFollowup',
    _$isFollowup,
    key: r'is_followup',
    opt: true,
    def: false,
  );
  static String? _$followupAppointmentId(MedicalDetailsData v) =>
      v.followupAppointmentId;
  static const Field<MedicalDetailsData, String> _f$followupAppointmentId =
      Field(
        'followupAppointmentId',
        _$followupAppointmentId,
        key: r'followup_appointment_id',
        opt: true,
      );
  static String _$createdAt(MedicalDetailsData v) => v.createdAt;
  static const Field<MedicalDetailsData, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    key: r'created_at',
    opt: true,
    def: '',
  );
  static String _$updatedAt(MedicalDetailsData v) => v.updatedAt;
  static const Field<MedicalDetailsData, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    key: r'updated_at',
    opt: true,
    def: '',
  );
  static Clinic _$clinic(MedicalDetailsData v) => v.clinic;
  static const Field<MedicalDetailsData, Clinic> _f$clinic = Field(
    'clinic',
    _$clinic,
    opt: true,
    def: const Clinic(),
  );
  static AssignedVet _$assignedVet(MedicalDetailsData v) => v.assignedVet;
  static const Field<MedicalDetailsData, AssignedVet> _f$assignedVet = Field(
    'assignedVet',
    _$assignedVet,
    key: r'assigned_vet',
    opt: true,
    def: const AssignedVet(),
  );
  static PetOwner _$petOwner(MedicalDetailsData v) => v.petOwner;
  static const Field<MedicalDetailsData, PetOwner> _f$petOwner = Field(
    'petOwner',
    _$petOwner,
    key: r'pet_owner',
    opt: true,
    def: const PetOwner(),
  );
  static Pet _$pet(MedicalDetailsData v) => v.pet;
  static const Field<MedicalDetailsData, Pet> _f$pet = Field(
    'pet',
    _$pet,
    opt: true,
    def: const Pet(),
  );
  static List<MedicalHistoryRecord> _$medicalHistoryRecords(
    MedicalDetailsData v,
  ) => v.medicalHistoryRecords;
  static const Field<MedicalDetailsData, List<MedicalHistoryRecord>>
  _f$medicalHistoryRecords = Field(
    'medicalHistoryRecords',
    _$medicalHistoryRecords,
    opt: true,
    def: const [],
    hook: MedicalHistoryRecordListHook(),
  );

  @override
  final MappableFields<MedicalDetailsData> fields = const {
    #id: _f$id,
    #clinicId: _f$clinicId,
    #userId: _f$userId,
    #petId: _f$petId,
    #vetId: _f$vetId,
    #appointmentDate: _f$appointmentDate,
    #startTime: _f$startTime,
    #endTime: _f$endTime,
    #consultationType: _f$consultationType,
    #chiefComplaint: _f$chiefComplaint,
    #appointmentStatus: _f$appointmentStatus,
    #vetAssignedAt: _f$vetAssignedAt,
    #assignedBy: _f$assignedBy,
    #isVetRequested: _f$isVetRequested,
    #requestedVetId: _f$requestedVetId,
    #priority: _f$priority,
    #actualEndTime: _f$actualEndTime,
    #cancellationReason: _f$cancellationReason,
    #cancellationNotes: _f$cancellationNotes,
    #cancelledById: _f$cancelledById,
    #previousTimeLogs: _f$previousTimeLogs,
    #symptoms: _f$symptoms,
    #duration: _f$duration,
    #medication: _f$medication,
    #medicalNotes: _f$medicalNotes,
    #isFollowup: _f$isFollowup,
    #followupAppointmentId: _f$followupAppointmentId,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #clinic: _f$clinic,
    #assignedVet: _f$assignedVet,
    #petOwner: _f$petOwner,
    #pet: _f$pet,
    #medicalHistoryRecords: _f$medicalHistoryRecords,
  };

  static MedicalDetailsData _instantiate(DecodingData data) {
    return MedicalDetailsData(
      id: data.dec(_f$id),
      clinicId: data.dec(_f$clinicId),
      userId: data.dec(_f$userId),
      petId: data.dec(_f$petId),
      vetId: data.dec(_f$vetId),
      appointmentDate: data.dec(_f$appointmentDate),
      startTime: data.dec(_f$startTime),
      endTime: data.dec(_f$endTime),
      consultationType: data.dec(_f$consultationType),
      chiefComplaint: data.dec(_f$chiefComplaint),
      appointmentStatus: data.dec(_f$appointmentStatus),
      vetAssignedAt: data.dec(_f$vetAssignedAt),
      assignedBy: data.dec(_f$assignedBy),
      isVetRequested: data.dec(_f$isVetRequested),
      requestedVetId: data.dec(_f$requestedVetId),
      priority: data.dec(_f$priority),
      actualEndTime: data.dec(_f$actualEndTime),
      cancellationReason: data.dec(_f$cancellationReason),
      cancellationNotes: data.dec(_f$cancellationNotes),
      cancelledById: data.dec(_f$cancelledById),
      previousTimeLogs: data.dec(_f$previousTimeLogs),
      symptoms: data.dec(_f$symptoms),
      duration: data.dec(_f$duration),
      medication: data.dec(_f$medication),
      medicalNotes: data.dec(_f$medicalNotes),
      isFollowup: data.dec(_f$isFollowup),
      followupAppointmentId: data.dec(_f$followupAppointmentId),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      clinic: data.dec(_f$clinic),
      assignedVet: data.dec(_f$assignedVet),
      petOwner: data.dec(_f$petOwner),
      pet: data.dec(_f$pet),
      medicalHistoryRecords: data.dec(_f$medicalHistoryRecords),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MedicalDetailsData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MedicalDetailsData>(map);
  }

  static MedicalDetailsData fromJson(String json) {
    return ensureInitialized().decodeJson<MedicalDetailsData>(json);
  }
}

mixin MedicalDetailsDataMappable {
  String toJson() {
    return MedicalDetailsDataMapper.ensureInitialized()
        .encodeJson<MedicalDetailsData>(this as MedicalDetailsData);
  }

  Map<String, dynamic> toMap() {
    return MedicalDetailsDataMapper.ensureInitialized()
        .encodeMap<MedicalDetailsData>(this as MedicalDetailsData);
  }

  MedicalDetailsDataCopyWith<
    MedicalDetailsData,
    MedicalDetailsData,
    MedicalDetailsData
  >
  get copyWith =>
      _MedicalDetailsDataCopyWithImpl<MedicalDetailsData, MedicalDetailsData>(
        this as MedicalDetailsData,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MedicalDetailsDataMapper.ensureInitialized().stringifyValue(
      this as MedicalDetailsData,
    );
  }

  @override
  bool operator ==(Object other) {
    return MedicalDetailsDataMapper.ensureInitialized().equalsValue(
      this as MedicalDetailsData,
      other,
    );
  }

  @override
  int get hashCode {
    return MedicalDetailsDataMapper.ensureInitialized().hashValue(
      this as MedicalDetailsData,
    );
  }
}

extension MedicalDetailsDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MedicalDetailsData, $Out> {
  MedicalDetailsDataCopyWith<$R, MedicalDetailsData, $Out>
  get $asMedicalDetailsData => $base.as(
    (v, t, t2) => _MedicalDetailsDataCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class MedicalDetailsDataCopyWith<
  $R,
  $In extends MedicalDetailsData,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    PreviousTimeLog,
    PreviousTimeLogCopyWith<$R, PreviousTimeLog, PreviousTimeLog>
  >
  get previousTimeLogs;
  ClinicCopyWith<$R, Clinic, Clinic> get clinic;
  AssignedVetCopyWith<$R, AssignedVet, AssignedVet> get assignedVet;
  PetOwnerCopyWith<$R, PetOwner, PetOwner> get petOwner;
  PetCopyWith<$R, Pet, Pet> get pet;
  ListCopyWith<
    $R,
    MedicalHistoryRecord,
    MedicalHistoryRecordCopyWith<$R, MedicalHistoryRecord, MedicalHistoryRecord>
  >
  get medicalHistoryRecords;
  $R call({
    String? id,
    String? clinicId,
    String? userId,
    String? petId,
    String? vetId,
    String? appointmentDate,
    String? startTime,
    String? endTime,
    String? consultationType,
    String? chiefComplaint,
    String? appointmentStatus,
    String? vetAssignedAt,
    String? assignedBy,
    bool? isVetRequested,
    String? requestedVetId,
    String? priority,
    String? actualEndTime,
    String? cancellationReason,
    String? cancellationNotes,
    String? cancelledById,
    List<PreviousTimeLog>? previousTimeLogs,
    String? symptoms,
    String? duration,
    String? medication,
    String? medicalNotes,
    bool? isFollowup,
    String? followupAppointmentId,
    String? createdAt,
    String? updatedAt,
    Clinic? clinic,
    AssignedVet? assignedVet,
    PetOwner? petOwner,
    Pet? pet,
    List<MedicalHistoryRecord>? medicalHistoryRecords,
  });
  MedicalDetailsDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MedicalDetailsDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MedicalDetailsData, $Out>
    implements MedicalDetailsDataCopyWith<$R, MedicalDetailsData, $Out> {
  _MedicalDetailsDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MedicalDetailsData> $mapper =
      MedicalDetailsDataMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    PreviousTimeLog,
    PreviousTimeLogCopyWith<$R, PreviousTimeLog, PreviousTimeLog>
  >
  get previousTimeLogs => ListCopyWith(
    $value.previousTimeLogs,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(previousTimeLogs: v),
  );
  @override
  ClinicCopyWith<$R, Clinic, Clinic> get clinic =>
      $value.clinic.copyWith.$chain((v) => call(clinic: v));
  @override
  AssignedVetCopyWith<$R, AssignedVet, AssignedVet> get assignedVet =>
      $value.assignedVet.copyWith.$chain((v) => call(assignedVet: v));
  @override
  PetOwnerCopyWith<$R, PetOwner, PetOwner> get petOwner =>
      $value.petOwner.copyWith.$chain((v) => call(petOwner: v));
  @override
  PetCopyWith<$R, Pet, Pet> get pet =>
      $value.pet.copyWith.$chain((v) => call(pet: v));
  @override
  ListCopyWith<
    $R,
    MedicalHistoryRecord,
    MedicalHistoryRecordCopyWith<$R, MedicalHistoryRecord, MedicalHistoryRecord>
  >
  get medicalHistoryRecords => ListCopyWith(
    $value.medicalHistoryRecords,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(medicalHistoryRecords: v),
  );
  @override
  $R call({
    String? id,
    String? clinicId,
    String? userId,
    String? petId,
    String? vetId,
    String? appointmentDate,
    String? startTime,
    String? endTime,
    String? consultationType,
    String? chiefComplaint,
    String? appointmentStatus,
    String? vetAssignedAt,
    Object? assignedBy = $none,
    bool? isVetRequested,
    Object? requestedVetId = $none,
    String? priority,
    String? actualEndTime,
    Object? cancellationReason = $none,
    Object? cancellationNotes = $none,
    Object? cancelledById = $none,
    List<PreviousTimeLog>? previousTimeLogs,
    String? symptoms,
    String? duration,
    String? medication,
    String? medicalNotes,
    bool? isFollowup,
    Object? followupAppointmentId = $none,
    String? createdAt,
    String? updatedAt,
    Clinic? clinic,
    AssignedVet? assignedVet,
    PetOwner? petOwner,
    Pet? pet,
    List<MedicalHistoryRecord>? medicalHistoryRecords,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (clinicId != null) #clinicId: clinicId,
      if (userId != null) #userId: userId,
      if (petId != null) #petId: petId,
      if (vetId != null) #vetId: vetId,
      if (appointmentDate != null) #appointmentDate: appointmentDate,
      if (startTime != null) #startTime: startTime,
      if (endTime != null) #endTime: endTime,
      if (consultationType != null) #consultationType: consultationType,
      if (chiefComplaint != null) #chiefComplaint: chiefComplaint,
      if (appointmentStatus != null) #appointmentStatus: appointmentStatus,
      if (vetAssignedAt != null) #vetAssignedAt: vetAssignedAt,
      if (assignedBy != $none) #assignedBy: assignedBy,
      if (isVetRequested != null) #isVetRequested: isVetRequested,
      if (requestedVetId != $none) #requestedVetId: requestedVetId,
      if (priority != null) #priority: priority,
      if (actualEndTime != null) #actualEndTime: actualEndTime,
      if (cancellationReason != $none) #cancellationReason: cancellationReason,
      if (cancellationNotes != $none) #cancellationNotes: cancellationNotes,
      if (cancelledById != $none) #cancelledById: cancelledById,
      if (previousTimeLogs != null) #previousTimeLogs: previousTimeLogs,
      if (symptoms != null) #symptoms: symptoms,
      if (duration != null) #duration: duration,
      if (medication != null) #medication: medication,
      if (medicalNotes != null) #medicalNotes: medicalNotes,
      if (isFollowup != null) #isFollowup: isFollowup,
      if (followupAppointmentId != $none)
        #followupAppointmentId: followupAppointmentId,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
      if (clinic != null) #clinic: clinic,
      if (assignedVet != null) #assignedVet: assignedVet,
      if (petOwner != null) #petOwner: petOwner,
      if (pet != null) #pet: pet,
      if (medicalHistoryRecords != null)
        #medicalHistoryRecords: medicalHistoryRecords,
    }),
  );
  @override
  MedicalDetailsData $make(CopyWithData data) => MedicalDetailsData(
    id: data.get(#id, or: $value.id),
    clinicId: data.get(#clinicId, or: $value.clinicId),
    userId: data.get(#userId, or: $value.userId),
    petId: data.get(#petId, or: $value.petId),
    vetId: data.get(#vetId, or: $value.vetId),
    appointmentDate: data.get(#appointmentDate, or: $value.appointmentDate),
    startTime: data.get(#startTime, or: $value.startTime),
    endTime: data.get(#endTime, or: $value.endTime),
    consultationType: data.get(#consultationType, or: $value.consultationType),
    chiefComplaint: data.get(#chiefComplaint, or: $value.chiefComplaint),
    appointmentStatus: data.get(
      #appointmentStatus,
      or: $value.appointmentStatus,
    ),
    vetAssignedAt: data.get(#vetAssignedAt, or: $value.vetAssignedAt),
    assignedBy: data.get(#assignedBy, or: $value.assignedBy),
    isVetRequested: data.get(#isVetRequested, or: $value.isVetRequested),
    requestedVetId: data.get(#requestedVetId, or: $value.requestedVetId),
    priority: data.get(#priority, or: $value.priority),
    actualEndTime: data.get(#actualEndTime, or: $value.actualEndTime),
    cancellationReason: data.get(
      #cancellationReason,
      or: $value.cancellationReason,
    ),
    cancellationNotes: data.get(
      #cancellationNotes,
      or: $value.cancellationNotes,
    ),
    cancelledById: data.get(#cancelledById, or: $value.cancelledById),
    previousTimeLogs: data.get(#previousTimeLogs, or: $value.previousTimeLogs),
    symptoms: data.get(#symptoms, or: $value.symptoms),
    duration: data.get(#duration, or: $value.duration),
    medication: data.get(#medication, or: $value.medication),
    medicalNotes: data.get(#medicalNotes, or: $value.medicalNotes),
    isFollowup: data.get(#isFollowup, or: $value.isFollowup),
    followupAppointmentId: data.get(
      #followupAppointmentId,
      or: $value.followupAppointmentId,
    ),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    clinic: data.get(#clinic, or: $value.clinic),
    assignedVet: data.get(#assignedVet, or: $value.assignedVet),
    petOwner: data.get(#petOwner, or: $value.petOwner),
    pet: data.get(#pet, or: $value.pet),
    medicalHistoryRecords: data.get(
      #medicalHistoryRecords,
      or: $value.medicalHistoryRecords,
    ),
  );

  @override
  MedicalDetailsDataCopyWith<$R2, MedicalDetailsData, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MedicalDetailsDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PreviousTimeLogMapper extends ClassMapperBase<PreviousTimeLog> {
  PreviousTimeLogMapper._();

  static PreviousTimeLogMapper? _instance;
  static PreviousTimeLogMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PreviousTimeLogMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PreviousTimeLog';

  static String _$reason(PreviousTimeLog v) => v.reason;
  static const Field<PreviousTimeLog, String> _f$reason = Field(
    'reason',
    _$reason,
    opt: true,
    def: '',
  );
  static String _$endTime(PreviousTimeLog v) => v.endTime;
  static const Field<PreviousTimeLog, String> _f$endTime = Field(
    'endTime',
    _$endTime,
    key: r'end_time',
    opt: true,
    def: '',
  );
  static String _$startTime(PreviousTimeLog v) => v.startTime;
  static const Field<PreviousTimeLog, String> _f$startTime = Field(
    'startTime',
    _$startTime,
    key: r'start_time',
    opt: true,
    def: '',
  );
  static String _$rescheduledAt(PreviousTimeLog v) => v.rescheduledAt;
  static const Field<PreviousTimeLog, String> _f$rescheduledAt = Field(
    'rescheduledAt',
    _$rescheduledAt,
    key: r'rescheduled_at',
    opt: true,
    def: '',
  );
  static String _$appointmentDate(PreviousTimeLog v) => v.appointmentDate;
  static const Field<PreviousTimeLog, String> _f$appointmentDate = Field(
    'appointmentDate',
    _$appointmentDate,
    key: r'appointment_date',
    opt: true,
    def: '',
  );

  @override
  final MappableFields<PreviousTimeLog> fields = const {
    #reason: _f$reason,
    #endTime: _f$endTime,
    #startTime: _f$startTime,
    #rescheduledAt: _f$rescheduledAt,
    #appointmentDate: _f$appointmentDate,
  };

  static PreviousTimeLog _instantiate(DecodingData data) {
    return PreviousTimeLog(
      reason: data.dec(_f$reason),
      endTime: data.dec(_f$endTime),
      startTime: data.dec(_f$startTime),
      rescheduledAt: data.dec(_f$rescheduledAt),
      appointmentDate: data.dec(_f$appointmentDate),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PreviousTimeLog fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PreviousTimeLog>(map);
  }

  static PreviousTimeLog fromJson(String json) {
    return ensureInitialized().decodeJson<PreviousTimeLog>(json);
  }
}

mixin PreviousTimeLogMappable {
  String toJson() {
    return PreviousTimeLogMapper.ensureInitialized()
        .encodeJson<PreviousTimeLog>(this as PreviousTimeLog);
  }

  Map<String, dynamic> toMap() {
    return PreviousTimeLogMapper.ensureInitialized().encodeMap<PreviousTimeLog>(
      this as PreviousTimeLog,
    );
  }

  PreviousTimeLogCopyWith<PreviousTimeLog, PreviousTimeLog, PreviousTimeLog>
  get copyWith =>
      _PreviousTimeLogCopyWithImpl<PreviousTimeLog, PreviousTimeLog>(
        this as PreviousTimeLog,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PreviousTimeLogMapper.ensureInitialized().stringifyValue(
      this as PreviousTimeLog,
    );
  }

  @override
  bool operator ==(Object other) {
    return PreviousTimeLogMapper.ensureInitialized().equalsValue(
      this as PreviousTimeLog,
      other,
    );
  }

  @override
  int get hashCode {
    return PreviousTimeLogMapper.ensureInitialized().hashValue(
      this as PreviousTimeLog,
    );
  }
}

extension PreviousTimeLogValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PreviousTimeLog, $Out> {
  PreviousTimeLogCopyWith<$R, PreviousTimeLog, $Out> get $asPreviousTimeLog =>
      $base.as((v, t, t2) => _PreviousTimeLogCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PreviousTimeLogCopyWith<$R, $In extends PreviousTimeLog, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? reason,
    String? endTime,
    String? startTime,
    String? rescheduledAt,
    String? appointmentDate,
  });
  PreviousTimeLogCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PreviousTimeLogCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PreviousTimeLog, $Out>
    implements PreviousTimeLogCopyWith<$R, PreviousTimeLog, $Out> {
  _PreviousTimeLogCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PreviousTimeLog> $mapper =
      PreviousTimeLogMapper.ensureInitialized();
  @override
  $R call({
    String? reason,
    String? endTime,
    String? startTime,
    String? rescheduledAt,
    String? appointmentDate,
  }) => $apply(
    FieldCopyWithData({
      if (reason != null) #reason: reason,
      if (endTime != null) #endTime: endTime,
      if (startTime != null) #startTime: startTime,
      if (rescheduledAt != null) #rescheduledAt: rescheduledAt,
      if (appointmentDate != null) #appointmentDate: appointmentDate,
    }),
  );
  @override
  PreviousTimeLog $make(CopyWithData data) => PreviousTimeLog(
    reason: data.get(#reason, or: $value.reason),
    endTime: data.get(#endTime, or: $value.endTime),
    startTime: data.get(#startTime, or: $value.startTime),
    rescheduledAt: data.get(#rescheduledAt, or: $value.rescheduledAt),
    appointmentDate: data.get(#appointmentDate, or: $value.appointmentDate),
  );

  @override
  PreviousTimeLogCopyWith<$R2, PreviousTimeLog, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PreviousTimeLogCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ClinicMapper extends ClassMapperBase<Clinic> {
  ClinicMapper._();

  static ClinicMapper? _instance;
  static ClinicMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ClinicMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Clinic';

  static String _$id(Clinic v) => v.id;
  static const Field<Clinic, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$clinicName(Clinic v) => v.clinicName;
  static const Field<Clinic, String> _f$clinicName = Field(
    'clinicName',
    _$clinicName,
    key: r'clinic_name',
    opt: true,
    def: '',
  );
  static String _$address(Clinic v) => v.address;
  static const Field<Clinic, String> _f$address = Field(
    'address',
    _$address,
    opt: true,
    def: '',
  );
  static String _$phone(Clinic v) => v.phone;
  static const Field<Clinic, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
    def: '',
  );
  static String _$clinicImage(Clinic v) => v.clinicImage;
  static const Field<Clinic, String> _f$clinicImage = Field(
    'clinicImage',
    _$clinicImage,
    key: r'clinic_image',
    opt: true,
    def: '',
  );

  @override
  final MappableFields<Clinic> fields = const {
    #id: _f$id,
    #clinicName: _f$clinicName,
    #address: _f$address,
    #phone: _f$phone,
    #clinicImage: _f$clinicImage,
  };

  static Clinic _instantiate(DecodingData data) {
    return Clinic(
      id: data.dec(_f$id),
      clinicName: data.dec(_f$clinicName),
      address: data.dec(_f$address),
      phone: data.dec(_f$phone),
      clinicImage: data.dec(_f$clinicImage),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Clinic fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Clinic>(map);
  }

  static Clinic fromJson(String json) {
    return ensureInitialized().decodeJson<Clinic>(json);
  }
}

mixin ClinicMappable {
  String toJson() {
    return ClinicMapper.ensureInitialized().encodeJson<Clinic>(this as Clinic);
  }

  Map<String, dynamic> toMap() {
    return ClinicMapper.ensureInitialized().encodeMap<Clinic>(this as Clinic);
  }

  ClinicCopyWith<Clinic, Clinic, Clinic> get copyWith =>
      _ClinicCopyWithImpl<Clinic, Clinic>(this as Clinic, $identity, $identity);
  @override
  String toString() {
    return ClinicMapper.ensureInitialized().stringifyValue(this as Clinic);
  }

  @override
  bool operator ==(Object other) {
    return ClinicMapper.ensureInitialized().equalsValue(this as Clinic, other);
  }

  @override
  int get hashCode {
    return ClinicMapper.ensureInitialized().hashValue(this as Clinic);
  }
}

extension ClinicValueCopy<$R, $Out> on ObjectCopyWith<$R, Clinic, $Out> {
  ClinicCopyWith<$R, Clinic, $Out> get $asClinic =>
      $base.as((v, t, t2) => _ClinicCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ClinicCopyWith<$R, $In extends Clinic, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? clinicName,
    String? address,
    String? phone,
    String? clinicImage,
  });
  ClinicCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ClinicCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Clinic, $Out>
    implements ClinicCopyWith<$R, Clinic, $Out> {
  _ClinicCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Clinic> $mapper = ClinicMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? clinicName,
    String? address,
    String? phone,
    String? clinicImage,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (clinicName != null) #clinicName: clinicName,
      if (address != null) #address: address,
      if (phone != null) #phone: phone,
      if (clinicImage != null) #clinicImage: clinicImage,
    }),
  );
  @override
  Clinic $make(CopyWithData data) => Clinic(
    id: data.get(#id, or: $value.id),
    clinicName: data.get(#clinicName, or: $value.clinicName),
    address: data.get(#address, or: $value.address),
    phone: data.get(#phone, or: $value.phone),
    clinicImage: data.get(#clinicImage, or: $value.clinicImage),
  );

  @override
  ClinicCopyWith<$R2, Clinic, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ClinicCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AssignedVetMapper extends ClassMapperBase<AssignedVet> {
  AssignedVetMapper._();

  static AssignedVetMapper? _instance;
  static AssignedVetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssignedVetMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AssignedVet';

  static String _$id(AssignedVet v) => v.id;
  static const Field<AssignedVet, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$name(AssignedVet v) => v.name;
  static const Field<AssignedVet, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
  );
  static List<String> _$specialization(AssignedVet v) => v.specialization;
  static const Field<AssignedVet, List<String>> _f$specialization = Field(
    'specialization',
    _$specialization,
    opt: true,
    def: const [],
    hook: SafeListHook(),
  );
  static String _$consultationFee(AssignedVet v) => v.consultationFee;
  static const Field<AssignedVet, String> _f$consultationFee = Field(
    'consultationFee',
    _$consultationFee,
    key: r'consultation_fee',
    opt: true,
    def: '',
  );
  static String _$profilePicture(AssignedVet v) => v.profilePicture;
  static const Field<AssignedVet, String> _f$profilePicture = Field(
    'profilePicture',
    _$profilePicture,
    key: r'profile_picture',
    opt: true,
    def: '',
  );

  @override
  final MappableFields<AssignedVet> fields = const {
    #id: _f$id,
    #name: _f$name,
    #specialization: _f$specialization,
    #consultationFee: _f$consultationFee,
    #profilePicture: _f$profilePicture,
  };

  static AssignedVet _instantiate(DecodingData data) {
    return AssignedVet(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      specialization: data.dec(_f$specialization),
      consultationFee: data.dec(_f$consultationFee),
      profilePicture: data.dec(_f$profilePicture),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AssignedVet fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AssignedVet>(map);
  }

  static AssignedVet fromJson(String json) {
    return ensureInitialized().decodeJson<AssignedVet>(json);
  }
}

mixin AssignedVetMappable {
  String toJson() {
    return AssignedVetMapper.ensureInitialized().encodeJson<AssignedVet>(
      this as AssignedVet,
    );
  }

  Map<String, dynamic> toMap() {
    return AssignedVetMapper.ensureInitialized().encodeMap<AssignedVet>(
      this as AssignedVet,
    );
  }

  AssignedVetCopyWith<AssignedVet, AssignedVet, AssignedVet> get copyWith =>
      _AssignedVetCopyWithImpl<AssignedVet, AssignedVet>(
        this as AssignedVet,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AssignedVetMapper.ensureInitialized().stringifyValue(
      this as AssignedVet,
    );
  }

  @override
  bool operator ==(Object other) {
    return AssignedVetMapper.ensureInitialized().equalsValue(
      this as AssignedVet,
      other,
    );
  }

  @override
  int get hashCode {
    return AssignedVetMapper.ensureInitialized().hashValue(this as AssignedVet);
  }
}

extension AssignedVetValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AssignedVet, $Out> {
  AssignedVetCopyWith<$R, AssignedVet, $Out> get $asAssignedVet =>
      $base.as((v, t, t2) => _AssignedVetCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AssignedVetCopyWith<$R, $In extends AssignedVet, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get specialization;
  $R call({
    String? id,
    String? name,
    List<String>? specialization,
    String? consultationFee,
    String? profilePicture,
  });
  AssignedVetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AssignedVetCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AssignedVet, $Out>
    implements AssignedVetCopyWith<$R, AssignedVet, $Out> {
  _AssignedVetCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AssignedVet> $mapper =
      AssignedVetMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get specialization => ListCopyWith(
    $value.specialization,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(specialization: v),
  );
  @override
  $R call({
    String? id,
    String? name,
    List<String>? specialization,
    String? consultationFee,
    String? profilePicture,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (specialization != null) #specialization: specialization,
      if (consultationFee != null) #consultationFee: consultationFee,
      if (profilePicture != null) #profilePicture: profilePicture,
    }),
  );
  @override
  AssignedVet $make(CopyWithData data) => AssignedVet(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    specialization: data.get(#specialization, or: $value.specialization),
    consultationFee: data.get(#consultationFee, or: $value.consultationFee),
    profilePicture: data.get(#profilePicture, or: $value.profilePicture),
  );

  @override
  AssignedVetCopyWith<$R2, AssignedVet, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AssignedVetCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PetOwnerMapper extends ClassMapperBase<PetOwner> {
  PetOwnerMapper._();

  static PetOwnerMapper? _instance;
  static PetOwnerMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PetOwnerMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PetOwner';

  static String _$id(PetOwner v) => v.id;
  static const Field<PetOwner, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$name(PetOwner v) => v.name;
  static const Field<PetOwner, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
  );
  static String _$phone(PetOwner v) => v.phone;
  static const Field<PetOwner, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<PetOwner> fields = const {
    #id: _f$id,
    #name: _f$name,
    #phone: _f$phone,
  };

  static PetOwner _instantiate(DecodingData data) {
    return PetOwner(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      phone: data.dec(_f$phone),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PetOwner fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PetOwner>(map);
  }

  static PetOwner fromJson(String json) {
    return ensureInitialized().decodeJson<PetOwner>(json);
  }
}

mixin PetOwnerMappable {
  String toJson() {
    return PetOwnerMapper.ensureInitialized().encodeJson<PetOwner>(
      this as PetOwner,
    );
  }

  Map<String, dynamic> toMap() {
    return PetOwnerMapper.ensureInitialized().encodeMap<PetOwner>(
      this as PetOwner,
    );
  }

  PetOwnerCopyWith<PetOwner, PetOwner, PetOwner> get copyWith =>
      _PetOwnerCopyWithImpl<PetOwner, PetOwner>(
        this as PetOwner,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PetOwnerMapper.ensureInitialized().stringifyValue(this as PetOwner);
  }

  @override
  bool operator ==(Object other) {
    return PetOwnerMapper.ensureInitialized().equalsValue(
      this as PetOwner,
      other,
    );
  }

  @override
  int get hashCode {
    return PetOwnerMapper.ensureInitialized().hashValue(this as PetOwner);
  }
}

extension PetOwnerValueCopy<$R, $Out> on ObjectCopyWith<$R, PetOwner, $Out> {
  PetOwnerCopyWith<$R, PetOwner, $Out> get $asPetOwner =>
      $base.as((v, t, t2) => _PetOwnerCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PetOwnerCopyWith<$R, $In extends PetOwner, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name, String? phone});
  PetOwnerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PetOwnerCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PetOwner, $Out>
    implements PetOwnerCopyWith<$R, PetOwner, $Out> {
  _PetOwnerCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PetOwner> $mapper =
      PetOwnerMapper.ensureInitialized();
  @override
  $R call({String? id, String? name, String? phone}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (phone != null) #phone: phone,
    }),
  );
  @override
  PetOwner $make(CopyWithData data) => PetOwner(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    phone: data.get(#phone, or: $value.phone),
  );

  @override
  PetOwnerCopyWith<$R2, PetOwner, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PetOwnerCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PetMapper extends ClassMapperBase<Pet> {
  PetMapper._();

  static PetMapper? _instance;
  static PetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PetMapper._());
      BreedInfoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Pet';

  static String _$id(Pet v) => v.id;
  static const Field<Pet, String> _f$id = Field('id', _$id, opt: true, def: '');
  static String _$name(Pet v) => v.name;
  static const Field<Pet, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
  );
  static String _$type(Pet v) => v.type;
  static const Field<Pet, String> _f$type = Field(
    'type',
    _$type,
    opt: true,
    def: '',
  );
  static String _$profilePicture(Pet v) => v.profilePicture;
  static const Field<Pet, String> _f$profilePicture = Field(
    'profilePicture',
    _$profilePicture,
    key: r'profile_picture',
    opt: true,
    def: '',
  );
  static BreedInfo _$breedInfo(Pet v) => v.breedInfo;
  static const Field<Pet, BreedInfo> _f$breedInfo = Field(
    'breedInfo',
    _$breedInfo,
    key: r'breed_info',
    opt: true,
    def: const BreedInfo(),
  );

  @override
  final MappableFields<Pet> fields = const {
    #id: _f$id,
    #name: _f$name,
    #type: _f$type,
    #profilePicture: _f$profilePicture,
    #breedInfo: _f$breedInfo,
  };

  static Pet _instantiate(DecodingData data) {
    return Pet(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      type: data.dec(_f$type),
      profilePicture: data.dec(_f$profilePicture),
      breedInfo: data.dec(_f$breedInfo),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Pet fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Pet>(map);
  }

  static Pet fromJson(String json) {
    return ensureInitialized().decodeJson<Pet>(json);
  }
}

mixin PetMappable {
  String toJson() {
    return PetMapper.ensureInitialized().encodeJson<Pet>(this as Pet);
  }

  Map<String, dynamic> toMap() {
    return PetMapper.ensureInitialized().encodeMap<Pet>(this as Pet);
  }

  PetCopyWith<Pet, Pet, Pet> get copyWith =>
      _PetCopyWithImpl<Pet, Pet>(this as Pet, $identity, $identity);
  @override
  String toString() {
    return PetMapper.ensureInitialized().stringifyValue(this as Pet);
  }

  @override
  bool operator ==(Object other) {
    return PetMapper.ensureInitialized().equalsValue(this as Pet, other);
  }

  @override
  int get hashCode {
    return PetMapper.ensureInitialized().hashValue(this as Pet);
  }
}

extension PetValueCopy<$R, $Out> on ObjectCopyWith<$R, Pet, $Out> {
  PetCopyWith<$R, Pet, $Out> get $asPet =>
      $base.as((v, t, t2) => _PetCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PetCopyWith<$R, $In extends Pet, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  BreedInfoCopyWith<$R, BreedInfo, BreedInfo> get breedInfo;
  $R call({
    String? id,
    String? name,
    String? type,
    String? profilePicture,
    BreedInfo? breedInfo,
  });
  PetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PetCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Pet, $Out>
    implements PetCopyWith<$R, Pet, $Out> {
  _PetCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Pet> $mapper = PetMapper.ensureInitialized();
  @override
  BreedInfoCopyWith<$R, BreedInfo, BreedInfo> get breedInfo =>
      $value.breedInfo.copyWith.$chain((v) => call(breedInfo: v));
  @override
  $R call({
    String? id,
    String? name,
    String? type,
    String? profilePicture,
    BreedInfo? breedInfo,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (type != null) #type: type,
      if (profilePicture != null) #profilePicture: profilePicture,
      if (breedInfo != null) #breedInfo: breedInfo,
    }),
  );
  @override
  Pet $make(CopyWithData data) => Pet(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    type: data.get(#type, or: $value.type),
    profilePicture: data.get(#profilePicture, or: $value.profilePicture),
    breedInfo: data.get(#breedInfo, or: $value.breedInfo),
  );

  @override
  PetCopyWith<$R2, Pet, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PetCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class BreedInfoMapper extends ClassMapperBase<BreedInfo> {
  BreedInfoMapper._();

  static BreedInfoMapper? _instance;
  static BreedInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BreedInfoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BreedInfo';

  static String _$breedName(BreedInfo v) => v.breedName;
  static const Field<BreedInfo, String> _f$breedName = Field(
    'breedName',
    _$breedName,
    key: r'breed_name',
    opt: true,
    def: '',
  );

  @override
  final MappableFields<BreedInfo> fields = const {#breedName: _f$breedName};

  static BreedInfo _instantiate(DecodingData data) {
    return BreedInfo(breedName: data.dec(_f$breedName));
  }

  @override
  final Function instantiate = _instantiate;

  static BreedInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BreedInfo>(map);
  }

  static BreedInfo fromJson(String json) {
    return ensureInitialized().decodeJson<BreedInfo>(json);
  }
}

mixin BreedInfoMappable {
  String toJson() {
    return BreedInfoMapper.ensureInitialized().encodeJson<BreedInfo>(
      this as BreedInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return BreedInfoMapper.ensureInitialized().encodeMap<BreedInfo>(
      this as BreedInfo,
    );
  }

  BreedInfoCopyWith<BreedInfo, BreedInfo, BreedInfo> get copyWith =>
      _BreedInfoCopyWithImpl<BreedInfo, BreedInfo>(
        this as BreedInfo,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return BreedInfoMapper.ensureInitialized().stringifyValue(
      this as BreedInfo,
    );
  }

  @override
  bool operator ==(Object other) {
    return BreedInfoMapper.ensureInitialized().equalsValue(
      this as BreedInfo,
      other,
    );
  }

  @override
  int get hashCode {
    return BreedInfoMapper.ensureInitialized().hashValue(this as BreedInfo);
  }
}

extension BreedInfoValueCopy<$R, $Out> on ObjectCopyWith<$R, BreedInfo, $Out> {
  BreedInfoCopyWith<$R, BreedInfo, $Out> get $asBreedInfo =>
      $base.as((v, t, t2) => _BreedInfoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BreedInfoCopyWith<$R, $In extends BreedInfo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? breedName});
  BreedInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BreedInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BreedInfo, $Out>
    implements BreedInfoCopyWith<$R, BreedInfo, $Out> {
  _BreedInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BreedInfo> $mapper =
      BreedInfoMapper.ensureInitialized();
  @override
  $R call({String? breedName}) =>
      $apply(FieldCopyWithData({if (breedName != null) #breedName: breedName}));
  @override
  BreedInfo $make(CopyWithData data) =>
      BreedInfo(breedName: data.get(#breedName, or: $value.breedName));

  @override
  BreedInfoCopyWith<$R2, BreedInfo, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BreedInfoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class MedicalHistoryRecordMapper extends ClassMapperBase<MedicalHistoryRecord> {
  MedicalHistoryRecordMapper._();

  static MedicalHistoryRecordMapper? _instance;
  static MedicalHistoryRecordMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MedicalHistoryRecordMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MedicalHistoryRecord';

  static String _$id(MedicalHistoryRecord v) => v.id;
  static const Field<MedicalHistoryRecord, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$type(MedicalHistoryRecord v) => v.type;
  static const Field<MedicalHistoryRecord, String> _f$type = Field(
    'type',
    _$type,
    opt: true,
    def: '',
  );
  static String _$consultationDate(MedicalHistoryRecord v) =>
      v.consultationDate;
  static const Field<MedicalHistoryRecord, String> _f$consultationDate = Field(
    'consultationDate',
    _$consultationDate,
    key: r'consultation_date',
    opt: true,
    def: '',
  );
  static dynamic _$clinic(MedicalHistoryRecord v) => v.clinic;
  static const Field<MedicalHistoryRecord, dynamic> _f$clinic = Field(
    'clinic',
    _$clinic,
    opt: true,
  );
  static List<dynamic> _$documentUrls(MedicalHistoryRecord v) => v.documentUrls;
  static const Field<MedicalHistoryRecord, List<dynamic>> _f$documentUrls =
      Field(
        'documentUrls',
        _$documentUrls,
        key: r'document_urls',
        opt: true,
        def: const [],
      );
  static String? _$reasonForVisit(MedicalHistoryRecord v) => v.reasonForVisit;
  static const Field<MedicalHistoryRecord, String> _f$reasonForVisit = Field(
    'reasonForVisit',
    _$reasonForVisit,
    key: r'reason_for_visit',
    opt: true,
  );
  static String? _$diagnosis(MedicalHistoryRecord v) => v.diagnosis;
  static const Field<MedicalHistoryRecord, String> _f$diagnosis = Field(
    'diagnosis',
    _$diagnosis,
    opt: true,
  );

  @override
  final MappableFields<MedicalHistoryRecord> fields = const {
    #id: _f$id,
    #type: _f$type,
    #consultationDate: _f$consultationDate,
    #clinic: _f$clinic,
    #documentUrls: _f$documentUrls,
    #reasonForVisit: _f$reasonForVisit,
    #diagnosis: _f$diagnosis,
  };
  @override
  final bool ignoreNull = true;

  static MedicalHistoryRecord _instantiate(DecodingData data) {
    return MedicalHistoryRecord(
      id: data.dec(_f$id),
      type: data.dec(_f$type),
      consultationDate: data.dec(_f$consultationDate),
      clinic: data.dec(_f$clinic),
      documentUrls: data.dec(_f$documentUrls),
      reasonForVisit: data.dec(_f$reasonForVisit),
      diagnosis: data.dec(_f$diagnosis),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MedicalHistoryRecord fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MedicalHistoryRecord>(map);
  }

  static MedicalHistoryRecord fromJson(String json) {
    return ensureInitialized().decodeJson<MedicalHistoryRecord>(json);
  }
}

mixin MedicalHistoryRecordMappable {
  String toJson() {
    return MedicalHistoryRecordMapper.ensureInitialized()
        .encodeJson<MedicalHistoryRecord>(this as MedicalHistoryRecord);
  }

  Map<String, dynamic> toMap() {
    return MedicalHistoryRecordMapper.ensureInitialized()
        .encodeMap<MedicalHistoryRecord>(this as MedicalHistoryRecord);
  }

  MedicalHistoryRecordCopyWith<
    MedicalHistoryRecord,
    MedicalHistoryRecord,
    MedicalHistoryRecord
  >
  get copyWith =>
      _MedicalHistoryRecordCopyWithImpl<
        MedicalHistoryRecord,
        MedicalHistoryRecord
      >(this as MedicalHistoryRecord, $identity, $identity);
  @override
  String toString() {
    return MedicalHistoryRecordMapper.ensureInitialized().stringifyValue(
      this as MedicalHistoryRecord,
    );
  }

  @override
  bool operator ==(Object other) {
    return MedicalHistoryRecordMapper.ensureInitialized().equalsValue(
      this as MedicalHistoryRecord,
      other,
    );
  }

  @override
  int get hashCode {
    return MedicalHistoryRecordMapper.ensureInitialized().hashValue(
      this as MedicalHistoryRecord,
    );
  }
}

extension MedicalHistoryRecordValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MedicalHistoryRecord, $Out> {
  MedicalHistoryRecordCopyWith<$R, MedicalHistoryRecord, $Out>
  get $asMedicalHistoryRecord => $base.as(
    (v, t, t2) => _MedicalHistoryRecordCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class MedicalHistoryRecordCopyWith<
  $R,
  $In extends MedicalHistoryRecord,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get documentUrls;
  $R call({
    String? id,
    String? type,
    String? consultationDate,
    dynamic clinic,
    List<dynamic>? documentUrls,
    String? reasonForVisit,
    String? diagnosis,
  });
  MedicalHistoryRecordCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MedicalHistoryRecordCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MedicalHistoryRecord, $Out>
    implements MedicalHistoryRecordCopyWith<$R, MedicalHistoryRecord, $Out> {
  _MedicalHistoryRecordCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MedicalHistoryRecord> $mapper =
      MedicalHistoryRecordMapper.ensureInitialized();
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get documentUrls => ListCopyWith(
    $value.documentUrls,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(documentUrls: v),
  );
  @override
  $R call({
    String? id,
    String? type,
    String? consultationDate,
    Object? clinic = $none,
    List<dynamic>? documentUrls,
    Object? reasonForVisit = $none,
    Object? diagnosis = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (type != null) #type: type,
      if (consultationDate != null) #consultationDate: consultationDate,
      if (clinic != $none) #clinic: clinic,
      if (documentUrls != null) #documentUrls: documentUrls,
      if (reasonForVisit != $none) #reasonForVisit: reasonForVisit,
      if (diagnosis != $none) #diagnosis: diagnosis,
    }),
  );
  @override
  MedicalHistoryRecord $make(CopyWithData data) => MedicalHistoryRecord(
    id: data.get(#id, or: $value.id),
    type: data.get(#type, or: $value.type),
    consultationDate: data.get(#consultationDate, or: $value.consultationDate),
    clinic: data.get(#clinic, or: $value.clinic),
    documentUrls: data.get(#documentUrls, or: $value.documentUrls),
    reasonForVisit: data.get(#reasonForVisit, or: $value.reasonForVisit),
    diagnosis: data.get(#diagnosis, or: $value.diagnosis),
  );

  @override
  MedicalHistoryRecordCopyWith<$R2, MedicalHistoryRecord, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MedicalHistoryRecordCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class MetaMapper extends ClassMapperBase<Meta> {
  MetaMapper._();

  static MetaMapper? _instance;
  static MetaMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MetaMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Meta';

  static String _$lang(Meta v) => v.lang;
  static const Field<Meta, String> _f$lang = Field(
    'lang',
    _$lang,
    opt: true,
    def: '',
  );
  static String _$timestamp(Meta v) => v.timestamp;
  static const Field<Meta, String> _f$timestamp = Field(
    'timestamp',
    _$timestamp,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<Meta> fields = const {
    #lang: _f$lang,
    #timestamp: _f$timestamp,
  };

  static Meta _instantiate(DecodingData data) {
    return Meta(lang: data.dec(_f$lang), timestamp: data.dec(_f$timestamp));
  }

  @override
  final Function instantiate = _instantiate;

  static Meta fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Meta>(map);
  }

  static Meta fromJson(String json) {
    return ensureInitialized().decodeJson<Meta>(json);
  }
}

mixin MetaMappable {
  String toJson() {
    return MetaMapper.ensureInitialized().encodeJson<Meta>(this as Meta);
  }

  Map<String, dynamic> toMap() {
    return MetaMapper.ensureInitialized().encodeMap<Meta>(this as Meta);
  }

  MetaCopyWith<Meta, Meta, Meta> get copyWith =>
      _MetaCopyWithImpl<Meta, Meta>(this as Meta, $identity, $identity);
  @override
  String toString() {
    return MetaMapper.ensureInitialized().stringifyValue(this as Meta);
  }

  @override
  bool operator ==(Object other) {
    return MetaMapper.ensureInitialized().equalsValue(this as Meta, other);
  }

  @override
  int get hashCode {
    return MetaMapper.ensureInitialized().hashValue(this as Meta);
  }
}

extension MetaValueCopy<$R, $Out> on ObjectCopyWith<$R, Meta, $Out> {
  MetaCopyWith<$R, Meta, $Out> get $asMeta =>
      $base.as((v, t, t2) => _MetaCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MetaCopyWith<$R, $In extends Meta, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? lang, String? timestamp});
  MetaCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MetaCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Meta, $Out>
    implements MetaCopyWith<$R, Meta, $Out> {
  _MetaCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Meta> $mapper = MetaMapper.ensureInitialized();
  @override
  $R call({String? lang, String? timestamp}) => $apply(
    FieldCopyWithData({
      if (lang != null) #lang: lang,
      if (timestamp != null) #timestamp: timestamp,
    }),
  );
  @override
  Meta $make(CopyWithData data) => Meta(
    lang: data.get(#lang, or: $value.lang),
    timestamp: data.get(#timestamp, or: $value.timestamp),
  );

  @override
  MetaCopyWith<$R2, Meta, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MetaCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

