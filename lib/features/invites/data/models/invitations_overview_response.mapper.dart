// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'invitations_overview_response.dart';

class InviteParentGroupResponseMapper
    extends ClassMapperBase<InviteParentGroupResponse> {
  InviteParentGroupResponseMapper._();

  static InviteParentGroupResponseMapper? _instance;
  static InviteParentGroupResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = InviteParentGroupResponseMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'InviteParentGroupResponse';

  static String _$id(InviteParentGroupResponse v) => v.id;
  static const Field<InviteParentGroupResponse, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$houseName(InviteParentGroupResponse v) => v.houseName;
  static const Field<InviteParentGroupResponse, String> _f$houseName = Field(
    'houseName',
    _$houseName,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$parentName(InviteParentGroupResponse v) => v.parentName;
  static const Field<InviteParentGroupResponse, String> _f$parentName = Field(
    'parentName',
    _$parentName,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$createdBy(InviteParentGroupResponse v) => v.createdBy;
  static const Field<InviteParentGroupResponse, String> _f$createdBy = Field(
    'createdBy',
    _$createdBy,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<InviteParentGroupResponse> fields = const {
    #id: _f$id,
    #houseName: _f$houseName,
    #parentName: _f$parentName,
    #createdBy: _f$createdBy,
  };

  static InviteParentGroupResponse _instantiate(DecodingData data) {
    return InviteParentGroupResponse(
      id: data.dec(_f$id),
      houseName: data.dec(_f$houseName),
      parentName: data.dec(_f$parentName),
      createdBy: data.dec(_f$createdBy),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static InviteParentGroupResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<InviteParentGroupResponse>(map);
  }

  static InviteParentGroupResponse fromJson(String json) {
    return ensureInitialized().decodeJson<InviteParentGroupResponse>(json);
  }
}

mixin InviteParentGroupResponseMappable {
  String toJson() {
    return InviteParentGroupResponseMapper.ensureInitialized()
        .encodeJson<InviteParentGroupResponse>(
          this as InviteParentGroupResponse,
        );
  }

  Map<String, dynamic> toMap() {
    return InviteParentGroupResponseMapper.ensureInitialized()
        .encodeMap<InviteParentGroupResponse>(
          this as InviteParentGroupResponse,
        );
  }

  InviteParentGroupResponseCopyWith<
    InviteParentGroupResponse,
    InviteParentGroupResponse,
    InviteParentGroupResponse
  >
  get copyWith =>
      _InviteParentGroupResponseCopyWithImpl<
        InviteParentGroupResponse,
        InviteParentGroupResponse
      >(this as InviteParentGroupResponse, $identity, $identity);
  @override
  String toString() {
    return InviteParentGroupResponseMapper.ensureInitialized().stringifyValue(
      this as InviteParentGroupResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return InviteParentGroupResponseMapper.ensureInitialized().equalsValue(
      this as InviteParentGroupResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return InviteParentGroupResponseMapper.ensureInitialized().hashValue(
      this as InviteParentGroupResponse,
    );
  }
}

extension InviteParentGroupResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, InviteParentGroupResponse, $Out> {
  InviteParentGroupResponseCopyWith<$R, InviteParentGroupResponse, $Out>
  get $asInviteParentGroupResponse => $base.as(
    (v, t, t2) => _InviteParentGroupResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class InviteParentGroupResponseCopyWith<
  $R,
  $In extends InviteParentGroupResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? houseName,
    String? parentName,
    String? createdBy,
  });
  InviteParentGroupResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _InviteParentGroupResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, InviteParentGroupResponse, $Out>
    implements
        InviteParentGroupResponseCopyWith<$R, InviteParentGroupResponse, $Out> {
  _InviteParentGroupResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<InviteParentGroupResponse> $mapper =
      InviteParentGroupResponseMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? houseName,
    String? parentName,
    String? createdBy,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (houseName != null) #houseName: houseName,
      if (parentName != null) #parentName: parentName,
      if (createdBy != null) #createdBy: createdBy,
    }),
  );
  @override
  InviteParentGroupResponse $make(CopyWithData data) =>
      InviteParentGroupResponse(
        id: data.get(#id, or: $value.id),
        houseName: data.get(#houseName, or: $value.houseName),
        parentName: data.get(#parentName, or: $value.parentName),
        createdBy: data.get(#createdBy, or: $value.createdBy),
      );

  @override
  InviteParentGroupResponseCopyWith<$R2, InviteParentGroupResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _InviteParentGroupResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class InviteUserResponseMapper extends ClassMapperBase<InviteUserResponse> {
  InviteUserResponseMapper._();

  static InviteUserResponseMapper? _instance;
  static InviteUserResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = InviteUserResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'InviteUserResponse';

  static String _$id(InviteUserResponse v) => v.id;
  static const Field<InviteUserResponse, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$name(InviteUserResponse v) => v.name;
  static const Field<InviteUserResponse, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$email(InviteUserResponse v) => v.email;
  static const Field<InviteUserResponse, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$phone(InviteUserResponse v) => v.phone;
  static const Field<InviteUserResponse, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$gender(InviteUserResponse v) => v.gender;
  static const Field<InviteUserResponse, String> _f$gender = Field(
    'gender',
    _$gender,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static int _$age(InviteUserResponse v) => v.age;
  static const Field<InviteUserResponse, int> _f$age = Field(
    'age',
    _$age,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );
  static String? _$profilePictureUrl(InviteUserResponse v) =>
      v.profilePictureUrl;
  static const Field<InviteUserResponse, String> _f$profilePictureUrl = Field(
    'profilePictureUrl',
    _$profilePictureUrl,
    opt: true,
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<InviteUserResponse> fields = const {
    #id: _f$id,
    #name: _f$name,
    #email: _f$email,
    #phone: _f$phone,
    #gender: _f$gender,
    #age: _f$age,
    #profilePictureUrl: _f$profilePictureUrl,
  };

  static InviteUserResponse _instantiate(DecodingData data) {
    return InviteUserResponse(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      email: data.dec(_f$email),
      phone: data.dec(_f$phone),
      gender: data.dec(_f$gender),
      age: data.dec(_f$age),
      profilePictureUrl: data.dec(_f$profilePictureUrl),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static InviteUserResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<InviteUserResponse>(map);
  }

  static InviteUserResponse fromJson(String json) {
    return ensureInitialized().decodeJson<InviteUserResponse>(json);
  }
}

mixin InviteUserResponseMappable {
  String toJson() {
    return InviteUserResponseMapper.ensureInitialized()
        .encodeJson<InviteUserResponse>(this as InviteUserResponse);
  }

  Map<String, dynamic> toMap() {
    return InviteUserResponseMapper.ensureInitialized()
        .encodeMap<InviteUserResponse>(this as InviteUserResponse);
  }

  InviteUserResponseCopyWith<
    InviteUserResponse,
    InviteUserResponse,
    InviteUserResponse
  >
  get copyWith =>
      _InviteUserResponseCopyWithImpl<InviteUserResponse, InviteUserResponse>(
        this as InviteUserResponse,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return InviteUserResponseMapper.ensureInitialized().stringifyValue(
      this as InviteUserResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return InviteUserResponseMapper.ensureInitialized().equalsValue(
      this as InviteUserResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return InviteUserResponseMapper.ensureInitialized().hashValue(
      this as InviteUserResponse,
    );
  }
}

extension InviteUserResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, InviteUserResponse, $Out> {
  InviteUserResponseCopyWith<$R, InviteUserResponse, $Out>
  get $asInviteUserResponse => $base.as(
    (v, t, t2) => _InviteUserResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class InviteUserResponseCopyWith<
  $R,
  $In extends InviteUserResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? gender,
    int? age,
    String? profilePictureUrl,
  });
  InviteUserResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _InviteUserResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, InviteUserResponse, $Out>
    implements InviteUserResponseCopyWith<$R, InviteUserResponse, $Out> {
  _InviteUserResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<InviteUserResponse> $mapper =
      InviteUserResponseMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? gender,
    int? age,
    Object? profilePictureUrl = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (email != null) #email: email,
      if (phone != null) #phone: phone,
      if (gender != null) #gender: gender,
      if (age != null) #age: age,
      if (profilePictureUrl != $none) #profilePictureUrl: profilePictureUrl,
    }),
  );
  @override
  InviteUserResponse $make(CopyWithData data) => InviteUserResponse(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    email: data.get(#email, or: $value.email),
    phone: data.get(#phone, or: $value.phone),
    gender: data.get(#gender, or: $value.gender),
    age: data.get(#age, or: $value.age),
    profilePictureUrl: data.get(
      #profilePictureUrl,
      or: $value.profilePictureUrl,
    ),
  );

  @override
  InviteUserResponseCopyWith<$R2, InviteUserResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _InviteUserResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class InviteeResponseMapper extends ClassMapperBase<InviteeResponse> {
  InviteeResponseMapper._();

  static InviteeResponseMapper? _instance;
  static InviteeResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = InviteeResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'InviteeResponse';

  static String _$id(InviteeResponse v) => v.id;
  static const Field<InviteeResponse, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$name(InviteeResponse v) => v.name;
  static const Field<InviteeResponse, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$email(InviteeResponse v) => v.email;
  static const Field<InviteeResponse, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$phone(InviteeResponse v) => v.phone;
  static const Field<InviteeResponse, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$gender(InviteeResponse v) => v.gender;
  static const Field<InviteeResponse, String> _f$gender = Field(
    'gender',
    _$gender,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static int _$age(InviteeResponse v) => v.age;
  static const Field<InviteeResponse, int> _f$age = Field(
    'age',
    _$age,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );
  static String _$type(InviteeResponse v) => v.type;
  static const Field<InviteeResponse, String> _f$type = Field(
    'type',
    _$type,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$profilePictureUrl(InviteeResponse v) => v.profilePictureUrl;
  static const Field<InviteeResponse, String> _f$profilePictureUrl = Field(
    'profilePictureUrl',
    _$profilePictureUrl,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<InviteeResponse> fields = const {
    #id: _f$id,
    #name: _f$name,
    #email: _f$email,
    #phone: _f$phone,
    #gender: _f$gender,
    #age: _f$age,
    #type: _f$type,
    #profilePictureUrl: _f$profilePictureUrl,
  };

  static InviteeResponse _instantiate(DecodingData data) {
    return InviteeResponse(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      email: data.dec(_f$email),
      phone: data.dec(_f$phone),
      gender: data.dec(_f$gender),
      age: data.dec(_f$age),
      type: data.dec(_f$type),
      profilePictureUrl: data.dec(_f$profilePictureUrl),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static InviteeResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<InviteeResponse>(map);
  }

  static InviteeResponse fromJson(String json) {
    return ensureInitialized().decodeJson<InviteeResponse>(json);
  }
}

mixin InviteeResponseMappable {
  String toJson() {
    return InviteeResponseMapper.ensureInitialized()
        .encodeJson<InviteeResponse>(this as InviteeResponse);
  }

  Map<String, dynamic> toMap() {
    return InviteeResponseMapper.ensureInitialized().encodeMap<InviteeResponse>(
      this as InviteeResponse,
    );
  }

  InviteeResponseCopyWith<InviteeResponse, InviteeResponse, InviteeResponse>
  get copyWith =>
      _InviteeResponseCopyWithImpl<InviteeResponse, InviteeResponse>(
        this as InviteeResponse,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return InviteeResponseMapper.ensureInitialized().stringifyValue(
      this as InviteeResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return InviteeResponseMapper.ensureInitialized().equalsValue(
      this as InviteeResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return InviteeResponseMapper.ensureInitialized().hashValue(
      this as InviteeResponse,
    );
  }
}

extension InviteeResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, InviteeResponse, $Out> {
  InviteeResponseCopyWith<$R, InviteeResponse, $Out> get $asInviteeResponse =>
      $base.as((v, t, t2) => _InviteeResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class InviteeResponseCopyWith<$R, $In extends InviteeResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? gender,
    int? age,
    String? type,
    String? profilePictureUrl,
  });
  InviteeResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _InviteeResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, InviteeResponse, $Out>
    implements InviteeResponseCopyWith<$R, InviteeResponse, $Out> {
  _InviteeResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<InviteeResponse> $mapper =
      InviteeResponseMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? gender,
    int? age,
    String? type,
    String? profilePictureUrl,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (email != null) #email: email,
      if (phone != null) #phone: phone,
      if (gender != null) #gender: gender,
      if (age != null) #age: age,
      if (type != null) #type: type,
      if (profilePictureUrl != null) #profilePictureUrl: profilePictureUrl,
    }),
  );
  @override
  InviteeResponse $make(CopyWithData data) => InviteeResponse(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    email: data.get(#email, or: $value.email),
    phone: data.get(#phone, or: $value.phone),
    gender: data.get(#gender, or: $value.gender),
    age: data.get(#age, or: $value.age),
    type: data.get(#type, or: $value.type),
    profilePictureUrl: data.get(
      #profilePictureUrl,
      or: $value.profilePictureUrl,
    ),
  );

  @override
  InviteeResponseCopyWith<$R2, InviteeResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _InviteeResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class InviteItemResponseMapper extends ClassMapperBase<InviteItemResponse> {
  InviteItemResponseMapper._();

  static InviteItemResponseMapper? _instance;
  static InviteItemResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = InviteItemResponseMapper._());
      InviteParentGroupResponseMapper.ensureInitialized();
      InviteUserResponseMapper.ensureInitialized();
      InviteeResponseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'InviteItemResponse';

  static String _$id(InviteItemResponse v) => v.id;
  static const Field<InviteItemResponse, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$parentGroupId(InviteItemResponse v) => v.parentGroupId;
  static const Field<InviteItemResponse, String> _f$parentGroupId = Field(
    'parentGroupId',
    _$parentGroupId,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static InviteParentGroupResponse _$parentGroup(InviteItemResponse v) =>
      v.parentGroup;
  static const Field<InviteItemResponse, InviteParentGroupResponse>
  _f$parentGroup = Field(
    'parentGroup',
    _$parentGroup,
    opt: true,
    def: const InviteParentGroupResponse(),
  );
  static InviteUserResponse _$inviter(InviteItemResponse v) => v.inviter;
  static const Field<InviteItemResponse, InviteUserResponse> _f$inviter = Field(
    'inviter',
    _$inviter,
    opt: true,
    def: const InviteUserResponse(),
  );
  static InviteeResponse _$invitee(InviteItemResponse v) => v.invitee;
  static const Field<InviteItemResponse, InviteeResponse> _f$invitee = Field(
    'invitee',
    _$invitee,
    opt: true,
    def: const InviteeResponse(),
  );
  static String _$status(InviteItemResponse v) => v.status;
  static const Field<InviteItemResponse, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$invitedAt(InviteItemResponse v) => v.invitedAt;
  static const Field<InviteItemResponse, String> _f$invitedAt = Field(
    'invitedAt',
    _$invitedAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$respondedAt(InviteItemResponse v) => v.respondedAt;
  static const Field<InviteItemResponse, String> _f$respondedAt = Field(
    'respondedAt',
    _$respondedAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$expiresAt(InviteItemResponse v) => v.expiresAt;
  static const Field<InviteItemResponse, String> _f$expiresAt = Field(
    'expiresAt',
    _$expiresAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static bool _$isExpired(InviteItemResponse v) => v.isExpired;
  static const Field<InviteItemResponse, bool> _f$isExpired = Field(
    'isExpired',
    _$isExpired,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static String _$inviteLink(InviteItemResponse v) => v.inviteLink;
  static const Field<InviteItemResponse, String> _f$inviteLink = Field(
    'inviteLink',
    _$inviteLink,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$invitationType(InviteItemResponse v) => v.invitationType;
  static const Field<InviteItemResponse, String> _f$invitationType = Field(
    'invitationType',
    _$invitationType,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$assignedRole(InviteItemResponse v) => v.assignedRole;
  static const Field<InviteItemResponse, String> _f$assignedRole = Field(
    'assignedRole',
    _$assignedRole,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<InviteItemResponse> fields = const {
    #id: _f$id,
    #parentGroupId: _f$parentGroupId,
    #parentGroup: _f$parentGroup,
    #inviter: _f$inviter,
    #invitee: _f$invitee,
    #status: _f$status,
    #invitedAt: _f$invitedAt,
    #respondedAt: _f$respondedAt,
    #expiresAt: _f$expiresAt,
    #isExpired: _f$isExpired,
    #inviteLink: _f$inviteLink,
    #invitationType: _f$invitationType,
    #assignedRole: _f$assignedRole,
  };

  static InviteItemResponse _instantiate(DecodingData data) {
    return InviteItemResponse(
      id: data.dec(_f$id),
      parentGroupId: data.dec(_f$parentGroupId),
      parentGroup: data.dec(_f$parentGroup),
      inviter: data.dec(_f$inviter),
      invitee: data.dec(_f$invitee),
      status: data.dec(_f$status),
      invitedAt: data.dec(_f$invitedAt),
      respondedAt: data.dec(_f$respondedAt),
      expiresAt: data.dec(_f$expiresAt),
      isExpired: data.dec(_f$isExpired),
      inviteLink: data.dec(_f$inviteLink),
      invitationType: data.dec(_f$invitationType),
      assignedRole: data.dec(_f$assignedRole),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static InviteItemResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<InviteItemResponse>(map);
  }

  static InviteItemResponse fromJson(String json) {
    return ensureInitialized().decodeJson<InviteItemResponse>(json);
  }
}

mixin InviteItemResponseMappable {
  String toJson() {
    return InviteItemResponseMapper.ensureInitialized()
        .encodeJson<InviteItemResponse>(this as InviteItemResponse);
  }

  Map<String, dynamic> toMap() {
    return InviteItemResponseMapper.ensureInitialized()
        .encodeMap<InviteItemResponse>(this as InviteItemResponse);
  }

  InviteItemResponseCopyWith<
    InviteItemResponse,
    InviteItemResponse,
    InviteItemResponse
  >
  get copyWith =>
      _InviteItemResponseCopyWithImpl<InviteItemResponse, InviteItemResponse>(
        this as InviteItemResponse,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return InviteItemResponseMapper.ensureInitialized().stringifyValue(
      this as InviteItemResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return InviteItemResponseMapper.ensureInitialized().equalsValue(
      this as InviteItemResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return InviteItemResponseMapper.ensureInitialized().hashValue(
      this as InviteItemResponse,
    );
  }
}

extension InviteItemResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, InviteItemResponse, $Out> {
  InviteItemResponseCopyWith<$R, InviteItemResponse, $Out>
  get $asInviteItemResponse => $base.as(
    (v, t, t2) => _InviteItemResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class InviteItemResponseCopyWith<
  $R,
  $In extends InviteItemResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  InviteParentGroupResponseCopyWith<
    $R,
    InviteParentGroupResponse,
    InviteParentGroupResponse
  >
  get parentGroup;
  InviteUserResponseCopyWith<$R, InviteUserResponse, InviteUserResponse>
  get inviter;
  InviteeResponseCopyWith<$R, InviteeResponse, InviteeResponse> get invitee;
  $R call({
    String? id,
    String? parentGroupId,
    InviteParentGroupResponse? parentGroup,
    InviteUserResponse? inviter,
    InviteeResponse? invitee,
    String? status,
    String? invitedAt,
    String? respondedAt,
    String? expiresAt,
    bool? isExpired,
    String? inviteLink,
    String? invitationType,
    String? assignedRole,
  });
  InviteItemResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _InviteItemResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, InviteItemResponse, $Out>
    implements InviteItemResponseCopyWith<$R, InviteItemResponse, $Out> {
  _InviteItemResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<InviteItemResponse> $mapper =
      InviteItemResponseMapper.ensureInitialized();
  @override
  InviteParentGroupResponseCopyWith<
    $R,
    InviteParentGroupResponse,
    InviteParentGroupResponse
  >
  get parentGroup =>
      $value.parentGroup.copyWith.$chain((v) => call(parentGroup: v));
  @override
  InviteUserResponseCopyWith<$R, InviteUserResponse, InviteUserResponse>
  get inviter => $value.inviter.copyWith.$chain((v) => call(inviter: v));
  @override
  InviteeResponseCopyWith<$R, InviteeResponse, InviteeResponse> get invitee =>
      $value.invitee.copyWith.$chain((v) => call(invitee: v));
  @override
  $R call({
    String? id,
    String? parentGroupId,
    InviteParentGroupResponse? parentGroup,
    InviteUserResponse? inviter,
    InviteeResponse? invitee,
    String? status,
    String? invitedAt,
    String? respondedAt,
    String? expiresAt,
    bool? isExpired,
    String? inviteLink,
    String? invitationType,
    String? assignedRole,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (parentGroupId != null) #parentGroupId: parentGroupId,
      if (parentGroup != null) #parentGroup: parentGroup,
      if (inviter != null) #inviter: inviter,
      if (invitee != null) #invitee: invitee,
      if (status != null) #status: status,
      if (invitedAt != null) #invitedAt: invitedAt,
      if (respondedAt != null) #respondedAt: respondedAt,
      if (expiresAt != null) #expiresAt: expiresAt,
      if (isExpired != null) #isExpired: isExpired,
      if (inviteLink != null) #inviteLink: inviteLink,
      if (invitationType != null) #invitationType: invitationType,
      if (assignedRole != null) #assignedRole: assignedRole,
    }),
  );
  @override
  InviteItemResponse $make(CopyWithData data) => InviteItemResponse(
    id: data.get(#id, or: $value.id),
    parentGroupId: data.get(#parentGroupId, or: $value.parentGroupId),
    parentGroup: data.get(#parentGroup, or: $value.parentGroup),
    inviter: data.get(#inviter, or: $value.inviter),
    invitee: data.get(#invitee, or: $value.invitee),
    status: data.get(#status, or: $value.status),
    invitedAt: data.get(#invitedAt, or: $value.invitedAt),
    respondedAt: data.get(#respondedAt, or: $value.respondedAt),
    expiresAt: data.get(#expiresAt, or: $value.expiresAt),
    isExpired: data.get(#isExpired, or: $value.isExpired),
    inviteLink: data.get(#inviteLink, or: $value.inviteLink),
    invitationType: data.get(#invitationType, or: $value.invitationType),
    assignedRole: data.get(#assignedRole, or: $value.assignedRole),
  );

  @override
  InviteItemResponseCopyWith<$R2, InviteItemResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _InviteItemResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class InvitationsOverviewResponseMapper
    extends ClassMapperBase<InvitationsOverviewResponse> {
  InvitationsOverviewResponseMapper._();

  static InvitationsOverviewResponseMapper? _instance;
  static InvitationsOverviewResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = InvitationsOverviewResponseMapper._(),
      );
      InviteItemResponseMapper.ensureInitialized();
      InvitePaginationResponseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'InvitationsOverviewResponse';

  static String _$userId(InvitationsOverviewResponse v) => v.userId;
  static const Field<InvitationsOverviewResponse, String> _f$userId = Field(
    'userId',
    _$userId,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$userIdentifier(InvitationsOverviewResponse v) =>
      v.userIdentifier;
  static const Field<InvitationsOverviewResponse, String> _f$userIdentifier =
      Field(
        'userIdentifier',
        _$userIdentifier,
        opt: true,
        def: '',
        hook: SafeStringHook(),
      );
  static List<InviteItemResponse> _$invitations(
    InvitationsOverviewResponse v,
  ) => v.invitations;
  static const Field<InvitationsOverviewResponse, List<InviteItemResponse>>
  _f$invitations = Field(
    'invitations',
    _$invitations,
    opt: true,
    def: const <InviteItemResponse>[],
  );
  static InvitePaginationResponse _$pagination(InvitationsOverviewResponse v) =>
      v.pagination;
  static const Field<InvitationsOverviewResponse, InvitePaginationResponse>
  _f$pagination = Field(
    'pagination',
    _$pagination,
    opt: true,
    def: const InvitePaginationResponse(),
  );

  @override
  final MappableFields<InvitationsOverviewResponse> fields = const {
    #userId: _f$userId,
    #userIdentifier: _f$userIdentifier,
    #invitations: _f$invitations,
    #pagination: _f$pagination,
  };

  static InvitationsOverviewResponse _instantiate(DecodingData data) {
    return InvitationsOverviewResponse(
      userId: data.dec(_f$userId),
      userIdentifier: data.dec(_f$userIdentifier),
      invitations: data.dec(_f$invitations),
      pagination: data.dec(_f$pagination),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static InvitationsOverviewResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<InvitationsOverviewResponse>(map);
  }

  static InvitationsOverviewResponse fromJson(String json) {
    return ensureInitialized().decodeJson<InvitationsOverviewResponse>(json);
  }
}

mixin InvitationsOverviewResponseMappable {
  String toJson() {
    return InvitationsOverviewResponseMapper.ensureInitialized()
        .encodeJson<InvitationsOverviewResponse>(
          this as InvitationsOverviewResponse,
        );
  }

  Map<String, dynamic> toMap() {
    return InvitationsOverviewResponseMapper.ensureInitialized()
        .encodeMap<InvitationsOverviewResponse>(
          this as InvitationsOverviewResponse,
        );
  }

  InvitationsOverviewResponseCopyWith<
    InvitationsOverviewResponse,
    InvitationsOverviewResponse,
    InvitationsOverviewResponse
  >
  get copyWith =>
      _InvitationsOverviewResponseCopyWithImpl<
        InvitationsOverviewResponse,
        InvitationsOverviewResponse
      >(this as InvitationsOverviewResponse, $identity, $identity);
  @override
  String toString() {
    return InvitationsOverviewResponseMapper.ensureInitialized().stringifyValue(
      this as InvitationsOverviewResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return InvitationsOverviewResponseMapper.ensureInitialized().equalsValue(
      this as InvitationsOverviewResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return InvitationsOverviewResponseMapper.ensureInitialized().hashValue(
      this as InvitationsOverviewResponse,
    );
  }
}

extension InvitationsOverviewResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, InvitationsOverviewResponse, $Out> {
  InvitationsOverviewResponseCopyWith<$R, InvitationsOverviewResponse, $Out>
  get $asInvitationsOverviewResponse => $base.as(
    (v, t, t2) => _InvitationsOverviewResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class InvitationsOverviewResponseCopyWith<
  $R,
  $In extends InvitationsOverviewResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    InviteItemResponse,
    InviteItemResponseCopyWith<$R, InviteItemResponse, InviteItemResponse>
  >
  get invitations;
  InvitePaginationResponseCopyWith<
    $R,
    InvitePaginationResponse,
    InvitePaginationResponse
  >
  get pagination;
  $R call({
    String? userId,
    String? userIdentifier,
    List<InviteItemResponse>? invitations,
    InvitePaginationResponse? pagination,
  });
  InvitationsOverviewResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _InvitationsOverviewResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, InvitationsOverviewResponse, $Out>
    implements
        InvitationsOverviewResponseCopyWith<
          $R,
          InvitationsOverviewResponse,
          $Out
        > {
  _InvitationsOverviewResponseCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<InvitationsOverviewResponse> $mapper =
      InvitationsOverviewResponseMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    InviteItemResponse,
    InviteItemResponseCopyWith<$R, InviteItemResponse, InviteItemResponse>
  >
  get invitations => ListCopyWith(
    $value.invitations,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(invitations: v),
  );
  @override
  InvitePaginationResponseCopyWith<
    $R,
    InvitePaginationResponse,
    InvitePaginationResponse
  >
  get pagination =>
      $value.pagination.copyWith.$chain((v) => call(pagination: v));
  @override
  $R call({
    String? userId,
    String? userIdentifier,
    List<InviteItemResponse>? invitations,
    InvitePaginationResponse? pagination,
  }) => $apply(
    FieldCopyWithData({
      if (userId != null) #userId: userId,
      if (userIdentifier != null) #userIdentifier: userIdentifier,
      if (invitations != null) #invitations: invitations,
      if (pagination != null) #pagination: pagination,
    }),
  );
  @override
  InvitationsOverviewResponse $make(CopyWithData data) =>
      InvitationsOverviewResponse(
        userId: data.get(#userId, or: $value.userId),
        userIdentifier: data.get(#userIdentifier, or: $value.userIdentifier),
        invitations: data.get(#invitations, or: $value.invitations),
        pagination: data.get(#pagination, or: $value.pagination),
      );

  @override
  InvitationsOverviewResponseCopyWith<$R2, InvitationsOverviewResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _InvitationsOverviewResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class InvitePaginationResponseMapper
    extends ClassMapperBase<InvitePaginationResponse> {
  InvitePaginationResponseMapper._();

  static InvitePaginationResponseMapper? _instance;
  static InvitePaginationResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = InvitePaginationResponseMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'InvitePaginationResponse';

  static int _$page(InvitePaginationResponse v) => v.page;
  static const Field<InvitePaginationResponse, int> _f$page = Field(
    'page',
    _$page,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );
  static int _$limit(InvitePaginationResponse v) => v.limit;
  static const Field<InvitePaginationResponse, int> _f$limit = Field(
    'limit',
    _$limit,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );
  static int _$total(InvitePaginationResponse v) => v.total;
  static const Field<InvitePaginationResponse, int> _f$total = Field(
    'total',
    _$total,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );
  static int _$totalPages(InvitePaginationResponse v) => v.totalPages;
  static const Field<InvitePaginationResponse, int> _f$totalPages = Field(
    'totalPages',
    _$totalPages,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );
  static bool _$hasNextPage(InvitePaginationResponse v) => v.hasNextPage;
  static const Field<InvitePaginationResponse, bool> _f$hasNextPage = Field(
    'hasNextPage',
    _$hasNextPage,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );
  static bool _$hasPrevPage(InvitePaginationResponse v) => v.hasPrevPage;
  static const Field<InvitePaginationResponse, bool> _f$hasPrevPage = Field(
    'hasPrevPage',
    _$hasPrevPage,
    opt: true,
    def: false,
    hook: SafeBoolHook(),
  );

  @override
  final MappableFields<InvitePaginationResponse> fields = const {
    #page: _f$page,
    #limit: _f$limit,
    #total: _f$total,
    #totalPages: _f$totalPages,
    #hasNextPage: _f$hasNextPage,
    #hasPrevPage: _f$hasPrevPage,
  };

  static InvitePaginationResponse _instantiate(DecodingData data) {
    return InvitePaginationResponse(
      page: data.dec(_f$page),
      limit: data.dec(_f$limit),
      total: data.dec(_f$total),
      totalPages: data.dec(_f$totalPages),
      hasNextPage: data.dec(_f$hasNextPage),
      hasPrevPage: data.dec(_f$hasPrevPage),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static InvitePaginationResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<InvitePaginationResponse>(map);
  }

  static InvitePaginationResponse fromJson(String json) {
    return ensureInitialized().decodeJson<InvitePaginationResponse>(json);
  }
}

mixin InvitePaginationResponseMappable {
  String toJson() {
    return InvitePaginationResponseMapper.ensureInitialized()
        .encodeJson<InvitePaginationResponse>(this as InvitePaginationResponse);
  }

  Map<String, dynamic> toMap() {
    return InvitePaginationResponseMapper.ensureInitialized()
        .encodeMap<InvitePaginationResponse>(this as InvitePaginationResponse);
  }

  InvitePaginationResponseCopyWith<
    InvitePaginationResponse,
    InvitePaginationResponse,
    InvitePaginationResponse
  >
  get copyWith =>
      _InvitePaginationResponseCopyWithImpl<
        InvitePaginationResponse,
        InvitePaginationResponse
      >(this as InvitePaginationResponse, $identity, $identity);
  @override
  String toString() {
    return InvitePaginationResponseMapper.ensureInitialized().stringifyValue(
      this as InvitePaginationResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return InvitePaginationResponseMapper.ensureInitialized().equalsValue(
      this as InvitePaginationResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return InvitePaginationResponseMapper.ensureInitialized().hashValue(
      this as InvitePaginationResponse,
    );
  }
}

extension InvitePaginationResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, InvitePaginationResponse, $Out> {
  InvitePaginationResponseCopyWith<$R, InvitePaginationResponse, $Out>
  get $asInvitePaginationResponse => $base.as(
    (v, t, t2) => _InvitePaginationResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class InvitePaginationResponseCopyWith<
  $R,
  $In extends InvitePaginationResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? page,
    int? limit,
    int? total,
    int? totalPages,
    bool? hasNextPage,
    bool? hasPrevPage,
  });
  InvitePaginationResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _InvitePaginationResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, InvitePaginationResponse, $Out>
    implements
        InvitePaginationResponseCopyWith<$R, InvitePaginationResponse, $Out> {
  _InvitePaginationResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<InvitePaginationResponse> $mapper =
      InvitePaginationResponseMapper.ensureInitialized();
  @override
  $R call({
    int? page,
    int? limit,
    int? total,
    int? totalPages,
    bool? hasNextPage,
    bool? hasPrevPage,
  }) => $apply(
    FieldCopyWithData({
      if (page != null) #page: page,
      if (limit != null) #limit: limit,
      if (total != null) #total: total,
      if (totalPages != null) #totalPages: totalPages,
      if (hasNextPage != null) #hasNextPage: hasNextPage,
      if (hasPrevPage != null) #hasPrevPage: hasPrevPage,
    }),
  );
  @override
  InvitePaginationResponse $make(CopyWithData data) => InvitePaginationResponse(
    page: data.get(#page, or: $value.page),
    limit: data.get(#limit, or: $value.limit),
    total: data.get(#total, or: $value.total),
    totalPages: data.get(#totalPages, or: $value.totalPages),
    hasNextPage: data.get(#hasNextPage, or: $value.hasNextPage),
    hasPrevPage: data.get(#hasPrevPage, or: $value.hasPrevPage),
  );

  @override
  InvitePaginationResponseCopyWith<$R2, InvitePaginationResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _InvitePaginationResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

