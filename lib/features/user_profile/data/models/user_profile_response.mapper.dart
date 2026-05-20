// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_profile_response.dart';

class UserProfileResponseMapper extends ClassMapperBase<UserProfileResponse> {
  UserProfileResponseMapper._();

  static UserProfileResponseMapper? _instance;
  static UserProfileResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserProfileResponseMapper._());
      UserProfileDetailsResponseMapper.ensureInitialized();
      ParentGroupResponseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UserProfileResponse';

  static String _$id(UserProfileResponse v) => v.id;
  static const Field<UserProfileResponse, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$name(UserProfileResponse v) => v.name;
  static const Field<UserProfileResponse, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$email(UserProfileResponse v) => v.email;
  static const Field<UserProfileResponse, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$phone(UserProfileResponse v) => v.phone;
  static const Field<UserProfileResponse, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$primaryIdentifier(UserProfileResponse v) =>
      v.primaryIdentifier;
  static const Field<UserProfileResponse, String> _f$primaryIdentifier = Field(
    'primaryIdentifier',
    _$primaryIdentifier,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$countryCode(UserProfileResponse v) => v.countryCode;
  static const Field<UserProfileResponse, String> _f$countryCode = Field(
    'countryCode',
    _$countryCode,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$country(UserProfileResponse v) => v.country;
  static const Field<UserProfileResponse, String> _f$country = Field(
    'country',
    _$country,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$provider(UserProfileResponse v) => v.provider;
  static const Field<UserProfileResponse, String> _f$provider = Field(
    'provider',
    _$provider,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$providerId(UserProfileResponse v) => v.providerId;
  static const Field<UserProfileResponse, String> _f$providerId = Field(
    'providerId',
    _$providerId,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static bool _$isSocialLogin(UserProfileResponse v) => v.isSocialLogin;
  static const Field<UserProfileResponse, bool> _f$isSocialLogin = Field(
    'isSocialLogin',
    _$isSocialLogin,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static String _$role(UserProfileResponse v) => v.role;
  static const Field<UserProfileResponse, String> _f$role = Field(
    'role',
    _$role,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static bool _$isVerified(UserProfileResponse v) => v.isVerified;
  static const Field<UserProfileResponse, bool> _f$isVerified = Field(
    'isVerified',
    _$isVerified,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static bool _$isActive(UserProfileResponse v) => v.isActive;
  static const Field<UserProfileResponse, bool> _f$isActive = Field(
    'isActive',
    _$isActive,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static bool _$isDeleted(UserProfileResponse v) => v.isDeleted;
  static const Field<UserProfileResponse, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static String _$deletedBy(UserProfileResponse v) => v.deletedBy;
  static const Field<UserProfileResponse, String> _f$deletedBy = Field(
    'deletedBy',
    _$deletedBy,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$deletedAt(UserProfileResponse v) => v.deletedAt;
  static const Field<UserProfileResponse, String> _f$deletedAt = Field(
    'deletedAt',
    _$deletedAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$deletedAtLegacy(UserProfileResponse v) => v.deletedAtLegacy;
  static const Field<UserProfileResponse, String> _f$deletedAtLegacy = Field(
    'deletedAtLegacy',
    _$deletedAtLegacy,
    key: r'deleted_at',
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$deletionReason(UserProfileResponse v) => v.deletionReason;
  static const Field<UserProfileResponse, String> _f$deletionReason = Field(
    'deletionReason',
    _$deletionReason,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static bool _$isOnboarded(UserProfileResponse v) => v.isOnboarded;
  static const Field<UserProfileResponse, bool> _f$isOnboarded = Field(
    'isOnboarded',
    _$isOnboarded,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static bool _$isProfileCompleted(UserProfileResponse v) =>
      v.isProfileCompleted;
  static const Field<UserProfileResponse, bool> _f$isProfileCompleted = Field(
    'isProfileCompleted',
    _$isProfileCompleted,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static bool _$isPetOnboarded(UserProfileResponse v) => v.isPetOnboarded;
  static const Field<UserProfileResponse, bool> _f$isPetOnboarded = Field(
    'isPetOnboarded',
    _$isPetOnboarded,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static bool _$hasBoughtPet(UserProfileResponse v) => v.hasBoughtPet;
  static const Field<UserProfileResponse, bool> _f$hasBoughtPet = Field(
    'hasBoughtPet',
    _$hasBoughtPet,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static int _$points(UserProfileResponse v) => v.points;
  static const Field<UserProfileResponse, int> _f$points = Field(
    'points',
    _$points,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );
  static String _$createdAt(UserProfileResponse v) => v.createdAt;
  static const Field<UserProfileResponse, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$updatedAt(UserProfileResponse v) => v.updatedAt;
  static const Field<UserProfileResponse, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$createdAtLegacy(UserProfileResponse v) => v.createdAtLegacy;
  static const Field<UserProfileResponse, String> _f$createdAtLegacy = Field(
    'createdAtLegacy',
    _$createdAtLegacy,
    key: r'created_at',
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$updatedAtLegacy(UserProfileResponse v) => v.updatedAtLegacy;
  static const Field<UserProfileResponse, String> _f$updatedAtLegacy = Field(
    'updatedAtLegacy',
    _$updatedAtLegacy,
    key: r'updated_at',
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static UserProfileDetailsResponse? _$profile(UserProfileResponse v) =>
      v.profile;
  static const Field<UserProfileResponse, UserProfileDetailsResponse>
  _f$profile = Field('profile', _$profile, opt: true);
  static List<ParentGroupResponse> _$parentGroups(UserProfileResponse v) =>
      v.parentGroups;
  static const Field<UserProfileResponse, List<ParentGroupResponse>>
  _f$parentGroups = Field(
    'parentGroups',
    _$parentGroups,
    opt: true,
    def: const <ParentGroupResponse>[],
  );
  static List<dynamic> _$invites(UserProfileResponse v) => v.invites;
  static const Field<UserProfileResponse, List<dynamic>> _f$invites = Field(
    'invites',
    _$invites,
    opt: true,
    def: const <dynamic>[],
  );

  @override
  final MappableFields<UserProfileResponse> fields = const {
    #id: _f$id,
    #name: _f$name,
    #email: _f$email,
    #phone: _f$phone,
    #primaryIdentifier: _f$primaryIdentifier,
    #countryCode: _f$countryCode,
    #country: _f$country,
    #provider: _f$provider,
    #providerId: _f$providerId,
    #isSocialLogin: _f$isSocialLogin,
    #role: _f$role,
    #isVerified: _f$isVerified,
    #isActive: _f$isActive,
    #isDeleted: _f$isDeleted,
    #deletedBy: _f$deletedBy,
    #deletedAt: _f$deletedAt,
    #deletedAtLegacy: _f$deletedAtLegacy,
    #deletionReason: _f$deletionReason,
    #isOnboarded: _f$isOnboarded,
    #isProfileCompleted: _f$isProfileCompleted,
    #isPetOnboarded: _f$isPetOnboarded,
    #hasBoughtPet: _f$hasBoughtPet,
    #points: _f$points,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #createdAtLegacy: _f$createdAtLegacy,
    #updatedAtLegacy: _f$updatedAtLegacy,
    #profile: _f$profile,
    #parentGroups: _f$parentGroups,
    #invites: _f$invites,
  };

  static UserProfileResponse _instantiate(DecodingData data) {
    return UserProfileResponse(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      email: data.dec(_f$email),
      phone: data.dec(_f$phone),
      primaryIdentifier: data.dec(_f$primaryIdentifier),
      countryCode: data.dec(_f$countryCode),
      country: data.dec(_f$country),
      provider: data.dec(_f$provider),
      providerId: data.dec(_f$providerId),
      isSocialLogin: data.dec(_f$isSocialLogin),
      role: data.dec(_f$role),
      isVerified: data.dec(_f$isVerified),
      isActive: data.dec(_f$isActive),
      isDeleted: data.dec(_f$isDeleted),
      deletedBy: data.dec(_f$deletedBy),
      deletedAt: data.dec(_f$deletedAt),
      deletedAtLegacy: data.dec(_f$deletedAtLegacy),
      deletionReason: data.dec(_f$deletionReason),
      isOnboarded: data.dec(_f$isOnboarded),
      isProfileCompleted: data.dec(_f$isProfileCompleted),
      isPetOnboarded: data.dec(_f$isPetOnboarded),
      hasBoughtPet: data.dec(_f$hasBoughtPet),
      points: data.dec(_f$points),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      createdAtLegacy: data.dec(_f$createdAtLegacy),
      updatedAtLegacy: data.dec(_f$updatedAtLegacy),
      profile: data.dec(_f$profile),
      parentGroups: data.dec(_f$parentGroups),
      invites: data.dec(_f$invites),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static UserProfileResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserProfileResponse>(map);
  }

  static UserProfileResponse fromJson(String json) {
    return ensureInitialized().decodeJson<UserProfileResponse>(json);
  }
}

mixin UserProfileResponseMappable {
  String toJson() {
    return UserProfileResponseMapper.ensureInitialized()
        .encodeJson<UserProfileResponse>(this as UserProfileResponse);
  }

  Map<String, dynamic> toMap() {
    return UserProfileResponseMapper.ensureInitialized()
        .encodeMap<UserProfileResponse>(this as UserProfileResponse);
  }

  UserProfileResponseCopyWith<
    UserProfileResponse,
    UserProfileResponse,
    UserProfileResponse
  >
  get copyWith =>
      _UserProfileResponseCopyWithImpl<
        UserProfileResponse,
        UserProfileResponse
      >(this as UserProfileResponse, $identity, $identity);
  @override
  String toString() {
    return UserProfileResponseMapper.ensureInitialized().stringifyValue(
      this as UserProfileResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserProfileResponseMapper.ensureInitialized().equalsValue(
      this as UserProfileResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return UserProfileResponseMapper.ensureInitialized().hashValue(
      this as UserProfileResponse,
    );
  }
}

extension UserProfileResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserProfileResponse, $Out> {
  UserProfileResponseCopyWith<$R, UserProfileResponse, $Out>
  get $asUserProfileResponse => $base.as(
    (v, t, t2) => _UserProfileResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class UserProfileResponseCopyWith<
  $R,
  $In extends UserProfileResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  UserProfileDetailsResponseCopyWith<
    $R,
    UserProfileDetailsResponse,
    UserProfileDetailsResponse
  >?
  get profile;
  ListCopyWith<
    $R,
    ParentGroupResponse,
    ParentGroupResponseCopyWith<$R, ParentGroupResponse, ParentGroupResponse>
  >
  get parentGroups;
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?> get invites;
  $R call({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? primaryIdentifier,
    String? countryCode,
    String? country,
    String? provider,
    String? providerId,
    bool? isSocialLogin,
    String? role,
    bool? isVerified,
    bool? isActive,
    bool? isDeleted,
    String? deletedBy,
    String? deletedAt,
    String? deletedAtLegacy,
    String? deletionReason,
    bool? isOnboarded,
    bool? isProfileCompleted,
    bool? isPetOnboarded,
    bool? hasBoughtPet,
    int? points,
    String? createdAt,
    String? updatedAt,
    String? createdAtLegacy,
    String? updatedAtLegacy,
    UserProfileDetailsResponse? profile,
    List<ParentGroupResponse>? parentGroups,
    List<dynamic>? invites,
  });
  UserProfileResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _UserProfileResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserProfileResponse, $Out>
    implements UserProfileResponseCopyWith<$R, UserProfileResponse, $Out> {
  _UserProfileResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserProfileResponse> $mapper =
      UserProfileResponseMapper.ensureInitialized();
  @override
  UserProfileDetailsResponseCopyWith<
    $R,
    UserProfileDetailsResponse,
    UserProfileDetailsResponse
  >?
  get profile => $value.profile?.copyWith.$chain((v) => call(profile: v));
  @override
  ListCopyWith<
    $R,
    ParentGroupResponse,
    ParentGroupResponseCopyWith<$R, ParentGroupResponse, ParentGroupResponse>
  >
  get parentGroups => ListCopyWith(
    $value.parentGroups,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(parentGroups: v),
  );
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get invites => ListCopyWith(
    $value.invites,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(invites: v),
  );
  @override
  $R call({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? primaryIdentifier,
    String? countryCode,
    String? country,
    String? provider,
    String? providerId,
    bool? isSocialLogin,
    String? role,
    bool? isVerified,
    bool? isActive,
    bool? isDeleted,
    String? deletedBy,
    String? deletedAt,
    String? deletedAtLegacy,
    String? deletionReason,
    bool? isOnboarded,
    bool? isProfileCompleted,
    bool? isPetOnboarded,
    bool? hasBoughtPet,
    int? points,
    String? createdAt,
    String? updatedAt,
    String? createdAtLegacy,
    String? updatedAtLegacy,
    Object? profile = $none,
    List<ParentGroupResponse>? parentGroups,
    List<dynamic>? invites,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (email != null) #email: email,
      if (phone != null) #phone: phone,
      if (primaryIdentifier != null) #primaryIdentifier: primaryIdentifier,
      if (countryCode != null) #countryCode: countryCode,
      if (country != null) #country: country,
      if (provider != null) #provider: provider,
      if (providerId != null) #providerId: providerId,
      if (isSocialLogin != null) #isSocialLogin: isSocialLogin,
      if (role != null) #role: role,
      if (isVerified != null) #isVerified: isVerified,
      if (isActive != null) #isActive: isActive,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (deletedBy != null) #deletedBy: deletedBy,
      if (deletedAt != null) #deletedAt: deletedAt,
      if (deletedAtLegacy != null) #deletedAtLegacy: deletedAtLegacy,
      if (deletionReason != null) #deletionReason: deletionReason,
      if (isOnboarded != null) #isOnboarded: isOnboarded,
      if (isProfileCompleted != null) #isProfileCompleted: isProfileCompleted,
      if (isPetOnboarded != null) #isPetOnboarded: isPetOnboarded,
      if (hasBoughtPet != null) #hasBoughtPet: hasBoughtPet,
      if (points != null) #points: points,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
      if (createdAtLegacy != null) #createdAtLegacy: createdAtLegacy,
      if (updatedAtLegacy != null) #updatedAtLegacy: updatedAtLegacy,
      if (profile != $none) #profile: profile,
      if (parentGroups != null) #parentGroups: parentGroups,
      if (invites != null) #invites: invites,
    }),
  );
  @override
  UserProfileResponse $make(CopyWithData data) => UserProfileResponse(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    email: data.get(#email, or: $value.email),
    phone: data.get(#phone, or: $value.phone),
    primaryIdentifier: data.get(
      #primaryIdentifier,
      or: $value.primaryIdentifier,
    ),
    countryCode: data.get(#countryCode, or: $value.countryCode),
    country: data.get(#country, or: $value.country),
    provider: data.get(#provider, or: $value.provider),
    providerId: data.get(#providerId, or: $value.providerId),
    isSocialLogin: data.get(#isSocialLogin, or: $value.isSocialLogin),
    role: data.get(#role, or: $value.role),
    isVerified: data.get(#isVerified, or: $value.isVerified),
    isActive: data.get(#isActive, or: $value.isActive),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    deletedBy: data.get(#deletedBy, or: $value.deletedBy),
    deletedAt: data.get(#deletedAt, or: $value.deletedAt),
    deletedAtLegacy: data.get(#deletedAtLegacy, or: $value.deletedAtLegacy),
    deletionReason: data.get(#deletionReason, or: $value.deletionReason),
    isOnboarded: data.get(#isOnboarded, or: $value.isOnboarded),
    isProfileCompleted: data.get(
      #isProfileCompleted,
      or: $value.isProfileCompleted,
    ),
    isPetOnboarded: data.get(#isPetOnboarded, or: $value.isPetOnboarded),
    hasBoughtPet: data.get(#hasBoughtPet, or: $value.hasBoughtPet),
    points: data.get(#points, or: $value.points),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    createdAtLegacy: data.get(#createdAtLegacy, or: $value.createdAtLegacy),
    updatedAtLegacy: data.get(#updatedAtLegacy, or: $value.updatedAtLegacy),
    profile: data.get(#profile, or: $value.profile),
    parentGroups: data.get(#parentGroups, or: $value.parentGroups),
    invites: data.get(#invites, or: $value.invites),
  );

  @override
  UserProfileResponseCopyWith<$R2, UserProfileResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _UserProfileResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class UserProfileDetailsResponseMapper
    extends ClassMapperBase<UserProfileDetailsResponse> {
  UserProfileDetailsResponseMapper._();

  static UserProfileDetailsResponseMapper? _instance;
  static UserProfileDetailsResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = UserProfileDetailsResponseMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'UserProfileDetailsResponse';

  static String _$id(UserProfileDetailsResponse v) => v.id;
  static const Field<UserProfileDetailsResponse, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$userId(UserProfileDetailsResponse v) => v.userId;
  static const Field<UserProfileDetailsResponse, String> _f$userId = Field(
    'userId',
    _$userId,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$profilePicture(UserProfileDetailsResponse v) =>
      v.profilePicture;
  static const Field<UserProfileDetailsResponse, String> _f$profilePicture =
      Field(
        'profilePicture',
        _$profilePicture,
        opt: true,
        def: '',
        hook: SafeStringHook(),
      );
  static String _$dateOfBirth(UserProfileDetailsResponse v) => v.dateOfBirth;
  static const Field<UserProfileDetailsResponse, String> _f$dateOfBirth = Field(
    'dateOfBirth',
    _$dateOfBirth,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$gender(UserProfileDetailsResponse v) => v.gender;
  static const Field<UserProfileDetailsResponse, String> _f$gender = Field(
    'gender',
    _$gender,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$bio(UserProfileDetailsResponse v) => v.bio;
  static const Field<UserProfileDetailsResponse, String> _f$bio = Field(
    'bio',
    _$bio,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$languagePreference(UserProfileDetailsResponse v) =>
      v.languagePreference;
  static const Field<UserProfileDetailsResponse, String> _f$languagePreference =
      Field(
        'languagePreference',
        _$languagePreference,
        opt: true,
        def: '',
        hook: SafeStringHook(),
      );
  static String _$createdAt(UserProfileDetailsResponse v) => v.createdAt;
  static const Field<UserProfileDetailsResponse, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$updatedAt(UserProfileDetailsResponse v) => v.updatedAt;
  static const Field<UserProfileDetailsResponse, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$userIdLegacy(UserProfileDetailsResponse v) => v.userIdLegacy;
  static const Field<UserProfileDetailsResponse, String> _f$userIdLegacy =
      Field(
        'userIdLegacy',
        _$userIdLegacy,
        key: r'user_id',
        opt: true,
        def: '',
        hook: SafeStringHook(),
      );

  @override
  final MappableFields<UserProfileDetailsResponse> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #profilePicture: _f$profilePicture,
    #dateOfBirth: _f$dateOfBirth,
    #gender: _f$gender,
    #bio: _f$bio,
    #languagePreference: _f$languagePreference,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #userIdLegacy: _f$userIdLegacy,
  };

  static UserProfileDetailsResponse _instantiate(DecodingData data) {
    return UserProfileDetailsResponse(
      id: data.dec(_f$id),
      userId: data.dec(_f$userId),
      profilePicture: data.dec(_f$profilePicture),
      dateOfBirth: data.dec(_f$dateOfBirth),
      gender: data.dec(_f$gender),
      bio: data.dec(_f$bio),
      languagePreference: data.dec(_f$languagePreference),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      userIdLegacy: data.dec(_f$userIdLegacy),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static UserProfileDetailsResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserProfileDetailsResponse>(map);
  }

  static UserProfileDetailsResponse fromJson(String json) {
    return ensureInitialized().decodeJson<UserProfileDetailsResponse>(json);
  }
}

mixin UserProfileDetailsResponseMappable {
  String toJson() {
    return UserProfileDetailsResponseMapper.ensureInitialized()
        .encodeJson<UserProfileDetailsResponse>(
          this as UserProfileDetailsResponse,
        );
  }

  Map<String, dynamic> toMap() {
    return UserProfileDetailsResponseMapper.ensureInitialized()
        .encodeMap<UserProfileDetailsResponse>(
          this as UserProfileDetailsResponse,
        );
  }

  UserProfileDetailsResponseCopyWith<
    UserProfileDetailsResponse,
    UserProfileDetailsResponse,
    UserProfileDetailsResponse
  >
  get copyWith =>
      _UserProfileDetailsResponseCopyWithImpl<
        UserProfileDetailsResponse,
        UserProfileDetailsResponse
      >(this as UserProfileDetailsResponse, $identity, $identity);
  @override
  String toString() {
    return UserProfileDetailsResponseMapper.ensureInitialized().stringifyValue(
      this as UserProfileDetailsResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserProfileDetailsResponseMapper.ensureInitialized().equalsValue(
      this as UserProfileDetailsResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return UserProfileDetailsResponseMapper.ensureInitialized().hashValue(
      this as UserProfileDetailsResponse,
    );
  }
}

extension UserProfileDetailsResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserProfileDetailsResponse, $Out> {
  UserProfileDetailsResponseCopyWith<$R, UserProfileDetailsResponse, $Out>
  get $asUserProfileDetailsResponse => $base.as(
    (v, t, t2) => _UserProfileDetailsResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class UserProfileDetailsResponseCopyWith<
  $R,
  $In extends UserProfileDetailsResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? userId,
    String? profilePicture,
    String? dateOfBirth,
    String? gender,
    String? bio,
    String? languagePreference,
    String? createdAt,
    String? updatedAt,
    String? userIdLegacy,
  });
  UserProfileDetailsResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _UserProfileDetailsResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserProfileDetailsResponse, $Out>
    implements
        UserProfileDetailsResponseCopyWith<
          $R,
          UserProfileDetailsResponse,
          $Out
        > {
  _UserProfileDetailsResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserProfileDetailsResponse> $mapper =
      UserProfileDetailsResponseMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? userId,
    String? profilePicture,
    String? dateOfBirth,
    String? gender,
    String? bio,
    String? languagePreference,
    String? createdAt,
    String? updatedAt,
    String? userIdLegacy,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (userId != null) #userId: userId,
      if (profilePicture != null) #profilePicture: profilePicture,
      if (dateOfBirth != null) #dateOfBirth: dateOfBirth,
      if (gender != null) #gender: gender,
      if (bio != null) #bio: bio,
      if (languagePreference != null) #languagePreference: languagePreference,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
      if (userIdLegacy != null) #userIdLegacy: userIdLegacy,
    }),
  );
  @override
  UserProfileDetailsResponse $make(CopyWithData data) =>
      UserProfileDetailsResponse(
        id: data.get(#id, or: $value.id),
        userId: data.get(#userId, or: $value.userId),
        profilePicture: data.get(#profilePicture, or: $value.profilePicture),
        dateOfBirth: data.get(#dateOfBirth, or: $value.dateOfBirth),
        gender: data.get(#gender, or: $value.gender),
        bio: data.get(#bio, or: $value.bio),
        languagePreference: data.get(
          #languagePreference,
          or: $value.languagePreference,
        ),
        createdAt: data.get(#createdAt, or: $value.createdAt),
        updatedAt: data.get(#updatedAt, or: $value.updatedAt),
        userIdLegacy: data.get(#userIdLegacy, or: $value.userIdLegacy),
      );

  @override
  UserProfileDetailsResponseCopyWith<$R2, UserProfileDetailsResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _UserProfileDetailsResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ParentGroupResponseMapper extends ClassMapperBase<ParentGroupResponse> {
  ParentGroupResponseMapper._();

  static ParentGroupResponseMapper? _instance;
  static ParentGroupResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ParentGroupResponseMapper._());
      ParentGroupPetResponseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ParentGroupResponse';

  static String _$id(ParentGroupResponse v) => v.id;
  static const Field<ParentGroupResponse, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$userRole(ParentGroupResponse v) => v.userRole;
  static const Field<ParentGroupResponse, String> _f$userRole = Field(
    'userRole',
    _$userRole,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static bool _$isOwner(ParentGroupResponse v) => v.isOwner;
  static const Field<ParentGroupResponse, bool> _f$isOwner = Field(
    'isOwner',
    _$isOwner,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static List<ParentGroupPetResponse> _$pets(ParentGroupResponse v) => v.pets;
  static const Field<ParentGroupResponse, List<ParentGroupPetResponse>>
  _f$pets = Field(
    'pets',
    _$pets,
    opt: true,
    def: const <ParentGroupPetResponse>[],
  );
  static List<dynamic> _$members(ParentGroupResponse v) => v.members;
  static const Field<ParentGroupResponse, List<dynamic>> _f$members = Field(
    'members',
    _$members,
    opt: true,
    def: const <dynamic>[],
  );

  @override
  final MappableFields<ParentGroupResponse> fields = const {
    #id: _f$id,
    #userRole: _f$userRole,
    #isOwner: _f$isOwner,
    #pets: _f$pets,
    #members: _f$members,
  };

  static ParentGroupResponse _instantiate(DecodingData data) {
    return ParentGroupResponse(
      id: data.dec(_f$id),
      userRole: data.dec(_f$userRole),
      isOwner: data.dec(_f$isOwner),
      pets: data.dec(_f$pets),
      members: data.dec(_f$members),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ParentGroupResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ParentGroupResponse>(map);
  }

  static ParentGroupResponse fromJson(String json) {
    return ensureInitialized().decodeJson<ParentGroupResponse>(json);
  }
}

mixin ParentGroupResponseMappable {
  String toJson() {
    return ParentGroupResponseMapper.ensureInitialized()
        .encodeJson<ParentGroupResponse>(this as ParentGroupResponse);
  }

  Map<String, dynamic> toMap() {
    return ParentGroupResponseMapper.ensureInitialized()
        .encodeMap<ParentGroupResponse>(this as ParentGroupResponse);
  }

  ParentGroupResponseCopyWith<
    ParentGroupResponse,
    ParentGroupResponse,
    ParentGroupResponse
  >
  get copyWith =>
      _ParentGroupResponseCopyWithImpl<
        ParentGroupResponse,
        ParentGroupResponse
      >(this as ParentGroupResponse, $identity, $identity);
  @override
  String toString() {
    return ParentGroupResponseMapper.ensureInitialized().stringifyValue(
      this as ParentGroupResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return ParentGroupResponseMapper.ensureInitialized().equalsValue(
      this as ParentGroupResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return ParentGroupResponseMapper.ensureInitialized().hashValue(
      this as ParentGroupResponse,
    );
  }
}

extension ParentGroupResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ParentGroupResponse, $Out> {
  ParentGroupResponseCopyWith<$R, ParentGroupResponse, $Out>
  get $asParentGroupResponse => $base.as(
    (v, t, t2) => _ParentGroupResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ParentGroupResponseCopyWith<
  $R,
  $In extends ParentGroupResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    ParentGroupPetResponse,
    ParentGroupPetResponseCopyWith<
      $R,
      ParentGroupPetResponse,
      ParentGroupPetResponse
    >
  >
  get pets;
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?> get members;
  $R call({
    String? id,
    String? userRole,
    bool? isOwner,
    List<ParentGroupPetResponse>? pets,
    List<dynamic>? members,
  });
  ParentGroupResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ParentGroupResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ParentGroupResponse, $Out>
    implements ParentGroupResponseCopyWith<$R, ParentGroupResponse, $Out> {
  _ParentGroupResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ParentGroupResponse> $mapper =
      ParentGroupResponseMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    ParentGroupPetResponse,
    ParentGroupPetResponseCopyWith<
      $R,
      ParentGroupPetResponse,
      ParentGroupPetResponse
    >
  >
  get pets => ListCopyWith(
    $value.pets,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(pets: v),
  );
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get members => ListCopyWith(
    $value.members,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(members: v),
  );
  @override
  $R call({
    String? id,
    String? userRole,
    bool? isOwner,
    List<ParentGroupPetResponse>? pets,
    List<dynamic>? members,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (userRole != null) #userRole: userRole,
      if (isOwner != null) #isOwner: isOwner,
      if (pets != null) #pets: pets,
      if (members != null) #members: members,
    }),
  );
  @override
  ParentGroupResponse $make(CopyWithData data) => ParentGroupResponse(
    id: data.get(#id, or: $value.id),
    userRole: data.get(#userRole, or: $value.userRole),
    isOwner: data.get(#isOwner, or: $value.isOwner),
    pets: data.get(#pets, or: $value.pets),
    members: data.get(#members, or: $value.members),
  );

  @override
  ParentGroupResponseCopyWith<$R2, ParentGroupResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ParentGroupResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ParentGroupPetResponseMapper
    extends ClassMapperBase<ParentGroupPetResponse> {
  ParentGroupPetResponseMapper._();

  static ParentGroupPetResponseMapper? _instance;
  static ParentGroupPetResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ParentGroupPetResponseMapper._());
      BreedInfoResponseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ParentGroupPetResponse';

  static String _$id(ParentGroupPetResponse v) => v.id;
  static const Field<ParentGroupPetResponse, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$petNumber(ParentGroupPetResponse v) => v.petNumber;
  static const Field<ParentGroupPetResponse, String> _f$petNumber = Field(
    'petNumber',
    _$petNumber,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$parentGroupId(ParentGroupPetResponse v) => v.parentGroupId;
  static const Field<ParentGroupPetResponse, String> _f$parentGroupId = Field(
    'parentGroupId',
    _$parentGroupId,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$userId(ParentGroupPetResponse v) => v.userId;
  static const Field<ParentGroupPetResponse, String> _f$userId = Field(
    'userId',
    _$userId,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$orderItemId(ParentGroupPetResponse v) => v.orderItemId;
  static const Field<ParentGroupPetResponse, String> _f$orderItemId = Field(
    'orderItemId',
    _$orderItemId,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$name(ParentGroupPetResponse v) => v.name;
  static const Field<ParentGroupPetResponse, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$type(ParentGroupPetResponse v) => v.type;
  static const Field<ParentGroupPetResponse, String> _f$type = Field(
    'type',
    _$type,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$gender(ParentGroupPetResponse v) => v.gender;
  static const Field<ParentGroupPetResponse, String> _f$gender = Field(
    'gender',
    _$gender,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$breedId(ParentGroupPetResponse v) => v.breedId;
  static const Field<ParentGroupPetResponse, String> _f$breedId = Field(
    'breedId',
    _$breedId,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$dob(ParentGroupPetResponse v) => v.dob;
  static const Field<ParentGroupPetResponse, String> _f$dob = Field(
    'dob',
    _$dob,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$size(ParentGroupPetResponse v) => v.size;
  static const Field<ParentGroupPetResponse, String> _f$size = Field(
    'size',
    _$size,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static int _$bcsScore(ParentGroupPetResponse v) => v.bcsScore;
  static const Field<ParentGroupPetResponse, int> _f$bcsScore = Field(
    'bcsScore',
    _$bcsScore,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );
  static double _$height(ParentGroupPetResponse v) => v.height;
  static const Field<ParentGroupPetResponse, double> _f$height = Field(
    'height',
    _$height,
    opt: true,
    def: 0,
    hook: SafeDoubleHook(),
  );
  static double _$weight(ParentGroupPetResponse v) => v.weight;
  static const Field<ParentGroupPetResponse, double> _f$weight = Field(
    'weight',
    _$weight,
    opt: true,
    def: 0,
    hook: SafeDoubleHook(),
  );
  static String _$heightUnit(ParentGroupPetResponse v) => v.heightUnit;
  static const Field<ParentGroupPetResponse, String> _f$heightUnit = Field(
    'heightUnit',
    _$heightUnit,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$weightUnit(ParentGroupPetResponse v) => v.weightUnit;
  static const Field<ParentGroupPetResponse, String> _f$weightUnit = Field(
    'weightUnit',
    _$weightUnit,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$profilePicture(ParentGroupPetResponse v) => v.profilePicture;
  static const Field<ParentGroupPetResponse, String> _f$profilePicture = Field(
    'profilePicture',
    _$profilePicture,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$healthInfo(ParentGroupPetResponse v) => v.healthInfo;
  static const Field<ParentGroupPetResponse, String> _f$healthInfo = Field(
    'healthInfo',
    _$healthInfo,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$createdAtLegacy(ParentGroupPetResponse v) =>
      v.createdAtLegacy;
  static const Field<ParentGroupPetResponse, String> _f$createdAtLegacy = Field(
    'createdAtLegacy',
    _$createdAtLegacy,
    key: r'created_at',
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$updatedAtLegacy(ParentGroupPetResponse v) =>
      v.updatedAtLegacy;
  static const Field<ParentGroupPetResponse, String> _f$updatedAtLegacy = Field(
    'updatedAtLegacy',
    _$updatedAtLegacy,
    key: r'updated_at',
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$deletedAtLegacy(ParentGroupPetResponse v) =>
      v.deletedAtLegacy;
  static const Field<ParentGroupPetResponse, String> _f$deletedAtLegacy = Field(
    'deletedAtLegacy',
    _$deletedAtLegacy,
    key: r'deleted_at',
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$userIdLegacy(ParentGroupPetResponse v) => v.userIdLegacy;
  static const Field<ParentGroupPetResponse, String> _f$userIdLegacy = Field(
    'userIdLegacy',
    _$userIdLegacy,
    key: r'user_id',
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$parentGroupIdLegacy(ParentGroupPetResponse v) =>
      v.parentGroupIdLegacy;
  static const Field<ParentGroupPetResponse, String> _f$parentGroupIdLegacy =
      Field(
        'parentGroupIdLegacy',
        _$parentGroupIdLegacy,
        key: r'parent_group_id',
        opt: true,
        def: '',
        hook: SafeStringHook(),
      );
  static BreedInfoResponse? _$breedInfo(ParentGroupPetResponse v) =>
      v.breedInfo;
  static const Field<ParentGroupPetResponse, BreedInfoResponse> _f$breedInfo =
      Field('breedInfo', _$breedInfo, opt: true);

  @override
  final MappableFields<ParentGroupPetResponse> fields = const {
    #id: _f$id,
    #petNumber: _f$petNumber,
    #parentGroupId: _f$parentGroupId,
    #userId: _f$userId,
    #orderItemId: _f$orderItemId,
    #name: _f$name,
    #type: _f$type,
    #gender: _f$gender,
    #breedId: _f$breedId,
    #dob: _f$dob,
    #size: _f$size,
    #bcsScore: _f$bcsScore,
    #height: _f$height,
    #weight: _f$weight,
    #heightUnit: _f$heightUnit,
    #weightUnit: _f$weightUnit,
    #profilePicture: _f$profilePicture,
    #healthInfo: _f$healthInfo,
    #createdAtLegacy: _f$createdAtLegacy,
    #updatedAtLegacy: _f$updatedAtLegacy,
    #deletedAtLegacy: _f$deletedAtLegacy,
    #userIdLegacy: _f$userIdLegacy,
    #parentGroupIdLegacy: _f$parentGroupIdLegacy,
    #breedInfo: _f$breedInfo,
  };

  static ParentGroupPetResponse _instantiate(DecodingData data) {
    return ParentGroupPetResponse(
      id: data.dec(_f$id),
      petNumber: data.dec(_f$petNumber),
      parentGroupId: data.dec(_f$parentGroupId),
      userId: data.dec(_f$userId),
      orderItemId: data.dec(_f$orderItemId),
      name: data.dec(_f$name),
      type: data.dec(_f$type),
      gender: data.dec(_f$gender),
      breedId: data.dec(_f$breedId),
      dob: data.dec(_f$dob),
      size: data.dec(_f$size),
      bcsScore: data.dec(_f$bcsScore),
      height: data.dec(_f$height),
      weight: data.dec(_f$weight),
      heightUnit: data.dec(_f$heightUnit),
      weightUnit: data.dec(_f$weightUnit),
      profilePicture: data.dec(_f$profilePicture),
      healthInfo: data.dec(_f$healthInfo),
      createdAtLegacy: data.dec(_f$createdAtLegacy),
      updatedAtLegacy: data.dec(_f$updatedAtLegacy),
      deletedAtLegacy: data.dec(_f$deletedAtLegacy),
      userIdLegacy: data.dec(_f$userIdLegacy),
      parentGroupIdLegacy: data.dec(_f$parentGroupIdLegacy),
      breedInfo: data.dec(_f$breedInfo),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ParentGroupPetResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ParentGroupPetResponse>(map);
  }

  static ParentGroupPetResponse fromJson(String json) {
    return ensureInitialized().decodeJson<ParentGroupPetResponse>(json);
  }
}

mixin ParentGroupPetResponseMappable {
  String toJson() {
    return ParentGroupPetResponseMapper.ensureInitialized()
        .encodeJson<ParentGroupPetResponse>(this as ParentGroupPetResponse);
  }

  Map<String, dynamic> toMap() {
    return ParentGroupPetResponseMapper.ensureInitialized()
        .encodeMap<ParentGroupPetResponse>(this as ParentGroupPetResponse);
  }

  ParentGroupPetResponseCopyWith<
    ParentGroupPetResponse,
    ParentGroupPetResponse,
    ParentGroupPetResponse
  >
  get copyWith =>
      _ParentGroupPetResponseCopyWithImpl<
        ParentGroupPetResponse,
        ParentGroupPetResponse
      >(this as ParentGroupPetResponse, $identity, $identity);
  @override
  String toString() {
    return ParentGroupPetResponseMapper.ensureInitialized().stringifyValue(
      this as ParentGroupPetResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return ParentGroupPetResponseMapper.ensureInitialized().equalsValue(
      this as ParentGroupPetResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return ParentGroupPetResponseMapper.ensureInitialized().hashValue(
      this as ParentGroupPetResponse,
    );
  }
}

extension ParentGroupPetResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ParentGroupPetResponse, $Out> {
  ParentGroupPetResponseCopyWith<$R, ParentGroupPetResponse, $Out>
  get $asParentGroupPetResponse => $base.as(
    (v, t, t2) => _ParentGroupPetResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ParentGroupPetResponseCopyWith<
  $R,
  $In extends ParentGroupPetResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  BreedInfoResponseCopyWith<$R, BreedInfoResponse, BreedInfoResponse>?
  get breedInfo;
  $R call({
    String? id,
    String? petNumber,
    String? parentGroupId,
    String? userId,
    String? orderItemId,
    String? name,
    String? type,
    String? gender,
    String? breedId,
    String? dob,
    String? size,
    int? bcsScore,
    double? height,
    double? weight,
    String? heightUnit,
    String? weightUnit,
    String? profilePicture,
    String? healthInfo,
    String? createdAtLegacy,
    String? updatedAtLegacy,
    String? deletedAtLegacy,
    String? userIdLegacy,
    String? parentGroupIdLegacy,
    BreedInfoResponse? breedInfo,
  });
  ParentGroupPetResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ParentGroupPetResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ParentGroupPetResponse, $Out>
    implements
        ParentGroupPetResponseCopyWith<$R, ParentGroupPetResponse, $Out> {
  _ParentGroupPetResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ParentGroupPetResponse> $mapper =
      ParentGroupPetResponseMapper.ensureInitialized();
  @override
  BreedInfoResponseCopyWith<$R, BreedInfoResponse, BreedInfoResponse>?
  get breedInfo => $value.breedInfo?.copyWith.$chain((v) => call(breedInfo: v));
  @override
  $R call({
    String? id,
    String? petNumber,
    String? parentGroupId,
    String? userId,
    String? orderItemId,
    String? name,
    String? type,
    String? gender,
    String? breedId,
    String? dob,
    String? size,
    int? bcsScore,
    double? height,
    double? weight,
    String? heightUnit,
    String? weightUnit,
    String? profilePicture,
    String? healthInfo,
    String? createdAtLegacy,
    String? updatedAtLegacy,
    String? deletedAtLegacy,
    String? userIdLegacy,
    String? parentGroupIdLegacy,
    Object? breedInfo = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (petNumber != null) #petNumber: petNumber,
      if (parentGroupId != null) #parentGroupId: parentGroupId,
      if (userId != null) #userId: userId,
      if (orderItemId != null) #orderItemId: orderItemId,
      if (name != null) #name: name,
      if (type != null) #type: type,
      if (gender != null) #gender: gender,
      if (breedId != null) #breedId: breedId,
      if (dob != null) #dob: dob,
      if (size != null) #size: size,
      if (bcsScore != null) #bcsScore: bcsScore,
      if (height != null) #height: height,
      if (weight != null) #weight: weight,
      if (heightUnit != null) #heightUnit: heightUnit,
      if (weightUnit != null) #weightUnit: weightUnit,
      if (profilePicture != null) #profilePicture: profilePicture,
      if (healthInfo != null) #healthInfo: healthInfo,
      if (createdAtLegacy != null) #createdAtLegacy: createdAtLegacy,
      if (updatedAtLegacy != null) #updatedAtLegacy: updatedAtLegacy,
      if (deletedAtLegacy != null) #deletedAtLegacy: deletedAtLegacy,
      if (userIdLegacy != null) #userIdLegacy: userIdLegacy,
      if (parentGroupIdLegacy != null)
        #parentGroupIdLegacy: parentGroupIdLegacy,
      if (breedInfo != $none) #breedInfo: breedInfo,
    }),
  );
  @override
  ParentGroupPetResponse $make(CopyWithData data) => ParentGroupPetResponse(
    id: data.get(#id, or: $value.id),
    petNumber: data.get(#petNumber, or: $value.petNumber),
    parentGroupId: data.get(#parentGroupId, or: $value.parentGroupId),
    userId: data.get(#userId, or: $value.userId),
    orderItemId: data.get(#orderItemId, or: $value.orderItemId),
    name: data.get(#name, or: $value.name),
    type: data.get(#type, or: $value.type),
    gender: data.get(#gender, or: $value.gender),
    breedId: data.get(#breedId, or: $value.breedId),
    dob: data.get(#dob, or: $value.dob),
    size: data.get(#size, or: $value.size),
    bcsScore: data.get(#bcsScore, or: $value.bcsScore),
    height: data.get(#height, or: $value.height),
    weight: data.get(#weight, or: $value.weight),
    heightUnit: data.get(#heightUnit, or: $value.heightUnit),
    weightUnit: data.get(#weightUnit, or: $value.weightUnit),
    profilePicture: data.get(#profilePicture, or: $value.profilePicture),
    healthInfo: data.get(#healthInfo, or: $value.healthInfo),
    createdAtLegacy: data.get(#createdAtLegacy, or: $value.createdAtLegacy),
    updatedAtLegacy: data.get(#updatedAtLegacy, or: $value.updatedAtLegacy),
    deletedAtLegacy: data.get(#deletedAtLegacy, or: $value.deletedAtLegacy),
    userIdLegacy: data.get(#userIdLegacy, or: $value.userIdLegacy),
    parentGroupIdLegacy: data.get(
      #parentGroupIdLegacy,
      or: $value.parentGroupIdLegacy,
    ),
    breedInfo: data.get(#breedInfo, or: $value.breedInfo),
  );

  @override
  ParentGroupPetResponseCopyWith<$R2, ParentGroupPetResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ParentGroupPetResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class BreedInfoResponseMapper extends ClassMapperBase<BreedInfoResponse> {
  BreedInfoResponseMapper._();

  static BreedInfoResponseMapper? _instance;
  static BreedInfoResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BreedInfoResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BreedInfoResponse';

  static String _$id(BreedInfoResponse v) => v.id;
  static const Field<BreedInfoResponse, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$breedName(BreedInfoResponse v) => v.breedName;
  static const Field<BreedInfoResponse, String> _f$breedName = Field(
    'breedName',
    _$breedName,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$petType(BreedInfoResponse v) => v.petType;
  static const Field<BreedInfoResponse, String> _f$petType = Field(
    'petType',
    _$petType,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$sizeCategory(BreedInfoResponse v) => v.sizeCategory;
  static const Field<BreedInfoResponse, String> _f$sizeCategory = Field(
    'sizeCategory',
    _$sizeCategory,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<BreedInfoResponse> fields = const {
    #id: _f$id,
    #breedName: _f$breedName,
    #petType: _f$petType,
    #sizeCategory: _f$sizeCategory,
  };

  static BreedInfoResponse _instantiate(DecodingData data) {
    return BreedInfoResponse(
      id: data.dec(_f$id),
      breedName: data.dec(_f$breedName),
      petType: data.dec(_f$petType),
      sizeCategory: data.dec(_f$sizeCategory),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static BreedInfoResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BreedInfoResponse>(map);
  }

  static BreedInfoResponse fromJson(String json) {
    return ensureInitialized().decodeJson<BreedInfoResponse>(json);
  }
}

mixin BreedInfoResponseMappable {
  String toJson() {
    return BreedInfoResponseMapper.ensureInitialized()
        .encodeJson<BreedInfoResponse>(this as BreedInfoResponse);
  }

  Map<String, dynamic> toMap() {
    return BreedInfoResponseMapper.ensureInitialized()
        .encodeMap<BreedInfoResponse>(this as BreedInfoResponse);
  }

  BreedInfoResponseCopyWith<
    BreedInfoResponse,
    BreedInfoResponse,
    BreedInfoResponse
  >
  get copyWith =>
      _BreedInfoResponseCopyWithImpl<BreedInfoResponse, BreedInfoResponse>(
        this as BreedInfoResponse,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return BreedInfoResponseMapper.ensureInitialized().stringifyValue(
      this as BreedInfoResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return BreedInfoResponseMapper.ensureInitialized().equalsValue(
      this as BreedInfoResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return BreedInfoResponseMapper.ensureInitialized().hashValue(
      this as BreedInfoResponse,
    );
  }
}

extension BreedInfoResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BreedInfoResponse, $Out> {
  BreedInfoResponseCopyWith<$R, BreedInfoResponse, $Out>
  get $asBreedInfoResponse => $base.as(
    (v, t, t2) => _BreedInfoResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class BreedInfoResponseCopyWith<
  $R,
  $In extends BreedInfoResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? breedName,
    String? petType,
    String? sizeCategory,
  });
  BreedInfoResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _BreedInfoResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BreedInfoResponse, $Out>
    implements BreedInfoResponseCopyWith<$R, BreedInfoResponse, $Out> {
  _BreedInfoResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BreedInfoResponse> $mapper =
      BreedInfoResponseMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? breedName,
    String? petType,
    String? sizeCategory,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (breedName != null) #breedName: breedName,
      if (petType != null) #petType: petType,
      if (sizeCategory != null) #sizeCategory: sizeCategory,
    }),
  );
  @override
  BreedInfoResponse $make(CopyWithData data) => BreedInfoResponse(
    id: data.get(#id, or: $value.id),
    breedName: data.get(#breedName, or: $value.breedName),
    petType: data.get(#petType, or: $value.petType),
    sizeCategory: data.get(#sizeCategory, or: $value.sizeCategory),
  );

  @override
  BreedInfoResponseCopyWith<$R2, BreedInfoResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BreedInfoResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

