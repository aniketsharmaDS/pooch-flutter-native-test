// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'google_login_response.dart';

class GoogleLoginResponseMapper extends ClassMapperBase<GoogleLoginResponse> {
  GoogleLoginResponseMapper._();

  static GoogleLoginResponseMapper? _instance;
  static GoogleLoginResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GoogleLoginResponseMapper._());
      GoogleLoginUserResponseMapper.ensureInitialized();
      GoogleLoginTokensResponseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GoogleLoginResponse';

  static GoogleLoginUserResponse _$user(GoogleLoginResponse v) => v.user;
  static const Field<GoogleLoginResponse, GoogleLoginUserResponse> _f$user =
      Field('user', _$user, opt: true, def: const GoogleLoginUserResponse());
  static bool _$hasInvites(GoogleLoginResponse v) => v.hasInvites;
  static const Field<GoogleLoginResponse, bool> _f$hasInvites = Field(
    'hasInvites',
    _$hasInvites,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static GoogleLoginTokensResponse _$tokens(GoogleLoginResponse v) => v.tokens;
  static const Field<GoogleLoginResponse, GoogleLoginTokensResponse> _f$tokens =
      Field(
        'tokens',
        _$tokens,
        opt: true,
        def: const GoogleLoginTokensResponse(),
      );

  @override
  final MappableFields<GoogleLoginResponse> fields = const {
    #user: _f$user,
    #hasInvites: _f$hasInvites,
    #tokens: _f$tokens,
  };

  static GoogleLoginResponse _instantiate(DecodingData data) {
    return GoogleLoginResponse(
      user: data.dec(_f$user),
      hasInvites: data.dec(_f$hasInvites),
      tokens: data.dec(_f$tokens),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static GoogleLoginResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GoogleLoginResponse>(map);
  }

  static GoogleLoginResponse fromJson(String json) {
    return ensureInitialized().decodeJson<GoogleLoginResponse>(json);
  }
}

mixin GoogleLoginResponseMappable {
  String toJson() {
    return GoogleLoginResponseMapper.ensureInitialized()
        .encodeJson<GoogleLoginResponse>(this as GoogleLoginResponse);
  }

  Map<String, dynamic> toMap() {
    return GoogleLoginResponseMapper.ensureInitialized()
        .encodeMap<GoogleLoginResponse>(this as GoogleLoginResponse);
  }

  GoogleLoginResponseCopyWith<
    GoogleLoginResponse,
    GoogleLoginResponse,
    GoogleLoginResponse
  >
  get copyWith =>
      _GoogleLoginResponseCopyWithImpl<
        GoogleLoginResponse,
        GoogleLoginResponse
      >(this as GoogleLoginResponse, $identity, $identity);
  @override
  String toString() {
    return GoogleLoginResponseMapper.ensureInitialized().stringifyValue(
      this as GoogleLoginResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return GoogleLoginResponseMapper.ensureInitialized().equalsValue(
      this as GoogleLoginResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return GoogleLoginResponseMapper.ensureInitialized().hashValue(
      this as GoogleLoginResponse,
    );
  }
}

extension GoogleLoginResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GoogleLoginResponse, $Out> {
  GoogleLoginResponseCopyWith<$R, GoogleLoginResponse, $Out>
  get $asGoogleLoginResponse => $base.as(
    (v, t, t2) => _GoogleLoginResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class GoogleLoginResponseCopyWith<
  $R,
  $In extends GoogleLoginResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  GoogleLoginUserResponseCopyWith<
    $R,
    GoogleLoginUserResponse,
    GoogleLoginUserResponse
  >
  get user;
  GoogleLoginTokensResponseCopyWith<
    $R,
    GoogleLoginTokensResponse,
    GoogleLoginTokensResponse
  >
  get tokens;
  $R call({
    GoogleLoginUserResponse? user,
    bool? hasInvites,
    GoogleLoginTokensResponse? tokens,
  });
  GoogleLoginResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _GoogleLoginResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GoogleLoginResponse, $Out>
    implements GoogleLoginResponseCopyWith<$R, GoogleLoginResponse, $Out> {
  _GoogleLoginResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GoogleLoginResponse> $mapper =
      GoogleLoginResponseMapper.ensureInitialized();
  @override
  GoogleLoginUserResponseCopyWith<
    $R,
    GoogleLoginUserResponse,
    GoogleLoginUserResponse
  >
  get user => $value.user.copyWith.$chain((v) => call(user: v));
  @override
  GoogleLoginTokensResponseCopyWith<
    $R,
    GoogleLoginTokensResponse,
    GoogleLoginTokensResponse
  >
  get tokens => $value.tokens.copyWith.$chain((v) => call(tokens: v));
  @override
  $R call({
    GoogleLoginUserResponse? user,
    bool? hasInvites,
    GoogleLoginTokensResponse? tokens,
  }) => $apply(
    FieldCopyWithData({
      if (user != null) #user: user,
      if (hasInvites != null) #hasInvites: hasInvites,
      if (tokens != null) #tokens: tokens,
    }),
  );
  @override
  GoogleLoginResponse $make(CopyWithData data) => GoogleLoginResponse(
    user: data.get(#user, or: $value.user),
    hasInvites: data.get(#hasInvites, or: $value.hasInvites),
    tokens: data.get(#tokens, or: $value.tokens),
  );

  @override
  GoogleLoginResponseCopyWith<$R2, GoogleLoginResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _GoogleLoginResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class GoogleLoginUserResponseMapper
    extends ClassMapperBase<GoogleLoginUserResponse> {
  GoogleLoginUserResponseMapper._();

  static GoogleLoginUserResponseMapper? _instance;
  static GoogleLoginUserResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = GoogleLoginUserResponseMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'GoogleLoginUserResponse';

  static String _$id(GoogleLoginUserResponse v) => v.id;
  static const Field<GoogleLoginUserResponse, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$provider(GoogleLoginUserResponse v) => v.provider;
  static const Field<GoogleLoginUserResponse, String> _f$provider = Field(
    'provider',
    _$provider,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static bool _$isActive(GoogleLoginUserResponse v) => v.isActive;
  static const Field<GoogleLoginUserResponse, bool> _f$isActive = Field(
    'isActive',
    _$isActive,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static bool _$isDeleted(GoogleLoginUserResponse v) => v.isDeleted;
  static const Field<GoogleLoginUserResponse, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static bool _$isOnboarded(GoogleLoginUserResponse v) => v.isOnboarded;
  static const Field<GoogleLoginUserResponse, bool> _f$isOnboarded = Field(
    'isOnboarded',
    _$isOnboarded,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static bool _$isProfileCompleted(GoogleLoginUserResponse v) =>
      v.isProfileCompleted;
  static const Field<GoogleLoginUserResponse, bool> _f$isProfileCompleted =
      Field(
        'isProfileCompleted',
        _$isProfileCompleted,
        opt: true,
        def: false,
        hook: SafeBoolHook(),
      );
  static bool _$isPetOnboarded(GoogleLoginUserResponse v) => v.isPetOnboarded;
  static const Field<GoogleLoginUserResponse, bool> _f$isPetOnboarded = Field(
    'isPetOnboarded',
    _$isPetOnboarded,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static int _$points(GoogleLoginUserResponse v) => v.points;
  static const Field<GoogleLoginUserResponse, int> _f$points = Field(
    'points',
    _$points,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );
  static String _$createdAt(GoogleLoginUserResponse v) => v.createdAt;
  static const Field<GoogleLoginUserResponse, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$updatedAt(GoogleLoginUserResponse v) => v.updatedAt;
  static const Field<GoogleLoginUserResponse, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$name(GoogleLoginUserResponse v) => v.name;
  static const Field<GoogleLoginUserResponse, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$email(GoogleLoginUserResponse v) => v.email;
  static const Field<GoogleLoginUserResponse, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$primaryIdentifier(GoogleLoginUserResponse v) =>
      v.primaryIdentifier;
  static const Field<GoogleLoginUserResponse, String> _f$primaryIdentifier =
      Field(
        'primaryIdentifier',
        _$primaryIdentifier,
        opt: true,
        def: '',
        hook: SafeStringHook(),
      );
  static bool _$isSocialLogin(GoogleLoginUserResponse v) => v.isSocialLogin;
  static const Field<GoogleLoginUserResponse, bool> _f$isSocialLogin = Field(
    'isSocialLogin',
    _$isSocialLogin,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static String _$role(GoogleLoginUserResponse v) => v.role;
  static const Field<GoogleLoginUserResponse, String> _f$role = Field(
    'role',
    _$role,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static bool _$isVerified(GoogleLoginUserResponse v) => v.isVerified;
  static const Field<GoogleLoginUserResponse, bool> _f$isVerified = Field(
    'isVerified',
    _$isVerified,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static String _$updatedAtLegacy(GoogleLoginUserResponse v) =>
      v.updatedAtLegacy;
  static const Field<GoogleLoginUserResponse, String> _f$updatedAtLegacy =
      Field(
        'updatedAtLegacy',
        _$updatedAtLegacy,
        key: r'updated_at',
        opt: true,
        def: '',
        hook: SafeStringHook(),
      );
  static String _$createdAtLegacy(GoogleLoginUserResponse v) =>
      v.createdAtLegacy;
  static const Field<GoogleLoginUserResponse, String> _f$createdAtLegacy =
      Field(
        'createdAtLegacy',
        _$createdAtLegacy,
        key: r'created_at',
        opt: true,
        def: '',
        hook: SafeStringHook(),
      );

  @override
  final MappableFields<GoogleLoginUserResponse> fields = const {
    #id: _f$id,
    #provider: _f$provider,
    #isActive: _f$isActive,
    #isDeleted: _f$isDeleted,
    #isOnboarded: _f$isOnboarded,
    #isProfileCompleted: _f$isProfileCompleted,
    #isPetOnboarded: _f$isPetOnboarded,
    #points: _f$points,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #name: _f$name,
    #email: _f$email,
    #primaryIdentifier: _f$primaryIdentifier,
    #isSocialLogin: _f$isSocialLogin,
    #role: _f$role,
    #isVerified: _f$isVerified,
    #updatedAtLegacy: _f$updatedAtLegacy,
    #createdAtLegacy: _f$createdAtLegacy,
  };

  static GoogleLoginUserResponse _instantiate(DecodingData data) {
    return GoogleLoginUserResponse(
      id: data.dec(_f$id),
      provider: data.dec(_f$provider),
      isActive: data.dec(_f$isActive),
      isDeleted: data.dec(_f$isDeleted),
      isOnboarded: data.dec(_f$isOnboarded),
      isProfileCompleted: data.dec(_f$isProfileCompleted),
      isPetOnboarded: data.dec(_f$isPetOnboarded),
      points: data.dec(_f$points),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      name: data.dec(_f$name),
      email: data.dec(_f$email),
      primaryIdentifier: data.dec(_f$primaryIdentifier),
      isSocialLogin: data.dec(_f$isSocialLogin),
      role: data.dec(_f$role),
      isVerified: data.dec(_f$isVerified),
      updatedAtLegacy: data.dec(_f$updatedAtLegacy),
      createdAtLegacy: data.dec(_f$createdAtLegacy),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static GoogleLoginUserResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GoogleLoginUserResponse>(map);
  }

  static GoogleLoginUserResponse fromJson(String json) {
    return ensureInitialized().decodeJson<GoogleLoginUserResponse>(json);
  }
}

mixin GoogleLoginUserResponseMappable {
  String toJson() {
    return GoogleLoginUserResponseMapper.ensureInitialized()
        .encodeJson<GoogleLoginUserResponse>(this as GoogleLoginUserResponse);
  }

  Map<String, dynamic> toMap() {
    return GoogleLoginUserResponseMapper.ensureInitialized()
        .encodeMap<GoogleLoginUserResponse>(this as GoogleLoginUserResponse);
  }

  GoogleLoginUserResponseCopyWith<
    GoogleLoginUserResponse,
    GoogleLoginUserResponse,
    GoogleLoginUserResponse
  >
  get copyWith =>
      _GoogleLoginUserResponseCopyWithImpl<
        GoogleLoginUserResponse,
        GoogleLoginUserResponse
      >(this as GoogleLoginUserResponse, $identity, $identity);
  @override
  String toString() {
    return GoogleLoginUserResponseMapper.ensureInitialized().stringifyValue(
      this as GoogleLoginUserResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return GoogleLoginUserResponseMapper.ensureInitialized().equalsValue(
      this as GoogleLoginUserResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return GoogleLoginUserResponseMapper.ensureInitialized().hashValue(
      this as GoogleLoginUserResponse,
    );
  }
}

extension GoogleLoginUserResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GoogleLoginUserResponse, $Out> {
  GoogleLoginUserResponseCopyWith<$R, GoogleLoginUserResponse, $Out>
  get $asGoogleLoginUserResponse => $base.as(
    (v, t, t2) => _GoogleLoginUserResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class GoogleLoginUserResponseCopyWith<
  $R,
  $In extends GoogleLoginUserResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? provider,
    bool? isActive,
    bool? isDeleted,
    bool? isOnboarded,
    bool? isProfileCompleted,
    bool? isPetOnboarded,
    int? points,
    String? createdAt,
    String? updatedAt,
    String? name,
    String? email,
    String? primaryIdentifier,
    bool? isSocialLogin,
    String? role,
    bool? isVerified,
    String? updatedAtLegacy,
    String? createdAtLegacy,
  });
  GoogleLoginUserResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _GoogleLoginUserResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GoogleLoginUserResponse, $Out>
    implements
        GoogleLoginUserResponseCopyWith<$R, GoogleLoginUserResponse, $Out> {
  _GoogleLoginUserResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GoogleLoginUserResponse> $mapper =
      GoogleLoginUserResponseMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? provider,
    bool? isActive,
    bool? isDeleted,
    bool? isOnboarded,
    bool? isProfileCompleted,
    bool? isPetOnboarded,
    int? points,
    String? createdAt,
    String? updatedAt,
    String? name,
    String? email,
    String? primaryIdentifier,
    bool? isSocialLogin,
    String? role,
    bool? isVerified,
    String? updatedAtLegacy,
    String? createdAtLegacy,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (provider != null) #provider: provider,
      if (isActive != null) #isActive: isActive,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (isOnboarded != null) #isOnboarded: isOnboarded,
      if (isProfileCompleted != null) #isProfileCompleted: isProfileCompleted,
      if (isPetOnboarded != null) #isPetOnboarded: isPetOnboarded,
      if (points != null) #points: points,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
      if (name != null) #name: name,
      if (email != null) #email: email,
      if (primaryIdentifier != null) #primaryIdentifier: primaryIdentifier,
      if (isSocialLogin != null) #isSocialLogin: isSocialLogin,
      if (role != null) #role: role,
      if (isVerified != null) #isVerified: isVerified,
      if (updatedAtLegacy != null) #updatedAtLegacy: updatedAtLegacy,
      if (createdAtLegacy != null) #createdAtLegacy: createdAtLegacy,
    }),
  );
  @override
  GoogleLoginUserResponse $make(CopyWithData data) => GoogleLoginUserResponse(
    id: data.get(#id, or: $value.id),
    provider: data.get(#provider, or: $value.provider),
    isActive: data.get(#isActive, or: $value.isActive),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
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
    email: data.get(#email, or: $value.email),
    primaryIdentifier: data.get(
      #primaryIdentifier,
      or: $value.primaryIdentifier,
    ),
    isSocialLogin: data.get(#isSocialLogin, or: $value.isSocialLogin),
    role: data.get(#role, or: $value.role),
    isVerified: data.get(#isVerified, or: $value.isVerified),
    updatedAtLegacy: data.get(#updatedAtLegacy, or: $value.updatedAtLegacy),
    createdAtLegacy: data.get(#createdAtLegacy, or: $value.createdAtLegacy),
  );

  @override
  GoogleLoginUserResponseCopyWith<$R2, GoogleLoginUserResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _GoogleLoginUserResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class GoogleLoginTokensResponseMapper
    extends ClassMapperBase<GoogleLoginTokensResponse> {
  GoogleLoginTokensResponseMapper._();

  static GoogleLoginTokensResponseMapper? _instance;
  static GoogleLoginTokensResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = GoogleLoginTokensResponseMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'GoogleLoginTokensResponse';

  static String _$accessToken(GoogleLoginTokensResponse v) => v.accessToken;
  static const Field<GoogleLoginTokensResponse, String> _f$accessToken = Field(
    'accessToken',
    _$accessToken,
    key: r'access_token',
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$refreshToken(GoogleLoginTokensResponse v) => v.refreshToken;
  static const Field<GoogleLoginTokensResponse, String> _f$refreshToken = Field(
    'refreshToken',
    _$refreshToken,
    key: r'refresh_token',
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$expiresIn(GoogleLoginTokensResponse v) => v.expiresIn;
  static const Field<GoogleLoginTokensResponse, String> _f$expiresIn = Field(
    'expiresIn',
    _$expiresIn,
    key: r'expires_in',
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$accessTokenExpiresAt(GoogleLoginTokensResponse v) =>
      v.accessTokenExpiresAt;
  static const Field<GoogleLoginTokensResponse, String>
  _f$accessTokenExpiresAt = Field(
    'accessTokenExpiresAt',
    _$accessTokenExpiresAt,
    key: r'access_token_expires_at',
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$refreshTokenExpiresAt(GoogleLoginTokensResponse v) =>
      v.refreshTokenExpiresAt;
  static const Field<GoogleLoginTokensResponse, String>
  _f$refreshTokenExpiresAt = Field(
    'refreshTokenExpiresAt',
    _$refreshTokenExpiresAt,
    key: r'refresh_token_expires_at',
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<GoogleLoginTokensResponse> fields = const {
    #accessToken: _f$accessToken,
    #refreshToken: _f$refreshToken,
    #expiresIn: _f$expiresIn,
    #accessTokenExpiresAt: _f$accessTokenExpiresAt,
    #refreshTokenExpiresAt: _f$refreshTokenExpiresAt,
  };

  static GoogleLoginTokensResponse _instantiate(DecodingData data) {
    return GoogleLoginTokensResponse(
      accessToken: data.dec(_f$accessToken),
      refreshToken: data.dec(_f$refreshToken),
      expiresIn: data.dec(_f$expiresIn),
      accessTokenExpiresAt: data.dec(_f$accessTokenExpiresAt),
      refreshTokenExpiresAt: data.dec(_f$refreshTokenExpiresAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static GoogleLoginTokensResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GoogleLoginTokensResponse>(map);
  }

  static GoogleLoginTokensResponse fromJson(String json) {
    return ensureInitialized().decodeJson<GoogleLoginTokensResponse>(json);
  }
}

mixin GoogleLoginTokensResponseMappable {
  String toJson() {
    return GoogleLoginTokensResponseMapper.ensureInitialized()
        .encodeJson<GoogleLoginTokensResponse>(
          this as GoogleLoginTokensResponse,
        );
  }

  Map<String, dynamic> toMap() {
    return GoogleLoginTokensResponseMapper.ensureInitialized()
        .encodeMap<GoogleLoginTokensResponse>(
          this as GoogleLoginTokensResponse,
        );
  }

  GoogleLoginTokensResponseCopyWith<
    GoogleLoginTokensResponse,
    GoogleLoginTokensResponse,
    GoogleLoginTokensResponse
  >
  get copyWith =>
      _GoogleLoginTokensResponseCopyWithImpl<
        GoogleLoginTokensResponse,
        GoogleLoginTokensResponse
      >(this as GoogleLoginTokensResponse, $identity, $identity);
  @override
  String toString() {
    return GoogleLoginTokensResponseMapper.ensureInitialized().stringifyValue(
      this as GoogleLoginTokensResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return GoogleLoginTokensResponseMapper.ensureInitialized().equalsValue(
      this as GoogleLoginTokensResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return GoogleLoginTokensResponseMapper.ensureInitialized().hashValue(
      this as GoogleLoginTokensResponse,
    );
  }
}

extension GoogleLoginTokensResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GoogleLoginTokensResponse, $Out> {
  GoogleLoginTokensResponseCopyWith<$R, GoogleLoginTokensResponse, $Out>
  get $asGoogleLoginTokensResponse => $base.as(
    (v, t, t2) => _GoogleLoginTokensResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class GoogleLoginTokensResponseCopyWith<
  $R,
  $In extends GoogleLoginTokensResponse,
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
  GoogleLoginTokensResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _GoogleLoginTokensResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GoogleLoginTokensResponse, $Out>
    implements
        GoogleLoginTokensResponseCopyWith<$R, GoogleLoginTokensResponse, $Out> {
  _GoogleLoginTokensResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GoogleLoginTokensResponse> $mapper =
      GoogleLoginTokensResponseMapper.ensureInitialized();
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
  GoogleLoginTokensResponse $make(CopyWithData data) =>
      GoogleLoginTokensResponse(
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
  GoogleLoginTokensResponseCopyWith<$R2, GoogleLoginTokensResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _GoogleLoginTokensResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

