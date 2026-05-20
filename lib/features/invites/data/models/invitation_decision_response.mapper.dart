// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'invitation_decision_response.dart';

class InvitationDecisionResponseMapper
    extends ClassMapperBase<InvitationDecisionResponse> {
  InvitationDecisionResponseMapper._();

  static InvitationDecisionResponseMapper? _instance;
  static InvitationDecisionResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = InvitationDecisionResponseMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'InvitationDecisionResponse';

  static String _$invitationId(InvitationDecisionResponse v) => v.invitationId;
  static const Field<InvitationDecisionResponse, String> _f$invitationId =
      Field(
        'invitationId',
        _$invitationId,
        opt: true,
        def: '',
        hook: SafeStringHook(),
      );
  static String _$parentGroupId(InvitationDecisionResponse v) =>
      v.parentGroupId;
  static const Field<InvitationDecisionResponse, String> _f$parentGroupId =
      Field(
        'parentGroupId',
        _$parentGroupId,
        opt: true,
        def: '',
        hook: SafeStringHook(),
      );
  static String _$role(InvitationDecisionResponse v) => v.role;
  static const Field<InvitationDecisionResponse, String> _f$role = Field(
    'role',
    _$role,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$acceptedAt(InvitationDecisionResponse v) => v.acceptedAt;
  static const Field<InvitationDecisionResponse, String> _f$acceptedAt = Field(
    'acceptedAt',
    _$acceptedAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$rejectedAt(InvitationDecisionResponse v) => v.rejectedAt;
  static const Field<InvitationDecisionResponse, String> _f$rejectedAt = Field(
    'rejectedAt',
    _$rejectedAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<InvitationDecisionResponse> fields = const {
    #invitationId: _f$invitationId,
    #parentGroupId: _f$parentGroupId,
    #role: _f$role,
    #acceptedAt: _f$acceptedAt,
    #rejectedAt: _f$rejectedAt,
  };

  static InvitationDecisionResponse _instantiate(DecodingData data) {
    return InvitationDecisionResponse(
      invitationId: data.dec(_f$invitationId),
      parentGroupId: data.dec(_f$parentGroupId),
      role: data.dec(_f$role),
      acceptedAt: data.dec(_f$acceptedAt),
      rejectedAt: data.dec(_f$rejectedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static InvitationDecisionResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<InvitationDecisionResponse>(map);
  }

  static InvitationDecisionResponse fromJson(String json) {
    return ensureInitialized().decodeJson<InvitationDecisionResponse>(json);
  }
}

mixin InvitationDecisionResponseMappable {
  String toJson() {
    return InvitationDecisionResponseMapper.ensureInitialized()
        .encodeJson<InvitationDecisionResponse>(
          this as InvitationDecisionResponse,
        );
  }

  Map<String, dynamic> toMap() {
    return InvitationDecisionResponseMapper.ensureInitialized()
        .encodeMap<InvitationDecisionResponse>(
          this as InvitationDecisionResponse,
        );
  }

  InvitationDecisionResponseCopyWith<
    InvitationDecisionResponse,
    InvitationDecisionResponse,
    InvitationDecisionResponse
  >
  get copyWith =>
      _InvitationDecisionResponseCopyWithImpl<
        InvitationDecisionResponse,
        InvitationDecisionResponse
      >(this as InvitationDecisionResponse, $identity, $identity);
  @override
  String toString() {
    return InvitationDecisionResponseMapper.ensureInitialized().stringifyValue(
      this as InvitationDecisionResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return InvitationDecisionResponseMapper.ensureInitialized().equalsValue(
      this as InvitationDecisionResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return InvitationDecisionResponseMapper.ensureInitialized().hashValue(
      this as InvitationDecisionResponse,
    );
  }
}

extension InvitationDecisionResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, InvitationDecisionResponse, $Out> {
  InvitationDecisionResponseCopyWith<$R, InvitationDecisionResponse, $Out>
  get $asInvitationDecisionResponse => $base.as(
    (v, t, t2) => _InvitationDecisionResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class InvitationDecisionResponseCopyWith<
  $R,
  $In extends InvitationDecisionResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? invitationId,
    String? parentGroupId,
    String? role,
    String? acceptedAt,
    String? rejectedAt,
  });
  InvitationDecisionResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _InvitationDecisionResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, InvitationDecisionResponse, $Out>
    implements
        InvitationDecisionResponseCopyWith<
          $R,
          InvitationDecisionResponse,
          $Out
        > {
  _InvitationDecisionResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<InvitationDecisionResponse> $mapper =
      InvitationDecisionResponseMapper.ensureInitialized();
  @override
  $R call({
    String? invitationId,
    String? parentGroupId,
    String? role,
    String? acceptedAt,
    String? rejectedAt,
  }) => $apply(
    FieldCopyWithData({
      if (invitationId != null) #invitationId: invitationId,
      if (parentGroupId != null) #parentGroupId: parentGroupId,
      if (role != null) #role: role,
      if (acceptedAt != null) #acceptedAt: acceptedAt,
      if (rejectedAt != null) #rejectedAt: rejectedAt,
    }),
  );
  @override
  InvitationDecisionResponse $make(CopyWithData data) =>
      InvitationDecisionResponse(
        invitationId: data.get(#invitationId, or: $value.invitationId),
        parentGroupId: data.get(#parentGroupId, or: $value.parentGroupId),
        role: data.get(#role, or: $value.role),
        acceptedAt: data.get(#acceptedAt, or: $value.acceptedAt),
        rejectedAt: data.get(#rejectedAt, or: $value.rejectedAt),
      );

  @override
  InvitationDecisionResponseCopyWith<$R2, InvitationDecisionResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _InvitationDecisionResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

