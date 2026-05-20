// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'verify_otp_response.dart';

class VerifyOtpResponseMapper extends ClassMapperBase<VerifyOtpResponse> {
  VerifyOtpResponseMapper._();

  static VerifyOtpResponseMapper? _instance;
  static VerifyOtpResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VerifyOtpResponseMapper._());
      VerifyOtpUserResponseMapper.ensureInitialized();
      VerifyOtpTokensResponseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'VerifyOtpResponse';

  static String _$type(VerifyOtpResponse v) => v.type;
  static const Field<VerifyOtpResponse, String> _f$type = Field(
    'type',
    _$type,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static VerifyOtpUserResponse _$user(VerifyOtpResponse v) => v.user;
  static const Field<VerifyOtpResponse, VerifyOtpUserResponse> _f$user = Field(
    'user',
    _$user,
    opt: true,
    def: const VerifyOtpUserResponse(),
  );
  static VerifyOtpTokensResponse _$tokens(VerifyOtpResponse v) => v.tokens;
  static const Field<VerifyOtpResponse, VerifyOtpTokensResponse> _f$tokens =
      Field(
        'tokens',
        _$tokens,
        opt: true,
        def: const VerifyOtpTokensResponse(),
      );
  static bool _$hasInvites(VerifyOtpResponse v) => v.hasInvites;
  static const Field<VerifyOtpResponse, bool> _f$hasInvites = Field(
    'hasInvites',
    _$hasInvites,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );

  @override
  final MappableFields<VerifyOtpResponse> fields = const {
    #type: _f$type,
    #user: _f$user,
    #tokens: _f$tokens,
    #hasInvites: _f$hasInvites,
  };

  static VerifyOtpResponse _instantiate(DecodingData data) {
    return VerifyOtpResponse(
      type: data.dec(_f$type),
      user: data.dec(_f$user),
      tokens: data.dec(_f$tokens),
      hasInvites: data.dec(_f$hasInvites),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static VerifyOtpResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VerifyOtpResponse>(map);
  }

  static VerifyOtpResponse fromJson(String json) {
    return ensureInitialized().decodeJson<VerifyOtpResponse>(json);
  }
}

mixin VerifyOtpResponseMappable {
  String toJson() {
    return VerifyOtpResponseMapper.ensureInitialized()
        .encodeJson<VerifyOtpResponse>(this as VerifyOtpResponse);
  }

  Map<String, dynamic> toMap() {
    return VerifyOtpResponseMapper.ensureInitialized()
        .encodeMap<VerifyOtpResponse>(this as VerifyOtpResponse);
  }

  VerifyOtpResponseCopyWith<
    VerifyOtpResponse,
    VerifyOtpResponse,
    VerifyOtpResponse
  >
  get copyWith =>
      _VerifyOtpResponseCopyWithImpl<VerifyOtpResponse, VerifyOtpResponse>(
        this as VerifyOtpResponse,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return VerifyOtpResponseMapper.ensureInitialized().stringifyValue(
      this as VerifyOtpResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return VerifyOtpResponseMapper.ensureInitialized().equalsValue(
      this as VerifyOtpResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return VerifyOtpResponseMapper.ensureInitialized().hashValue(
      this as VerifyOtpResponse,
    );
  }
}

extension VerifyOtpResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VerifyOtpResponse, $Out> {
  VerifyOtpResponseCopyWith<$R, VerifyOtpResponse, $Out>
  get $asVerifyOtpResponse => $base.as(
    (v, t, t2) => _VerifyOtpResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class VerifyOtpResponseCopyWith<
  $R,
  $In extends VerifyOtpResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  VerifyOtpUserResponseCopyWith<
    $R,
    VerifyOtpUserResponse,
    VerifyOtpUserResponse
  >
  get user;
  VerifyOtpTokensResponseCopyWith<
    $R,
    VerifyOtpTokensResponse,
    VerifyOtpTokensResponse
  >
  get tokens;
  $R call({
    String? type,
    VerifyOtpUserResponse? user,
    VerifyOtpTokensResponse? tokens,
    bool? hasInvites,
  });
  VerifyOtpResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _VerifyOtpResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VerifyOtpResponse, $Out>
    implements VerifyOtpResponseCopyWith<$R, VerifyOtpResponse, $Out> {
  _VerifyOtpResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VerifyOtpResponse> $mapper =
      VerifyOtpResponseMapper.ensureInitialized();
  @override
  VerifyOtpUserResponseCopyWith<
    $R,
    VerifyOtpUserResponse,
    VerifyOtpUserResponse
  >
  get user => $value.user.copyWith.$chain((v) => call(user: v));
  @override
  VerifyOtpTokensResponseCopyWith<
    $R,
    VerifyOtpTokensResponse,
    VerifyOtpTokensResponse
  >
  get tokens => $value.tokens.copyWith.$chain((v) => call(tokens: v));
  @override
  $R call({
    String? type,
    VerifyOtpUserResponse? user,
    VerifyOtpTokensResponse? tokens,
    bool? hasInvites,
  }) => $apply(
    FieldCopyWithData({
      if (type != null) #type: type,
      if (user != null) #user: user,
      if (tokens != null) #tokens: tokens,
      if (hasInvites != null) #hasInvites: hasInvites,
    }),
  );
  @override
  VerifyOtpResponse $make(CopyWithData data) => VerifyOtpResponse(
    type: data.get(#type, or: $value.type),
    user: data.get(#user, or: $value.user),
    tokens: data.get(#tokens, or: $value.tokens),
    hasInvites: data.get(#hasInvites, or: $value.hasInvites),
  );

  @override
  VerifyOtpResponseCopyWith<$R2, VerifyOtpResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _VerifyOtpResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class VerifyOtpUserResponseMapper
    extends ClassMapperBase<VerifyOtpUserResponse> {
  VerifyOtpUserResponseMapper._();

  static VerifyOtpUserResponseMapper? _instance;
  static VerifyOtpUserResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VerifyOtpUserResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'VerifyOtpUserResponse';

  static String _$id(VerifyOtpUserResponse v) => v.id;
  static const Field<VerifyOtpUserResponse, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$provider(VerifyOtpUserResponse v) => v.provider;
  static const Field<VerifyOtpUserResponse, String> _f$provider = Field(
    'provider',
    _$provider,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$providerId(VerifyOtpUserResponse v) => v.providerId;
  static const Field<VerifyOtpUserResponse, String> _f$providerId = Field(
    'providerId',
    _$providerId,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static bool _$isSocialLogin(VerifyOtpUserResponse v) => v.isSocialLogin;
  static const Field<VerifyOtpUserResponse, bool> _f$isSocialLogin = Field(
    'isSocialLogin',
    _$isSocialLogin,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static bool _$isActive(VerifyOtpUserResponse v) => v.isActive;
  static const Field<VerifyOtpUserResponse, bool> _f$isActive = Field(
    'isActive',
    _$isActive,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static bool _$isDeleted(VerifyOtpUserResponse v) => v.isDeleted;
  static const Field<VerifyOtpUserResponse, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static String _$deletedBy(VerifyOtpUserResponse v) => v.deletedBy;
  static const Field<VerifyOtpUserResponse, String> _f$deletedBy = Field(
    'deletedBy',
    _$deletedBy,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$deletedAt(VerifyOtpUserResponse v) => v.deletedAt;
  static const Field<VerifyOtpUserResponse, String> _f$deletedAt = Field(
    'deletedAt',
    _$deletedAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$deletionReason(VerifyOtpUserResponse v) => v.deletionReason;
  static const Field<VerifyOtpUserResponse, String> _f$deletionReason = Field(
    'deletionReason',
    _$deletionReason,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static bool _$isOnboarded(VerifyOtpUserResponse v) => v.isOnboarded;
  static const Field<VerifyOtpUserResponse, bool> _f$isOnboarded = Field(
    'isOnboarded',
    _$isOnboarded,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static bool _$isProfileCompleted(VerifyOtpUserResponse v) =>
      v.isProfileCompleted;
  static const Field<VerifyOtpUserResponse, bool> _f$isProfileCompleted = Field(
    'isProfileCompleted',
    _$isProfileCompleted,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static bool _$isPetOnboarded(VerifyOtpUserResponse v) => v.isPetOnboarded;
  static const Field<VerifyOtpUserResponse, bool> _f$isPetOnboarded = Field(
    'isPetOnboarded',
    _$isPetOnboarded,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static int _$points(VerifyOtpUserResponse v) => v.points;
  static const Field<VerifyOtpUserResponse, int> _f$points = Field(
    'points',
    _$points,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );
  static String _$createdAt(VerifyOtpUserResponse v) => v.createdAt;
  static const Field<VerifyOtpUserResponse, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$updatedAt(VerifyOtpUserResponse v) => v.updatedAt;
  static const Field<VerifyOtpUserResponse, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$name(VerifyOtpUserResponse v) => v.name;
  static const Field<VerifyOtpUserResponse, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$phone(VerifyOtpUserResponse v) => v.phone;
  static const Field<VerifyOtpUserResponse, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$countryCode(VerifyOtpUserResponse v) => v.countryCode;
  static const Field<VerifyOtpUserResponse, String> _f$countryCode = Field(
    'countryCode',
    _$countryCode,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$country(VerifyOtpUserResponse v) => v.country;
  static const Field<VerifyOtpUserResponse, String> _f$country = Field(
    'country',
    _$country,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$role(VerifyOtpUserResponse v) => v.role;
  static const Field<VerifyOtpUserResponse, String> _f$role = Field(
    'role',
    _$role,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$primaryIdentifier(VerifyOtpUserResponse v) =>
      v.primaryIdentifier;
  static const Field<VerifyOtpUserResponse, String> _f$primaryIdentifier =
      Field(
        'primaryIdentifier',
        _$primaryIdentifier,
        opt: true,
        def: '',
        hook: SafeStringHook(),
      );
  static bool _$isVerified(VerifyOtpUserResponse v) => v.isVerified;
  static const Field<VerifyOtpUserResponse, bool> _f$isVerified = Field(
    'isVerified',
    _$isVerified,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static bool _$hasInvites(VerifyOtpUserResponse v) => v.hasInvites;
  static const Field<VerifyOtpUserResponse, bool> _f$hasInvites = Field(
    'hasInvites',
    _$hasInvites,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static String _$updatedAtLegacy(VerifyOtpUserResponse v) => v.updatedAtLegacy;
  static const Field<VerifyOtpUserResponse, String> _f$updatedAtLegacy = Field(
    'updatedAtLegacy',
    _$updatedAtLegacy,
    key: r'updated_at',
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$createdAtLegacy(VerifyOtpUserResponse v) => v.createdAtLegacy;
  static const Field<VerifyOtpUserResponse, String> _f$createdAtLegacy = Field(
    'createdAtLegacy',
    _$createdAtLegacy,
    key: r'created_at',
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$email(VerifyOtpUserResponse v) => v.email;
  static const Field<VerifyOtpUserResponse, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<VerifyOtpUserResponse> fields = const {
    #id: _f$id,
    #provider: _f$provider,
    #providerId: _f$providerId,
    #isSocialLogin: _f$isSocialLogin,
    #isActive: _f$isActive,
    #isDeleted: _f$isDeleted,
    #deletedBy: _f$deletedBy,
    #deletedAt: _f$deletedAt,
    #deletionReason: _f$deletionReason,
    #isOnboarded: _f$isOnboarded,
    #isProfileCompleted: _f$isProfileCompleted,
    #isPetOnboarded: _f$isPetOnboarded,
    #points: _f$points,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #name: _f$name,
    #phone: _f$phone,
    #countryCode: _f$countryCode,
    #country: _f$country,
    #role: _f$role,
    #primaryIdentifier: _f$primaryIdentifier,
    #isVerified: _f$isVerified,
    #hasInvites: _f$hasInvites,
    #updatedAtLegacy: _f$updatedAtLegacy,
    #createdAtLegacy: _f$createdAtLegacy,
    #email: _f$email,
  };

  static VerifyOtpUserResponse _instantiate(DecodingData data) {
    return VerifyOtpUserResponse(
      id: data.dec(_f$id),
      provider: data.dec(_f$provider),
      providerId: data.dec(_f$providerId),
      isSocialLogin: data.dec(_f$isSocialLogin),
      isActive: data.dec(_f$isActive),
      isDeleted: data.dec(_f$isDeleted),
      deletedBy: data.dec(_f$deletedBy),
      deletedAt: data.dec(_f$deletedAt),
      deletionReason: data.dec(_f$deletionReason),
      isOnboarded: data.dec(_f$isOnboarded),
      isProfileCompleted: data.dec(_f$isProfileCompleted),
      isPetOnboarded: data.dec(_f$isPetOnboarded),
      points: data.dec(_f$points),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      name: data.dec(_f$name),
      phone: data.dec(_f$phone),
      countryCode: data.dec(_f$countryCode),
      country: data.dec(_f$country),
      role: data.dec(_f$role),
      primaryIdentifier: data.dec(_f$primaryIdentifier),
      isVerified: data.dec(_f$isVerified),
      hasInvites: data.dec(_f$hasInvites),
      updatedAtLegacy: data.dec(_f$updatedAtLegacy),
      createdAtLegacy: data.dec(_f$createdAtLegacy),
      email: data.dec(_f$email),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static VerifyOtpUserResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VerifyOtpUserResponse>(map);
  }

  static VerifyOtpUserResponse fromJson(String json) {
    return ensureInitialized().decodeJson<VerifyOtpUserResponse>(json);
  }
}

mixin VerifyOtpUserResponseMappable {
  String toJson() {
    return VerifyOtpUserResponseMapper.ensureInitialized()
        .encodeJson<VerifyOtpUserResponse>(this as VerifyOtpUserResponse);
  }

  Map<String, dynamic> toMap() {
    return VerifyOtpUserResponseMapper.ensureInitialized()
        .encodeMap<VerifyOtpUserResponse>(this as VerifyOtpUserResponse);
  }

  VerifyOtpUserResponseCopyWith<
    VerifyOtpUserResponse,
    VerifyOtpUserResponse,
    VerifyOtpUserResponse
  >
  get copyWith =>
      _VerifyOtpUserResponseCopyWithImpl<
        VerifyOtpUserResponse,
        VerifyOtpUserResponse
      >(this as VerifyOtpUserResponse, $identity, $identity);
  @override
  String toString() {
    return VerifyOtpUserResponseMapper.ensureInitialized().stringifyValue(
      this as VerifyOtpUserResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return VerifyOtpUserResponseMapper.ensureInitialized().equalsValue(
      this as VerifyOtpUserResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return VerifyOtpUserResponseMapper.ensureInitialized().hashValue(
      this as VerifyOtpUserResponse,
    );
  }
}

extension VerifyOtpUserResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VerifyOtpUserResponse, $Out> {
  VerifyOtpUserResponseCopyWith<$R, VerifyOtpUserResponse, $Out>
  get $asVerifyOtpUserResponse => $base.as(
    (v, t, t2) => _VerifyOtpUserResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class VerifyOtpUserResponseCopyWith<
  $R,
  $In extends VerifyOtpUserResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? provider,
    String? providerId,
    bool? isSocialLogin,
    bool? isActive,
    bool? isDeleted,
    String? deletedBy,
    String? deletedAt,
    String? deletionReason,
    bool? isOnboarded,
    bool? isProfileCompleted,
    bool? isPetOnboarded,
    int? points,
    String? createdAt,
    String? updatedAt,
    String? name,
    String? phone,
    String? countryCode,
    String? country,
    String? role,
    String? primaryIdentifier,
    bool? isVerified,
    bool? hasInvites,
    String? updatedAtLegacy,
    String? createdAtLegacy,
    String? email,
  });
  VerifyOtpUserResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _VerifyOtpUserResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VerifyOtpUserResponse, $Out>
    implements VerifyOtpUserResponseCopyWith<$R, VerifyOtpUserResponse, $Out> {
  _VerifyOtpUserResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VerifyOtpUserResponse> $mapper =
      VerifyOtpUserResponseMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? provider,
    String? providerId,
    bool? isSocialLogin,
    bool? isActive,
    bool? isDeleted,
    String? deletedBy,
    String? deletedAt,
    String? deletionReason,
    bool? isOnboarded,
    bool? isProfileCompleted,
    bool? isPetOnboarded,
    int? points,
    String? createdAt,
    String? updatedAt,
    String? name,
    String? phone,
    String? countryCode,
    String? country,
    String? role,
    String? primaryIdentifier,
    bool? isVerified,
    bool? hasInvites,
    String? updatedAtLegacy,
    String? createdAtLegacy,
    String? email,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (provider != null) #provider: provider,
      if (providerId != null) #providerId: providerId,
      if (isSocialLogin != null) #isSocialLogin: isSocialLogin,
      if (isActive != null) #isActive: isActive,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (deletedBy != null) #deletedBy: deletedBy,
      if (deletedAt != null) #deletedAt: deletedAt,
      if (deletionReason != null) #deletionReason: deletionReason,
      if (isOnboarded != null) #isOnboarded: isOnboarded,
      if (isProfileCompleted != null) #isProfileCompleted: isProfileCompleted,
      if (isPetOnboarded != null) #isPetOnboarded: isPetOnboarded,
      if (points != null) #points: points,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
      if (name != null) #name: name,
      if (phone != null) #phone: phone,
      if (countryCode != null) #countryCode: countryCode,
      if (country != null) #country: country,
      if (role != null) #role: role,
      if (primaryIdentifier != null) #primaryIdentifier: primaryIdentifier,
      if (isVerified != null) #isVerified: isVerified,
      if (hasInvites != null) #hasInvites: hasInvites,
      if (updatedAtLegacy != null) #updatedAtLegacy: updatedAtLegacy,
      if (createdAtLegacy != null) #createdAtLegacy: createdAtLegacy,
      if (email != null) #email: email,
    }),
  );
  @override
  VerifyOtpUserResponse $make(CopyWithData data) => VerifyOtpUserResponse(
    id: data.get(#id, or: $value.id),
    provider: data.get(#provider, or: $value.provider),
    providerId: data.get(#providerId, or: $value.providerId),
    isSocialLogin: data.get(#isSocialLogin, or: $value.isSocialLogin),
    isActive: data.get(#isActive, or: $value.isActive),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    deletedBy: data.get(#deletedBy, or: $value.deletedBy),
    deletedAt: data.get(#deletedAt, or: $value.deletedAt),
    deletionReason: data.get(#deletionReason, or: $value.deletionReason),
    isOnboarded: data.get(#isOnboarded, or: $value.isOnboarded),
    isProfileCompleted: data.get(
      #isProfileCompleted,
      or: $value.isProfileCompleted,
    ),
    isPetOnboarded: data.get(#isPetOnboarded, or: $value.isPetOnboarded),
    points: data.get(#points, or: $value.points),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    name: data.get(#name, or: $value.name),
    phone: data.get(#phone, or: $value.phone),
    countryCode: data.get(#countryCode, or: $value.countryCode),
    country: data.get(#country, or: $value.country),
    role: data.get(#role, or: $value.role),
    primaryIdentifier: data.get(
      #primaryIdentifier,
      or: $value.primaryIdentifier,
    ),
    isVerified: data.get(#isVerified, or: $value.isVerified),
    hasInvites: data.get(#hasInvites, or: $value.hasInvites),
    updatedAtLegacy: data.get(#updatedAtLegacy, or: $value.updatedAtLegacy),
    createdAtLegacy: data.get(#createdAtLegacy, or: $value.createdAtLegacy),
    email: data.get(#email, or: $value.email),
  );

  @override
  VerifyOtpUserResponseCopyWith<$R2, VerifyOtpUserResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _VerifyOtpUserResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class VerifyOtpTokensResponseMapper
    extends ClassMapperBase<VerifyOtpTokensResponse> {
  VerifyOtpTokensResponseMapper._();

  static VerifyOtpTokensResponseMapper? _instance;
  static VerifyOtpTokensResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = VerifyOtpTokensResponseMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'VerifyOtpTokensResponse';

  static String _$accessToken(VerifyOtpTokensResponse v) => v.accessToken;
  static const Field<VerifyOtpTokensResponse, String> _f$accessToken = Field(
    'accessToken',
    _$accessToken,
    key: r'access_token',
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$refreshToken(VerifyOtpTokensResponse v) => v.refreshToken;
  static const Field<VerifyOtpTokensResponse, String> _f$refreshToken = Field(
    'refreshToken',
    _$refreshToken,
    key: r'refresh_token',
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$expiresIn(VerifyOtpTokensResponse v) => v.expiresIn;
  static const Field<VerifyOtpTokensResponse, String> _f$expiresIn = Field(
    'expiresIn',
    _$expiresIn,
    key: r'expires_in',
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$accessTokenExpiresAt(VerifyOtpTokensResponse v) =>
      v.accessTokenExpiresAt;
  static const Field<VerifyOtpTokensResponse, String> _f$accessTokenExpiresAt =
      Field(
        'accessTokenExpiresAt',
        _$accessTokenExpiresAt,
        key: r'access_token_expires_at',
        opt: true,
        def: '',
        hook: SafeStringHook(),
      );
  static String _$refreshTokenExpiresAt(VerifyOtpTokensResponse v) =>
      v.refreshTokenExpiresAt;
  static const Field<VerifyOtpTokensResponse, String> _f$refreshTokenExpiresAt =
      Field(
        'refreshTokenExpiresAt',
        _$refreshTokenExpiresAt,
        key: r'refresh_token_expires_at',
        opt: true,
        def: '',
        hook: SafeStringHook(),
      );

  @override
  final MappableFields<VerifyOtpTokensResponse> fields = const {
    #accessToken: _f$accessToken,
    #refreshToken: _f$refreshToken,
    #expiresIn: _f$expiresIn,
    #accessTokenExpiresAt: _f$accessTokenExpiresAt,
    #refreshTokenExpiresAt: _f$refreshTokenExpiresAt,
  };

  static VerifyOtpTokensResponse _instantiate(DecodingData data) {
    return VerifyOtpTokensResponse(
      accessToken: data.dec(_f$accessToken),
      refreshToken: data.dec(_f$refreshToken),
      expiresIn: data.dec(_f$expiresIn),
      accessTokenExpiresAt: data.dec(_f$accessTokenExpiresAt),
      refreshTokenExpiresAt: data.dec(_f$refreshTokenExpiresAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static VerifyOtpTokensResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VerifyOtpTokensResponse>(map);
  }

  static VerifyOtpTokensResponse fromJson(String json) {
    return ensureInitialized().decodeJson<VerifyOtpTokensResponse>(json);
  }
}

mixin VerifyOtpTokensResponseMappable {
  String toJson() {
    return VerifyOtpTokensResponseMapper.ensureInitialized()
        .encodeJson<VerifyOtpTokensResponse>(this as VerifyOtpTokensResponse);
  }

  Map<String, dynamic> toMap() {
    return VerifyOtpTokensResponseMapper.ensureInitialized()
        .encodeMap<VerifyOtpTokensResponse>(this as VerifyOtpTokensResponse);
  }

  VerifyOtpTokensResponseCopyWith<
    VerifyOtpTokensResponse,
    VerifyOtpTokensResponse,
    VerifyOtpTokensResponse
  >
  get copyWith =>
      _VerifyOtpTokensResponseCopyWithImpl<
        VerifyOtpTokensResponse,
        VerifyOtpTokensResponse
      >(this as VerifyOtpTokensResponse, $identity, $identity);
  @override
  String toString() {
    return VerifyOtpTokensResponseMapper.ensureInitialized().stringifyValue(
      this as VerifyOtpTokensResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return VerifyOtpTokensResponseMapper.ensureInitialized().equalsValue(
      this as VerifyOtpTokensResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return VerifyOtpTokensResponseMapper.ensureInitialized().hashValue(
      this as VerifyOtpTokensResponse,
    );
  }
}

extension VerifyOtpTokensResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VerifyOtpTokensResponse, $Out> {
  VerifyOtpTokensResponseCopyWith<$R, VerifyOtpTokensResponse, $Out>
  get $asVerifyOtpTokensResponse => $base.as(
    (v, t, t2) => _VerifyOtpTokensResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class VerifyOtpTokensResponseCopyWith<
  $R,
  $In extends VerifyOtpTokensResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? accessToken,
    String? refreshToken,
    String? expiresIn,
    String? accessTokenExpiresAt,
    String? refreshTokenExpiresAt,
  });
  VerifyOtpTokensResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _VerifyOtpTokensResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VerifyOtpTokensResponse, $Out>
    implements
        VerifyOtpTokensResponseCopyWith<$R, VerifyOtpTokensResponse, $Out> {
  _VerifyOtpTokensResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VerifyOtpTokensResponse> $mapper =
      VerifyOtpTokensResponseMapper.ensureInitialized();
  @override
  $R call({
    String? accessToken,
    String? refreshToken,
    String? expiresIn,
    String? accessTokenExpiresAt,
    String? refreshTokenExpiresAt,
  }) => $apply(
    FieldCopyWithData({
      if (accessToken != null) #accessToken: accessToken,
      if (refreshToken != null) #refreshToken: refreshToken,
      if (expiresIn != null) #expiresIn: expiresIn,
      if (accessTokenExpiresAt != null)
        #accessTokenExpiresAt: accessTokenExpiresAt,
      if (refreshTokenExpiresAt != null)
        #refreshTokenExpiresAt: refreshTokenExpiresAt,
    }),
  );
  @override
  VerifyOtpTokensResponse $make(CopyWithData data) => VerifyOtpTokensResponse(
    accessToken: data.get(#accessToken, or: $value.accessToken),
    refreshToken: data.get(#refreshToken, or: $value.refreshToken),
    expiresIn: data.get(#expiresIn, or: $value.expiresIn),
    accessTokenExpiresAt: data.get(
      #accessTokenExpiresAt,
      or: $value.accessTokenExpiresAt,
    ),
    refreshTokenExpiresAt: data.get(
      #refreshTokenExpiresAt,
      or: $value.refreshTokenExpiresAt,
    ),
  );

  @override
  VerifyOtpTokensResponseCopyWith<$R2, VerifyOtpTokensResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _VerifyOtpTokensResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

