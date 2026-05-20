// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'medical_record_details_response_model.dart';

class MedicalRecordDetailsResponseModelMapper
    extends ClassMapperBase<MedicalRecordDetailsResponseModel> {
  MedicalRecordDetailsResponseModelMapper._();

  static MedicalRecordDetailsResponseModelMapper? _instance;
  static MedicalRecordDetailsResponseModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = MedicalRecordDetailsResponseModelMapper._(),
      );
      MedicalRecordDataMapper.ensureInitialized();
      MetaMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MedicalRecordDetailsResponseModel';

  static bool _$success(MedicalRecordDetailsResponseModel v) => v.success;
  static const Field<MedicalRecordDetailsResponseModel, bool> _f$success =
      Field('success', _$success, opt: true, def: false);
  static String _$message(MedicalRecordDetailsResponseModel v) => v.message;
  static const Field<MedicalRecordDetailsResponseModel, String> _f$message =
      Field('message', _$message, opt: true, def: '');
  static int _$status(MedicalRecordDetailsResponseModel v) => v.status;
  static const Field<MedicalRecordDetailsResponseModel, int> _f$status = Field(
    'status',
    _$status,
    opt: true,
    def: 0,
  );
  static MedicalRecordData _$data(MedicalRecordDetailsResponseModel v) =>
      v.data;
  static const Field<MedicalRecordDetailsResponseModel, MedicalRecordData>
  _f$data = Field('data', _$data, opt: true, def: const MedicalRecordData());
  static Meta _$meta(MedicalRecordDetailsResponseModel v) => v.meta;
  static const Field<MedicalRecordDetailsResponseModel, Meta> _f$meta = Field(
    'meta',
    _$meta,
    opt: true,
    def: const Meta(),
  );

  @override
  final MappableFields<MedicalRecordDetailsResponseModel> fields = const {
    #success: _f$success,
    #message: _f$message,
    #status: _f$status,
    #data: _f$data,
    #meta: _f$meta,
  };

  static MedicalRecordDetailsResponseModel _instantiate(DecodingData data) {
    return MedicalRecordDetailsResponseModel(
      success: data.dec(_f$success),
      message: data.dec(_f$message),
      status: data.dec(_f$status),
      data: data.dec(_f$data),
      meta: data.dec(_f$meta),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MedicalRecordDetailsResponseModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MedicalRecordDetailsResponseModel>(
      map,
    );
  }

  static MedicalRecordDetailsResponseModel fromJson(String json) {
    return ensureInitialized().decodeJson<MedicalRecordDetailsResponseModel>(
      json,
    );
  }
}

mixin MedicalRecordDetailsResponseModelMappable {
  String toJson() {
    return MedicalRecordDetailsResponseModelMapper.ensureInitialized()
        .encodeJson<MedicalRecordDetailsResponseModel>(
          this as MedicalRecordDetailsResponseModel,
        );
  }

  Map<String, dynamic> toMap() {
    return MedicalRecordDetailsResponseModelMapper.ensureInitialized()
        .encodeMap<MedicalRecordDetailsResponseModel>(
          this as MedicalRecordDetailsResponseModel,
        );
  }

  MedicalRecordDetailsResponseModelCopyWith<
    MedicalRecordDetailsResponseModel,
    MedicalRecordDetailsResponseModel,
    MedicalRecordDetailsResponseModel
  >
  get copyWith =>
      _MedicalRecordDetailsResponseModelCopyWithImpl<
        MedicalRecordDetailsResponseModel,
        MedicalRecordDetailsResponseModel
      >(this as MedicalRecordDetailsResponseModel, $identity, $identity);
  @override
  String toString() {
    return MedicalRecordDetailsResponseModelMapper.ensureInitialized()
        .stringifyValue(this as MedicalRecordDetailsResponseModel);
  }

  @override
  bool operator ==(Object other) {
    return MedicalRecordDetailsResponseModelMapper.ensureInitialized()
        .equalsValue(this as MedicalRecordDetailsResponseModel, other);
  }

  @override
  int get hashCode {
    return MedicalRecordDetailsResponseModelMapper.ensureInitialized()
        .hashValue(this as MedicalRecordDetailsResponseModel);
  }
}

extension MedicalRecordDetailsResponseModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MedicalRecordDetailsResponseModel, $Out> {
  MedicalRecordDetailsResponseModelCopyWith<
    $R,
    MedicalRecordDetailsResponseModel,
    $Out
  >
  get $asMedicalRecordDetailsResponseModel => $base.as(
    (v, t, t2) =>
        _MedicalRecordDetailsResponseModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class MedicalRecordDetailsResponseModelCopyWith<
  $R,
  $In extends MedicalRecordDetailsResponseModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  MedicalRecordDataCopyWith<$R, MedicalRecordData, MedicalRecordData> get data;
  MetaCopyWith<$R, Meta, Meta> get meta;
  $R call({
    bool? success,
    String? message,
    int? status,
    MedicalRecordData? data,
    Meta? meta,
  });
  MedicalRecordDetailsResponseModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MedicalRecordDetailsResponseModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MedicalRecordDetailsResponseModel, $Out>
    implements
        MedicalRecordDetailsResponseModelCopyWith<
          $R,
          MedicalRecordDetailsResponseModel,
          $Out
        > {
  _MedicalRecordDetailsResponseModelCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<MedicalRecordDetailsResponseModel> $mapper =
      MedicalRecordDetailsResponseModelMapper.ensureInitialized();
  @override
  MedicalRecordDataCopyWith<$R, MedicalRecordData, MedicalRecordData>
  get data => $value.data.copyWith.$chain((v) => call(data: v));
  @override
  MetaCopyWith<$R, Meta, Meta> get meta =>
      $value.meta.copyWith.$chain((v) => call(meta: v));
  @override
  $R call({
    bool? success,
    String? message,
    int? status,
    MedicalRecordData? data,
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
  MedicalRecordDetailsResponseModel $make(CopyWithData data) =>
      MedicalRecordDetailsResponseModel(
        success: data.get(#success, or: $value.success),
        message: data.get(#message, or: $value.message),
        status: data.get(#status, or: $value.status),
        data: data.get(#data, or: $value.data),
        meta: data.get(#meta, or: $value.meta),
      );

  @override
  MedicalRecordDetailsResponseModelCopyWith<
    $R2,
    MedicalRecordDetailsResponseModel,
    $Out2
  >
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MedicalRecordDetailsResponseModelCopyWithImpl<$R2, $Out2>(
        $value,
        $cast,
        t,
      );
}

class MedicalRecordDataMapper extends ClassMapperBase<MedicalRecordData> {
  MedicalRecordDataMapper._();

  static MedicalRecordDataMapper? _instance;
  static MedicalRecordDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MedicalRecordDataMapper._());
      ClinicMapper.ensureInitialized();
      DocumentUrlMapper.ensureInitialized();
      PetMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MedicalRecordData';

  static String _$id(MedicalRecordData v) => v.id;
  static const Field<MedicalRecordData, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$historyRecordId(MedicalRecordData v) => v.historyRecordId;
  static const Field<MedicalRecordData, String> _f$historyRecordId = Field(
    'historyRecordId',
    _$historyRecordId,
    opt: true,
    def: '',
  );
  static String? _$appointmentId(MedicalRecordData v) => v.appointmentId;
  static const Field<MedicalRecordData, String> _f$appointmentId = Field(
    'appointmentId',
    _$appointmentId,
    opt: true,
  );
  static String _$petId(MedicalRecordData v) => v.petId;
  static const Field<MedicalRecordData, String> _f$petId = Field(
    'petId',
    _$petId,
    opt: true,
    def: '',
  );
  static String? _$clinicId(MedicalRecordData v) => v.clinicId;
  static const Field<MedicalRecordData, String> _f$clinicId = Field(
    'clinicId',
    _$clinicId,
    opt: true,
  );
  static String? _$userId(MedicalRecordData v) => v.userId;
  static const Field<MedicalRecordData, String> _f$userId = Field(
    'userId',
    _$userId,
    opt: true,
  );
  static String _$otherClinicName(MedicalRecordData v) => v.otherClinicName;
  static const Field<MedicalRecordData, String> _f$otherClinicName = Field(
    'otherClinicName',
    _$otherClinicName,
    opt: true,
    def: '',
  );
  static String? _$vetId(MedicalRecordData v) => v.vetId;
  static const Field<MedicalRecordData, String> _f$vetId = Field(
    'vetId',
    _$vetId,
    opt: true,
  );
  static String _$consultationDate(MedicalRecordData v) => v.consultationDate;
  static const Field<MedicalRecordData, String> _f$consultationDate = Field(
    'consultationDate',
    _$consultationDate,
    opt: true,
    def: '',
  );
  static String _$reasonForVisit(MedicalRecordData v) => v.reasonForVisit;
  static const Field<MedicalRecordData, String> _f$reasonForVisit = Field(
    'reasonForVisit',
    _$reasonForVisit,
    opt: true,
    def: '',
  );
  static String? _$symptomsObserved(MedicalRecordData v) => v.symptomsObserved;
  static const Field<MedicalRecordData, String> _f$symptomsObserved = Field(
    'symptomsObserved',
    _$symptomsObserved,
    opt: true,
  );
  static String? _$diagnosis(MedicalRecordData v) => v.diagnosis;
  static const Field<MedicalRecordData, String> _f$diagnosis = Field(
    'diagnosis',
    _$diagnosis,
    opt: true,
  );
  static String? _$diagnosisType(MedicalRecordData v) => v.diagnosisType;
  static const Field<MedicalRecordData, String> _f$diagnosisType = Field(
    'diagnosisType',
    _$diagnosisType,
    opt: true,
  );
  static String? _$treatmentProvided(MedicalRecordData v) =>
      v.treatmentProvided;
  static const Field<MedicalRecordData, String> _f$treatmentProvided = Field(
    'treatmentProvided',
    _$treatmentProvided,
    opt: true,
  );
  static String _$notes(MedicalRecordData v) => v.notes;
  static const Field<MedicalRecordData, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
    def: '',
  );
  static String _$consultationStatus(MedicalRecordData v) =>
      v.consultationStatus;
  static const Field<MedicalRecordData, String> _f$consultationStatus = Field(
    'consultationStatus',
    _$consultationStatus,
    opt: true,
    def: '',
  );
  static String? _$healthIssue(MedicalRecordData v) => v.healthIssue;
  static const Field<MedicalRecordData, String> _f$healthIssue = Field(
    'healthIssue',
    _$healthIssue,
    opt: true,
  );
  static String? _$observation(MedicalRecordData v) => v.observation;
  static const Field<MedicalRecordData, String> _f$observation = Field(
    'observation',
    _$observation,
    opt: true,
  );
  static String? _$recordedDate(MedicalRecordData v) => v.recordedDate;
  static const Field<MedicalRecordData, String> _f$recordedDate = Field(
    'recordedDate',
    _$recordedDate,
    opt: true,
  );
  static String? _$severity(MedicalRecordData v) => v.severity;
  static const Field<MedicalRecordData, String> _f$severity = Field(
    'severity',
    _$severity,
    opt: true,
  );
  static String? _$status(MedicalRecordData v) => v.status;
  static const Field<MedicalRecordData, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
  );
  static String? _$createdBy(MedicalRecordData v) => v.createdBy;
  static const Field<MedicalRecordData, String> _f$createdBy = Field(
    'createdBy',
    _$createdBy,
    opt: true,
  );
  static String _$createdAt(MedicalRecordData v) => v.createdAt;
  static const Field<MedicalRecordData, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
    def: '',
  );
  static String _$updatedAt(MedicalRecordData v) => v.updatedAt;
  static const Field<MedicalRecordData, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
    def: '',
  );
  static String _$sourceType(MedicalRecordData v) => v.sourceType;
  static const Field<MedicalRecordData, String> _f$sourceType = Field(
    'sourceType',
    _$sourceType,
    opt: true,
    def: '',
  );
  static String? _$appointmentTime(MedicalRecordData v) => v.appointmentTime;
  static const Field<MedicalRecordData, String> _f$appointmentTime = Field(
    'appointmentTime',
    _$appointmentTime,
    opt: true,
  );
  static String? _$appointmentDate(MedicalRecordData v) => v.appointmentDate;
  static const Field<MedicalRecordData, String> _f$appointmentDate = Field(
    'appointmentDate',
    _$appointmentDate,
    opt: true,
  );
  static String _$recordType(MedicalRecordData v) => v.recordType;
  static const Field<MedicalRecordData, String> _f$recordType = Field(
    'recordType',
    _$recordType,
    opt: true,
    def: '',
  );
  static Clinic? _$clinic(MedicalRecordData v) => v.clinic;
  static const Field<MedicalRecordData, Clinic> _f$clinic = Field(
    'clinic',
    _$clinic,
    opt: true,
  );
  static List<DocumentUrl> _$documentUrls(MedicalRecordData v) =>
      v.documentUrls;
  static const Field<MedicalRecordData, List<DocumentUrl>> _f$documentUrls =
      Field(
        'documentUrls',
        _$documentUrls,
        opt: true,
        def: const [],
        hook: SafeListHook(),
      );
  static Pet? _$pet(MedicalRecordData v) => v.pet;
  static const Field<MedicalRecordData, Pet> _f$pet = Field(
    'pet',
    _$pet,
    opt: true,
    def: const Pet(),
  );

  @override
  final MappableFields<MedicalRecordData> fields = const {
    #id: _f$id,
    #historyRecordId: _f$historyRecordId,
    #appointmentId: _f$appointmentId,
    #petId: _f$petId,
    #clinicId: _f$clinicId,
    #userId: _f$userId,
    #otherClinicName: _f$otherClinicName,
    #vetId: _f$vetId,
    #consultationDate: _f$consultationDate,
    #reasonForVisit: _f$reasonForVisit,
    #symptomsObserved: _f$symptomsObserved,
    #diagnosis: _f$diagnosis,
    #diagnosisType: _f$diagnosisType,
    #treatmentProvided: _f$treatmentProvided,
    #notes: _f$notes,
    #consultationStatus: _f$consultationStatus,
    #healthIssue: _f$healthIssue,
    #observation: _f$observation,
    #recordedDate: _f$recordedDate,
    #severity: _f$severity,
    #status: _f$status,
    #createdBy: _f$createdBy,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #sourceType: _f$sourceType,
    #appointmentTime: _f$appointmentTime,
    #appointmentDate: _f$appointmentDate,
    #recordType: _f$recordType,
    #clinic: _f$clinic,
    #documentUrls: _f$documentUrls,
    #pet: _f$pet,
  };

  static MedicalRecordData _instantiate(DecodingData data) {
    return MedicalRecordData(
      id: data.dec(_f$id),
      historyRecordId: data.dec(_f$historyRecordId),
      appointmentId: data.dec(_f$appointmentId),
      petId: data.dec(_f$petId),
      clinicId: data.dec(_f$clinicId),
      userId: data.dec(_f$userId),
      otherClinicName: data.dec(_f$otherClinicName),
      vetId: data.dec(_f$vetId),
      consultationDate: data.dec(_f$consultationDate),
      reasonForVisit: data.dec(_f$reasonForVisit),
      symptomsObserved: data.dec(_f$symptomsObserved),
      diagnosis: data.dec(_f$diagnosis),
      diagnosisType: data.dec(_f$diagnosisType),
      treatmentProvided: data.dec(_f$treatmentProvided),
      notes: data.dec(_f$notes),
      consultationStatus: data.dec(_f$consultationStatus),
      healthIssue: data.dec(_f$healthIssue),
      observation: data.dec(_f$observation),
      recordedDate: data.dec(_f$recordedDate),
      severity: data.dec(_f$severity),
      status: data.dec(_f$status),
      createdBy: data.dec(_f$createdBy),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      sourceType: data.dec(_f$sourceType),
      appointmentTime: data.dec(_f$appointmentTime),
      appointmentDate: data.dec(_f$appointmentDate),
      recordType: data.dec(_f$recordType),
      clinic: data.dec(_f$clinic),
      documentUrls: data.dec(_f$documentUrls),
      pet: data.dec(_f$pet),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MedicalRecordData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MedicalRecordData>(map);
  }

  static MedicalRecordData fromJson(String json) {
    return ensureInitialized().decodeJson<MedicalRecordData>(json);
  }
}

mixin MedicalRecordDataMappable {
  String toJson() {
    return MedicalRecordDataMapper.ensureInitialized()
        .encodeJson<MedicalRecordData>(this as MedicalRecordData);
  }

  Map<String, dynamic> toMap() {
    return MedicalRecordDataMapper.ensureInitialized()
        .encodeMap<MedicalRecordData>(this as MedicalRecordData);
  }

  MedicalRecordDataCopyWith<
    MedicalRecordData,
    MedicalRecordData,
    MedicalRecordData
  >
  get copyWith =>
      _MedicalRecordDataCopyWithImpl<MedicalRecordData, MedicalRecordData>(
        this as MedicalRecordData,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MedicalRecordDataMapper.ensureInitialized().stringifyValue(
      this as MedicalRecordData,
    );
  }

  @override
  bool operator ==(Object other) {
    return MedicalRecordDataMapper.ensureInitialized().equalsValue(
      this as MedicalRecordData,
      other,
    );
  }

  @override
  int get hashCode {
    return MedicalRecordDataMapper.ensureInitialized().hashValue(
      this as MedicalRecordData,
    );
  }
}

extension MedicalRecordDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MedicalRecordData, $Out> {
  MedicalRecordDataCopyWith<$R, MedicalRecordData, $Out>
  get $asMedicalRecordData => $base.as(
    (v, t, t2) => _MedicalRecordDataCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class MedicalRecordDataCopyWith<
  $R,
  $In extends MedicalRecordData,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ClinicCopyWith<$R, Clinic, Clinic>? get clinic;
  ListCopyWith<
    $R,
    DocumentUrl,
    DocumentUrlCopyWith<$R, DocumentUrl, DocumentUrl>
  >
  get documentUrls;
  PetCopyWith<$R, Pet, Pet>? get pet;
  $R call({
    String? id,
    String? historyRecordId,
    String? appointmentId,
    String? petId,
    String? clinicId,
    String? userId,
    String? otherClinicName,
    String? vetId,
    String? consultationDate,
    String? reasonForVisit,
    String? symptomsObserved,
    String? diagnosis,
    String? diagnosisType,
    String? treatmentProvided,
    String? notes,
    String? consultationStatus,
    String? healthIssue,
    String? observation,
    String? recordedDate,
    String? severity,
    String? status,
    String? createdBy,
    String? createdAt,
    String? updatedAt,
    String? sourceType,
    String? appointmentTime,
    String? appointmentDate,
    String? recordType,
    Clinic? clinic,
    List<DocumentUrl>? documentUrls,
    Pet? pet,
  });
  MedicalRecordDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MedicalRecordDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MedicalRecordData, $Out>
    implements MedicalRecordDataCopyWith<$R, MedicalRecordData, $Out> {
  _MedicalRecordDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MedicalRecordData> $mapper =
      MedicalRecordDataMapper.ensureInitialized();
  @override
  ClinicCopyWith<$R, Clinic, Clinic>? get clinic =>
      $value.clinic?.copyWith.$chain((v) => call(clinic: v));
  @override
  ListCopyWith<
    $R,
    DocumentUrl,
    DocumentUrlCopyWith<$R, DocumentUrl, DocumentUrl>
  >
  get documentUrls => ListCopyWith(
    $value.documentUrls,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(documentUrls: v),
  );
  @override
  PetCopyWith<$R, Pet, Pet>? get pet =>
      $value.pet?.copyWith.$chain((v) => call(pet: v));
  @override
  $R call({
    String? id,
    String? historyRecordId,
    Object? appointmentId = $none,
    String? petId,
    Object? clinicId = $none,
    Object? userId = $none,
    String? otherClinicName,
    Object? vetId = $none,
    String? consultationDate,
    String? reasonForVisit,
    Object? symptomsObserved = $none,
    Object? diagnosis = $none,
    Object? diagnosisType = $none,
    Object? treatmentProvided = $none,
    String? notes,
    String? consultationStatus,
    Object? healthIssue = $none,
    Object? observation = $none,
    Object? recordedDate = $none,
    Object? severity = $none,
    Object? status = $none,
    Object? createdBy = $none,
    String? createdAt,
    String? updatedAt,
    String? sourceType,
    Object? appointmentTime = $none,
    Object? appointmentDate = $none,
    String? recordType,
    Object? clinic = $none,
    List<DocumentUrl>? documentUrls,
    Object? pet = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (historyRecordId != null) #historyRecordId: historyRecordId,
      if (appointmentId != $none) #appointmentId: appointmentId,
      if (petId != null) #petId: petId,
      if (clinicId != $none) #clinicId: clinicId,
      if (userId != $none) #userId: userId,
      if (otherClinicName != null) #otherClinicName: otherClinicName,
      if (vetId != $none) #vetId: vetId,
      if (consultationDate != null) #consultationDate: consultationDate,
      if (reasonForVisit != null) #reasonForVisit: reasonForVisit,
      if (symptomsObserved != $none) #symptomsObserved: symptomsObserved,
      if (diagnosis != $none) #diagnosis: diagnosis,
      if (diagnosisType != $none) #diagnosisType: diagnosisType,
      if (treatmentProvided != $none) #treatmentProvided: treatmentProvided,
      if (notes != null) #notes: notes,
      if (consultationStatus != null) #consultationStatus: consultationStatus,
      if (healthIssue != $none) #healthIssue: healthIssue,
      if (observation != $none) #observation: observation,
      if (recordedDate != $none) #recordedDate: recordedDate,
      if (severity != $none) #severity: severity,
      if (status != $none) #status: status,
      if (createdBy != $none) #createdBy: createdBy,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
      if (sourceType != null) #sourceType: sourceType,
      if (appointmentTime != $none) #appointmentTime: appointmentTime,
      if (appointmentDate != $none) #appointmentDate: appointmentDate,
      if (recordType != null) #recordType: recordType,
      if (clinic != $none) #clinic: clinic,
      if (documentUrls != null) #documentUrls: documentUrls,
      if (pet != $none) #pet: pet,
    }),
  );
  @override
  MedicalRecordData $make(CopyWithData data) => MedicalRecordData(
    id: data.get(#id, or: $value.id),
    historyRecordId: data.get(#historyRecordId, or: $value.historyRecordId),
    appointmentId: data.get(#appointmentId, or: $value.appointmentId),
    petId: data.get(#petId, or: $value.petId),
    clinicId: data.get(#clinicId, or: $value.clinicId),
    userId: data.get(#userId, or: $value.userId),
    otherClinicName: data.get(#otherClinicName, or: $value.otherClinicName),
    vetId: data.get(#vetId, or: $value.vetId),
    consultationDate: data.get(#consultationDate, or: $value.consultationDate),
    reasonForVisit: data.get(#reasonForVisit, or: $value.reasonForVisit),
    symptomsObserved: data.get(#symptomsObserved, or: $value.symptomsObserved),
    diagnosis: data.get(#diagnosis, or: $value.diagnosis),
    diagnosisType: data.get(#diagnosisType, or: $value.diagnosisType),
    treatmentProvided: data.get(
      #treatmentProvided,
      or: $value.treatmentProvided,
    ),
    notes: data.get(#notes, or: $value.notes),
    consultationStatus: data.get(
      #consultationStatus,
      or: $value.consultationStatus,
    ),
    healthIssue: data.get(#healthIssue, or: $value.healthIssue),
    observation: data.get(#observation, or: $value.observation),
    recordedDate: data.get(#recordedDate, or: $value.recordedDate),
    severity: data.get(#severity, or: $value.severity),
    status: data.get(#status, or: $value.status),
    createdBy: data.get(#createdBy, or: $value.createdBy),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    sourceType: data.get(#sourceType, or: $value.sourceType),
    appointmentTime: data.get(#appointmentTime, or: $value.appointmentTime),
    appointmentDate: data.get(#appointmentDate, or: $value.appointmentDate),
    recordType: data.get(#recordType, or: $value.recordType),
    clinic: data.get(#clinic, or: $value.clinic),
    documentUrls: data.get(#documentUrls, or: $value.documentUrls),
    pet: data.get(#pet, or: $value.pet),
  );

  @override
  MedicalRecordDataCopyWith<$R2, MedicalRecordData, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MedicalRecordDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
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
    opt: true,
    def: '',
  );

  @override
  final MappableFields<Clinic> fields = const {
    #id: _f$id,
    #clinicName: _f$clinicName,
  };

  static Clinic _instantiate(DecodingData data) {
    return Clinic(id: data.dec(_f$id), clinicName: data.dec(_f$clinicName));
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
  $R call({String? id, String? clinicName});
  ClinicCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ClinicCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Clinic, $Out>
    implements ClinicCopyWith<$R, Clinic, $Out> {
  _ClinicCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Clinic> $mapper = ClinicMapper.ensureInitialized();
  @override
  $R call({String? id, String? clinicName}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (clinicName != null) #clinicName: clinicName,
    }),
  );
  @override
  Clinic $make(CopyWithData data) => Clinic(
    id: data.get(#id, or: $value.id),
    clinicName: data.get(#clinicName, or: $value.clinicName),
  );

  @override
  ClinicCopyWith<$R2, Clinic, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ClinicCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DocumentUrlMapper extends ClassMapperBase<DocumentUrl> {
  DocumentUrlMapper._();

  static DocumentUrlMapper? _instance;
  static DocumentUrlMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DocumentUrlMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DocumentUrl';

  static String? _$id(DocumentUrl v) => v.id;
  static const Field<DocumentUrl, String> _f$id = Field('id', _$id, opt: true);
  static String _$url(DocumentUrl v) => v.url;
  static const Field<DocumentUrl, String> _f$url = Field(
    'url',
    _$url,
    opt: true,
    def: '',
  );
  static String _$name(DocumentUrl v) => v.name;
  static const Field<DocumentUrl, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
  );
  static String? _$createdAt(DocumentUrl v) => v.createdAt;
  static const Field<DocumentUrl, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );
  static String? _$prescriptionId(DocumentUrl v) => v.prescriptionId;
  static const Field<DocumentUrl, String> _f$prescriptionId = Field(
    'prescriptionId',
    _$prescriptionId,
    opt: true,
  );
  static bool? _$isFromPrescription(DocumentUrl v) => v.isFromPrescription;
  static const Field<DocumentUrl, bool> _f$isFromPrescription = Field(
    'isFromPrescription',
    _$isFromPrescription,
    opt: true,
  );
  static String? _$size(DocumentUrl v) => v.size;
  static const Field<DocumentUrl, String> _f$size = Field(
    'size',
    _$size,
    opt: true,
  );

  @override
  final MappableFields<DocumentUrl> fields = const {
    #id: _f$id,
    #url: _f$url,
    #name: _f$name,
    #createdAt: _f$createdAt,
    #prescriptionId: _f$prescriptionId,
    #isFromPrescription: _f$isFromPrescription,
    #size: _f$size,
  };

  static DocumentUrl _instantiate(DecodingData data) {
    return DocumentUrl(
      id: data.dec(_f$id),
      url: data.dec(_f$url),
      name: data.dec(_f$name),
      createdAt: data.dec(_f$createdAt),
      prescriptionId: data.dec(_f$prescriptionId),
      isFromPrescription: data.dec(_f$isFromPrescription),
      size: data.dec(_f$size),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DocumentUrl fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DocumentUrl>(map);
  }

  static DocumentUrl fromJson(String json) {
    return ensureInitialized().decodeJson<DocumentUrl>(json);
  }
}

mixin DocumentUrlMappable {
  String toJson() {
    return DocumentUrlMapper.ensureInitialized().encodeJson<DocumentUrl>(
      this as DocumentUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return DocumentUrlMapper.ensureInitialized().encodeMap<DocumentUrl>(
      this as DocumentUrl,
    );
  }

  DocumentUrlCopyWith<DocumentUrl, DocumentUrl, DocumentUrl> get copyWith =>
      _DocumentUrlCopyWithImpl<DocumentUrl, DocumentUrl>(
        this as DocumentUrl,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DocumentUrlMapper.ensureInitialized().stringifyValue(
      this as DocumentUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    return DocumentUrlMapper.ensureInitialized().equalsValue(
      this as DocumentUrl,
      other,
    );
  }

  @override
  int get hashCode {
    return DocumentUrlMapper.ensureInitialized().hashValue(this as DocumentUrl);
  }
}

extension DocumentUrlValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DocumentUrl, $Out> {
  DocumentUrlCopyWith<$R, DocumentUrl, $Out> get $asDocumentUrl =>
      $base.as((v, t, t2) => _DocumentUrlCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DocumentUrlCopyWith<$R, $In extends DocumentUrl, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? url,
    String? name,
    String? createdAt,
    String? prescriptionId,
    bool? isFromPrescription,
    String? size,
  });
  DocumentUrlCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DocumentUrlCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DocumentUrl, $Out>
    implements DocumentUrlCopyWith<$R, DocumentUrl, $Out> {
  _DocumentUrlCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DocumentUrl> $mapper =
      DocumentUrlMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    String? url,
    String? name,
    Object? createdAt = $none,
    Object? prescriptionId = $none,
    Object? isFromPrescription = $none,
    Object? size = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (url != null) #url: url,
      if (name != null) #name: name,
      if (createdAt != $none) #createdAt: createdAt,
      if (prescriptionId != $none) #prescriptionId: prescriptionId,
      if (isFromPrescription != $none) #isFromPrescription: isFromPrescription,
      if (size != $none) #size: size,
    }),
  );
  @override
  DocumentUrl $make(CopyWithData data) => DocumentUrl(
    id: data.get(#id, or: $value.id),
    url: data.get(#url, or: $value.url),
    name: data.get(#name, or: $value.name),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    prescriptionId: data.get(#prescriptionId, or: $value.prescriptionId),
    isFromPrescription: data.get(
      #isFromPrescription,
      or: $value.isFromPrescription,
    ),
    size: data.get(#size, or: $value.size),
  );

  @override
  DocumentUrlCopyWith<$R2, DocumentUrl, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DocumentUrlCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PetMapper extends ClassMapperBase<Pet> {
  PetMapper._();

  static PetMapper? _instance;
  static PetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PetMapper._());
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

  @override
  final MappableFields<Pet> fields = const {
    #id: _f$id,
    #name: _f$name,
    #type: _f$type,
    #profilePicture: _f$profilePicture,
  };

  static Pet _instantiate(DecodingData data) {
    return Pet(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      type: data.dec(_f$type),
      profilePicture: data.dec(_f$profilePicture),
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
  $R call({String? id, String? name, String? type, String? profilePicture});
  PetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PetCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Pet, $Out>
    implements PetCopyWith<$R, Pet, $Out> {
  _PetCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Pet> $mapper = PetMapper.ensureInitialized();
  @override
  $R call({String? id, String? name, String? type, String? profilePicture}) =>
      $apply(
        FieldCopyWithData({
          if (id != null) #id: id,
          if (name != null) #name: name,
          if (type != null) #type: type,
          if (profilePicture != null) #profilePicture: profilePicture,
        }),
      );
  @override
  Pet $make(CopyWithData data) => Pet(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    type: data.get(#type, or: $value.type),
    profilePicture: data.get(#profilePicture, or: $value.profilePicture),
  );

  @override
  PetCopyWith<$R2, Pet, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PetCopyWithImpl<$R2, $Out2>($value, $cast, t);
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

