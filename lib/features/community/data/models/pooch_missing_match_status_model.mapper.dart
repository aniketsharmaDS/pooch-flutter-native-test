// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pooch_missing_match_status_model.dart';

class PoochMissingMatchStatusModelMapper
    extends ClassMapperBase<PoochMissingMatchStatusModel> {
  PoochMissingMatchStatusModelMapper._();

  static PoochMissingMatchStatusModelMapper? _instance;
  static PoochMissingMatchStatusModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = PoochMissingMatchStatusModelMapper._(),
      );
      PoochPetMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PoochMissingMatchStatusModel';

  static bool _$matched(PoochMissingMatchStatusModel v) => v.matched;
  static const Field<PoochMissingMatchStatusModel, bool> _f$matched = Field(
    'matched',
    _$matched,
    opt: true,
    def: false,
  );
  static PoochPet? _$pet(PoochMissingMatchStatusModel v) => v.pet;
  static const Field<PoochMissingMatchStatusModel, PoochPet> _f$pet = Field(
    'pet',
    _$pet,
    opt: true,
  );

  @override
  final MappableFields<PoochMissingMatchStatusModel> fields = const {
    #matched: _f$matched,
    #pet: _f$pet,
  };

  static PoochMissingMatchStatusModel _instantiate(DecodingData data) {
    return PoochMissingMatchStatusModel(
      matched: data.dec(_f$matched),
      pet: data.dec(_f$pet),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PoochMissingMatchStatusModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PoochMissingMatchStatusModel>(map);
  }

  static PoochMissingMatchStatusModel fromJson(String json) {
    return ensureInitialized().decodeJson<PoochMissingMatchStatusModel>(json);
  }
}

mixin PoochMissingMatchStatusModelMappable {
  String toJson() {
    return PoochMissingMatchStatusModelMapper.ensureInitialized()
        .encodeJson<PoochMissingMatchStatusModel>(
          this as PoochMissingMatchStatusModel,
        );
  }

  Map<String, dynamic> toMap() {
    return PoochMissingMatchStatusModelMapper.ensureInitialized()
        .encodeMap<PoochMissingMatchStatusModel>(
          this as PoochMissingMatchStatusModel,
        );
  }

  PoochMissingMatchStatusModelCopyWith<
    PoochMissingMatchStatusModel,
    PoochMissingMatchStatusModel,
    PoochMissingMatchStatusModel
  >
  get copyWith =>
      _PoochMissingMatchStatusModelCopyWithImpl<
        PoochMissingMatchStatusModel,
        PoochMissingMatchStatusModel
      >(this as PoochMissingMatchStatusModel, $identity, $identity);
  @override
  String toString() {
    return PoochMissingMatchStatusModelMapper.ensureInitialized()
        .stringifyValue(this as PoochMissingMatchStatusModel);
  }

  @override
  bool operator ==(Object other) {
    return PoochMissingMatchStatusModelMapper.ensureInitialized().equalsValue(
      this as PoochMissingMatchStatusModel,
      other,
    );
  }

  @override
  int get hashCode {
    return PoochMissingMatchStatusModelMapper.ensureInitialized().hashValue(
      this as PoochMissingMatchStatusModel,
    );
  }
}

extension PoochMissingMatchStatusModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PoochMissingMatchStatusModel, $Out> {
  PoochMissingMatchStatusModelCopyWith<$R, PoochMissingMatchStatusModel, $Out>
  get $asPoochMissingMatchStatusModel => $base.as(
    (v, t, t2) => _PoochMissingMatchStatusModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class PoochMissingMatchStatusModelCopyWith<
  $R,
  $In extends PoochMissingMatchStatusModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  PoochPetCopyWith<$R, PoochPet, PoochPet>? get pet;
  $R call({bool? matched, PoochPet? pet});
  PoochMissingMatchStatusModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PoochMissingMatchStatusModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PoochMissingMatchStatusModel, $Out>
    implements
        PoochMissingMatchStatusModelCopyWith<
          $R,
          PoochMissingMatchStatusModel,
          $Out
        > {
  _PoochMissingMatchStatusModelCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<PoochMissingMatchStatusModel> $mapper =
      PoochMissingMatchStatusModelMapper.ensureInitialized();
  @override
  PoochPetCopyWith<$R, PoochPet, PoochPet>? get pet =>
      $value.pet?.copyWith.$chain((v) => call(pet: v));
  @override
  $R call({bool? matched, Object? pet = $none}) => $apply(
    FieldCopyWithData({
      if (matched != null) #matched: matched,
      if (pet != $none) #pet: pet,
    }),
  );
  @override
  PoochMissingMatchStatusModel $make(CopyWithData data) =>
      PoochMissingMatchStatusModel(
        matched: data.get(#matched, or: $value.matched),
        pet: data.get(#pet, or: $value.pet),
      );

  @override
  PoochMissingMatchStatusModelCopyWith<$R2, PoochMissingMatchStatusModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PoochMissingMatchStatusModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PoochPetMapper extends ClassMapperBase<PoochPet> {
  PoochPetMapper._();

  static PoochPetMapper? _instance;
  static PoochPetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PoochPetMapper._());
      PoochBreedMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PoochPet';

  static String _$id(PoochPet v) => v.id;
  static const Field<PoochPet, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$name(PoochPet v) => v.name;
  static const Field<PoochPet, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
  );
  static String _$breedId(PoochPet v) => v.breedId;
  static const Field<PoochPet, String> _f$breedId = Field(
    'breedId',
    _$breedId,
    opt: true,
    def: '',
  );
  static PoochBreed? _$breed(PoochPet v) => v.breed;
  static const Field<PoochPet, PoochBreed> _f$breed = Field(
    'breed',
    _$breed,
    opt: true,
  );
  static String _$type(PoochPet v) => v.type;
  static const Field<PoochPet, String> _f$type = Field(
    'type',
    _$type,
    opt: true,
    def: '',
  );
  static String _$size(PoochPet v) => v.size;
  static const Field<PoochPet, String> _f$size = Field(
    'size',
    _$size,
    opt: true,
    def: '',
  );
  static String _$gender(PoochPet v) => v.gender;
  static const Field<PoochPet, String> _f$gender = Field(
    'gender',
    _$gender,
    opt: true,
    def: '',
  );
  static String _$dob(PoochPet v) => v.dob;
  static const Field<PoochPet, String> _f$dob = Field(
    'dob',
    _$dob,
    opt: true,
    def: '',
  );
  static String _$profilePicture(PoochPet v) => v.profilePicture;
  static const Field<PoochPet, String> _f$profilePicture = Field(
    'profilePicture',
    _$profilePicture,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<PoochPet> fields = const {
    #id: _f$id,
    #name: _f$name,
    #breedId: _f$breedId,
    #breed: _f$breed,
    #type: _f$type,
    #size: _f$size,
    #gender: _f$gender,
    #dob: _f$dob,
    #profilePicture: _f$profilePicture,
  };

  static PoochPet _instantiate(DecodingData data) {
    return PoochPet(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      breedId: data.dec(_f$breedId),
      breed: data.dec(_f$breed),
      type: data.dec(_f$type),
      size: data.dec(_f$size),
      gender: data.dec(_f$gender),
      dob: data.dec(_f$dob),
      profilePicture: data.dec(_f$profilePicture),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PoochPet fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PoochPet>(map);
  }

  static PoochPet fromJson(String json) {
    return ensureInitialized().decodeJson<PoochPet>(json);
  }
}

mixin PoochPetMappable {
  String toJson() {
    return PoochPetMapper.ensureInitialized().encodeJson<PoochPet>(
      this as PoochPet,
    );
  }

  Map<String, dynamic> toMap() {
    return PoochPetMapper.ensureInitialized().encodeMap<PoochPet>(
      this as PoochPet,
    );
  }

  PoochPetCopyWith<PoochPet, PoochPet, PoochPet> get copyWith =>
      _PoochPetCopyWithImpl<PoochPet, PoochPet>(
        this as PoochPet,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PoochPetMapper.ensureInitialized().stringifyValue(this as PoochPet);
  }

  @override
  bool operator ==(Object other) {
    return PoochPetMapper.ensureInitialized().equalsValue(
      this as PoochPet,
      other,
    );
  }

  @override
  int get hashCode {
    return PoochPetMapper.ensureInitialized().hashValue(this as PoochPet);
  }
}

extension PoochPetValueCopy<$R, $Out> on ObjectCopyWith<$R, PoochPet, $Out> {
  PoochPetCopyWith<$R, PoochPet, $Out> get $asPoochPet =>
      $base.as((v, t, t2) => _PoochPetCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PoochPetCopyWith<$R, $In extends PoochPet, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PoochBreedCopyWith<$R, PoochBreed, PoochBreed>? get breed;
  $R call({
    String? id,
    String? name,
    String? breedId,
    PoochBreed? breed,
    String? type,
    String? size,
    String? gender,
    String? dob,
    String? profilePicture,
  });
  PoochPetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PoochPetCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PoochPet, $Out>
    implements PoochPetCopyWith<$R, PoochPet, $Out> {
  _PoochPetCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PoochPet> $mapper =
      PoochPetMapper.ensureInitialized();
  @override
  PoochBreedCopyWith<$R, PoochBreed, PoochBreed>? get breed =>
      $value.breed?.copyWith.$chain((v) => call(breed: v));
  @override
  $R call({
    String? id,
    String? name,
    String? breedId,
    Object? breed = $none,
    String? type,
    String? size,
    String? gender,
    String? dob,
    String? profilePicture,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (breedId != null) #breedId: breedId,
      if (breed != $none) #breed: breed,
      if (type != null) #type: type,
      if (size != null) #size: size,
      if (gender != null) #gender: gender,
      if (dob != null) #dob: dob,
      if (profilePicture != null) #profilePicture: profilePicture,
    }),
  );
  @override
  PoochPet $make(CopyWithData data) => PoochPet(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    breedId: data.get(#breedId, or: $value.breedId),
    breed: data.get(#breed, or: $value.breed),
    type: data.get(#type, or: $value.type),
    size: data.get(#size, or: $value.size),
    gender: data.get(#gender, or: $value.gender),
    dob: data.get(#dob, or: $value.dob),
    profilePicture: data.get(#profilePicture, or: $value.profilePicture),
  );

  @override
  PoochPetCopyWith<$R2, PoochPet, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PoochPetCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PoochBreedMapper extends ClassMapperBase<PoochBreed> {
  PoochBreedMapper._();

  static PoochBreedMapper? _instance;
  static PoochBreedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PoochBreedMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PoochBreed';

  static String _$id(PoochBreed v) => v.id;
  static const Field<PoochBreed, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$breedName(PoochBreed v) => v.breedName;
  static const Field<PoochBreed, String> _f$breedName = Field(
    'breedName',
    _$breedName,
    opt: true,
    def: '',
  );
  static String _$petType(PoochBreed v) => v.petType;
  static const Field<PoochBreed, String> _f$petType = Field(
    'petType',
    _$petType,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<PoochBreed> fields = const {
    #id: _f$id,
    #breedName: _f$breedName,
    #petType: _f$petType,
  };

  static PoochBreed _instantiate(DecodingData data) {
    return PoochBreed(
      id: data.dec(_f$id),
      breedName: data.dec(_f$breedName),
      petType: data.dec(_f$petType),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PoochBreed fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PoochBreed>(map);
  }

  static PoochBreed fromJson(String json) {
    return ensureInitialized().decodeJson<PoochBreed>(json);
  }
}

mixin PoochBreedMappable {
  String toJson() {
    return PoochBreedMapper.ensureInitialized().encodeJson<PoochBreed>(
      this as PoochBreed,
    );
  }

  Map<String, dynamic> toMap() {
    return PoochBreedMapper.ensureInitialized().encodeMap<PoochBreed>(
      this as PoochBreed,
    );
  }

  PoochBreedCopyWith<PoochBreed, PoochBreed, PoochBreed> get copyWith =>
      _PoochBreedCopyWithImpl<PoochBreed, PoochBreed>(
        this as PoochBreed,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PoochBreedMapper.ensureInitialized().stringifyValue(
      this as PoochBreed,
    );
  }

  @override
  bool operator ==(Object other) {
    return PoochBreedMapper.ensureInitialized().equalsValue(
      this as PoochBreed,
      other,
    );
  }

  @override
  int get hashCode {
    return PoochBreedMapper.ensureInitialized().hashValue(this as PoochBreed);
  }
}

extension PoochBreedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PoochBreed, $Out> {
  PoochBreedCopyWith<$R, PoochBreed, $Out> get $asPoochBreed =>
      $base.as((v, t, t2) => _PoochBreedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PoochBreedCopyWith<$R, $In extends PoochBreed, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? breedName, String? petType});
  PoochBreedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PoochBreedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PoochBreed, $Out>
    implements PoochBreedCopyWith<$R, PoochBreed, $Out> {
  _PoochBreedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PoochBreed> $mapper =
      PoochBreedMapper.ensureInitialized();
  @override
  $R call({String? id, String? breedName, String? petType}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (breedName != null) #breedName: breedName,
      if (petType != null) #petType: petType,
    }),
  );
  @override
  PoochBreed $make(CopyWithData data) => PoochBreed(
    id: data.get(#id, or: $value.id),
    breedName: data.get(#breedName, or: $value.breedName),
    petType: data.get(#petType, or: $value.petType),
  );

  @override
  PoochBreedCopyWith<$R2, PoochBreed, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PoochBreedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

