// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'otp_send_response.dart';

class OtpSendResponseMapper extends ClassMapperBase<OtpSendResponse> {
  OtpSendResponseMapper._();

  static OtpSendResponseMapper? _instance;
  static OtpSendResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OtpSendResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'OtpSendResponse';

  static String _$placeholder(OtpSendResponse v) => v.placeholder;
  static const Field<OtpSendResponse, String> _f$placeholder = Field(
    'placeholder',
    _$placeholder,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<OtpSendResponse> fields = const {
    #placeholder: _f$placeholder,
  };

  static OtpSendResponse _instantiate(DecodingData data) {
    return OtpSendResponse(placeholder: data.dec(_f$placeholder));
  }

  @override
  final Function instantiate = _instantiate;

  static OtpSendResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<OtpSendResponse>(map);
  }

  static OtpSendResponse fromJson(String json) {
    return ensureInitialized().decodeJson<OtpSendResponse>(json);
  }
}

mixin OtpSendResponseMappable {
  String toJson() {
    return OtpSendResponseMapper.ensureInitialized()
        .encodeJson<OtpSendResponse>(this as OtpSendResponse);
  }

  Map<String, dynamic> toMap() {
    return OtpSendResponseMapper.ensureInitialized().encodeMap<OtpSendResponse>(
      this as OtpSendResponse,
    );
  }

  OtpSendResponseCopyWith<OtpSendResponse, OtpSendResponse, OtpSendResponse>
  get copyWith =>
      _OtpSendResponseCopyWithImpl<OtpSendResponse, OtpSendResponse>(
        this as OtpSendResponse,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return OtpSendResponseMapper.ensureInitialized().stringifyValue(
      this as OtpSendResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return OtpSendResponseMapper.ensureInitialized().equalsValue(
      this as OtpSendResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return OtpSendResponseMapper.ensureInitialized().hashValue(
      this as OtpSendResponse,
    );
  }
}

extension OtpSendResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, OtpSendResponse, $Out> {
  OtpSendResponseCopyWith<$R, OtpSendResponse, $Out> get $asOtpSendResponse =>
      $base.as((v, t, t2) => _OtpSendResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class OtpSendResponseCopyWith<$R, $In extends OtpSendResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? placeholder});
  OtpSendResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _OtpSendResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OtpSendResponse, $Out>
    implements OtpSendResponseCopyWith<$R, OtpSendResponse, $Out> {
  _OtpSendResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OtpSendResponse> $mapper =
      OtpSendResponseMapper.ensureInitialized();
  @override
  $R call({String? placeholder}) => $apply(
    FieldCopyWithData({if (placeholder != null) #placeholder: placeholder}),
  );
  @override
  OtpSendResponse $make(CopyWithData data) => OtpSendResponse(
    placeholder: data.get(#placeholder, or: $value.placeholder),
  );

  @override
  OtpSendResponseCopyWith<$R2, OtpSendResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _OtpSendResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

