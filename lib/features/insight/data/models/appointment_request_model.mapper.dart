// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'appointment_request_model.dart';

class AppointmentRequestModelMapper
    extends ClassMapperBase<AppointmentRequestModel> {
  AppointmentRequestModelMapper._();

  static AppointmentRequestModelMapper? _instance;
  static AppointmentRequestModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = AppointmentRequestModelMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'AppointmentRequestModel';

  static String? _$petId(AppointmentRequestModel v) => v.petId;
  static const Field<AppointmentRequestModel, String> _f$petId = Field(
    'petId',
    _$petId,
    opt: true,
  );
  static String? _$clinicId(AppointmentRequestModel v) => v.clinicId;
  static const Field<AppointmentRequestModel, String> _f$clinicId = Field(
    'clinicId',
    _$clinicId,
    opt: true,
  );
  static String? _$appointmentDate(AppointmentRequestModel v) =>
      v.appointmentDate;
  static const Field<AppointmentRequestModel, String> _f$appointmentDate =
      Field('appointmentDate', _$appointmentDate, opt: true);
  static String? _$appointmentTime(AppointmentRequestModel v) =>
      v.appointmentTime;
  static const Field<AppointmentRequestModel, String> _f$appointmentTime =
      Field('appointmentTime', _$appointmentTime, opt: true);
  static String? _$consultationType(AppointmentRequestModel v) =>
      v.consultationType;
  static const Field<AppointmentRequestModel, String> _f$consultationType =
      Field('consultationType', _$consultationType, opt: true);
  static String? _$chiefComplaint(AppointmentRequestModel v) =>
      v.chiefComplaint;
  static const Field<AppointmentRequestModel, String> _f$chiefComplaint = Field(
    'chiefComplaint',
    _$chiefComplaint,
    opt: true,
  );
  static String? _$priority(AppointmentRequestModel v) => v.priority;
  static const Field<AppointmentRequestModel, String> _f$priority = Field(
    'priority',
    _$priority,
    opt: true,
  );
  static int? _$durationMinutes(AppointmentRequestModel v) => v.durationMinutes;
  static const Field<AppointmentRequestModel, int> _f$durationMinutes = Field(
    'durationMinutes',
    _$durationMinutes,
    opt: true,
  );
  static String? _$planId(AppointmentRequestModel v) => v.planId;
  static const Field<AppointmentRequestModel, String> _f$planId = Field(
    'planId',
    _$planId,
    opt: true,
  );
  static String? _$petName(AppointmentRequestModel v) => v.petName;
  static const Field<AppointmentRequestModel, String> _f$petName = Field(
    'petName',
    _$petName,
    opt: true,
  );
  static String? _$petImage(AppointmentRequestModel v) => v.petImage;
  static const Field<AppointmentRequestModel, String> _f$petImage = Field(
    'petImage',
    _$petImage,
    opt: true,
  );
  static String? _$petNotes(AppointmentRequestModel v) => v.petNotes;
  static const Field<AppointmentRequestModel, String> _f$petNotes = Field(
    'petNotes',
    _$petNotes,
    opt: true,
  );

  @override
  final MappableFields<AppointmentRequestModel> fields = const {
    #petId: _f$petId,
    #clinicId: _f$clinicId,
    #appointmentDate: _f$appointmentDate,
    #appointmentTime: _f$appointmentTime,
    #consultationType: _f$consultationType,
    #chiefComplaint: _f$chiefComplaint,
    #priority: _f$priority,
    #durationMinutes: _f$durationMinutes,
    #planId: _f$planId,
    #petName: _f$petName,
    #petImage: _f$petImage,
    #petNotes: _f$petNotes,
  };

  static AppointmentRequestModel _instantiate(DecodingData data) {
    return AppointmentRequestModel(
      petId: data.dec(_f$petId),
      clinicId: data.dec(_f$clinicId),
      appointmentDate: data.dec(_f$appointmentDate),
      appointmentTime: data.dec(_f$appointmentTime),
      consultationType: data.dec(_f$consultationType),
      chiefComplaint: data.dec(_f$chiefComplaint),
      priority: data.dec(_f$priority),
      durationMinutes: data.dec(_f$durationMinutes),
      planId: data.dec(_f$planId),
      petName: data.dec(_f$petName),
      petImage: data.dec(_f$petImage),
      petNotes: data.dec(_f$petNotes),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppointmentRequestModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppointmentRequestModel>(map);
  }

  static AppointmentRequestModel fromJson(String json) {
    return ensureInitialized().decodeJson<AppointmentRequestModel>(json);
  }
}

mixin AppointmentRequestModelMappable {
  String toJson() {
    return AppointmentRequestModelMapper.ensureInitialized()
        .encodeJson<AppointmentRequestModel>(this as AppointmentRequestModel);
  }

  Map<String, dynamic> toMap() {
    return AppointmentRequestModelMapper.ensureInitialized()
        .encodeMap<AppointmentRequestModel>(this as AppointmentRequestModel);
  }

  AppointmentRequestModelCopyWith<
    AppointmentRequestModel,
    AppointmentRequestModel,
    AppointmentRequestModel
  >
  get copyWith =>
      _AppointmentRequestModelCopyWithImpl<
        AppointmentRequestModel,
        AppointmentRequestModel
      >(this as AppointmentRequestModel, $identity, $identity);
  @override
  String toString() {
    return AppointmentRequestModelMapper.ensureInitialized().stringifyValue(
      this as AppointmentRequestModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppointmentRequestModelMapper.ensureInitialized().equalsValue(
      this as AppointmentRequestModel,
      other,
    );
  }

  @override
  int get hashCode {
    return AppointmentRequestModelMapper.ensureInitialized().hashValue(
      this as AppointmentRequestModel,
    );
  }
}

extension AppointmentRequestModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppointmentRequestModel, $Out> {
  AppointmentRequestModelCopyWith<$R, AppointmentRequestModel, $Out>
  get $asAppointmentRequestModel => $base.as(
    (v, t, t2) => _AppointmentRequestModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AppointmentRequestModelCopyWith<
  $R,
  $In extends AppointmentRequestModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? petId,
    String? clinicId,
    String? appointmentDate,
    String? appointmentTime,
    String? consultationType,
    String? chiefComplaint,
    String? priority,
    int? durationMinutes,
    String? planId,
    String? petName,
    String? petImage,
    String? petNotes,
  });
  AppointmentRequestModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AppointmentRequestModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppointmentRequestModel, $Out>
    implements
        AppointmentRequestModelCopyWith<$R, AppointmentRequestModel, $Out> {
  _AppointmentRequestModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppointmentRequestModel> $mapper =
      AppointmentRequestModelMapper.ensureInitialized();
  @override
  $R call({
    Object? petId = $none,
    Object? clinicId = $none,
    Object? appointmentDate = $none,
    Object? appointmentTime = $none,
    Object? consultationType = $none,
    Object? chiefComplaint = $none,
    Object? priority = $none,
    Object? durationMinutes = $none,
    Object? planId = $none,
    Object? petName = $none,
    Object? petImage = $none,
    Object? petNotes = $none,
  }) => $apply(
    FieldCopyWithData({
      if (petId != $none) #petId: petId,
      if (clinicId != $none) #clinicId: clinicId,
      if (appointmentDate != $none) #appointmentDate: appointmentDate,
      if (appointmentTime != $none) #appointmentTime: appointmentTime,
      if (consultationType != $none) #consultationType: consultationType,
      if (chiefComplaint != $none) #chiefComplaint: chiefComplaint,
      if (priority != $none) #priority: priority,
      if (durationMinutes != $none) #durationMinutes: durationMinutes,
      if (planId != $none) #planId: planId,
      if (petName != $none) #petName: petName,
      if (petImage != $none) #petImage: petImage,
      if (petNotes != $none) #petNotes: petNotes,
    }),
  );
  @override
  AppointmentRequestModel $make(CopyWithData data) => AppointmentRequestModel(
    petId: data.get(#petId, or: $value.petId),
    clinicId: data.get(#clinicId, or: $value.clinicId),
    appointmentDate: data.get(#appointmentDate, or: $value.appointmentDate),
    appointmentTime: data.get(#appointmentTime, or: $value.appointmentTime),
    consultationType: data.get(#consultationType, or: $value.consultationType),
    chiefComplaint: data.get(#chiefComplaint, or: $value.chiefComplaint),
    priority: data.get(#priority, or: $value.priority),
    durationMinutes: data.get(#durationMinutes, or: $value.durationMinutes),
    planId: data.get(#planId, or: $value.planId),
    petName: data.get(#petName, or: $value.petName),
    petImage: data.get(#petImage, or: $value.petImage),
    petNotes: data.get(#petNotes, or: $value.petNotes),
  );

  @override
  AppointmentRequestModelCopyWith<$R2, AppointmentRequestModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AppointmentRequestModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

