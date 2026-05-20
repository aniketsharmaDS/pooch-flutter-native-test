// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'appointment_cal_response_model.dart';

class AppointmentCalResponseModelMapper
    extends ClassMapperBase<AppointmentCalResponseModel> {
  AppointmentCalResponseModelMapper._();

  static AppointmentCalResponseModelMapper? _instance;
  static AppointmentCalResponseModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = AppointmentCalResponseModelMapper._(),
      );
      AppointmentCalendarDataMapper.ensureInitialized();
      MetaMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AppointmentCalResponseModel';

  static bool _$success(AppointmentCalResponseModel v) => v.success;
  static const Field<AppointmentCalResponseModel, bool> _f$success = Field(
    'success',
    _$success,
    opt: true,
    def: false,
  );
  static String _$message(AppointmentCalResponseModel v) => v.message;
  static const Field<AppointmentCalResponseModel, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
    def: '',
  );
  static int _$status(AppointmentCalResponseModel v) => v.status;
  static const Field<AppointmentCalResponseModel, int> _f$status = Field(
    'status',
    _$status,
    opt: true,
    def: 0,
  );
  static AppointmentCalendarData _$data(AppointmentCalResponseModel v) =>
      v.data;
  static const Field<AppointmentCalResponseModel, AppointmentCalendarData>
  _f$data = Field(
    'data',
    _$data,
    opt: true,
    def: const AppointmentCalendarData(),
  );
  static Meta _$meta(AppointmentCalResponseModel v) => v.meta;
  static const Field<AppointmentCalResponseModel, Meta> _f$meta = Field(
    'meta',
    _$meta,
    opt: true,
    def: const Meta(),
  );

  @override
  final MappableFields<AppointmentCalResponseModel> fields = const {
    #success: _f$success,
    #message: _f$message,
    #status: _f$status,
    #data: _f$data,
    #meta: _f$meta,
  };

  static AppointmentCalResponseModel _instantiate(DecodingData data) {
    return AppointmentCalResponseModel(
      success: data.dec(_f$success),
      message: data.dec(_f$message),
      status: data.dec(_f$status),
      data: data.dec(_f$data),
      meta: data.dec(_f$meta),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppointmentCalResponseModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppointmentCalResponseModel>(map);
  }

  static AppointmentCalResponseModel fromJson(String json) {
    return ensureInitialized().decodeJson<AppointmentCalResponseModel>(json);
  }
}

mixin AppointmentCalResponseModelMappable {
  String toJson() {
    return AppointmentCalResponseModelMapper.ensureInitialized()
        .encodeJson<AppointmentCalResponseModel>(
          this as AppointmentCalResponseModel,
        );
  }

  Map<String, dynamic> toMap() {
    return AppointmentCalResponseModelMapper.ensureInitialized()
        .encodeMap<AppointmentCalResponseModel>(
          this as AppointmentCalResponseModel,
        );
  }

  AppointmentCalResponseModelCopyWith<
    AppointmentCalResponseModel,
    AppointmentCalResponseModel,
    AppointmentCalResponseModel
  >
  get copyWith =>
      _AppointmentCalResponseModelCopyWithImpl<
        AppointmentCalResponseModel,
        AppointmentCalResponseModel
      >(this as AppointmentCalResponseModel, $identity, $identity);
  @override
  String toString() {
    return AppointmentCalResponseModelMapper.ensureInitialized().stringifyValue(
      this as AppointmentCalResponseModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppointmentCalResponseModelMapper.ensureInitialized().equalsValue(
      this as AppointmentCalResponseModel,
      other,
    );
  }

  @override
  int get hashCode {
    return AppointmentCalResponseModelMapper.ensureInitialized().hashValue(
      this as AppointmentCalResponseModel,
    );
  }
}

extension AppointmentCalResponseModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppointmentCalResponseModel, $Out> {
  AppointmentCalResponseModelCopyWith<$R, AppointmentCalResponseModel, $Out>
  get $asAppointmentCalResponseModel => $base.as(
    (v, t, t2) => _AppointmentCalResponseModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AppointmentCalResponseModelCopyWith<
  $R,
  $In extends AppointmentCalResponseModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  AppointmentCalendarDataCopyWith<
    $R,
    AppointmentCalendarData,
    AppointmentCalendarData
  >
  get data;
  MetaCopyWith<$R, Meta, Meta> get meta;
  $R call({
    bool? success,
    String? message,
    int? status,
    AppointmentCalendarData? data,
    Meta? meta,
  });
  AppointmentCalResponseModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AppointmentCalResponseModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppointmentCalResponseModel, $Out>
    implements
        AppointmentCalResponseModelCopyWith<
          $R,
          AppointmentCalResponseModel,
          $Out
        > {
  _AppointmentCalResponseModelCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<AppointmentCalResponseModel> $mapper =
      AppointmentCalResponseModelMapper.ensureInitialized();
  @override
  AppointmentCalendarDataCopyWith<
    $R,
    AppointmentCalendarData,
    AppointmentCalendarData
  >
  get data => $value.data.copyWith.$chain((v) => call(data: v));
  @override
  MetaCopyWith<$R, Meta, Meta> get meta =>
      $value.meta.copyWith.$chain((v) => call(meta: v));
  @override
  $R call({
    bool? success,
    String? message,
    int? status,
    AppointmentCalendarData? data,
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
  AppointmentCalResponseModel $make(CopyWithData data) =>
      AppointmentCalResponseModel(
        success: data.get(#success, or: $value.success),
        message: data.get(#message, or: $value.message),
        status: data.get(#status, or: $value.status),
        data: data.get(#data, or: $value.data),
        meta: data.get(#meta, or: $value.meta),
      );

  @override
  AppointmentCalResponseModelCopyWith<$R2, AppointmentCalResponseModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AppointmentCalResponseModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AppointmentCalendarDataMapper
    extends ClassMapperBase<AppointmentCalendarData> {
  AppointmentCalendarDataMapper._();

  static AppointmentCalendarDataMapper? _instance;
  static AppointmentCalendarDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = AppointmentCalendarDataMapper._(),
      );
      AppointmentItemMapper.ensureInitialized();
      AppointmentSummaryMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AppointmentCalendarData';

  static List<AppointmentItem> _$appointments(AppointmentCalendarData v) =>
      v.appointments;
  static const Field<AppointmentCalendarData, List<AppointmentItem>>
  _f$appointments = Field(
    'appointments',
    _$appointments,
    opt: true,
    def: const [],
    hook: SafeListHook(),
  );
  static AppointmentSummary _$summary(AppointmentCalendarData v) => v.summary;
  static const Field<AppointmentCalendarData, AppointmentSummary> _f$summary =
      Field('summary', _$summary, opt: true, def: const AppointmentSummary());

  @override
  final MappableFields<AppointmentCalendarData> fields = const {
    #appointments: _f$appointments,
    #summary: _f$summary,
  };

  static AppointmentCalendarData _instantiate(DecodingData data) {
    return AppointmentCalendarData(
      appointments: data.dec(_f$appointments),
      summary: data.dec(_f$summary),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppointmentCalendarData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppointmentCalendarData>(map);
  }

  static AppointmentCalendarData fromJson(String json) {
    return ensureInitialized().decodeJson<AppointmentCalendarData>(json);
  }
}

mixin AppointmentCalendarDataMappable {
  String toJson() {
    return AppointmentCalendarDataMapper.ensureInitialized()
        .encodeJson<AppointmentCalendarData>(this as AppointmentCalendarData);
  }

  Map<String, dynamic> toMap() {
    return AppointmentCalendarDataMapper.ensureInitialized()
        .encodeMap<AppointmentCalendarData>(this as AppointmentCalendarData);
  }

  AppointmentCalendarDataCopyWith<
    AppointmentCalendarData,
    AppointmentCalendarData,
    AppointmentCalendarData
  >
  get copyWith =>
      _AppointmentCalendarDataCopyWithImpl<
        AppointmentCalendarData,
        AppointmentCalendarData
      >(this as AppointmentCalendarData, $identity, $identity);
  @override
  String toString() {
    return AppointmentCalendarDataMapper.ensureInitialized().stringifyValue(
      this as AppointmentCalendarData,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppointmentCalendarDataMapper.ensureInitialized().equalsValue(
      this as AppointmentCalendarData,
      other,
    );
  }

  @override
  int get hashCode {
    return AppointmentCalendarDataMapper.ensureInitialized().hashValue(
      this as AppointmentCalendarData,
    );
  }
}

extension AppointmentCalendarDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppointmentCalendarData, $Out> {
  AppointmentCalendarDataCopyWith<$R, AppointmentCalendarData, $Out>
  get $asAppointmentCalendarData => $base.as(
    (v, t, t2) => _AppointmentCalendarDataCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AppointmentCalendarDataCopyWith<
  $R,
  $In extends AppointmentCalendarData,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    AppointmentItem,
    AppointmentItemCopyWith<$R, AppointmentItem, AppointmentItem>
  >
  get appointments;
  AppointmentSummaryCopyWith<$R, AppointmentSummary, AppointmentSummary>
  get summary;
  $R call({List<AppointmentItem>? appointments, AppointmentSummary? summary});
  AppointmentCalendarDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AppointmentCalendarDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppointmentCalendarData, $Out>
    implements
        AppointmentCalendarDataCopyWith<$R, AppointmentCalendarData, $Out> {
  _AppointmentCalendarDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppointmentCalendarData> $mapper =
      AppointmentCalendarDataMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    AppointmentItem,
    AppointmentItemCopyWith<$R, AppointmentItem, AppointmentItem>
  >
  get appointments => ListCopyWith(
    $value.appointments,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(appointments: v),
  );
  @override
  AppointmentSummaryCopyWith<$R, AppointmentSummary, AppointmentSummary>
  get summary => $value.summary.copyWith.$chain((v) => call(summary: v));
  @override
  $R call({List<AppointmentItem>? appointments, AppointmentSummary? summary}) =>
      $apply(
        FieldCopyWithData({
          if (appointments != null) #appointments: appointments,
          if (summary != null) #summary: summary,
        }),
      );
  @override
  AppointmentCalendarData $make(CopyWithData data) => AppointmentCalendarData(
    appointments: data.get(#appointments, or: $value.appointments),
    summary: data.get(#summary, or: $value.summary),
  );

  @override
  AppointmentCalendarDataCopyWith<$R2, AppointmentCalendarData, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AppointmentCalendarDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AppointmentItemMapper extends ClassMapperBase<AppointmentItem> {
  AppointmentItemMapper._();

  static AppointmentItemMapper? _instance;
  static AppointmentItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppointmentItemMapper._());
      PreviousTimeLogMapper.ensureInitialized();
      AppointmentDocumentMapper.ensureInitialized();
      AppointmentClinicMapper.ensureInitialized();
      AssignedVetMapper.ensureInitialized();
      AppointmentPetMapper.ensureInitialized();
      MedicalHistoryRecordMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AppointmentItem';

  static String _$id(AppointmentItem v) => v.id;
  static const Field<AppointmentItem, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$clinicId(AppointmentItem v) => v.clinicId;
  static const Field<AppointmentItem, String> _f$clinicId = Field(
    'clinicId',
    _$clinicId,
    key: r'clinic_id',
    opt: true,
    def: '',
  );
  static String _$userId(AppointmentItem v) => v.userId;
  static const Field<AppointmentItem, String> _f$userId = Field(
    'userId',
    _$userId,
    key: r'user_id',
    opt: true,
    def: '',
  );
  static String _$petId(AppointmentItem v) => v.petId;
  static const Field<AppointmentItem, String> _f$petId = Field(
    'petId',
    _$petId,
    key: r'pet_id',
    opt: true,
    def: '',
  );
  static String? _$vetId(AppointmentItem v) => v.vetId;
  static const Field<AppointmentItem, String> _f$vetId = Field(
    'vetId',
    _$vetId,
    key: r'vet_id',
    opt: true,
  );
  static String _$appointmentDate(AppointmentItem v) => v.appointmentDate;
  static const Field<AppointmentItem, String> _f$appointmentDate = Field(
    'appointmentDate',
    _$appointmentDate,
    key: r'appointment_date',
    opt: true,
    def: '',
  );
  static String _$startTime(AppointmentItem v) => v.startTime;
  static const Field<AppointmentItem, String> _f$startTime = Field(
    'startTime',
    _$startTime,
    key: r'start_time',
    opt: true,
    def: '',
  );
  static String _$endTime(AppointmentItem v) => v.endTime;
  static const Field<AppointmentItem, String> _f$endTime = Field(
    'endTime',
    _$endTime,
    key: r'end_time',
    opt: true,
    def: '',
  );
  static String _$consultationType(AppointmentItem v) => v.consultationType;
  static const Field<AppointmentItem, String> _f$consultationType = Field(
    'consultationType',
    _$consultationType,
    key: r'consultation_type',
    opt: true,
    def: '',
  );
  static String _$chiefComplaint(AppointmentItem v) => v.chiefComplaint;
  static const Field<AppointmentItem, String> _f$chiefComplaint = Field(
    'chiefComplaint',
    _$chiefComplaint,
    key: r'chief_complaint',
    opt: true,
    def: '',
  );
  static String _$appointmentStatus(AppointmentItem v) => v.appointmentStatus;
  static const Field<AppointmentItem, String> _f$appointmentStatus = Field(
    'appointmentStatus',
    _$appointmentStatus,
    key: r'appointment_status',
    opt: true,
    def: '',
  );
  static String? _$vetAssignedAt(AppointmentItem v) => v.vetAssignedAt;
  static const Field<AppointmentItem, String> _f$vetAssignedAt = Field(
    'vetAssignedAt',
    _$vetAssignedAt,
    key: r'vet_assigned_at',
    opt: true,
  );
  static String? _$assignedBy(AppointmentItem v) => v.assignedBy;
  static const Field<AppointmentItem, String> _f$assignedBy = Field(
    'assignedBy',
    _$assignedBy,
    key: r'assigned_by',
    opt: true,
  );
  static bool _$isVetRequested(AppointmentItem v) => v.isVetRequested;
  static const Field<AppointmentItem, bool> _f$isVetRequested = Field(
    'isVetRequested',
    _$isVetRequested,
    key: r'is_vet_requested',
    opt: true,
    def: false,
  );
  static String? _$requestedVetId(AppointmentItem v) => v.requestedVetId;
  static const Field<AppointmentItem, String> _f$requestedVetId = Field(
    'requestedVetId',
    _$requestedVetId,
    key: r'requested_vet_id',
    opt: true,
  );
  static String _$priority(AppointmentItem v) => v.priority;
  static const Field<AppointmentItem, String> _f$priority = Field(
    'priority',
    _$priority,
    opt: true,
    def: '',
  );
  static String? _$actualEndTime(AppointmentItem v) => v.actualEndTime;
  static const Field<AppointmentItem, String> _f$actualEndTime = Field(
    'actualEndTime',
    _$actualEndTime,
    key: r'actual_end_time',
    opt: true,
  );
  static String? _$cancellationReason(AppointmentItem v) =>
      v.cancellationReason;
  static const Field<AppointmentItem, String> _f$cancellationReason = Field(
    'cancellationReason',
    _$cancellationReason,
    key: r'cancellation_reason',
    opt: true,
  );
  static String? _$cancellationNotes(AppointmentItem v) => v.cancellationNotes;
  static const Field<AppointmentItem, String> _f$cancellationNotes = Field(
    'cancellationNotes',
    _$cancellationNotes,
    key: r'cancellation_notes',
    opt: true,
  );
  static String? _$cancelledById(AppointmentItem v) => v.cancelledById;
  static const Field<AppointmentItem, String> _f$cancelledById = Field(
    'cancelledById',
    _$cancelledById,
    key: r'cancelled_by_id',
    opt: true,
  );
  static List<PreviousTimeLog> _$previousTimeLogs(AppointmentItem v) =>
      v.previousTimeLogs;
  static const Field<AppointmentItem, List<PreviousTimeLog>>
  _f$previousTimeLogs = Field(
    'previousTimeLogs',
    _$previousTimeLogs,
    key: r'previous_time_logs',
    opt: true,
    def: const [],
    hook: SafeListHook(),
  );
  static String? _$symptoms(AppointmentItem v) => v.symptoms;
  static const Field<AppointmentItem, String> _f$symptoms = Field(
    'symptoms',
    _$symptoms,
    opt: true,
  );
  static String? _$duration(AppointmentItem v) => v.duration;
  static const Field<AppointmentItem, String> _f$duration = Field(
    'duration',
    _$duration,
    opt: true,
  );
  static String? _$medication(AppointmentItem v) => v.medication;
  static const Field<AppointmentItem, String> _f$medication = Field(
    'medication',
    _$medication,
    opt: true,
  );
  static String? _$medicalNotes(AppointmentItem v) => v.medicalNotes;
  static const Field<AppointmentItem, String> _f$medicalNotes = Field(
    'medicalNotes',
    _$medicalNotes,
    key: r'medical_notes',
    opt: true,
  );
  static List<AppointmentDocument> _$documents(AppointmentItem v) =>
      v.documents;
  static const Field<AppointmentItem, List<AppointmentDocument>> _f$documents =
      Field(
        'documents',
        _$documents,
        opt: true,
        def: const [],
        hook: SafeListHook(),
      );
  static bool _$isFollowup(AppointmentItem v) => v.isFollowup;
  static const Field<AppointmentItem, bool> _f$isFollowup = Field(
    'isFollowup',
    _$isFollowup,
    key: r'is_followup',
    opt: true,
    def: false,
  );
  static String? _$followupAppointmentId(AppointmentItem v) =>
      v.followupAppointmentId;
  static const Field<AppointmentItem, String> _f$followupAppointmentId = Field(
    'followupAppointmentId',
    _$followupAppointmentId,
    key: r'followup_appointment_id',
    opt: true,
  );
  static String _$createdAt(AppointmentItem v) => v.createdAt;
  static const Field<AppointmentItem, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    key: r'created_at',
    opt: true,
    def: '',
  );
  static String _$updatedAt(AppointmentItem v) => v.updatedAt;
  static const Field<AppointmentItem, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    key: r'updated_at',
    opt: true,
    def: '',
  );
  static AppointmentClinic _$clinic(AppointmentItem v) => v.clinic;
  static const Field<AppointmentItem, AppointmentClinic> _f$clinic = Field(
    'clinic',
    _$clinic,
    opt: true,
    def: const AppointmentClinic(),
  );
  static AssignedVet? _$assignedVet(AppointmentItem v) => v.assignedVet;
  static const Field<AppointmentItem, AssignedVet> _f$assignedVet = Field(
    'assignedVet',
    _$assignedVet,
    key: r'assigned_vet',
    opt: true,
  );
  static AppointmentPet _$pet(AppointmentItem v) => v.pet;
  static const Field<AppointmentItem, AppointmentPet> _f$pet = Field(
    'pet',
    _$pet,
    opt: true,
    def: const AppointmentPet(),
  );
  static List<MedicalHistoryRecord> _$medicalHistoryRecords(
    AppointmentItem v,
  ) => v.medicalHistoryRecords;
  static const Field<AppointmentItem, List<MedicalHistoryRecord>>
  _f$medicalHistoryRecords = Field(
    'medicalHistoryRecords',
    _$medicalHistoryRecords,
    key: r'medical_history_records',
    opt: true,
    def: const [],
    hook: SafeListHook(),
  );

  @override
  final MappableFields<AppointmentItem> fields = const {
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
    #documents: _f$documents,
    #isFollowup: _f$isFollowup,
    #followupAppointmentId: _f$followupAppointmentId,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #clinic: _f$clinic,
    #assignedVet: _f$assignedVet,
    #pet: _f$pet,
    #medicalHistoryRecords: _f$medicalHistoryRecords,
  };

  static AppointmentItem _instantiate(DecodingData data) {
    return AppointmentItem(
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
      documents: data.dec(_f$documents),
      isFollowup: data.dec(_f$isFollowup),
      followupAppointmentId: data.dec(_f$followupAppointmentId),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      clinic: data.dec(_f$clinic),
      assignedVet: data.dec(_f$assignedVet),
      pet: data.dec(_f$pet),
      medicalHistoryRecords: data.dec(_f$medicalHistoryRecords),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppointmentItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppointmentItem>(map);
  }

  static AppointmentItem fromJson(String json) {
    return ensureInitialized().decodeJson<AppointmentItem>(json);
  }
}

mixin AppointmentItemMappable {
  String toJson() {
    return AppointmentItemMapper.ensureInitialized()
        .encodeJson<AppointmentItem>(this as AppointmentItem);
  }

  Map<String, dynamic> toMap() {
    return AppointmentItemMapper.ensureInitialized().encodeMap<AppointmentItem>(
      this as AppointmentItem,
    );
  }

  AppointmentItemCopyWith<AppointmentItem, AppointmentItem, AppointmentItem>
  get copyWith =>
      _AppointmentItemCopyWithImpl<AppointmentItem, AppointmentItem>(
        this as AppointmentItem,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AppointmentItemMapper.ensureInitialized().stringifyValue(
      this as AppointmentItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppointmentItemMapper.ensureInitialized().equalsValue(
      this as AppointmentItem,
      other,
    );
  }

  @override
  int get hashCode {
    return AppointmentItemMapper.ensureInitialized().hashValue(
      this as AppointmentItem,
    );
  }
}

extension AppointmentItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppointmentItem, $Out> {
  AppointmentItemCopyWith<$R, AppointmentItem, $Out> get $asAppointmentItem =>
      $base.as((v, t, t2) => _AppointmentItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AppointmentItemCopyWith<$R, $In extends AppointmentItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    PreviousTimeLog,
    PreviousTimeLogCopyWith<$R, PreviousTimeLog, PreviousTimeLog>
  >
  get previousTimeLogs;
  ListCopyWith<
    $R,
    AppointmentDocument,
    AppointmentDocumentCopyWith<$R, AppointmentDocument, AppointmentDocument>
  >
  get documents;
  AppointmentClinicCopyWith<$R, AppointmentClinic, AppointmentClinic>
  get clinic;
  AssignedVetCopyWith<$R, AssignedVet, AssignedVet>? get assignedVet;
  AppointmentPetCopyWith<$R, AppointmentPet, AppointmentPet> get pet;
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
    List<AppointmentDocument>? documents,
    bool? isFollowup,
    String? followupAppointmentId,
    String? createdAt,
    String? updatedAt,
    AppointmentClinic? clinic,
    AssignedVet? assignedVet,
    AppointmentPet? pet,
    List<MedicalHistoryRecord>? medicalHistoryRecords,
  });
  AppointmentItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AppointmentItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppointmentItem, $Out>
    implements AppointmentItemCopyWith<$R, AppointmentItem, $Out> {
  _AppointmentItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppointmentItem> $mapper =
      AppointmentItemMapper.ensureInitialized();
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
  ListCopyWith<
    $R,
    AppointmentDocument,
    AppointmentDocumentCopyWith<$R, AppointmentDocument, AppointmentDocument>
  >
  get documents => ListCopyWith(
    $value.documents,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(documents: v),
  );
  @override
  AppointmentClinicCopyWith<$R, AppointmentClinic, AppointmentClinic>
  get clinic => $value.clinic.copyWith.$chain((v) => call(clinic: v));
  @override
  AssignedVetCopyWith<$R, AssignedVet, AssignedVet>? get assignedVet =>
      $value.assignedVet?.copyWith.$chain((v) => call(assignedVet: v));
  @override
  AppointmentPetCopyWith<$R, AppointmentPet, AppointmentPet> get pet =>
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
    Object? vetId = $none,
    String? appointmentDate,
    String? startTime,
    String? endTime,
    String? consultationType,
    String? chiefComplaint,
    String? appointmentStatus,
    Object? vetAssignedAt = $none,
    Object? assignedBy = $none,
    bool? isVetRequested,
    Object? requestedVetId = $none,
    String? priority,
    Object? actualEndTime = $none,
    Object? cancellationReason = $none,
    Object? cancellationNotes = $none,
    Object? cancelledById = $none,
    List<PreviousTimeLog>? previousTimeLogs,
    Object? symptoms = $none,
    Object? duration = $none,
    Object? medication = $none,
    Object? medicalNotes = $none,
    List<AppointmentDocument>? documents,
    bool? isFollowup,
    Object? followupAppointmentId = $none,
    String? createdAt,
    String? updatedAt,
    AppointmentClinic? clinic,
    Object? assignedVet = $none,
    AppointmentPet? pet,
    List<MedicalHistoryRecord>? medicalHistoryRecords,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (clinicId != null) #clinicId: clinicId,
      if (userId != null) #userId: userId,
      if (petId != null) #petId: petId,
      if (vetId != $none) #vetId: vetId,
      if (appointmentDate != null) #appointmentDate: appointmentDate,
      if (startTime != null) #startTime: startTime,
      if (endTime != null) #endTime: endTime,
      if (consultationType != null) #consultationType: consultationType,
      if (chiefComplaint != null) #chiefComplaint: chiefComplaint,
      if (appointmentStatus != null) #appointmentStatus: appointmentStatus,
      if (vetAssignedAt != $none) #vetAssignedAt: vetAssignedAt,
      if (assignedBy != $none) #assignedBy: assignedBy,
      if (isVetRequested != null) #isVetRequested: isVetRequested,
      if (requestedVetId != $none) #requestedVetId: requestedVetId,
      if (priority != null) #priority: priority,
      if (actualEndTime != $none) #actualEndTime: actualEndTime,
      if (cancellationReason != $none) #cancellationReason: cancellationReason,
      if (cancellationNotes != $none) #cancellationNotes: cancellationNotes,
      if (cancelledById != $none) #cancelledById: cancelledById,
      if (previousTimeLogs != null) #previousTimeLogs: previousTimeLogs,
      if (symptoms != $none) #symptoms: symptoms,
      if (duration != $none) #duration: duration,
      if (medication != $none) #medication: medication,
      if (medicalNotes != $none) #medicalNotes: medicalNotes,
      if (documents != null) #documents: documents,
      if (isFollowup != null) #isFollowup: isFollowup,
      if (followupAppointmentId != $none)
        #followupAppointmentId: followupAppointmentId,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
      if (clinic != null) #clinic: clinic,
      if (assignedVet != $none) #assignedVet: assignedVet,
      if (pet != null) #pet: pet,
      if (medicalHistoryRecords != null)
        #medicalHistoryRecords: medicalHistoryRecords,
    }),
  );
  @override
  AppointmentItem $make(CopyWithData data) => AppointmentItem(
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
    documents: data.get(#documents, or: $value.documents),
    isFollowup: data.get(#isFollowup, or: $value.isFollowup),
    followupAppointmentId: data.get(
      #followupAppointmentId,
      or: $value.followupAppointmentId,
    ),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    clinic: data.get(#clinic, or: $value.clinic),
    assignedVet: data.get(#assignedVet, or: $value.assignedVet),
    pet: data.get(#pet, or: $value.pet),
    medicalHistoryRecords: data.get(
      #medicalHistoryRecords,
      or: $value.medicalHistoryRecords,
    ),
  );

  @override
  AppointmentItemCopyWith<$R2, AppointmentItem, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AppointmentItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
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

class AppointmentDocumentMapper extends ClassMapperBase<AppointmentDocument> {
  AppointmentDocumentMapper._();

  static AppointmentDocumentMapper? _instance;
  static AppointmentDocumentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppointmentDocumentMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AppointmentDocument';

  static String _$id(AppointmentDocument v) => v.id;
  static const Field<AppointmentDocument, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$url(AppointmentDocument v) => v.url;
  static const Field<AppointmentDocument, String> _f$url = Field(
    'url',
    _$url,
    opt: true,
    def: '',
  );
  static String _$fileName(AppointmentDocument v) => v.fileName;
  static const Field<AppointmentDocument, String> _f$fileName = Field(
    'fileName',
    _$fileName,
    key: r'file_name',
    opt: true,
    def: '',
  );

  @override
  final MappableFields<AppointmentDocument> fields = const {
    #id: _f$id,
    #url: _f$url,
    #fileName: _f$fileName,
  };

  static AppointmentDocument _instantiate(DecodingData data) {
    return AppointmentDocument(
      id: data.dec(_f$id),
      url: data.dec(_f$url),
      fileName: data.dec(_f$fileName),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppointmentDocument fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppointmentDocument>(map);
  }

  static AppointmentDocument fromJson(String json) {
    return ensureInitialized().decodeJson<AppointmentDocument>(json);
  }
}

mixin AppointmentDocumentMappable {
  String toJson() {
    return AppointmentDocumentMapper.ensureInitialized()
        .encodeJson<AppointmentDocument>(this as AppointmentDocument);
  }

  Map<String, dynamic> toMap() {
    return AppointmentDocumentMapper.ensureInitialized()
        .encodeMap<AppointmentDocument>(this as AppointmentDocument);
  }

  AppointmentDocumentCopyWith<
    AppointmentDocument,
    AppointmentDocument,
    AppointmentDocument
  >
  get copyWith =>
      _AppointmentDocumentCopyWithImpl<
        AppointmentDocument,
        AppointmentDocument
      >(this as AppointmentDocument, $identity, $identity);
  @override
  String toString() {
    return AppointmentDocumentMapper.ensureInitialized().stringifyValue(
      this as AppointmentDocument,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppointmentDocumentMapper.ensureInitialized().equalsValue(
      this as AppointmentDocument,
      other,
    );
  }

  @override
  int get hashCode {
    return AppointmentDocumentMapper.ensureInitialized().hashValue(
      this as AppointmentDocument,
    );
  }
}

extension AppointmentDocumentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppointmentDocument, $Out> {
  AppointmentDocumentCopyWith<$R, AppointmentDocument, $Out>
  get $asAppointmentDocument => $base.as(
    (v, t, t2) => _AppointmentDocumentCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AppointmentDocumentCopyWith<
  $R,
  $In extends AppointmentDocument,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? url, String? fileName});
  AppointmentDocumentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AppointmentDocumentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppointmentDocument, $Out>
    implements AppointmentDocumentCopyWith<$R, AppointmentDocument, $Out> {
  _AppointmentDocumentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppointmentDocument> $mapper =
      AppointmentDocumentMapper.ensureInitialized();
  @override
  $R call({String? id, String? url, String? fileName}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (url != null) #url: url,
      if (fileName != null) #fileName: fileName,
    }),
  );
  @override
  AppointmentDocument $make(CopyWithData data) => AppointmentDocument(
    id: data.get(#id, or: $value.id),
    url: data.get(#url, or: $value.url),
    fileName: data.get(#fileName, or: $value.fileName),
  );

  @override
  AppointmentDocumentCopyWith<$R2, AppointmentDocument, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AppointmentDocumentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AppointmentClinicMapper extends ClassMapperBase<AppointmentClinic> {
  AppointmentClinicMapper._();

  static AppointmentClinicMapper? _instance;
  static AppointmentClinicMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppointmentClinicMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AppointmentClinic';

  static String _$id(AppointmentClinic v) => v.id;
  static const Field<AppointmentClinic, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$clinicName(AppointmentClinic v) => v.clinicName;
  static const Field<AppointmentClinic, String> _f$clinicName = Field(
    'clinicName',
    _$clinicName,
    key: r'clinic_name',
    opt: true,
    def: '',
  );
  static String _$city(AppointmentClinic v) => v.city;
  static const Field<AppointmentClinic, String> _f$city = Field(
    'city',
    _$city,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<AppointmentClinic> fields = const {
    #id: _f$id,
    #clinicName: _f$clinicName,
    #city: _f$city,
  };

  static AppointmentClinic _instantiate(DecodingData data) {
    return AppointmentClinic(
      id: data.dec(_f$id),
      clinicName: data.dec(_f$clinicName),
      city: data.dec(_f$city),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppointmentClinic fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppointmentClinic>(map);
  }

  static AppointmentClinic fromJson(String json) {
    return ensureInitialized().decodeJson<AppointmentClinic>(json);
  }
}

mixin AppointmentClinicMappable {
  String toJson() {
    return AppointmentClinicMapper.ensureInitialized()
        .encodeJson<AppointmentClinic>(this as AppointmentClinic);
  }

  Map<String, dynamic> toMap() {
    return AppointmentClinicMapper.ensureInitialized()
        .encodeMap<AppointmentClinic>(this as AppointmentClinic);
  }

  AppointmentClinicCopyWith<
    AppointmentClinic,
    AppointmentClinic,
    AppointmentClinic
  >
  get copyWith =>
      _AppointmentClinicCopyWithImpl<AppointmentClinic, AppointmentClinic>(
        this as AppointmentClinic,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AppointmentClinicMapper.ensureInitialized().stringifyValue(
      this as AppointmentClinic,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppointmentClinicMapper.ensureInitialized().equalsValue(
      this as AppointmentClinic,
      other,
    );
  }

  @override
  int get hashCode {
    return AppointmentClinicMapper.ensureInitialized().hashValue(
      this as AppointmentClinic,
    );
  }
}

extension AppointmentClinicValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppointmentClinic, $Out> {
  AppointmentClinicCopyWith<$R, AppointmentClinic, $Out>
  get $asAppointmentClinic => $base.as(
    (v, t, t2) => _AppointmentClinicCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AppointmentClinicCopyWith<
  $R,
  $In extends AppointmentClinic,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? clinicName, String? city});
  AppointmentClinicCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AppointmentClinicCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppointmentClinic, $Out>
    implements AppointmentClinicCopyWith<$R, AppointmentClinic, $Out> {
  _AppointmentClinicCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppointmentClinic> $mapper =
      AppointmentClinicMapper.ensureInitialized();
  @override
  $R call({String? id, String? clinicName, String? city}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (clinicName != null) #clinicName: clinicName,
      if (city != null) #city: city,
    }),
  );
  @override
  AppointmentClinic $make(CopyWithData data) => AppointmentClinic(
    id: data.get(#id, or: $value.id),
    clinicName: data.get(#clinicName, or: $value.clinicName),
    city: data.get(#city, or: $value.city),
  );

  @override
  AppointmentClinicCopyWith<$R2, AppointmentClinic, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AppointmentClinicCopyWithImpl<$R2, $Out2>($value, $cast, t);
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

  @override
  final MappableFields<AssignedVet> fields = const {#id: _f$id, #name: _f$name};

  static AssignedVet _instantiate(DecodingData data) {
    return AssignedVet(id: data.dec(_f$id), name: data.dec(_f$name));
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
  $R call({String? id, String? name});
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
  $R call({String? id, String? name}) => $apply(
    FieldCopyWithData({if (id != null) #id: id, if (name != null) #name: name}),
  );
  @override
  AssignedVet $make(CopyWithData data) => AssignedVet(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
  );

  @override
  AssignedVetCopyWith<$R2, AssignedVet, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AssignedVetCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AppointmentPetMapper extends ClassMapperBase<AppointmentPet> {
  AppointmentPetMapper._();

  static AppointmentPetMapper? _instance;
  static AppointmentPetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppointmentPetMapper._());
      BreedInfoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AppointmentPet';

  static String _$id(AppointmentPet v) => v.id;
  static const Field<AppointmentPet, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$name(AppointmentPet v) => v.name;
  static const Field<AppointmentPet, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
  );
  static String _$type(AppointmentPet v) => v.type;
  static const Field<AppointmentPet, String> _f$type = Field(
    'type',
    _$type,
    opt: true,
    def: '',
  );
  static String _$profilePicture(AppointmentPet v) => v.profilePicture;
  static const Field<AppointmentPet, String> _f$profilePicture = Field(
    'profilePicture',
    _$profilePicture,
    opt: true,
    def: '',
  );
  static BreedInfo _$breedInfo(AppointmentPet v) => v.breedInfo;
  static const Field<AppointmentPet, BreedInfo> _f$breedInfo = Field(
    'breedInfo',
    _$breedInfo,
    opt: true,
    def: const BreedInfo(),
  );

  @override
  final MappableFields<AppointmentPet> fields = const {
    #id: _f$id,
    #name: _f$name,
    #type: _f$type,
    #profilePicture: _f$profilePicture,
    #breedInfo: _f$breedInfo,
  };

  static AppointmentPet _instantiate(DecodingData data) {
    return AppointmentPet(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      type: data.dec(_f$type),
      profilePicture: data.dec(_f$profilePicture),
      breedInfo: data.dec(_f$breedInfo),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppointmentPet fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppointmentPet>(map);
  }

  static AppointmentPet fromJson(String json) {
    return ensureInitialized().decodeJson<AppointmentPet>(json);
  }
}

mixin AppointmentPetMappable {
  String toJson() {
    return AppointmentPetMapper.ensureInitialized().encodeJson<AppointmentPet>(
      this as AppointmentPet,
    );
  }

  Map<String, dynamic> toMap() {
    return AppointmentPetMapper.ensureInitialized().encodeMap<AppointmentPet>(
      this as AppointmentPet,
    );
  }

  AppointmentPetCopyWith<AppointmentPet, AppointmentPet, AppointmentPet>
  get copyWith => _AppointmentPetCopyWithImpl<AppointmentPet, AppointmentPet>(
    this as AppointmentPet,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return AppointmentPetMapper.ensureInitialized().stringifyValue(
      this as AppointmentPet,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppointmentPetMapper.ensureInitialized().equalsValue(
      this as AppointmentPet,
      other,
    );
  }

  @override
  int get hashCode {
    return AppointmentPetMapper.ensureInitialized().hashValue(
      this as AppointmentPet,
    );
  }
}

extension AppointmentPetValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppointmentPet, $Out> {
  AppointmentPetCopyWith<$R, AppointmentPet, $Out> get $asAppointmentPet =>
      $base.as((v, t, t2) => _AppointmentPetCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AppointmentPetCopyWith<$R, $In extends AppointmentPet, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  BreedInfoCopyWith<$R, BreedInfo, BreedInfo> get breedInfo;
  $R call({
    String? id,
    String? name,
    String? type,
    String? profilePicture,
    BreedInfo? breedInfo,
  });
  AppointmentPetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AppointmentPetCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppointmentPet, $Out>
    implements AppointmentPetCopyWith<$R, AppointmentPet, $Out> {
  _AppointmentPetCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppointmentPet> $mapper =
      AppointmentPetMapper.ensureInitialized();
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
  AppointmentPet $make(CopyWithData data) => AppointmentPet(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    type: data.get(#type, or: $value.type),
    profilePicture: data.get(#profilePicture, or: $value.profilePicture),
    breedInfo: data.get(#breedInfo, or: $value.breedInfo),
  );

  @override
  AppointmentPetCopyWith<$R2, AppointmentPet, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AppointmentPetCopyWithImpl<$R2, $Out2>($value, $cast, t);
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

  @override
  final MappableFields<MedicalHistoryRecord> fields = const {
    #id: _f$id,
    #type: _f$type,
    #consultationDate: _f$consultationDate,
  };

  static MedicalHistoryRecord _instantiate(DecodingData data) {
    return MedicalHistoryRecord(
      id: data.dec(_f$id),
      type: data.dec(_f$type),
      consultationDate: data.dec(_f$consultationDate),
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
  $R call({String? id, String? type, String? consultationDate});
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
  $R call({String? id, String? type, String? consultationDate}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (type != null) #type: type,
      if (consultationDate != null) #consultationDate: consultationDate,
    }),
  );
  @override
  MedicalHistoryRecord $make(CopyWithData data) => MedicalHistoryRecord(
    id: data.get(#id, or: $value.id),
    type: data.get(#type, or: $value.type),
    consultationDate: data.get(#consultationDate, or: $value.consultationDate),
  );

  @override
  MedicalHistoryRecordCopyWith<$R2, MedicalHistoryRecord, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MedicalHistoryRecordCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AppointmentSummaryMapper extends ClassMapperBase<AppointmentSummary> {
  AppointmentSummaryMapper._();

  static AppointmentSummaryMapper? _instance;
  static AppointmentSummaryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppointmentSummaryMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AppointmentSummary';

  static int _$total(AppointmentSummary v) => v.total;
  static const Field<AppointmentSummary, int> _f$total = Field(
    'total',
    _$total,
    opt: true,
    def: 0,
  );
  static int _$month(AppointmentSummary v) => v.month;
  static const Field<AppointmentSummary, int> _f$month = Field(
    'month',
    _$month,
    opt: true,
    def: 0,
  );
  static int _$year(AppointmentSummary v) => v.year;
  static const Field<AppointmentSummary, int> _f$year = Field(
    'year',
    _$year,
    opt: true,
    def: 0,
  );

  @override
  final MappableFields<AppointmentSummary> fields = const {
    #total: _f$total,
    #month: _f$month,
    #year: _f$year,
  };

  static AppointmentSummary _instantiate(DecodingData data) {
    return AppointmentSummary(
      total: data.dec(_f$total),
      month: data.dec(_f$month),
      year: data.dec(_f$year),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppointmentSummary fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppointmentSummary>(map);
  }

  static AppointmentSummary fromJson(String json) {
    return ensureInitialized().decodeJson<AppointmentSummary>(json);
  }
}

mixin AppointmentSummaryMappable {
  String toJson() {
    return AppointmentSummaryMapper.ensureInitialized()
        .encodeJson<AppointmentSummary>(this as AppointmentSummary);
  }

  Map<String, dynamic> toMap() {
    return AppointmentSummaryMapper.ensureInitialized()
        .encodeMap<AppointmentSummary>(this as AppointmentSummary);
  }

  AppointmentSummaryCopyWith<
    AppointmentSummary,
    AppointmentSummary,
    AppointmentSummary
  >
  get copyWith =>
      _AppointmentSummaryCopyWithImpl<AppointmentSummary, AppointmentSummary>(
        this as AppointmentSummary,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AppointmentSummaryMapper.ensureInitialized().stringifyValue(
      this as AppointmentSummary,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppointmentSummaryMapper.ensureInitialized().equalsValue(
      this as AppointmentSummary,
      other,
    );
  }

  @override
  int get hashCode {
    return AppointmentSummaryMapper.ensureInitialized().hashValue(
      this as AppointmentSummary,
    );
  }
}

extension AppointmentSummaryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppointmentSummary, $Out> {
  AppointmentSummaryCopyWith<$R, AppointmentSummary, $Out>
  get $asAppointmentSummary => $base.as(
    (v, t, t2) => _AppointmentSummaryCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AppointmentSummaryCopyWith<
  $R,
  $In extends AppointmentSummary,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? total, int? month, int? year});
  AppointmentSummaryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AppointmentSummaryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppointmentSummary, $Out>
    implements AppointmentSummaryCopyWith<$R, AppointmentSummary, $Out> {
  _AppointmentSummaryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppointmentSummary> $mapper =
      AppointmentSummaryMapper.ensureInitialized();
  @override
  $R call({int? total, int? month, int? year}) => $apply(
    FieldCopyWithData({
      if (total != null) #total: total,
      if (month != null) #month: month,
      if (year != null) #year: year,
    }),
  );
  @override
  AppointmentSummary $make(CopyWithData data) => AppointmentSummary(
    total: data.get(#total, or: $value.total),
    month: data.get(#month, or: $value.month),
    year: data.get(#year, or: $value.year),
  );

  @override
  AppointmentSummaryCopyWith<$R2, AppointmentSummary, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AppointmentSummaryCopyWithImpl<$R2, $Out2>($value, $cast, t);
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

