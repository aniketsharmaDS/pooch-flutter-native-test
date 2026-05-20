// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'register_response.dart';

class RegisterResponseMapper extends ClassMapperBase<RegisterResponse> {
  RegisterResponseMapper._();

  static RegisterResponseMapper? _instance;
  static RegisterResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RegisterResponseMapper._());
      RegisterUserResponseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RegisterResponse';

  static RegisterUserResponse _$user(RegisterResponse v) => v.user;
  static const Field<RegisterResponse, RegisterUserResponse> _f$user = Field(
    'user',
    _$user,
    opt: true,
    def: const RegisterUserResponse(),
  );
  static bool _$needsOtpVerification(RegisterResponse v) =>
      v.needsOtpVerification;
  static const Field<RegisterResponse, bool> _f$needsOtpVerification = Field(
    'needsOtpVerification',
    _$needsOtpVerification,
    key: r'needsOTPVerification',
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static String _$verificationToken(RegisterResponse v) => v.verificationToken;
  static const Field<RegisterResponse, String> _f$verificationToken = Field(
    'verificationToken',
    _$verificationToken,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<RegisterResponse> fields = const {
    #user: _f$user,
    #needsOtpVerification: _f$needsOtpVerification,
    #verificationToken: _f$verificationToken,
  };

  static RegisterResponse _instantiate(DecodingData data) {
    return RegisterResponse(
      user: data.dec(_f$user),
      needsOtpVerification: data.dec(_f$needsOtpVerification),
      verificationToken: data.dec(_f$verificationToken),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RegisterResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RegisterResponse>(map);
  }

  static RegisterResponse fromJson(String json) {
    return ensureInitialized().decodeJson<RegisterResponse>(json);
  }
}

mixin RegisterResponseMappable {
  String toJson() {
    return RegisterResponseMapper.ensureInitialized()
        .encodeJson<RegisterResponse>(this as RegisterResponse);
  }

  Map<String, dynamic> toMap() {
    return RegisterResponseMapper.ensureInitialized()
        .encodeMap<RegisterResponse>(this as RegisterResponse);
  }

  RegisterResponseCopyWith<RegisterResponse, RegisterResponse, RegisterResponse>
  get copyWith =>
      _RegisterResponseCopyWithImpl<RegisterResponse, RegisterResponse>(
        this as RegisterResponse,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return RegisterResponseMapper.ensureInitialized().stringifyValue(
      this as RegisterResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return RegisterResponseMapper.ensureInitialized().equalsValue(
      this as RegisterResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return RegisterResponseMapper.ensureInitialized().hashValue(
      this as RegisterResponse,
    );
  }
}

extension RegisterResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RegisterResponse, $Out> {
  RegisterResponseCopyWith<$R, RegisterResponse, $Out>
  get $asRegisterResponse =>
      $base.as((v, t, t2) => _RegisterResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class RegisterResponseCopyWith<$R, $In extends RegisterResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  RegisterUserResponseCopyWith<$R, RegisterUserResponse, RegisterUserResponse>
  get user;
  $R call({
    RegisterUserResponse? user,
    bool? needsOtpVerification,
    String? verificationToken,
  });
  RegisterResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RegisterResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RegisterResponse, $Out>
    implements RegisterResponseCopyWith<$R, RegisterResponse, $Out> {
  _RegisterResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RegisterResponse> $mapper =
      RegisterResponseMapper.ensureInitialized();
  @override
  RegisterUserResponseCopyWith<$R, RegisterUserResponse, RegisterUserResponse>
  get user => $value.user.copyWith.$chain((v) => call(user: v));
  @override
  $R call({
    RegisterUserResponse? user,
    bool? needsOtpVerification,
    String? verificationToken,
  }) => $apply(
    FieldCopyWithData({
      if (user != null) #user: user,
      if (needsOtpVerification != null)
        #needsOtpVerification: needsOtpVerification,
      if (verificationToken != null) #verificationToken: verificationToken,
    }),
  );
  @override
  RegisterResponse $make(CopyWithData data) => RegisterResponse(
    user: data.get(#user, or: $value.user),
    needsOtpVerification: data.get(
      #needsOtpVerification,
      or: $value.needsOtpVerification,
    ),
    verificationToken: data.get(
      #verificationToken,
      or: $value.verificationToken,
    ),
  );

  @override
  RegisterResponseCopyWith<$R2, RegisterResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _RegisterResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class RegisterUserResponseMapper extends ClassMapperBase<RegisterUserResponse> {
  RegisterUserResponseMapper._();

  static RegisterUserResponseMapper? _instance;
  static RegisterUserResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RegisterUserResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'RegisterUserResponse';

  static String _$name(RegisterUserResponse v) => v.name;
  static const Field<RegisterUserResponse, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$phone(RegisterUserResponse v) => v.phone;
  static const Field<RegisterUserResponse, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$role(RegisterUserResponse v) => v.role;
  static const Field<RegisterUserResponse, String> _f$role = Field(
    'role',
    _$role,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static bool _$hasInvites(RegisterUserResponse v) => v.hasInvites;
  static const Field<RegisterUserResponse, bool> _f$hasInvites = Field(
    'hasInvites',
    _$hasInvites,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static String _$email(RegisterUserResponse v) => v.email;
  static const Field<RegisterUserResponse, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<RegisterUserResponse> fields = const {
    #name: _f$name,
    #phone: _f$phone,
    #role: _f$role,
    #hasInvites: _f$hasInvites,
    #email: _f$email,
  };

  static RegisterUserResponse _instantiate(DecodingData data) {
    return RegisterUserResponse(
      name: data.dec(_f$name),
      phone: data.dec(_f$phone),
      role: data.dec(_f$role),
      hasInvites: data.dec(_f$hasInvites),
      email: data.dec(_f$email),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RegisterUserResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RegisterUserResponse>(map);
  }

  static RegisterUserResponse fromJson(String json) {
    return ensureInitialized().decodeJson<RegisterUserResponse>(json);
  }
}

mixin RegisterUserResponseMappable {
  String toJson() {
    return RegisterUserResponseMapper.ensureInitialized()
        .encodeJson<RegisterUserResponse>(this as RegisterUserResponse);
  }

  Map<String, dynamic> toMap() {
    return RegisterUserResponseMapper.ensureInitialized()
        .encodeMap<RegisterUserResponse>(this as RegisterUserResponse);
  }

  RegisterUserResponseCopyWith<
    RegisterUserResponse,
    RegisterUserResponse,
    RegisterUserResponse
  >
  get copyWith =>
      _RegisterUserResponseCopyWithImpl<
        RegisterUserResponse,
        RegisterUserResponse
      >(this as RegisterUserResponse, $identity, $identity);
  @override
  String toString() {
    return RegisterUserResponseMapper.ensureInitialized().stringifyValue(
      this as RegisterUserResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return RegisterUserResponseMapper.ensureInitialized().equalsValue(
      this as RegisterUserResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return RegisterUserResponseMapper.ensureInitialized().hashValue(
      this as RegisterUserResponse,
    );
  }
}

extension RegisterUserResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RegisterUserResponse, $Out> {
  RegisterUserResponseCopyWith<$R, RegisterUserResponse, $Out>
  get $asRegisterUserResponse => $base.as(
    (v, t, t2) => _RegisterUserResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class RegisterUserResponseCopyWith<
  $R,
  $In extends RegisterUserResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? name,
    String? phone,
    String? role,
    bool? hasInvites,
    String? email,
  });
  RegisterUserResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RegisterUserResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RegisterUserResponse, $Out>
    implements RegisterUserResponseCopyWith<$R, RegisterUserResponse, $Out> {
  _RegisterUserResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RegisterUserResponse> $mapper =
      RegisterUserResponseMapper.ensureInitialized();
  @override
  $R call({
    String? name,
    String? phone,
    String? role,
    bool? hasInvites,
    String? email,
  }) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (phone != null) #phone: phone,
      if (role != null) #role: role,
      if (hasInvites != null) #hasInvites: hasInvites,
      if (email != null) #email: email,
    }),
  );
  @override
  RegisterUserResponse $make(CopyWithData data) => RegisterUserResponse(
    name: data.get(#name, or: $value.name),
    phone: data.get(#phone, or: $value.phone),
    role: data.get(#role, or: $value.role),
    hasInvites: data.get(#hasInvites, or: $value.hasInvites),
    email: data.get(#email, or: $value.email),
  );

  @override
  RegisterUserResponseCopyWith<$R2, RegisterUserResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _RegisterUserResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

