// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'missing_pet_model.dart';

class MissingPetModelMapper extends ClassMapperBase<MissingPetModel> {
  MissingPetModelMapper._();

  static MissingPetModelMapper? _instance;
  static MissingPetModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MissingPetModelMapper._());
      PetMapper.ensureInitialized();
      OwnerMapper.ensureInitialized();
      ImageModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MissingPetModel';

  static String _$id(MissingPetModel v) => v.id;
  static const Field<MissingPetModel, String> _f$id = Field('id', _$id);
  static String _$petId(MissingPetModel v) => v.petId;
  static const Field<MissingPetModel, String> _f$petId = Field(
    'petId',
    _$petId,
  );
  static String _$ownerId(MissingPetModel v) => v.ownerId;
  static const Field<MissingPetModel, String> _f$ownerId = Field(
    'ownerId',
    _$ownerId,
  );
  static String _$lastKnownLocation(MissingPetModel v) => v.lastKnownLocation;
  static const Field<MissingPetModel, String> _f$lastKnownLocation = Field(
    'lastKnownLocation',
    _$lastKnownLocation,
  );
  static bool _$isDeleted(MissingPetModel v) => v.isDeleted;
  static const Field<MissingPetModel, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
  );
  static String? _$color(MissingPetModel v) => v.color;
  static const Field<MissingPetModel, String> _f$color = Field(
    'color',
    _$color,
    opt: true,
  );
  static double? _$latitude(MissingPetModel v) => v.latitude;
  static const Field<MissingPetModel, double> _f$latitude = Field(
    'latitude',
    _$latitude,
    opt: true,
    hook: DoubleHook(),
  );
  static double? _$longitude(MissingPetModel v) => v.longitude;
  static const Field<MissingPetModel, double> _f$longitude = Field(
    'longitude',
    _$longitude,
    opt: true,
    hook: DoubleHook(),
  );
  static String? _$missingDate(MissingPetModel v) => v.missingDate;
  static const Field<MissingPetModel, String> _f$missingDate = Field(
    'missingDate',
    _$missingDate,
    opt: true,
  );
  static String? _$missingTime(MissingPetModel v) => v.missingTime;
  static const Field<MissingPetModel, String> _f$missingTime = Field(
    'missingTime',
    _$missingTime,
    opt: true,
  );
  static String _$description(MissingPetModel v) => v.description;
  static const Field<MissingPetModel, String> _f$description = Field(
    'description',
    _$description,
  );
  static double? _$rewardAmount(MissingPetModel v) => v.rewardAmount;
  static const Field<MissingPetModel, double> _f$rewardAmount = Field(
    'rewardAmount',
    _$rewardAmount,
    opt: true,
    hook: DoubleHook(),
  );
  static String? _$currencyUnit(MissingPetModel v) => v.currencyUnit;
  static const Field<MissingPetModel, String> _f$currencyUnit = Field(
    'currencyUnit',
    _$currencyUnit,
    opt: true,
  );
  static String _$status(MissingPetModel v) => v.status;
  static const Field<MissingPetModel, String> _f$status = Field(
    'status',
    _$status,
  );
  static DateTime _$createdAt(MissingPetModel v) => v.createdAt;
  static const Field<MissingPetModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static DateTime _$updatedAt(MissingPetModel v) => v.updatedAt;
  static const Field<MissingPetModel, DateTime> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
  );
  static DateTime? _$resolvedAt(MissingPetModel v) => v.resolvedAt;
  static const Field<MissingPetModel, DateTime> _f$resolvedAt = Field(
    'resolvedAt',
    _$resolvedAt,
    opt: true,
  );
  static Pet _$pet(MissingPetModel v) => v.pet;
  static const Field<MissingPetModel, Pet> _f$pet = Field('pet', _$pet);
  static Owner _$owner(MissingPetModel v) => v.owner;
  static const Field<MissingPetModel, Owner> _f$owner = Field('owner', _$owner);
  static List<ImageModel> _$images(MissingPetModel v) => v.images;
  static const Field<MissingPetModel, List<ImageModel>> _f$images = Field(
    'images',
    _$images,
  );
  static bool? _$isAuthor(MissingPetModel v) => v.isAuthor;
  static const Field<MissingPetModel, bool> _f$isAuthor = Field(
    'isAuthor',
    _$isAuthor,
    opt: true,
  );

  @override
  final MappableFields<MissingPetModel> fields = const {
    #id: _f$id,
    #petId: _f$petId,
    #ownerId: _f$ownerId,
    #lastKnownLocation: _f$lastKnownLocation,
    #isDeleted: _f$isDeleted,
    #color: _f$color,
    #latitude: _f$latitude,
    #longitude: _f$longitude,
    #missingDate: _f$missingDate,
    #missingTime: _f$missingTime,
    #description: _f$description,
    #rewardAmount: _f$rewardAmount,
    #currencyUnit: _f$currencyUnit,
    #status: _f$status,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #resolvedAt: _f$resolvedAt,
    #pet: _f$pet,
    #owner: _f$owner,
    #images: _f$images,
    #isAuthor: _f$isAuthor,
  };

  static MissingPetModel _instantiate(DecodingData data) {
    return MissingPetModel(
      id: data.dec(_f$id),
      petId: data.dec(_f$petId),
      ownerId: data.dec(_f$ownerId),
      lastKnownLocation: data.dec(_f$lastKnownLocation),
      isDeleted: data.dec(_f$isDeleted),
      color: data.dec(_f$color),
      latitude: data.dec(_f$latitude),
      longitude: data.dec(_f$longitude),
      missingDate: data.dec(_f$missingDate),
      missingTime: data.dec(_f$missingTime),
      description: data.dec(_f$description),
      rewardAmount: data.dec(_f$rewardAmount),
      currencyUnit: data.dec(_f$currencyUnit),
      status: data.dec(_f$status),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      resolvedAt: data.dec(_f$resolvedAt),
      pet: data.dec(_f$pet),
      owner: data.dec(_f$owner),
      images: data.dec(_f$images),
      isAuthor: data.dec(_f$isAuthor),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MissingPetModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MissingPetModel>(map);
  }

  static MissingPetModel fromJson(String json) {
    return ensureInitialized().decodeJson<MissingPetModel>(json);
  }
}

mixin MissingPetModelMappable {
  String toJson() {
    return MissingPetModelMapper.ensureInitialized()
        .encodeJson<MissingPetModel>(this as MissingPetModel);
  }

  Map<String, dynamic> toMap() {
    return MissingPetModelMapper.ensureInitialized().encodeMap<MissingPetModel>(
      this as MissingPetModel,
    );
  }

  MissingPetModelCopyWith<MissingPetModel, MissingPetModel, MissingPetModel>
  get copyWith =>
      _MissingPetModelCopyWithImpl<MissingPetModel, MissingPetModel>(
        this as MissingPetModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MissingPetModelMapper.ensureInitialized().stringifyValue(
      this as MissingPetModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return MissingPetModelMapper.ensureInitialized().equalsValue(
      this as MissingPetModel,
      other,
    );
  }

  @override
  int get hashCode {
    return MissingPetModelMapper.ensureInitialized().hashValue(
      this as MissingPetModel,
    );
  }
}

extension MissingPetModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MissingPetModel, $Out> {
  MissingPetModelCopyWith<$R, MissingPetModel, $Out> get $asMissingPetModel =>
      $base.as((v, t, t2) => _MissingPetModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MissingPetModelCopyWith<$R, $In extends MissingPetModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PetCopyWith<$R, Pet, Pet> get pet;
  OwnerCopyWith<$R, Owner, Owner> get owner;
  ListCopyWith<$R, ImageModel, ImageModelCopyWith<$R, ImageModel, ImageModel>>
  get images;
  $R call({
    String? id,
    String? petId,
    String? ownerId,
    String? lastKnownLocation,
    bool? isDeleted,
    String? color,
    double? latitude,
    double? longitude,
    String? missingDate,
    String? missingTime,
    String? description,
    double? rewardAmount,
    String? currencyUnit,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? resolvedAt,
    Pet? pet,
    Owner? owner,
    List<ImageModel>? images,
    bool? isAuthor,
  });
  MissingPetModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MissingPetModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MissingPetModel, $Out>
    implements MissingPetModelCopyWith<$R, MissingPetModel, $Out> {
  _MissingPetModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MissingPetModel> $mapper =
      MissingPetModelMapper.ensureInitialized();
  @override
  PetCopyWith<$R, Pet, Pet> get pet =>
      $value.pet.copyWith.$chain((v) => call(pet: v));
  @override
  OwnerCopyWith<$R, Owner, Owner> get owner =>
      $value.owner.copyWith.$chain((v) => call(owner: v));
  @override
  ListCopyWith<$R, ImageModel, ImageModelCopyWith<$R, ImageModel, ImageModel>>
  get images => ListCopyWith(
    $value.images,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(images: v),
  );
  @override
  $R call({
    String? id,
    String? petId,
    String? ownerId,
    String? lastKnownLocation,
    bool? isDeleted,
    Object? color = $none,
    Object? latitude = $none,
    Object? longitude = $none,
    Object? missingDate = $none,
    Object? missingTime = $none,
    String? description,
    Object? rewardAmount = $none,
    Object? currencyUnit = $none,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? resolvedAt = $none,
    Pet? pet,
    Owner? owner,
    List<ImageModel>? images,
    Object? isAuthor = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (petId != null) #petId: petId,
      if (ownerId != null) #ownerId: ownerId,
      if (lastKnownLocation != null) #lastKnownLocation: lastKnownLocation,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (color != $none) #color: color,
      if (latitude != $none) #latitude: latitude,
      if (longitude != $none) #longitude: longitude,
      if (missingDate != $none) #missingDate: missingDate,
      if (missingTime != $none) #missingTime: missingTime,
      if (description != null) #description: description,
      if (rewardAmount != $none) #rewardAmount: rewardAmount,
      if (currencyUnit != $none) #currencyUnit: currencyUnit,
      if (status != null) #status: status,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
      if (resolvedAt != $none) #resolvedAt: resolvedAt,
      if (pet != null) #pet: pet,
      if (owner != null) #owner: owner,
      if (images != null) #images: images,
      if (isAuthor != $none) #isAuthor: isAuthor,
    }),
  );
  @override
  MissingPetModel $make(CopyWithData data) => MissingPetModel(
    id: data.get(#id, or: $value.id),
    petId: data.get(#petId, or: $value.petId),
    ownerId: data.get(#ownerId, or: $value.ownerId),
    lastKnownLocation: data.get(
      #lastKnownLocation,
      or: $value.lastKnownLocation,
    ),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    color: data.get(#color, or: $value.color),
    latitude: data.get(#latitude, or: $value.latitude),
    longitude: data.get(#longitude, or: $value.longitude),
    missingDate: data.get(#missingDate, or: $value.missingDate),
    missingTime: data.get(#missingTime, or: $value.missingTime),
    description: data.get(#description, or: $value.description),
    rewardAmount: data.get(#rewardAmount, or: $value.rewardAmount),
    currencyUnit: data.get(#currencyUnit, or: $value.currencyUnit),
    status: data.get(#status, or: $value.status),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    resolvedAt: data.get(#resolvedAt, or: $value.resolvedAt),
    pet: data.get(#pet, or: $value.pet),
    owner: data.get(#owner, or: $value.owner),
    images: data.get(#images, or: $value.images),
    isAuthor: data.get(#isAuthor, or: $value.isAuthor),
  );

  @override
  MissingPetModelCopyWith<$R2, MissingPetModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MissingPetModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
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
  static const Field<Pet, String> _f$id = Field('id', _$id);
  static String _$name(Pet v) => v.name;
  static const Field<Pet, String> _f$name = Field('name', _$name);
  static String _$breedId(Pet v) => v.breedId;
  static const Field<Pet, String> _f$breedId = Field('breedId', _$breedId);
  static String? _$profilePicture(Pet v) => v.profilePicture;
  static const Field<Pet, String> _f$profilePicture = Field(
    'profilePicture',
    _$profilePicture,
    opt: true,
  );
  static String _$gender(Pet v) => v.gender;
  static const Field<Pet, String> _f$gender = Field('gender', _$gender);
  static DateTime _$dob(Pet v) => v.dob;
  static const Field<Pet, DateTime> _f$dob = Field('dob', _$dob);
  static String _$type(Pet v) => v.type;
  static const Field<Pet, String> _f$type = Field('type', _$type);
  static BreedInfo _$breedInfo(Pet v) => v.breedInfo;
  static const Field<Pet, BreedInfo> _f$breedInfo = Field(
    'breedInfo',
    _$breedInfo,
  );

  @override
  final MappableFields<Pet> fields = const {
    #id: _f$id,
    #name: _f$name,
    #breedId: _f$breedId,
    #profilePicture: _f$profilePicture,
    #gender: _f$gender,
    #dob: _f$dob,
    #type: _f$type,
    #breedInfo: _f$breedInfo,
  };

  static Pet _instantiate(DecodingData data) {
    return Pet(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      breedId: data.dec(_f$breedId),
      profilePicture: data.dec(_f$profilePicture),
      gender: data.dec(_f$gender),
      dob: data.dec(_f$dob),
      type: data.dec(_f$type),
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
    String? breedId,
    String? profilePicture,
    String? gender,
    DateTime? dob,
    String? type,
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
    String? breedId,
    Object? profilePicture = $none,
    String? gender,
    DateTime? dob,
    String? type,
    BreedInfo? breedInfo,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (breedId != null) #breedId: breedId,
      if (profilePicture != $none) #profilePicture: profilePicture,
      if (gender != null) #gender: gender,
      if (dob != null) #dob: dob,
      if (type != null) #type: type,
      if (breedInfo != null) #breedInfo: breedInfo,
    }),
  );
  @override
  Pet $make(CopyWithData data) => Pet(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    breedId: data.get(#breedId, or: $value.breedId),
    profilePicture: data.get(#profilePicture, or: $value.profilePicture),
    gender: data.get(#gender, or: $value.gender),
    dob: data.get(#dob, or: $value.dob),
    type: data.get(#type, or: $value.type),
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

  static String _$id(BreedInfo v) => v.id;
  static const Field<BreedInfo, String> _f$id = Field('id', _$id);
  static String _$breedName(BreedInfo v) => v.breedName;
  static const Field<BreedInfo, String> _f$breedName = Field(
    'breedName',
    _$breedName,
  );
  static String _$petType(BreedInfo v) => v.petType;
  static const Field<BreedInfo, String> _f$petType = Field(
    'petType',
    _$petType,
  );

  @override
  final MappableFields<BreedInfo> fields = const {
    #id: _f$id,
    #breedName: _f$breedName,
    #petType: _f$petType,
  };

  static BreedInfo _instantiate(DecodingData data) {
    return BreedInfo(
      id: data.dec(_f$id),
      breedName: data.dec(_f$breedName),
      petType: data.dec(_f$petType),
    );
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
  $R call({String? id, String? breedName, String? petType});
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
  $R call({String? id, String? breedName, String? petType}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (breedName != null) #breedName: breedName,
      if (petType != null) #petType: petType,
    }),
  );
  @override
  BreedInfo $make(CopyWithData data) => BreedInfo(
    id: data.get(#id, or: $value.id),
    breedName: data.get(#breedName, or: $value.breedName),
    petType: data.get(#petType, or: $value.petType),
  );

  @override
  BreedInfoCopyWith<$R2, BreedInfo, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BreedInfoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class OwnerMapper extends ClassMapperBase<Owner> {
  OwnerMapper._();

  static OwnerMapper? _instance;
  static OwnerMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OwnerMapper._());
      OwnerProfileMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Owner';

  static String _$id(Owner v) => v.id;
  static const Field<Owner, String> _f$id = Field('id', _$id);
  static String _$name(Owner v) => v.name;
  static const Field<Owner, String> _f$name = Field('name', _$name);
  static String? _$phone(Owner v) => v.phone;
  static const Field<Owner, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
  );
  static String? _$email(Owner v) => v.email;
  static const Field<Owner, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
  );
  static OwnerProfile? _$profile(Owner v) => v.profile;
  static const Field<Owner, OwnerProfile> _f$profile = Field(
    'profile',
    _$profile,
    opt: true,
  );

  @override
  final MappableFields<Owner> fields = const {
    #id: _f$id,
    #name: _f$name,
    #phone: _f$phone,
    #email: _f$email,
    #profile: _f$profile,
  };

  static Owner _instantiate(DecodingData data) {
    return Owner(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      phone: data.dec(_f$phone),
      email: data.dec(_f$email),
      profile: data.dec(_f$profile),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Owner fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Owner>(map);
  }

  static Owner fromJson(String json) {
    return ensureInitialized().decodeJson<Owner>(json);
  }
}

mixin OwnerMappable {
  String toJson() {
    return OwnerMapper.ensureInitialized().encodeJson<Owner>(this as Owner);
  }

  Map<String, dynamic> toMap() {
    return OwnerMapper.ensureInitialized().encodeMap<Owner>(this as Owner);
  }

  OwnerCopyWith<Owner, Owner, Owner> get copyWith =>
      _OwnerCopyWithImpl<Owner, Owner>(this as Owner, $identity, $identity);
  @override
  String toString() {
    return OwnerMapper.ensureInitialized().stringifyValue(this as Owner);
  }

  @override
  bool operator ==(Object other) {
    return OwnerMapper.ensureInitialized().equalsValue(this as Owner, other);
  }

  @override
  int get hashCode {
    return OwnerMapper.ensureInitialized().hashValue(this as Owner);
  }
}

extension OwnerValueCopy<$R, $Out> on ObjectCopyWith<$R, Owner, $Out> {
  OwnerCopyWith<$R, Owner, $Out> get $asOwner =>
      $base.as((v, t, t2) => _OwnerCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class OwnerCopyWith<$R, $In extends Owner, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  OwnerProfileCopyWith<$R, OwnerProfile, OwnerProfile>? get profile;
  $R call({
    String? id,
    String? name,
    String? phone,
    String? email,
    OwnerProfile? profile,
  });
  OwnerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _OwnerCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Owner, $Out>
    implements OwnerCopyWith<$R, Owner, $Out> {
  _OwnerCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Owner> $mapper = OwnerMapper.ensureInitialized();
  @override
  OwnerProfileCopyWith<$R, OwnerProfile, OwnerProfile>? get profile =>
      $value.profile?.copyWith.$chain((v) => call(profile: v));
  @override
  $R call({
    String? id,
    String? name,
    Object? phone = $none,
    Object? email = $none,
    Object? profile = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (phone != $none) #phone: phone,
      if (email != $none) #email: email,
      if (profile != $none) #profile: profile,
    }),
  );
  @override
  Owner $make(CopyWithData data) => Owner(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    phone: data.get(#phone, or: $value.phone),
    email: data.get(#email, or: $value.email),
    profile: data.get(#profile, or: $value.profile),
  );

  @override
  OwnerCopyWith<$R2, Owner, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _OwnerCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class OwnerProfileMapper extends ClassMapperBase<OwnerProfile> {
  OwnerProfileMapper._();

  static OwnerProfileMapper? _instance;
  static OwnerProfileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OwnerProfileMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'OwnerProfile';

  static String? _$profilePicture(OwnerProfile v) => v.profilePicture;
  static const Field<OwnerProfile, String> _f$profilePicture = Field(
    'profilePicture',
    _$profilePicture,
    opt: true,
  );

  @override
  final MappableFields<OwnerProfile> fields = const {
    #profilePicture: _f$profilePicture,
  };

  static OwnerProfile _instantiate(DecodingData data) {
    return OwnerProfile(profilePicture: data.dec(_f$profilePicture));
  }

  @override
  final Function instantiate = _instantiate;

  static OwnerProfile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<OwnerProfile>(map);
  }

  static OwnerProfile fromJson(String json) {
    return ensureInitialized().decodeJson<OwnerProfile>(json);
  }
}

mixin OwnerProfileMappable {
  String toJson() {
    return OwnerProfileMapper.ensureInitialized().encodeJson<OwnerProfile>(
      this as OwnerProfile,
    );
  }

  Map<String, dynamic> toMap() {
    return OwnerProfileMapper.ensureInitialized().encodeMap<OwnerProfile>(
      this as OwnerProfile,
    );
  }

  OwnerProfileCopyWith<OwnerProfile, OwnerProfile, OwnerProfile> get copyWith =>
      _OwnerProfileCopyWithImpl<OwnerProfile, OwnerProfile>(
        this as OwnerProfile,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return OwnerProfileMapper.ensureInitialized().stringifyValue(
      this as OwnerProfile,
    );
  }

  @override
  bool operator ==(Object other) {
    return OwnerProfileMapper.ensureInitialized().equalsValue(
      this as OwnerProfile,
      other,
    );
  }

  @override
  int get hashCode {
    return OwnerProfileMapper.ensureInitialized().hashValue(
      this as OwnerProfile,
    );
  }
}

extension OwnerProfileValueCopy<$R, $Out>
    on ObjectCopyWith<$R, OwnerProfile, $Out> {
  OwnerProfileCopyWith<$R, OwnerProfile, $Out> get $asOwnerProfile =>
      $base.as((v, t, t2) => _OwnerProfileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class OwnerProfileCopyWith<$R, $In extends OwnerProfile, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? profilePicture});
  OwnerProfileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _OwnerProfileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OwnerProfile, $Out>
    implements OwnerProfileCopyWith<$R, OwnerProfile, $Out> {
  _OwnerProfileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OwnerProfile> $mapper =
      OwnerProfileMapper.ensureInitialized();
  @override
  $R call({Object? profilePicture = $none}) => $apply(
    FieldCopyWithData({
      if (profilePicture != $none) #profilePicture: profilePicture,
    }),
  );
  @override
  OwnerProfile $make(CopyWithData data) => OwnerProfile(
    profilePicture: data.get(#profilePicture, or: $value.profilePicture),
  );

  @override
  OwnerProfileCopyWith<$R2, OwnerProfile, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _OwnerProfileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ImageModelMapper extends ClassMapperBase<ImageModel> {
  ImageModelMapper._();

  static ImageModelMapper? _instance;
  static ImageModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ImageModel';

  static String _$id(ImageModel v) => v.id;
  static const Field<ImageModel, String> _f$id = Field('id', _$id);
  static String _$imageUrl(ImageModel v) => v.imageUrl;
  static const Field<ImageModel, String> _f$imageUrl = Field(
    'imageUrl',
    _$imageUrl,
  );

  @override
  final MappableFields<ImageModel> fields = const {
    #id: _f$id,
    #imageUrl: _f$imageUrl,
  };

  static ImageModel _instantiate(DecodingData data) {
    return ImageModel(id: data.dec(_f$id), imageUrl: data.dec(_f$imageUrl));
  }

  @override
  final Function instantiate = _instantiate;

  static ImageModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ImageModel>(map);
  }

  static ImageModel fromJson(String json) {
    return ensureInitialized().decodeJson<ImageModel>(json);
  }
}

mixin ImageModelMappable {
  String toJson() {
    return ImageModelMapper.ensureInitialized().encodeJson<ImageModel>(
      this as ImageModel,
    );
  }

  Map<String, dynamic> toMap() {
    return ImageModelMapper.ensureInitialized().encodeMap<ImageModel>(
      this as ImageModel,
    );
  }

  ImageModelCopyWith<ImageModel, ImageModel, ImageModel> get copyWith =>
      _ImageModelCopyWithImpl<ImageModel, ImageModel>(
        this as ImageModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ImageModelMapper.ensureInitialized().stringifyValue(
      this as ImageModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ImageModelMapper.ensureInitialized().equalsValue(
      this as ImageModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ImageModelMapper.ensureInitialized().hashValue(this as ImageModel);
  }
}

extension ImageModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ImageModel, $Out> {
  ImageModelCopyWith<$R, ImageModel, $Out> get $asImageModel =>
      $base.as((v, t, t2) => _ImageModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ImageModelCopyWith<$R, $In extends ImageModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? imageUrl});
  ImageModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ImageModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ImageModel, $Out>
    implements ImageModelCopyWith<$R, ImageModel, $Out> {
  _ImageModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ImageModel> $mapper =
      ImageModelMapper.ensureInitialized();
  @override
  $R call({String? id, String? imageUrl}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (imageUrl != null) #imageUrl: imageUrl,
    }),
  );
  @override
  ImageModel $make(CopyWithData data) => ImageModel(
    id: data.get(#id, or: $value.id),
    imageUrl: data.get(#imageUrl, or: $value.imageUrl),
  );

  @override
  ImageModelCopyWith<$R2, ImageModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ImageModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

