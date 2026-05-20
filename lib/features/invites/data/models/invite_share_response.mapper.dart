// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'invite_share_response.dart';

class InviteShareInvitationResponseMapper
    extends ClassMapperBase<InviteShareInvitationResponse> {
  InviteShareInvitationResponseMapper._();

  static InviteShareInvitationResponseMapper? _instance;
  static InviteShareInvitationResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = InviteShareInvitationResponseMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'InviteShareInvitationResponse';

  static String _$id(InviteShareInvitationResponse v) => v.id;
  static const Field<InviteShareInvitationResponse, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$inviteePhone(InviteShareInvitationResponse v) =>
      v.inviteePhone;
  static const Field<InviteShareInvitationResponse, String> _f$inviteePhone =
      Field(
        'inviteePhone',
        _$inviteePhone,
        opt: true,
        def: '',
        hook: SafeStringHook(),
      );
  static String _$targetContact(InviteShareInvitationResponse v) =>
      v.targetContact;
  static const Field<InviteShareInvitationResponse, String> _f$targetContact =
      Field(
        'targetContact',
        _$targetContact,
        opt: true,
        def: '',
        hook: SafeStringHook(),
      );
  static String _$contactType(InviteShareInvitationResponse v) => v.contactType;
  static const Field<InviteShareInvitationResponse, String> _f$contactType =
      Field(
        'contactType',
        _$contactType,
        opt: true,
        def: '',
        hook: SafeStringHook(),
      );
  static String _$assignedRole(InviteShareInvitationResponse v) =>
      v.assignedRole;
  static const Field<InviteShareInvitationResponse, String> _f$assignedRole =
      Field(
        'assignedRole',
        _$assignedRole,
        opt: true,
        def: '',
        hook: SafeStringHook(),
      );
  static String _$roleDisplayName(InviteShareInvitationResponse v) =>
      v.roleDisplayName;
  static const Field<InviteShareInvitationResponse, String> _f$roleDisplayName =
      Field(
        'roleDisplayName',
        _$roleDisplayName,
        opt: true,
        def: '',
        hook: SafeStringHook(),
      );
  static bool _$isNetworkInvite(InviteShareInvitationResponse v) =>
      v.isNetworkInvite;
  static const Field<InviteShareInvitationResponse, bool> _f$isNetworkInvite =
      Field(
        'isNetworkInvite',
        _$isNetworkInvite,
        opt: true,
        def: false,
        hook: SafeBoolHook(),
      );
  static String _$networkInviteType(InviteShareInvitationResponse v) =>
      v.networkInviteType;
  static const Field<InviteShareInvitationResponse, String>
  _f$networkInviteType = Field(
    'networkInviteType',
    _$networkInviteType,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$status(InviteShareInvitationResponse v) => v.status;
  static const Field<InviteShareInvitationResponse, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$expiresAt(InviteShareInvitationResponse v) => v.expiresAt;
  static const Field<InviteShareInvitationResponse, String> _f$expiresAt =
      Field(
        'expiresAt',
        _$expiresAt,
        opt: true,
        def: '',
        hook: SafeStringHook(),
      );
  static String _$inviteLink(InviteShareInvitationResponse v) => v.inviteLink;
  static const Field<InviteShareInvitationResponse, String> _f$inviteLink =
      Field(
        'inviteLink',
        _$inviteLink,
        opt: true,
        def: '',
        hook: SafeStringHook(),
      );

  @override
  final MappableFields<InviteShareInvitationResponse> fields = const {
    #id: _f$id,
    #inviteePhone: _f$inviteePhone,
    #targetContact: _f$targetContact,
    #contactType: _f$contactType,
    #assignedRole: _f$assignedRole,
    #roleDisplayName: _f$roleDisplayName,
    #isNetworkInvite: _f$isNetworkInvite,
    #networkInviteType: _f$networkInviteType,
    #status: _f$status,
    #expiresAt: _f$expiresAt,
    #inviteLink: _f$inviteLink,
  };

  static InviteShareInvitationResponse _instantiate(DecodingData data) {
    return InviteShareInvitationResponse(
      id: data.dec(_f$id),
      inviteePhone: data.dec(_f$inviteePhone),
      targetContact: data.dec(_f$targetContact),
      contactType: data.dec(_f$contactType),
      assignedRole: data.dec(_f$assignedRole),
      roleDisplayName: data.dec(_f$roleDisplayName),
      isNetworkInvite: data.dec(_f$isNetworkInvite),
      networkInviteType: data.dec(_f$networkInviteType),
      status: data.dec(_f$status),
      expiresAt: data.dec(_f$expiresAt),
      inviteLink: data.dec(_f$inviteLink),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static InviteShareInvitationResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<InviteShareInvitationResponse>(map);
  }

  static InviteShareInvitationResponse fromJson(String json) {
    return ensureInitialized().decodeJson<InviteShareInvitationResponse>(json);
  }
}

mixin InviteShareInvitationResponseMappable {
  String toJson() {
    return InviteShareInvitationResponseMapper.ensureInitialized()
        .encodeJson<InviteShareInvitationResponse>(
          this as InviteShareInvitationResponse,
        );
  }

  Map<String, dynamic> toMap() {
    return InviteShareInvitationResponseMapper.ensureInitialized()
        .encodeMap<InviteShareInvitationResponse>(
          this as InviteShareInvitationResponse,
        );
  }

  InviteShareInvitationResponseCopyWith<
    InviteShareInvitationResponse,
    InviteShareInvitationResponse,
    InviteShareInvitationResponse
  >
  get copyWith =>
      _InviteShareInvitationResponseCopyWithImpl<
        InviteShareInvitationResponse,
        InviteShareInvitationResponse
      >(this as InviteShareInvitationResponse, $identity, $identity);
  @override
  String toString() {
    return InviteShareInvitationResponseMapper.ensureInitialized()
        .stringifyValue(this as InviteShareInvitationResponse);
  }

  @override
  bool operator ==(Object other) {
    return InviteShareInvitationResponseMapper.ensureInitialized().equalsValue(
      this as InviteShareInvitationResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return InviteShareInvitationResponseMapper.ensureInitialized().hashValue(
      this as InviteShareInvitationResponse,
    );
  }
}

extension InviteShareInvitationResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, InviteShareInvitationResponse, $Out> {
  InviteShareInvitationResponseCopyWith<$R, InviteShareInvitationResponse, $Out>
  get $asInviteShareInvitationResponse => $base.as(
    (v, t, t2) =>
        _InviteShareInvitationResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class InviteShareInvitationResponseCopyWith<
  $R,
  $In extends InviteShareInvitationResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? inviteePhone,
    String? targetContact,
    String? contactType,
    String? assignedRole,
    String? roleDisplayName,
    bool? isNetworkInvite,
    String? networkInviteType,
    String? status,
    String? expiresAt,
    String? inviteLink,
  });
  InviteShareInvitationResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _InviteShareInvitationResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, InviteShareInvitationResponse, $Out>
    implements
        InviteShareInvitationResponseCopyWith<
          $R,
          InviteShareInvitationResponse,
          $Out
        > {
  _InviteShareInvitationResponseCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<InviteShareInvitationResponse> $mapper =
      InviteShareInvitationResponseMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? inviteePhone,
    String? targetContact,
    String? contactType,
    String? assignedRole,
    String? roleDisplayName,
    bool? isNetworkInvite,
    String? networkInviteType,
    String? status,
    String? expiresAt,
    String? inviteLink,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (inviteePhone != null) #inviteePhone: inviteePhone,
      if (targetContact != null) #targetContact: targetContact,
      if (contactType != null) #contactType: contactType,
      if (assignedRole != null) #assignedRole: assignedRole,
      if (roleDisplayName != null) #roleDisplayName: roleDisplayName,
      if (isNetworkInvite != null) #isNetworkInvite: isNetworkInvite,
      if (networkInviteType != null) #networkInviteType: networkInviteType,
      if (status != null) #status: status,
      if (expiresAt != null) #expiresAt: expiresAt,
      if (inviteLink != null) #inviteLink: inviteLink,
    }),
  );
  @override
  InviteShareInvitationResponse $make(CopyWithData data) =>
      InviteShareInvitationResponse(
        id: data.get(#id, or: $value.id),
        inviteePhone: data.get(#inviteePhone, or: $value.inviteePhone),
        targetContact: data.get(#targetContact, or: $value.targetContact),
        contactType: data.get(#contactType, or: $value.contactType),
        assignedRole: data.get(#assignedRole, or: $value.assignedRole),
        roleDisplayName: data.get(#roleDisplayName, or: $value.roleDisplayName),
        isNetworkInvite: data.get(#isNetworkInvite, or: $value.isNetworkInvite),
        networkInviteType: data.get(
          #networkInviteType,
          or: $value.networkInviteType,
        ),
        status: data.get(#status, or: $value.status),
        expiresAt: data.get(#expiresAt, or: $value.expiresAt),
        inviteLink: data.get(#inviteLink, or: $value.inviteLink),
      );

  @override
  InviteShareInvitationResponseCopyWith<
    $R2,
    InviteShareInvitationResponse,
    $Out2
  >
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _InviteShareInvitationResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class InviteShareResponseMapper extends ClassMapperBase<InviteShareResponse> {
  InviteShareResponseMapper._();

  static InviteShareResponseMapper? _instance;
  static InviteShareResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = InviteShareResponseMapper._());
      InviteShareInvitationResponseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'InviteShareResponse';

  static String _$parentGroupId(InviteShareResponse v) => v.parentGroupId;
  static const Field<InviteShareResponse, String> _f$parentGroupId = Field(
    'parentGroupId',
    _$parentGroupId,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$type(InviteShareResponse v) => v.type;
  static const Field<InviteShareResponse, String> _f$type = Field(
    'type',
    _$type,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static InviteShareInvitationResponse _$invitation(InviteShareResponse v) =>
      v.invitation;
  static const Field<InviteShareResponse, InviteShareInvitationResponse>
  _f$invitation = Field(
    'invitation',
    _$invitation,
    opt: true,
    def: const InviteShareInvitationResponse(),
  );
  static String _$sharedBy(InviteShareResponse v) => v.sharedBy;
  static const Field<InviteShareResponse, String> _f$sharedBy = Field(
    'sharedBy',
    _$sharedBy,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$invitedAt(InviteShareResponse v) => v.invitedAt;
  static const Field<InviteShareResponse, String> _f$invitedAt = Field(
    'invitedAt',
    _$invitedAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<InviteShareResponse> fields = const {
    #parentGroupId: _f$parentGroupId,
    #type: _f$type,
    #invitation: _f$invitation,
    #sharedBy: _f$sharedBy,
    #invitedAt: _f$invitedAt,
  };

  static InviteShareResponse _instantiate(DecodingData data) {
    return InviteShareResponse(
      parentGroupId: data.dec(_f$parentGroupId),
      type: data.dec(_f$type),
      invitation: data.dec(_f$invitation),
      sharedBy: data.dec(_f$sharedBy),
      invitedAt: data.dec(_f$invitedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static InviteShareResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<InviteShareResponse>(map);
  }

  static InviteShareResponse fromJson(String json) {
    return ensureInitialized().decodeJson<InviteShareResponse>(json);
  }
}

mixin InviteShareResponseMappable {
  String toJson() {
    return InviteShareResponseMapper.ensureInitialized()
        .encodeJson<InviteShareResponse>(this as InviteShareResponse);
  }

  Map<String, dynamic> toMap() {
    return InviteShareResponseMapper.ensureInitialized()
        .encodeMap<InviteShareResponse>(this as InviteShareResponse);
  }

  InviteShareResponseCopyWith<
    InviteShareResponse,
    InviteShareResponse,
    InviteShareResponse
  >
  get copyWith =>
      _InviteShareResponseCopyWithImpl<
        InviteShareResponse,
        InviteShareResponse
      >(this as InviteShareResponse, $identity, $identity);
  @override
  String toString() {
    return InviteShareResponseMapper.ensureInitialized().stringifyValue(
      this as InviteShareResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return InviteShareResponseMapper.ensureInitialized().equalsValue(
      this as InviteShareResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return InviteShareResponseMapper.ensureInitialized().hashValue(
      this as InviteShareResponse,
    );
  }
}

extension InviteShareResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, InviteShareResponse, $Out> {
  InviteShareResponseCopyWith<$R, InviteShareResponse, $Out>
  get $asInviteShareResponse => $base.as(
    (v, t, t2) => _InviteShareResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class InviteShareResponseCopyWith<
  $R,
  $In extends InviteShareResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  InviteShareInvitationResponseCopyWith<
    $R,
    InviteShareInvitationResponse,
    InviteShareInvitationResponse
  >
  get invitation;
  $R call({
    String? parentGroupId,
    String? type,
    InviteShareInvitationResponse? invitation,
    String? sharedBy,
    String? invitedAt,
  });
  InviteShareResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _InviteShareResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, InviteShareResponse, $Out>
    implements InviteShareResponseCopyWith<$R, InviteShareResponse, $Out> {
  _InviteShareResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<InviteShareResponse> $mapper =
      InviteShareResponseMapper.ensureInitialized();
  @override
  InviteShareInvitationResponseCopyWith<
    $R,
    InviteShareInvitationResponse,
    InviteShareInvitationResponse
  >
  get invitation =>
      $value.invitation.copyWith.$chain((v) => call(invitation: v));
  @override
  $R call({
    String? parentGroupId,
    String? type,
    InviteShareInvitationResponse? invitation,
    String? sharedBy,
    String? invitedAt,
  }) => $apply(
    FieldCopyWithData({
      if (parentGroupId != null) #parentGroupId: parentGroupId,
      if (type != null) #type: type,
      if (invitation != null) #invitation: invitation,
      if (sharedBy != null) #sharedBy: sharedBy,
      if (invitedAt != null) #invitedAt: invitedAt,
    }),
  );
  @override
  InviteShareResponse $make(CopyWithData data) => InviteShareResponse(
    parentGroupId: data.get(#parentGroupId, or: $value.parentGroupId),
    type: data.get(#type, or: $value.type),
    invitation: data.get(#invitation, or: $value.invitation),
    sharedBy: data.get(#sharedBy, or: $value.sharedBy),
    invitedAt: data.get(#invitedAt, or: $value.invitedAt),
  );

  @override
  InviteShareResponseCopyWith<$R2, InviteShareResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _InviteShareResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

