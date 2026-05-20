// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'identifier_otp_send_response.dart';

class IdentifierOtpSendResponseMapper
    extends ClassMapperBase<IdentifierOtpSendResponse> {
  IdentifierOtpSendResponseMapper._();

  static IdentifierOtpSendResponseMapper? _instance;
  static IdentifierOtpSendResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = IdentifierOtpSendResponseMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'IdentifierOtpSendResponse';

  static String _$placeholder(IdentifierOtpSendResponse v) => v.placeholder;
  static const Field<IdentifierOtpSendResponse, String> _f$placeholder = Field(
    'placeholder',
    _$placeholder,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<IdentifierOtpSendResponse> fields = const {
    #placeholder: _f$placeholder,
  };

  static IdentifierOtpSendResponse _instantiate(DecodingData data) {
    return IdentifierOtpSendResponse(placeholder: data.dec(_f$placeholder));
  }

  @override
  final Function instantiate = _instantiate;

  static IdentifierOtpSendResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IdentifierOtpSendResponse>(map);
  }

  static IdentifierOtpSendResponse fromJson(String json) {
    return ensureInitialized().decodeJson<IdentifierOtpSendResponse>(json);
  }
}

mixin IdentifierOtpSendResponseMappable {
  String toJson() {
    return IdentifierOtpSendResponseMapper.ensureInitialized()
        .encodeJson<IdentifierOtpSendResponse>(
          this as IdentifierOtpSendResponse,
        );
  }

  Map<String, dynamic> toMap() {
    return IdentifierOtpSendResponseMapper.ensureInitialized()
        .encodeMap<IdentifierOtpSendResponse>(
          this as IdentifierOtpSendResponse,
        );
  }

  IdentifierOtpSendResponseCopyWith<
    IdentifierOtpSendResponse,
    IdentifierOtpSendResponse,
    IdentifierOtpSendResponse
  >
  get copyWith =>
      _IdentifierOtpSendResponseCopyWithImpl<
        IdentifierOtpSendResponse,
        IdentifierOtpSendResponse
      >(this as IdentifierOtpSendResponse, $identity, $identity);
  @override
  String toString() {
    return IdentifierOtpSendResponseMapper.ensureInitialized().stringifyValue(
      this as IdentifierOtpSendResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return IdentifierOtpSendResponseMapper.ensureInitialized().equalsValue(
      this as IdentifierOtpSendResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return IdentifierOtpSendResponseMapper.ensureInitialized().hashValue(
      this as IdentifierOtpSendResponse,
    );
  }
}

extension IdentifierOtpSendResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IdentifierOtpSendResponse, $Out> {
  IdentifierOtpSendResponseCopyWith<$R, IdentifierOtpSendResponse, $Out>
  get $asIdentifierOtpSendResponse => $base.as(
    (v, t, t2) => _IdentifierOtpSendResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class IdentifierOtpSendResponseCopyWith<
  $R,
  $In extends IdentifierOtpSendResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? placeholder});
  IdentifierOtpSendResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _IdentifierOtpSendResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IdentifierOtpSendResponse, $Out>
    implements
        IdentifierOtpSendResponseCopyWith<$R, IdentifierOtpSendResponse, $Out> {
  _IdentifierOtpSendResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IdentifierOtpSendResponse> $mapper =
      IdentifierOtpSendResponseMapper.ensureInitialized();
  @override
  $R call({String? placeholder}) => $apply(
    FieldCopyWithData({if (placeholder != null) #placeholder: placeholder}),
  );
  @override
  IdentifierOtpSendResponse $make(CopyWithData data) =>
      IdentifierOtpSendResponse(
        placeholder: data.get(#placeholder, or: $value.placeholder),
      );

  @override
  IdentifierOtpSendResponseCopyWith<$R2, IdentifierOtpSendResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _IdentifierOtpSendResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

