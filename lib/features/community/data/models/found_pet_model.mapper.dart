// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'found_pet_model.dart';

class FoundPetModelMapper extends ClassMapperBase<FoundPetModel> {
  FoundPetModelMapper._();

  static FoundPetModelMapper? _instance;
  static FoundPetModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FoundPetModelMapper._());
      MissingReportMapper.ensureInitialized();
      FinderMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FoundPetModel';

  static String _$id(FoundPetModel v) => v.id;
  static const Field<FoundPetModel, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String? _$missingReportId(FoundPetModel v) => v.missingReportId;
  static const Field<FoundPetModel, String> _f$missingReportId = Field(
    'missingReportId',
    _$missingReportId,
    opt: true,
  );
  static String _$finderId(FoundPetModel v) => v.finderId;
  static const Field<FoundPetModel, String> _f$finderId = Field(
    'finderId',
    _$finderId,
    opt: true,
    def: '',
  );
  static String _$verificationMethod(FoundPetModel v) => v.verificationMethod;
  static const Field<FoundPetModel, String> _f$verificationMethod = Field(
    'verificationMethod',
    _$verificationMethod,
    opt: true,
    def: '',
  );
  static bool _$isVerified(FoundPetModel v) => v.isVerified;
  static const Field<FoundPetModel, bool> _f$isVerified = Field(
    'isVerified',
    _$isVerified,
    opt: true,
    def: false,
  );
  static bool _$isDeleted(FoundPetModel v) => v.isDeleted;
  static const Field<FoundPetModel, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static String _$notes(FoundPetModel v) => v.notes;
  static const Field<FoundPetModel, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
    def: '',
  );
  static String _$latitude(FoundPetModel v) => v.latitude;
  static const Field<FoundPetModel, String> _f$latitude = Field(
    'latitude',
    _$latitude,
    opt: true,
    def: '',
  );
  static String _$longitude(FoundPetModel v) => v.longitude;
  static const Field<FoundPetModel, String> _f$longitude = Field(
    'longitude',
    _$longitude,
    opt: true,
    def: '',
  );
  static String _$location(FoundPetModel v) => v.location;
  static const Field<FoundPetModel, String> _f$location = Field(
    'location',
    _$location,
    opt: true,
    def: '',
  );
  static String _$createdAt(FoundPetModel v) => v.createdAt;
  static const Field<FoundPetModel, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
    def: '',
  );
  static MissingReport? _$missingReport(FoundPetModel v) => v.missingReport;
  static const Field<FoundPetModel, MissingReport> _f$missingReport = Field(
    'missingReport',
    _$missingReport,
    opt: true,
  );
  static Finder _$finder(FoundPetModel v) => v.finder;
  static const Field<FoundPetModel, Finder> _f$finder = Field(
    'finder',
    _$finder,
    opt: true,
    def: const Finder(),
  );
  static bool _$isAuthor(FoundPetModel v) => v.isAuthor;
  static const Field<FoundPetModel, bool> _f$isAuthor = Field(
    'isAuthor',
    _$isAuthor,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<FoundPetModel> fields = const {
    #id: _f$id,
    #missingReportId: _f$missingReportId,
    #finderId: _f$finderId,
    #verificationMethod: _f$verificationMethod,
    #isVerified: _f$isVerified,
    #isDeleted: _f$isDeleted,
    #notes: _f$notes,
    #latitude: _f$latitude,
    #longitude: _f$longitude,
    #location: _f$location,
    #createdAt: _f$createdAt,
    #missingReport: _f$missingReport,
    #finder: _f$finder,
    #isAuthor: _f$isAuthor,
  };

  static FoundPetModel _instantiate(DecodingData data) {
    return FoundPetModel(
      id: data.dec(_f$id),
      missingReportId: data.dec(_f$missingReportId),
      finderId: data.dec(_f$finderId),
      verificationMethod: data.dec(_f$verificationMethod),
      isVerified: data.dec(_f$isVerified),
      isDeleted: data.dec(_f$isDeleted),
      notes: data.dec(_f$notes),
      latitude: data.dec(_f$latitude),
      longitude: data.dec(_f$longitude),
      location: data.dec(_f$location),
      createdAt: data.dec(_f$createdAt),
      missingReport: data.dec(_f$missingReport),
      finder: data.dec(_f$finder),
      isAuthor: data.dec(_f$isAuthor),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static FoundPetModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FoundPetModel>(map);
  }

  static FoundPetModel fromJson(String json) {
    return ensureInitialized().decodeJson<FoundPetModel>(json);
  }
}

mixin FoundPetModelMappable {
  String toJson() {
    return FoundPetModelMapper.ensureInitialized().encodeJson<FoundPetModel>(
      this as FoundPetModel,
    );
  }

  Map<String, dynamic> toMap() {
    return FoundPetModelMapper.ensureInitialized().encodeMap<FoundPetModel>(
      this as FoundPetModel,
    );
  }

  FoundPetModelCopyWith<FoundPetModel, FoundPetModel, FoundPetModel>
  get copyWith => _FoundPetModelCopyWithImpl<FoundPetModel, FoundPetModel>(
    this as FoundPetModel,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return FoundPetModelMapper.ensureInitialized().stringifyValue(
      this as FoundPetModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return FoundPetModelMapper.ensureInitialized().equalsValue(
      this as FoundPetModel,
      other,
    );
  }

  @override
  int get hashCode {
    return FoundPetModelMapper.ensureInitialized().hashValue(
      this as FoundPetModel,
    );
  }
}

extension FoundPetModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FoundPetModel, $Out> {
  FoundPetModelCopyWith<$R, FoundPetModel, $Out> get $asFoundPetModel =>
      $base.as((v, t, t2) => _FoundPetModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FoundPetModelCopyWith<$R, $In extends FoundPetModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MissingReportCopyWith<$R, MissingReport, MissingReport>? get missingReport;
  FinderCopyWith<$R, Finder, Finder> get finder;
  $R call({
    String? id,
    String? missingReportId,
    String? finderId,
    String? verificationMethod,
    bool? isVerified,
    bool? isDeleted,
    String? notes,
    String? latitude,
    String? longitude,
    String? location,
    String? createdAt,
    MissingReport? missingReport,
    Finder? finder,
    bool? isAuthor,
  });
  FoundPetModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FoundPetModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FoundPetModel, $Out>
    implements FoundPetModelCopyWith<$R, FoundPetModel, $Out> {
  _FoundPetModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FoundPetModel> $mapper =
      FoundPetModelMapper.ensureInitialized();
  @override
  MissingReportCopyWith<$R, MissingReport, MissingReport>? get missingReport =>
      $value.missingReport?.copyWith.$chain((v) => call(missingReport: v));
  @override
  FinderCopyWith<$R, Finder, Finder> get finder =>
      $value.finder.copyWith.$chain((v) => call(finder: v));
  @override
  $R call({
    String? id,
    Object? missingReportId = $none,
    String? finderId,
    String? verificationMethod,
    bool? isVerified,
    bool? isDeleted,
    String? notes,
    String? latitude,
    String? longitude,
    String? location,
    String? createdAt,
    Object? missingReport = $none,
    Finder? finder,
    bool? isAuthor,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (missingReportId != $none) #missingReportId: missingReportId,
      if (finderId != null) #finderId: finderId,
      if (verificationMethod != null) #verificationMethod: verificationMethod,
      if (isVerified != null) #isVerified: isVerified,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (notes != null) #notes: notes,
      if (latitude != null) #latitude: latitude,
      if (longitude != null) #longitude: longitude,
      if (location != null) #location: location,
      if (createdAt != null) #createdAt: createdAt,
      if (missingReport != $none) #missingReport: missingReport,
      if (finder != null) #finder: finder,
      if (isAuthor != null) #isAuthor: isAuthor,
    }),
  );
  @override
  FoundPetModel $make(CopyWithData data) => FoundPetModel(
    id: data.get(#id, or: $value.id),
    missingReportId: data.get(#missingReportId, or: $value.missingReportId),
    finderId: data.get(#finderId, or: $value.finderId),
    verificationMethod: data.get(
      #verificationMethod,
      or: $value.verificationMethod,
    ),
    isVerified: data.get(#isVerified, or: $value.isVerified),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    notes: data.get(#notes, or: $value.notes),
    latitude: data.get(#latitude, or: $value.latitude),
    longitude: data.get(#longitude, or: $value.longitude),
    location: data.get(#location, or: $value.location),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    missingReport: data.get(#missingReport, or: $value.missingReport),
    finder: data.get(#finder, or: $value.finder),
    isAuthor: data.get(#isAuthor, or: $value.isAuthor),
  );

  @override
  FoundPetModelCopyWith<$R2, FoundPetModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _FoundPetModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class MissingReportMapper extends ClassMapperBase<MissingReport> {
  MissingReportMapper._();

  static MissingReportMapper? _instance;
  static MissingReportMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MissingReportMapper._());
      PetMapper.ensureInitialized();
      OwnerMapper.ensureInitialized();
      ReportImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MissingReport';

  static String _$id(MissingReport v) => v.id;
  static const Field<MissingReport, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$description(MissingReport v) => v.description;
  static const Field<MissingReport, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
  );
  static String _$lastKnownLocation(MissingReport v) => v.lastKnownLocation;
  static const Field<MissingReport, String> _f$lastKnownLocation = Field(
    'lastKnownLocation',
    _$lastKnownLocation,
    opt: true,
    def: '',
  );
  static String _$missingDate(MissingReport v) => v.missingDate;
  static const Field<MissingReport, String> _f$missingDate = Field(
    'missingDate',
    _$missingDate,
    opt: true,
    def: '',
  );
  static String _$missingTime(MissingReport v) => v.missingTime;
  static const Field<MissingReport, String> _f$missingTime = Field(
    'missingTime',
    _$missingTime,
    opt: true,
    def: '',
  );
  static String _$rewardAmount(MissingReport v) => v.rewardAmount;
  static const Field<MissingReport, String> _f$rewardAmount = Field(
    'rewardAmount',
    _$rewardAmount,
    opt: true,
    def: '',
  );
  static String _$status(MissingReport v) => v.status;
  static const Field<MissingReport, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
    def: '',
  );
  static Pet _$pet(MissingReport v) => v.pet;
  static const Field<MissingReport, Pet> _f$pet = Field(
    'pet',
    _$pet,
    opt: true,
    def: const Pet(),
  );
  static Owner _$owner(MissingReport v) => v.owner;
  static const Field<MissingReport, Owner> _f$owner = Field(
    'owner',
    _$owner,
    opt: true,
    def: const Owner(),
  );
  static List<ReportImage> _$images(MissingReport v) => v.images;
  static const Field<MissingReport, List<ReportImage>> _f$images = Field(
    'images',
    _$images,
    opt: true,
    def: const [],
    hook: SafeListHook(),
  );

  @override
  final MappableFields<MissingReport> fields = const {
    #id: _f$id,
    #description: _f$description,
    #lastKnownLocation: _f$lastKnownLocation,
    #missingDate: _f$missingDate,
    #missingTime: _f$missingTime,
    #rewardAmount: _f$rewardAmount,
    #status: _f$status,
    #pet: _f$pet,
    #owner: _f$owner,
    #images: _f$images,
  };

  static MissingReport _instantiate(DecodingData data) {
    return MissingReport(
      id: data.dec(_f$id),
      description: data.dec(_f$description),
      lastKnownLocation: data.dec(_f$lastKnownLocation),
      missingDate: data.dec(_f$missingDate),
      missingTime: data.dec(_f$missingTime),
      rewardAmount: data.dec(_f$rewardAmount),
      status: data.dec(_f$status),
      pet: data.dec(_f$pet),
      owner: data.dec(_f$owner),
      images: data.dec(_f$images),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MissingReport fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MissingReport>(map);
  }

  static MissingReport fromJson(String json) {
    return ensureInitialized().decodeJson<MissingReport>(json);
  }
}

mixin MissingReportMappable {
  String toJson() {
    return MissingReportMapper.ensureInitialized().encodeJson<MissingReport>(
      this as MissingReport,
    );
  }

  Map<String, dynamic> toMap() {
    return MissingReportMapper.ensureInitialized().encodeMap<MissingReport>(
      this as MissingReport,
    );
  }

  MissingReportCopyWith<MissingReport, MissingReport, MissingReport>
  get copyWith => _MissingReportCopyWithImpl<MissingReport, MissingReport>(
    this as MissingReport,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return MissingReportMapper.ensureInitialized().stringifyValue(
      this as MissingReport,
    );
  }

  @override
  bool operator ==(Object other) {
    return MissingReportMapper.ensureInitialized().equalsValue(
      this as MissingReport,
      other,
    );
  }

  @override
  int get hashCode {
    return MissingReportMapper.ensureInitialized().hashValue(
      this as MissingReport,
    );
  }
}

extension MissingReportValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MissingReport, $Out> {
  MissingReportCopyWith<$R, MissingReport, $Out> get $asMissingReport =>
      $base.as((v, t, t2) => _MissingReportCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MissingReportCopyWith<$R, $In extends MissingReport, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PetCopyWith<$R, Pet, Pet> get pet;
  OwnerCopyWith<$R, Owner, Owner> get owner;
  ListCopyWith<
    $R,
    ReportImage,
    ReportImageCopyWith<$R, ReportImage, ReportImage>
  >
  get images;
  $R call({
    String? id,
    String? description,
    String? lastKnownLocation,
    String? missingDate,
    String? missingTime,
    String? rewardAmount,
    String? status,
    Pet? pet,
    Owner? owner,
    List<ReportImage>? images,
  });
  MissingReportCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MissingReportCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MissingReport, $Out>
    implements MissingReportCopyWith<$R, MissingReport, $Out> {
  _MissingReportCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MissingReport> $mapper =
      MissingReportMapper.ensureInitialized();
  @override
  PetCopyWith<$R, Pet, Pet> get pet =>
      $value.pet.copyWith.$chain((v) => call(pet: v));
  @override
  OwnerCopyWith<$R, Owner, Owner> get owner =>
      $value.owner.copyWith.$chain((v) => call(owner: v));
  @override
  ListCopyWith<
    $R,
    ReportImage,
    ReportImageCopyWith<$R, ReportImage, ReportImage>
  >
  get images => ListCopyWith(
    $value.images,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(images: v),
  );
  @override
  $R call({
    String? id,
    String? description,
    String? lastKnownLocation,
    String? missingDate,
    String? missingTime,
    String? rewardAmount,
    String? status,
    Pet? pet,
    Owner? owner,
    List<ReportImage>? images,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (description != null) #description: description,
      if (lastKnownLocation != null) #lastKnownLocation: lastKnownLocation,
      if (missingDate != null) #missingDate: missingDate,
      if (missingTime != null) #missingTime: missingTime,
      if (rewardAmount != null) #rewardAmount: rewardAmount,
      if (status != null) #status: status,
      if (pet != null) #pet: pet,
      if (owner != null) #owner: owner,
      if (images != null) #images: images,
    }),
  );
  @override
  MissingReport $make(CopyWithData data) => MissingReport(
    id: data.get(#id, or: $value.id),
    description: data.get(#description, or: $value.description),
    lastKnownLocation: data.get(
      #lastKnownLocation,
      or: $value.lastKnownLocation,
    ),
    missingDate: data.get(#missingDate, or: $value.missingDate),
    missingTime: data.get(#missingTime, or: $value.missingTime),
    rewardAmount: data.get(#rewardAmount, or: $value.rewardAmount),
    status: data.get(#status, or: $value.status),
    pet: data.get(#pet, or: $value.pet),
    owner: data.get(#owner, or: $value.owner),
    images: data.get(#images, or: $value.images),
  );

  @override
  MissingReportCopyWith<$R2, MissingReport, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MissingReportCopyWithImpl<$R2, $Out2>($value, $cast, t);
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
  static String _$profilePicture(Pet v) => v.profilePicture;
  static const Field<Pet, String> _f$profilePicture = Field(
    'profilePicture',
    _$profilePicture,
    opt: true,
    def: '',
  );
  static String _$gender(Pet v) => v.gender;
  static const Field<Pet, String> _f$gender = Field(
    'gender',
    _$gender,
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
  static BreedInfo _$breedInfo(Pet v) => v.breedInfo;
  static const Field<Pet, BreedInfo> _f$breedInfo = Field(
    'breedInfo',
    _$breedInfo,
    opt: true,
    def: const BreedInfo(),
  );

  @override
  final MappableFields<Pet> fields = const {
    #id: _f$id,
    #name: _f$name,
    #profilePicture: _f$profilePicture,
    #gender: _f$gender,
    #type: _f$type,
    #breedInfo: _f$breedInfo,
  };

  static Pet _instantiate(DecodingData data) {
    return Pet(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      profilePicture: data.dec(_f$profilePicture),
      gender: data.dec(_f$gender),
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
    String? profilePicture,
    String? gender,
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
    String? profilePicture,
    String? gender,
    String? type,
    BreedInfo? breedInfo,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (profilePicture != null) #profilePicture: profilePicture,
      if (gender != null) #gender: gender,
      if (type != null) #type: type,
      if (breedInfo != null) #breedInfo: breedInfo,
    }),
  );
  @override
  Pet $make(CopyWithData data) => Pet(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    profilePicture: data.get(#profilePicture, or: $value.profilePicture),
    gender: data.get(#gender, or: $value.gender),
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

class OwnerMapper extends ClassMapperBase<Owner> {
  OwnerMapper._();

  static OwnerMapper? _instance;
  static OwnerMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OwnerMapper._());
      UserProfileMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Owner';

  static String _$name(Owner v) => v.name;
  static const Field<Owner, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
  );
  static String _$phone(Owner v) => v.phone;
  static const Field<Owner, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
    def: '',
  );
  static UserProfile _$profile(Owner v) => v.profile;
  static const Field<Owner, UserProfile> _f$profile = Field(
    'profile',
    _$profile,
    opt: true,
    def: const UserProfile(),
  );

  @override
  final MappableFields<Owner> fields = const {
    #name: _f$name,
    #phone: _f$phone,
    #profile: _f$profile,
  };

  static Owner _instantiate(DecodingData data) {
    return Owner(
      name: data.dec(_f$name),
      phone: data.dec(_f$phone),
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
  UserProfileCopyWith<$R, UserProfile, UserProfile> get profile;
  $R call({String? name, String? phone, UserProfile? profile});
  OwnerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _OwnerCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Owner, $Out>
    implements OwnerCopyWith<$R, Owner, $Out> {
  _OwnerCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Owner> $mapper = OwnerMapper.ensureInitialized();
  @override
  UserProfileCopyWith<$R, UserProfile, UserProfile> get profile =>
      $value.profile.copyWith.$chain((v) => call(profile: v));
  @override
  $R call({String? name, String? phone, UserProfile? profile}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (phone != null) #phone: phone,
      if (profile != null) #profile: profile,
    }),
  );
  @override
  Owner $make(CopyWithData data) => Owner(
    name: data.get(#name, or: $value.name),
    phone: data.get(#phone, or: $value.phone),
    profile: data.get(#profile, or: $value.profile),
  );

  @override
  OwnerCopyWith<$R2, Owner, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _OwnerCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class UserProfileMapper extends ClassMapperBase<UserProfile> {
  UserProfileMapper._();

  static UserProfileMapper? _instance;
  static UserProfileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserProfileMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserProfile';

  static String? _$profilePicture(UserProfile v) => v.profilePicture;
  static const Field<UserProfile, String> _f$profilePicture = Field(
    'profilePicture',
    _$profilePicture,
    opt: true,
  );

  @override
  final MappableFields<UserProfile> fields = const {
    #profilePicture: _f$profilePicture,
  };

  static UserProfile _instantiate(DecodingData data) {
    return UserProfile(profilePicture: data.dec(_f$profilePicture));
  }

  @override
  final Function instantiate = _instantiate;

  static UserProfile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserProfile>(map);
  }

  static UserProfile fromJson(String json) {
    return ensureInitialized().decodeJson<UserProfile>(json);
  }
}

mixin UserProfileMappable {
  String toJson() {
    return UserProfileMapper.ensureInitialized().encodeJson<UserProfile>(
      this as UserProfile,
    );
  }

  Map<String, dynamic> toMap() {
    return UserProfileMapper.ensureInitialized().encodeMap<UserProfile>(
      this as UserProfile,
    );
  }

  UserProfileCopyWith<UserProfile, UserProfile, UserProfile> get copyWith =>
      _UserProfileCopyWithImpl<UserProfile, UserProfile>(
        this as UserProfile,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return UserProfileMapper.ensureInitialized().stringifyValue(
      this as UserProfile,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserProfileMapper.ensureInitialized().equalsValue(
      this as UserProfile,
      other,
    );
  }

  @override
  int get hashCode {
    return UserProfileMapper.ensureInitialized().hashValue(this as UserProfile);
  }
}

extension UserProfileValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserProfile, $Out> {
  UserProfileCopyWith<$R, UserProfile, $Out> get $asUserProfile =>
      $base.as((v, t, t2) => _UserProfileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserProfileCopyWith<$R, $In extends UserProfile, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? profilePicture});
  UserProfileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserProfileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserProfile, $Out>
    implements UserProfileCopyWith<$R, UserProfile, $Out> {
  _UserProfileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserProfile> $mapper =
      UserProfileMapper.ensureInitialized();
  @override
  $R call({Object? profilePicture = $none}) => $apply(
    FieldCopyWithData({
      if (profilePicture != $none) #profilePicture: profilePicture,
    }),
  );
  @override
  UserProfile $make(CopyWithData data) => UserProfile(
    profilePicture: data.get(#profilePicture, or: $value.profilePicture),
  );

  @override
  UserProfileCopyWith<$R2, UserProfile, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserProfileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ReportImageMapper extends ClassMapperBase<ReportImage> {
  ReportImageMapper._();

  static ReportImageMapper? _instance;
  static ReportImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ReportImageMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ReportImage';

  static String _$id(ReportImage v) => v.id;
  static const Field<ReportImage, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$imageUrl(ReportImage v) => v.imageUrl;
  static const Field<ReportImage, String> _f$imageUrl = Field(
    'imageUrl',
    _$imageUrl,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<ReportImage> fields = const {
    #id: _f$id,
    #imageUrl: _f$imageUrl,
  };

  static ReportImage _instantiate(DecodingData data) {
    return ReportImage(id: data.dec(_f$id), imageUrl: data.dec(_f$imageUrl));
  }

  @override
  final Function instantiate = _instantiate;

  static ReportImage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ReportImage>(map);
  }

  static ReportImage fromJson(String json) {
    return ensureInitialized().decodeJson<ReportImage>(json);
  }
}

mixin ReportImageMappable {
  String toJson() {
    return ReportImageMapper.ensureInitialized().encodeJson<ReportImage>(
      this as ReportImage,
    );
  }

  Map<String, dynamic> toMap() {
    return ReportImageMapper.ensureInitialized().encodeMap<ReportImage>(
      this as ReportImage,
    );
  }

  ReportImageCopyWith<ReportImage, ReportImage, ReportImage> get copyWith =>
      _ReportImageCopyWithImpl<ReportImage, ReportImage>(
        this as ReportImage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ReportImageMapper.ensureInitialized().stringifyValue(
      this as ReportImage,
    );
  }

  @override
  bool operator ==(Object other) {
    return ReportImageMapper.ensureInitialized().equalsValue(
      this as ReportImage,
      other,
    );
  }

  @override
  int get hashCode {
    return ReportImageMapper.ensureInitialized().hashValue(this as ReportImage);
  }
}

extension ReportImageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ReportImage, $Out> {
  ReportImageCopyWith<$R, ReportImage, $Out> get $asReportImage =>
      $base.as((v, t, t2) => _ReportImageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ReportImageCopyWith<$R, $In extends ReportImage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? imageUrl});
  ReportImageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ReportImageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ReportImage, $Out>
    implements ReportImageCopyWith<$R, ReportImage, $Out> {
  _ReportImageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ReportImage> $mapper =
      ReportImageMapper.ensureInitialized();
  @override
  $R call({String? id, String? imageUrl}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (imageUrl != null) #imageUrl: imageUrl,
    }),
  );
  @override
  ReportImage $make(CopyWithData data) => ReportImage(
    id: data.get(#id, or: $value.id),
    imageUrl: data.get(#imageUrl, or: $value.imageUrl),
  );

  @override
  ReportImageCopyWith<$R2, ReportImage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ReportImageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class FinderMapper extends ClassMapperBase<Finder> {
  FinderMapper._();

  static FinderMapper? _instance;
  static FinderMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FinderMapper._());
      UserProfileMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Finder';

  static String _$id(Finder v) => v.id;
  static const Field<Finder, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$name(Finder v) => v.name;
  static const Field<Finder, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
  );
  static String? _$phone(Finder v) => v.phone;
  static const Field<Finder, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
  );
  static UserProfile _$profile(Finder v) => v.profile;
  static const Field<Finder, UserProfile> _f$profile = Field(
    'profile',
    _$profile,
    opt: true,
    def: const UserProfile(),
  );

  @override
  final MappableFields<Finder> fields = const {
    #id: _f$id,
    #name: _f$name,
    #phone: _f$phone,
    #profile: _f$profile,
  };

  static Finder _instantiate(DecodingData data) {
    return Finder(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      phone: data.dec(_f$phone),
      profile: data.dec(_f$profile),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Finder fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Finder>(map);
  }

  static Finder fromJson(String json) {
    return ensureInitialized().decodeJson<Finder>(json);
  }
}

mixin FinderMappable {
  String toJson() {
    return FinderMapper.ensureInitialized().encodeJson<Finder>(this as Finder);
  }

  Map<String, dynamic> toMap() {
    return FinderMapper.ensureInitialized().encodeMap<Finder>(this as Finder);
  }

  FinderCopyWith<Finder, Finder, Finder> get copyWith =>
      _FinderCopyWithImpl<Finder, Finder>(this as Finder, $identity, $identity);
  @override
  String toString() {
    return FinderMapper.ensureInitialized().stringifyValue(this as Finder);
  }

  @override
  bool operator ==(Object other) {
    return FinderMapper.ensureInitialized().equalsValue(this as Finder, other);
  }

  @override
  int get hashCode {
    return FinderMapper.ensureInitialized().hashValue(this as Finder);
  }
}

extension FinderValueCopy<$R, $Out> on ObjectCopyWith<$R, Finder, $Out> {
  FinderCopyWith<$R, Finder, $Out> get $asFinder =>
      $base.as((v, t, t2) => _FinderCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FinderCopyWith<$R, $In extends Finder, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  UserProfileCopyWith<$R, UserProfile, UserProfile> get profile;
  $R call({String? id, String? name, String? phone, UserProfile? profile});
  FinderCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FinderCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Finder, $Out>
    implements FinderCopyWith<$R, Finder, $Out> {
  _FinderCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Finder> $mapper = FinderMapper.ensureInitialized();
  @override
  UserProfileCopyWith<$R, UserProfile, UserProfile> get profile =>
      $value.profile.copyWith.$chain((v) => call(profile: v));
  @override
  $R call({
    String? id,
    String? name,
    Object? phone = $none,
    UserProfile? profile,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (phone != $none) #phone: phone,
      if (profile != null) #profile: profile,
    }),
  );
  @override
  Finder $make(CopyWithData data) => Finder(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    phone: data.get(#phone, or: $value.phone),
    profile: data.get(#profile, or: $value.profile),
  );

  @override
  FinderCopyWith<$R2, Finder, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FinderCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

