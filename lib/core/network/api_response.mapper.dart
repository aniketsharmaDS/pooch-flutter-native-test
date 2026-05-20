// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'api_response.dart';

class ApiResponseMapper extends ClassMapperBase<ApiResponse> {
  ApiResponseMapper._();

  static ApiResponseMapper? _instance;
  static ApiResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ApiResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ApiResponse';

  static bool _$success(ApiResponse v) => v.success;
  static const Field<ApiResponse, bool> _f$success = Field(
    'success',
    _$success,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static String _$message(ApiResponse v) => v.message;
  static const Field<ApiResponse, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static int _$status(ApiResponse v) => v.status;
  static const Field<ApiResponse, int> _f$status = Field(
    'status',
    _$status,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );
  static dynamic _$data(ApiResponse v) => v.data;
  static const Field<ApiResponse, dynamic> _f$data = Field(
    'data',
    _$data,
    opt: true,
  );

  @override
  final MappableFields<ApiResponse> fields = const {
    #success: _f$success,
    #message: _f$message,
    #status: _f$status,
    #data: _f$data,
  };

  static ApiResponse _instantiate(DecodingData data) {
    return ApiResponse(
      success: data.dec(_f$success),
      message: data.dec(_f$message),
      status: data.dec(_f$status),
      data: data.dec(_f$data),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ApiResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ApiResponse>(map);
  }

  static ApiResponse fromJson(String json) {
    return ensureInitialized().decodeJson<ApiResponse>(json);
  }
}

mixin ApiResponseMappable {
  String toJson() {
    return ApiResponseMapper.ensureInitialized().encodeJson<ApiResponse>(
      this as ApiResponse,
    );
  }

  Map<String, dynamic> toMap() {
    return ApiResponseMapper.ensureInitialized().encodeMap<ApiResponse>(
      this as ApiResponse,
    );
  }

  ApiResponseCopyWith<ApiResponse, ApiResponse, ApiResponse> get copyWith =>
      _ApiResponseCopyWithImpl<ApiResponse, ApiResponse>(
        this as ApiResponse,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ApiResponseMapper.ensureInitialized().stringifyValue(
      this as ApiResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return ApiResponseMapper.ensureInitialized().equalsValue(
      this as ApiResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return ApiResponseMapper.ensureInitialized().hashValue(this as ApiResponse);
  }
}

extension ApiResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ApiResponse, $Out> {
  ApiResponseCopyWith<$R, ApiResponse, $Out> get $asApiResponse =>
      $base.as((v, t, t2) => _ApiResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ApiResponseCopyWith<$R, $In extends ApiResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? success, String? message, int? status, dynamic data});
  ApiResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ApiResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ApiResponse, $Out>
    implements ApiResponseCopyWith<$R, ApiResponse, $Out> {
  _ApiResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ApiResponse> $mapper =
      ApiResponseMapper.ensureInitialized();
  @override
  $R call({
    bool? success,
    String? message,
    int? status,
    Object? data = $none,
  }) => $apply(
    FieldCopyWithData({
      if (success != null) #success: success,
      if (message != null) #message: message,
      if (status != null) #status: status,
      if (data != $none) #data: data,
    }),
  );
  @override
  ApiResponse $make(CopyWithData data) => ApiResponse(
    success: data.get(#success, or: $value.success),
    message: data.get(#message, or: $value.message),
    status: data.get(#status, or: $value.status),
    data: data.get(#data, or: $value.data),
  );

  @override
  ApiResponseCopyWith<$R2, ApiResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ApiResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

