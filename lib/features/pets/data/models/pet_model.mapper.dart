// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pet_model.dart';

class PetModelMapper extends ClassMapperBase<PetModel> {
  PetModelMapper._();

  static PetModelMapper? _instance;
  static PetModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PetModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PetModel';

  static String? _$profilePicture(PetModel v) => v.profilePicture;
  static const Field<PetModel, String> _f$profilePicture = Field(
    'profilePicture',
    _$profilePicture,
    opt: true,
    hook: SafeStringHook(),
  );
  static int? _$bcsScore(PetModel v) => v.bcsScore;
  static const Field<PetModel, int> _f$bcsScore = Field(
    'bcsScore',
    _$bcsScore,
    opt: true,
    hook: SafeIntHook(),
  );
  static String _$name(PetModel v) => v.name;
  static const Field<PetModel, String> _f$name = Field(
    'name',
    _$name,
    hook: SafeStringHook(),
  );
  static String _$type(PetModel v) => v.type;
  static const Field<PetModel, String> _f$type = Field(
    'type',
    _$type,
    hook: SafeStringHook(),
  );
  static String _$breedId(PetModel v) => v.breedId;
  static const Field<PetModel, String> _f$breedId = Field(
    'breedId',
    _$breedId,
    hook: SafeStringHook(),
  );
  static String _$gender(PetModel v) => v.gender;
  static const Field<PetModel, String> _f$gender = Field(
    'gender',
    _$gender,
    hook: SafeStringHook(),
  );
  static String _$dob(PetModel v) => v.dob;
  static const Field<PetModel, String> _f$dob = Field(
    'dob',
    _$dob,
    hook: SafeStringHook(),
  );
  static String _$size(PetModel v) => v.size;
  static const Field<PetModel, String> _f$size = Field(
    'size',
    _$size,
    hook: SafeStringHook(),
  );
  static double _$weight(PetModel v) => v.weight;
  static const Field<PetModel, double> _f$weight = Field(
    'weight',
    _$weight,
    hook: SafeDoubleHook(),
  );
  static double _$height(PetModel v) => v.height;
  static const Field<PetModel, double> _f$height = Field(
    'height',
    _$height,
    hook: SafeDoubleHook(),
  );
  static String _$heightUnit(PetModel v) => v.heightUnit;
  static const Field<PetModel, String> _f$heightUnit = Field(
    'heightUnit',
    _$heightUnit,
    hook: SafeStringHook(),
  );
  static String _$weightUnit(PetModel v) => v.weightUnit;
  static const Field<PetModel, String> _f$weightUnit = Field(
    'weightUnit',
    _$weightUnit,
    hook: SafeStringHook(),
  );
  static String? _$healthInfo(PetModel v) => v.healthInfo;
  static const Field<PetModel, String> _f$healthInfo = Field(
    'healthInfo',
    _$healthInfo,
    opt: true,
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<PetModel> fields = const {
    #profilePicture: _f$profilePicture,
    #bcsScore: _f$bcsScore,
    #name: _f$name,
    #type: _f$type,
    #breedId: _f$breedId,
    #gender: _f$gender,
    #dob: _f$dob,
    #size: _f$size,
    #weight: _f$weight,
    #height: _f$height,
    #heightUnit: _f$heightUnit,
    #weightUnit: _f$weightUnit,
    #healthInfo: _f$healthInfo,
  };

  static PetModel _instantiate(DecodingData data) {
    return PetModel(
      profilePicture: data.dec(_f$profilePicture),
      bcsScore: data.dec(_f$bcsScore),
      name: data.dec(_f$name),
      type: data.dec(_f$type),
      breedId: data.dec(_f$breedId),
      gender: data.dec(_f$gender),
      dob: data.dec(_f$dob),
      size: data.dec(_f$size),
      weight: data.dec(_f$weight),
      height: data.dec(_f$height),
      heightUnit: data.dec(_f$heightUnit),
      weightUnit: data.dec(_f$weightUnit),
      healthInfo: data.dec(_f$healthInfo),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PetModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PetModel>(map);
  }

  static PetModel fromJson(String json) {
    return ensureInitialized().decodeJson<PetModel>(json);
  }
}

mixin PetModelMappable {
  String toJson() {
    return PetModelMapper.ensureInitialized().encodeJson<PetModel>(
      this as PetModel,
    );
  }

  Map<String, dynamic> toMap() {
    return PetModelMapper.ensureInitialized().encodeMap<PetModel>(
      this as PetModel,
    );
  }

  PetModelCopyWith<PetModel, PetModel, PetModel> get copyWith =>
      _PetModelCopyWithImpl<PetModel, PetModel>(
        this as PetModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PetModelMapper.ensureInitialized().stringifyValue(this as PetModel);
  }

  @override
  bool operator ==(Object other) {
    return PetModelMapper.ensureInitialized().equalsValue(
      this as PetModel,
      other,
    );
  }

  @override
  int get hashCode {
    return PetModelMapper.ensureInitialized().hashValue(this as PetModel);
  }
}

extension PetModelValueCopy<$R, $Out> on ObjectCopyWith<$R, PetModel, $Out> {
  PetModelCopyWith<$R, PetModel, $Out> get $asPetModel =>
      $base.as((v, t, t2) => _PetModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PetModelCopyWith<$R, $In extends PetModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? profilePicture,
    int? bcsScore,
    String? name,
    String? type,
    String? breedId,
    String? gender,
    String? dob,
    String? size,
    double? weight,
    double? height,
    String? heightUnit,
    String? weightUnit,
    String? healthInfo,
  });
  PetModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PetModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PetModel, $Out>
    implements PetModelCopyWith<$R, PetModel, $Out> {
  _PetModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PetModel> $mapper =
      PetModelMapper.ensureInitialized();
  @override
  $R call({
    Object? profilePicture = $none,
    Object? bcsScore = $none,
    String? name,
    String? type,
    String? breedId,
    String? gender,
    String? dob,
    String? size,
    double? weight,
    double? height,
    String? heightUnit,
    String? weightUnit,
    Object? healthInfo = $none,
  }) => $apply(
    FieldCopyWithData({
      if (profilePicture != $none) #profilePicture: profilePicture,
      if (bcsScore != $none) #bcsScore: bcsScore,
      if (name != null) #name: name,
      if (type != null) #type: type,
      if (breedId != null) #breedId: breedId,
      if (gender != null) #gender: gender,
      if (dob != null) #dob: dob,
      if (size != null) #size: size,
      if (weight != null) #weight: weight,
      if (height != null) #height: height,
      if (heightUnit != null) #heightUnit: heightUnit,
      if (weightUnit != null) #weightUnit: weightUnit,
      if (healthInfo != $none) #healthInfo: healthInfo,
    }),
  );
  @override
  PetModel $make(CopyWithData data) => PetModel(
    profilePicture: data.get(#profilePicture, or: $value.profilePicture),
    bcsScore: data.get(#bcsScore, or: $value.bcsScore),
    name: data.get(#name, or: $value.name),
    type: data.get(#type, or: $value.type),
    breedId: data.get(#breedId, or: $value.breedId),
    gender: data.get(#gender, or: $value.gender),
    dob: data.get(#dob, or: $value.dob),
    size: data.get(#size, or: $value.size),
    weight: data.get(#weight, or: $value.weight),
    height: data.get(#height, or: $value.height),
    heightUnit: data.get(#heightUnit, or: $value.heightUnit),
    weightUnit: data.get(#weightUnit, or: $value.weightUnit),
    healthInfo: data.get(#healthInfo, or: $value.healthInfo),
  );

  @override
  PetModelCopyWith<$R2, PetModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PetModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

