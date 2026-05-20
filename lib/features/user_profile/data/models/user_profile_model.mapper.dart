// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_profile_model.dart';

class UserProfileModelMapper extends ClassMapperBase<UserProfileModel> {
  UserProfileModelMapper._();

  static UserProfileModelMapper? _instance;
  static UserProfileModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserProfileModelMapper._());
      ParentGroupModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UserProfileModel';

  static String _$id(UserProfileModel v) => v.id;
  static const Field<UserProfileModel, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$name(UserProfileModel v) => v.name;
  static const Field<UserProfileModel, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$role(UserProfileModel v) => v.role;
  static const Field<UserProfileModel, String> _f$role = Field(
    'role',
    _$role,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static List<ParentGroupModel> _$parentGroups(UserProfileModel v) =>
      v.parentGroups;
  static const Field<UserProfileModel, List<ParentGroupModel>> _f$parentGroups =
      Field(
        'parentGroups',
        _$parentGroups,
        opt: true,
        def: const <ParentGroupModel>[],
      );

  @override
  final MappableFields<UserProfileModel> fields = const {
    #id: _f$id,
    #name: _f$name,
    #role: _f$role,
    #parentGroups: _f$parentGroups,
  };

  static UserProfileModel _instantiate(DecodingData data) {
    return UserProfileModel(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      role: data.dec(_f$role),
      parentGroups: data.dec(_f$parentGroups),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static UserProfileModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserProfileModel>(map);
  }

  static UserProfileModel fromJson(String json) {
    return ensureInitialized().decodeJson<UserProfileModel>(json);
  }
}

mixin UserProfileModelMappable {
  String toJson() {
    return UserProfileModelMapper.ensureInitialized()
        .encodeJson<UserProfileModel>(this as UserProfileModel);
  }

  Map<String, dynamic> toMap() {
    return UserProfileModelMapper.ensureInitialized()
        .encodeMap<UserProfileModel>(this as UserProfileModel);
  }

  UserProfileModelCopyWith<UserProfileModel, UserProfileModel, UserProfileModel>
  get copyWith =>
      _UserProfileModelCopyWithImpl<UserProfileModel, UserProfileModel>(
        this as UserProfileModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return UserProfileModelMapper.ensureInitialized().stringifyValue(
      this as UserProfileModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserProfileModelMapper.ensureInitialized().equalsValue(
      this as UserProfileModel,
      other,
    );
  }

  @override
  int get hashCode {
    return UserProfileModelMapper.ensureInitialized().hashValue(
      this as UserProfileModel,
    );
  }
}

extension UserProfileModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserProfileModel, $Out> {
  UserProfileModelCopyWith<$R, UserProfileModel, $Out>
  get $asUserProfileModel =>
      $base.as((v, t, t2) => _UserProfileModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserProfileModelCopyWith<$R, $In extends UserProfileModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    ParentGroupModel,
    ParentGroupModelCopyWith<$R, ParentGroupModel, ParentGroupModel>
  >
  get parentGroups;
  $R call({
    String? id,
    String? name,
    String? role,
    List<ParentGroupModel>? parentGroups,
  });
  UserProfileModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _UserProfileModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserProfileModel, $Out>
    implements UserProfileModelCopyWith<$R, UserProfileModel, $Out> {
  _UserProfileModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserProfileModel> $mapper =
      UserProfileModelMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    ParentGroupModel,
    ParentGroupModelCopyWith<$R, ParentGroupModel, ParentGroupModel>
  >
  get parentGroups => ListCopyWith(
    $value.parentGroups,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(parentGroups: v),
  );
  @override
  $R call({
    String? id,
    String? name,
    String? role,
    List<ParentGroupModel>? parentGroups,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (role != null) #role: role,
      if (parentGroups != null) #parentGroups: parentGroups,
    }),
  );
  @override
  UserProfileModel $make(CopyWithData data) => UserProfileModel(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    role: data.get(#role, or: $value.role),
    parentGroups: data.get(#parentGroups, or: $value.parentGroups),
  );

  @override
  UserProfileModelCopyWith<$R2, UserProfileModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserProfileModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ParentGroupModelMapper extends ClassMapperBase<ParentGroupModel> {
  ParentGroupModelMapper._();

  static ParentGroupModelMapper? _instance;
  static ParentGroupModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ParentGroupModelMapper._());
      UserPetModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ParentGroupModel';

  static String _$id(ParentGroupModel v) => v.id;
  static const Field<ParentGroupModel, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$userRole(ParentGroupModel v) => v.userRole;
  static const Field<ParentGroupModel, String> _f$userRole = Field(
    'userRole',
    _$userRole,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static bool _$isOwner(ParentGroupModel v) => v.isOwner;
  static const Field<ParentGroupModel, bool> _f$isOwner = Field(
    'isOwner',
    _$isOwner,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static List<UserPetModel> _$pets(ParentGroupModel v) => v.pets;
  static const Field<ParentGroupModel, List<UserPetModel>> _f$pets = Field(
    'pets',
    _$pets,
    opt: true,
    def: const <UserPetModel>[],
  );

  @override
  final MappableFields<ParentGroupModel> fields = const {
    #id: _f$id,
    #userRole: _f$userRole,
    #isOwner: _f$isOwner,
    #pets: _f$pets,
  };

  static ParentGroupModel _instantiate(DecodingData data) {
    return ParentGroupModel(
      id: data.dec(_f$id),
      userRole: data.dec(_f$userRole),
      isOwner: data.dec(_f$isOwner),
      pets: data.dec(_f$pets),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ParentGroupModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ParentGroupModel>(map);
  }

  static ParentGroupModel fromJson(String json) {
    return ensureInitialized().decodeJson<ParentGroupModel>(json);
  }
}

mixin ParentGroupModelMappable {
  String toJson() {
    return ParentGroupModelMapper.ensureInitialized()
        .encodeJson<ParentGroupModel>(this as ParentGroupModel);
  }

  Map<String, dynamic> toMap() {
    return ParentGroupModelMapper.ensureInitialized()
        .encodeMap<ParentGroupModel>(this as ParentGroupModel);
  }

  ParentGroupModelCopyWith<ParentGroupModel, ParentGroupModel, ParentGroupModel>
  get copyWith =>
      _ParentGroupModelCopyWithImpl<ParentGroupModel, ParentGroupModel>(
        this as ParentGroupModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ParentGroupModelMapper.ensureInitialized().stringifyValue(
      this as ParentGroupModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ParentGroupModelMapper.ensureInitialized().equalsValue(
      this as ParentGroupModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ParentGroupModelMapper.ensureInitialized().hashValue(
      this as ParentGroupModel,
    );
  }
}

extension ParentGroupModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ParentGroupModel, $Out> {
  ParentGroupModelCopyWith<$R, ParentGroupModel, $Out>
  get $asParentGroupModel =>
      $base.as((v, t, t2) => _ParentGroupModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ParentGroupModelCopyWith<$R, $In extends ParentGroupModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    UserPetModel,
    UserPetModelCopyWith<$R, UserPetModel, UserPetModel>
  >
  get pets;
  $R call({
    String? id,
    String? userRole,
    bool? isOwner,
    List<UserPetModel>? pets,
  });
  ParentGroupModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ParentGroupModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ParentGroupModel, $Out>
    implements ParentGroupModelCopyWith<$R, ParentGroupModel, $Out> {
  _ParentGroupModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ParentGroupModel> $mapper =
      ParentGroupModelMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    UserPetModel,
    UserPetModelCopyWith<$R, UserPetModel, UserPetModel>
  >
  get pets => ListCopyWith(
    $value.pets,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(pets: v),
  );
  @override
  $R call({
    String? id,
    String? userRole,
    bool? isOwner,
    List<UserPetModel>? pets,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (userRole != null) #userRole: userRole,
      if (isOwner != null) #isOwner: isOwner,
      if (pets != null) #pets: pets,
    }),
  );
  @override
  ParentGroupModel $make(CopyWithData data) => ParentGroupModel(
    id: data.get(#id, or: $value.id),
    userRole: data.get(#userRole, or: $value.userRole),
    isOwner: data.get(#isOwner, or: $value.isOwner),
    pets: data.get(#pets, or: $value.pets),
  );

  @override
  ParentGroupModelCopyWith<$R2, ParentGroupModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ParentGroupModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class UserPetModelMapper extends ClassMapperBase<UserPetModel> {
  UserPetModelMapper._();

  static UserPetModelMapper? _instance;
  static UserPetModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserPetModelMapper._());
      BreedInfoModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UserPetModel';

  static String _$id(UserPetModel v) => v.id;
  static const Field<UserPetModel, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$name(UserPetModel v) => v.name;
  static const Field<UserPetModel, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$type(UserPetModel v) => v.type;
  static const Field<UserPetModel, String> _f$type = Field(
    'type',
    _$type,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$breedId(UserPetModel v) => v.breedId;
  static const Field<UserPetModel, String> _f$breedId = Field(
    'breedId',
    _$breedId,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$gender(UserPetModel v) => v.gender;
  static const Field<UserPetModel, String> _f$gender = Field(
    'gender',
    _$gender,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$dob(UserPetModel v) => v.dob;
  static const Field<UserPetModel, String> _f$dob = Field(
    'dob',
    _$dob,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String? _$size(UserPetModel v) => v.size;
  static const Field<UserPetModel, String> _f$size = Field(
    'size',
    _$size,
    opt: true,
    hook: SafeStringHook(),
  );
  static double _$weight(UserPetModel v) => v.weight;
  static const Field<UserPetModel, double> _f$weight = Field(
    'weight',
    _$weight,
    opt: true,
    def: 0,
    hook: SafeDoubleHook(),
  );
  static double _$height(UserPetModel v) => v.height;
  static const Field<UserPetModel, double> _f$height = Field(
    'height',
    _$height,
    opt: true,
    def: 0,
    hook: SafeDoubleHook(),
  );
  static String _$weightUnit(UserPetModel v) => v.weightUnit;
  static const Field<UserPetModel, String> _f$weightUnit = Field(
    'weightUnit',
    _$weightUnit,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$heightUnit(UserPetModel v) => v.heightUnit;
  static const Field<UserPetModel, String> _f$heightUnit = Field(
    'heightUnit',
    _$heightUnit,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static int _$bcsScore(UserPetModel v) => v.bcsScore;
  static const Field<UserPetModel, int> _f$bcsScore = Field(
    'bcsScore',
    _$bcsScore,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );
  static String? _$healthInfo(UserPetModel v) => v.healthInfo;
  static const Field<UserPetModel, String> _f$healthInfo = Field(
    'healthInfo',
    _$healthInfo,
    opt: true,
    hook: SafeStringHook(),
  );
  static String? _$profilePicture(UserPetModel v) => v.profilePicture;
  static const Field<UserPetModel, String> _f$profilePicture = Field(
    'profilePicture',
    _$profilePicture,
    opt: true,
    hook: SafeStringHook(),
  );
  static BreedInfoModel? _$breedInfo(UserPetModel v) => v.breedInfo;
  static const Field<UserPetModel, BreedInfoModel> _f$breedInfo = Field(
    'breedInfo',
    _$breedInfo,
    opt: true,
  );

  @override
  final MappableFields<UserPetModel> fields = const {
    #id: _f$id,
    #name: _f$name,
    #type: _f$type,
    #breedId: _f$breedId,
    #gender: _f$gender,
    #dob: _f$dob,
    #size: _f$size,
    #weight: _f$weight,
    #height: _f$height,
    #weightUnit: _f$weightUnit,
    #heightUnit: _f$heightUnit,
    #bcsScore: _f$bcsScore,
    #healthInfo: _f$healthInfo,
    #profilePicture: _f$profilePicture,
    #breedInfo: _f$breedInfo,
  };

  static UserPetModel _instantiate(DecodingData data) {
    return UserPetModel(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      type: data.dec(_f$type),
      breedId: data.dec(_f$breedId),
      gender: data.dec(_f$gender),
      dob: data.dec(_f$dob),
      size: data.dec(_f$size),
      weight: data.dec(_f$weight),
      height: data.dec(_f$height),
      weightUnit: data.dec(_f$weightUnit),
      heightUnit: data.dec(_f$heightUnit),
      bcsScore: data.dec(_f$bcsScore),
      healthInfo: data.dec(_f$healthInfo),
      profilePicture: data.dec(_f$profilePicture),
      breedInfo: data.dec(_f$breedInfo),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static UserPetModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserPetModel>(map);
  }

  static UserPetModel fromJson(String json) {
    return ensureInitialized().decodeJson<UserPetModel>(json);
  }
}

mixin UserPetModelMappable {
  String toJson() {
    return UserPetModelMapper.ensureInitialized().encodeJson<UserPetModel>(
      this as UserPetModel,
    );
  }

  Map<String, dynamic> toMap() {
    return UserPetModelMapper.ensureInitialized().encodeMap<UserPetModel>(
      this as UserPetModel,
    );
  }

  UserPetModelCopyWith<UserPetModel, UserPetModel, UserPetModel> get copyWith =>
      _UserPetModelCopyWithImpl<UserPetModel, UserPetModel>(
        this as UserPetModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return UserPetModelMapper.ensureInitialized().stringifyValue(
      this as UserPetModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserPetModelMapper.ensureInitialized().equalsValue(
      this as UserPetModel,
      other,
    );
  }

  @override
  int get hashCode {
    return UserPetModelMapper.ensureInitialized().hashValue(
      this as UserPetModel,
    );
  }
}

extension UserPetModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserPetModel, $Out> {
  UserPetModelCopyWith<$R, UserPetModel, $Out> get $asUserPetModel =>
      $base.as((v, t, t2) => _UserPetModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserPetModelCopyWith<$R, $In extends UserPetModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  BreedInfoModelCopyWith<$R, BreedInfoModel, BreedInfoModel>? get breedInfo;
  $R call({
    String? id,
    String? name,
    String? type,
    String? breedId,
    String? gender,
    String? dob,
    String? size,
    double? weight,
    double? height,
    String? weightUnit,
    String? heightUnit,
    int? bcsScore,
    String? healthInfo,
    String? profilePicture,
    BreedInfoModel? breedInfo,
  });
  UserPetModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserPetModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserPetModel, $Out>
    implements UserPetModelCopyWith<$R, UserPetModel, $Out> {
  _UserPetModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserPetModel> $mapper =
      UserPetModelMapper.ensureInitialized();
  @override
  BreedInfoModelCopyWith<$R, BreedInfoModel, BreedInfoModel>? get breedInfo =>
      $value.breedInfo?.copyWith.$chain((v) => call(breedInfo: v));
  @override
  $R call({
    String? id,
    String? name,
    String? type,
    String? breedId,
    String? gender,
    String? dob,
    Object? size = $none,
    double? weight,
    double? height,
    String? weightUnit,
    String? heightUnit,
    int? bcsScore,
    Object? healthInfo = $none,
    Object? profilePicture = $none,
    Object? breedInfo = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (type != null) #type: type,
      if (breedId != null) #breedId: breedId,
      if (gender != null) #gender: gender,
      if (dob != null) #dob: dob,
      if (size != $none) #size: size,
      if (weight != null) #weight: weight,
      if (height != null) #height: height,
      if (weightUnit != null) #weightUnit: weightUnit,
      if (heightUnit != null) #heightUnit: heightUnit,
      if (bcsScore != null) #bcsScore: bcsScore,
      if (healthInfo != $none) #healthInfo: healthInfo,
      if (profilePicture != $none) #profilePicture: profilePicture,
      if (breedInfo != $none) #breedInfo: breedInfo,
    }),
  );
  @override
  UserPetModel $make(CopyWithData data) => UserPetModel(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    type: data.get(#type, or: $value.type),
    breedId: data.get(#breedId, or: $value.breedId),
    gender: data.get(#gender, or: $value.gender),
    dob: data.get(#dob, or: $value.dob),
    size: data.get(#size, or: $value.size),
    weight: data.get(#weight, or: $value.weight),
    height: data.get(#height, or: $value.height),
    weightUnit: data.get(#weightUnit, or: $value.weightUnit),
    heightUnit: data.get(#heightUnit, or: $value.heightUnit),
    bcsScore: data.get(#bcsScore, or: $value.bcsScore),
    healthInfo: data.get(#healthInfo, or: $value.healthInfo),
    profilePicture: data.get(#profilePicture, or: $value.profilePicture),
    breedInfo: data.get(#breedInfo, or: $value.breedInfo),
  );

  @override
  UserPetModelCopyWith<$R2, UserPetModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserPetModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class BreedInfoModelMapper extends ClassMapperBase<BreedInfoModel> {
  BreedInfoModelMapper._();

  static BreedInfoModelMapper? _instance;
  static BreedInfoModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BreedInfoModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BreedInfoModel';

  static String _$breedName(BreedInfoModel v) => v.breedName;
  static const Field<BreedInfoModel, String> _f$breedName = Field(
    'breedName',
    _$breedName,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<BreedInfoModel> fields = const {
    #breedName: _f$breedName,
  };

  static BreedInfoModel _instantiate(DecodingData data) {
    return BreedInfoModel(breedName: data.dec(_f$breedName));
  }

  @override
  final Function instantiate = _instantiate;

  static BreedInfoModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BreedInfoModel>(map);
  }

  static BreedInfoModel fromJson(String json) {
    return ensureInitialized().decodeJson<BreedInfoModel>(json);
  }
}

mixin BreedInfoModelMappable {
  String toJson() {
    return BreedInfoModelMapper.ensureInitialized().encodeJson<BreedInfoModel>(
      this as BreedInfoModel,
    );
  }

  Map<String, dynamic> toMap() {
    return BreedInfoModelMapper.ensureInitialized().encodeMap<BreedInfoModel>(
      this as BreedInfoModel,
    );
  }

  BreedInfoModelCopyWith<BreedInfoModel, BreedInfoModel, BreedInfoModel>
  get copyWith => _BreedInfoModelCopyWithImpl<BreedInfoModel, BreedInfoModel>(
    this as BreedInfoModel,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return BreedInfoModelMapper.ensureInitialized().stringifyValue(
      this as BreedInfoModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return BreedInfoModelMapper.ensureInitialized().equalsValue(
      this as BreedInfoModel,
      other,
    );
  }

  @override
  int get hashCode {
    return BreedInfoModelMapper.ensureInitialized().hashValue(
      this as BreedInfoModel,
    );
  }
}

extension BreedInfoModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BreedInfoModel, $Out> {
  BreedInfoModelCopyWith<$R, BreedInfoModel, $Out> get $asBreedInfoModel =>
      $base.as((v, t, t2) => _BreedInfoModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BreedInfoModelCopyWith<$R, $In extends BreedInfoModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? breedName});
  BreedInfoModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _BreedInfoModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BreedInfoModel, $Out>
    implements BreedInfoModelCopyWith<$R, BreedInfoModel, $Out> {
  _BreedInfoModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BreedInfoModel> $mapper =
      BreedInfoModelMapper.ensureInitialized();
  @override
  $R call({String? breedName}) =>
      $apply(FieldCopyWithData({if (breedName != null) #breedName: breedName}));
  @override
  BreedInfoModel $make(CopyWithData data) =>
      BreedInfoModel(breedName: data.get(#breedName, or: $value.breedName));

  @override
  BreedInfoModelCopyWith<$R2, BreedInfoModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BreedInfoModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

