// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'login_with_otp_response.dart';

class LoginWithOtpResponseMapper extends ClassMapperBase<LoginWithOtpResponse> {
  LoginWithOtpResponseMapper._();

  static LoginWithOtpResponseMapper? _instance;
  static LoginWithOtpResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LoginWithOtpResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LoginWithOtpResponse';

  static String _$expiresIn(LoginWithOtpResponse v) => v.expiresIn;
  static const Field<LoginWithOtpResponse, String> _f$expiresIn = Field(
    'expiresIn',
    _$expiresIn,
    key: r'expires_in',
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<LoginWithOtpResponse> fields = const {
    #expiresIn: _f$expiresIn,
  };

  static LoginWithOtpResponse _instantiate(DecodingData data) {
    return LoginWithOtpResponse(expiresIn: data.dec(_f$expiresIn));
  }

  @override
  final Function instantiate = _instantiate;

  static LoginWithOtpResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LoginWithOtpResponse>(map);
  }

  static LoginWithOtpResponse fromJson(String json) {
    return ensureInitialized().decodeJson<LoginWithOtpResponse>(json);
  }
}

mixin LoginWithOtpResponseMappable {
  String toJson() {
    return LoginWithOtpResponseMapper.ensureInitialized()
        .encodeJson<LoginWithOtpResponse>(this as LoginWithOtpResponse);
  }

  Map<String, dynamic> toMap() {
    return LoginWithOtpResponseMapper.ensureInitialized()
        .encodeMap<LoginWithOtpResponse>(this as LoginWithOtpResponse);
  }

  LoginWithOtpResponseCopyWith<
    LoginWithOtpResponse,
    LoginWithOtpResponse,
    LoginWithOtpResponse
  >
  get copyWith =>
      _LoginWithOtpResponseCopyWithImpl<
        LoginWithOtpResponse,
        LoginWithOtpResponse
      >(this as LoginWithOtpResponse, $identity, $identity);
  @override
  String toString() {
    return LoginWithOtpResponseMapper.ensureInitialized().stringifyValue(
      this as LoginWithOtpResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return LoginWithOtpResponseMapper.ensureInitialized().equalsValue(
      this as LoginWithOtpResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return LoginWithOtpResponseMapper.ensureInitialized().hashValue(
      this as LoginWithOtpResponse,
    );
  }
}

extension LoginWithOtpResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LoginWithOtpResponse, $Out> {
  LoginWithOtpResponseCopyWith<$R, LoginWithOtpResponse, $Out>
  get $asLoginWithOtpResponse => $base.as(
    (v, t, t2) => _LoginWithOtpResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LoginWithOtpResponseCopyWith<
  $R,
  $In extends LoginWithOtpResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? expiresIn});
  LoginWithOtpResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LoginWithOtpResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LoginWithOtpResponse, $Out>
    implements LoginWithOtpResponseCopyWith<$R, LoginWithOtpResponse, $Out> {
  _LoginWithOtpResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LoginWithOtpResponse> $mapper =
      LoginWithOtpResponseMapper.ensureInitialized();
  @override
  $R call({String? expiresIn}) =>
      $apply(FieldCopyWithData({if (expiresIn != null) #expiresIn: expiresIn}));
  @override
  LoginWithOtpResponse $make(CopyWithData data) => LoginWithOtpResponse(
    expiresIn: data.get(#expiresIn, or: $value.expiresIn),
  );

  @override
  LoginWithOtpResponseCopyWith<$R2, LoginWithOtpResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LoginWithOtpResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

