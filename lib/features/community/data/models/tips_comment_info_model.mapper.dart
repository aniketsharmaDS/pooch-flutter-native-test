// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'tips_comment_info_model.dart';

class TipsCommentInfoModelMapper extends ClassMapperBase<TipsCommentInfoModel> {
  TipsCommentInfoModelMapper._();

  static TipsCommentInfoModelMapper? _instance;
  static TipsCommentInfoModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TipsCommentInfoModelMapper._());
      TipsCommentUserInfoMapper.ensureInitialized();
      TipsCommentInfoModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TipsCommentInfoModel';

  static String _$id(TipsCommentInfoModel v) => v.id;
  static const Field<TipsCommentInfoModel, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$tipId(TipsCommentInfoModel v) => v.tipId;
  static const Field<TipsCommentInfoModel, String> _f$tipId = Field(
    'tipId',
    _$tipId,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$userId(TipsCommentInfoModel v) => v.userId;
  static const Field<TipsCommentInfoModel, String> _f$userId = Field(
    'userId',
    _$userId,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String? _$parentCommentId(TipsCommentInfoModel v) => v.parentCommentId;
  static const Field<TipsCommentInfoModel, String> _f$parentCommentId = Field(
    'parentCommentId',
    _$parentCommentId,
    opt: true,
  );
  static String _$comment(TipsCommentInfoModel v) => v.comment;
  static const Field<TipsCommentInfoModel, String> _f$comment = Field(
    'comment',
    _$comment,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$createdAt(TipsCommentInfoModel v) => v.createdAt;
  static const Field<TipsCommentInfoModel, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$updatedAt(TipsCommentInfoModel v) => v.updatedAt;
  static const Field<TipsCommentInfoModel, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static TipsCommentUserInfo? _$user(TipsCommentInfoModel v) => v.user;
  static const Field<TipsCommentInfoModel, TipsCommentUserInfo> _f$user = Field(
    'user',
    _$user,
    opt: true,
  );
  static bool _$isCurrentUser(TipsCommentInfoModel v) => v.isCurrentUser;
  static const Field<TipsCommentInfoModel, bool> _f$isCurrentUser = Field(
    'isCurrentUser',
    _$isCurrentUser,
    opt: true,
    def: false,
  );
  static String _$messageStatus(TipsCommentInfoModel v) => v.messageStatus;
  static const Field<TipsCommentInfoModel, String> _f$messageStatus = Field(
    'messageStatus',
    _$messageStatus,
    opt: true,
    def: 'posted',
    hook: SafeStringHook(defaultValue: 'posted'),
  );
  static bool? _$hasReplies(TipsCommentInfoModel v) => v.hasReplies;
  static const Field<TipsCommentInfoModel, bool> _f$hasReplies = Field(
    'hasReplies',
    _$hasReplies,
    opt: true,
  );
  static int? _$replyCount(TipsCommentInfoModel v) => v.replyCount;
  static const Field<TipsCommentInfoModel, int> _f$replyCount = Field(
    'replyCount',
    _$replyCount,
    opt: true,
    hook: SafeIntHook(),
  );
  static List<TipsCommentInfoModel> _$replies(TipsCommentInfoModel v) =>
      v.replies;
  static const Field<TipsCommentInfoModel, List<TipsCommentInfoModel>>
  _f$replies = Field(
    'replies',
    _$replies,
    opt: true,
    def: const [],
    hook: SafeListHook<TipsCommentInfoModel>(),
  );

  @override
  final MappableFields<TipsCommentInfoModel> fields = const {
    #id: _f$id,
    #tipId: _f$tipId,
    #userId: _f$userId,
    #parentCommentId: _f$parentCommentId,
    #comment: _f$comment,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #user: _f$user,
    #isCurrentUser: _f$isCurrentUser,
    #messageStatus: _f$messageStatus,
    #hasReplies: _f$hasReplies,
    #replyCount: _f$replyCount,
    #replies: _f$replies,
  };

  static TipsCommentInfoModel _instantiate(DecodingData data) {
    return TipsCommentInfoModel(
      id: data.dec(_f$id),
      tipId: data.dec(_f$tipId),
      userId: data.dec(_f$userId),
      parentCommentId: data.dec(_f$parentCommentId),
      comment: data.dec(_f$comment),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      user: data.dec(_f$user),
      isCurrentUser: data.dec(_f$isCurrentUser),
      messageStatus: data.dec(_f$messageStatus),
      hasReplies: data.dec(_f$hasReplies),
      replyCount: data.dec(_f$replyCount),
      replies: data.dec(_f$replies),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static TipsCommentInfoModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TipsCommentInfoModel>(map);
  }

  static TipsCommentInfoModel fromJson(String json) {
    return ensureInitialized().decodeJson<TipsCommentInfoModel>(json);
  }
}

mixin TipsCommentInfoModelMappable {
  String toJson() {
    return TipsCommentInfoModelMapper.ensureInitialized()
        .encodeJson<TipsCommentInfoModel>(this as TipsCommentInfoModel);
  }

  Map<String, dynamic> toMap() {
    return TipsCommentInfoModelMapper.ensureInitialized()
        .encodeMap<TipsCommentInfoModel>(this as TipsCommentInfoModel);
  }

  TipsCommentInfoModelCopyWith<
    TipsCommentInfoModel,
    TipsCommentInfoModel,
    TipsCommentInfoModel
  >
  get copyWith =>
      _TipsCommentInfoModelCopyWithImpl<
        TipsCommentInfoModel,
        TipsCommentInfoModel
      >(this as TipsCommentInfoModel, $identity, $identity);
  @override
  String toString() {
    return TipsCommentInfoModelMapper.ensureInitialized().stringifyValue(
      this as TipsCommentInfoModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return TipsCommentInfoModelMapper.ensureInitialized().equalsValue(
      this as TipsCommentInfoModel,
      other,
    );
  }

  @override
  int get hashCode {
    return TipsCommentInfoModelMapper.ensureInitialized().hashValue(
      this as TipsCommentInfoModel,
    );
  }
}

extension TipsCommentInfoModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TipsCommentInfoModel, $Out> {
  TipsCommentInfoModelCopyWith<$R, TipsCommentInfoModel, $Out>
  get $asTipsCommentInfoModel => $base.as(
    (v, t, t2) => _TipsCommentInfoModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class TipsCommentInfoModelCopyWith<
  $R,
  $In extends TipsCommentInfoModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  TipsCommentUserInfoCopyWith<$R, TipsCommentUserInfo, TipsCommentUserInfo>?
  get user;
  ListCopyWith<
    $R,
    TipsCommentInfoModel,
    TipsCommentInfoModelCopyWith<$R, TipsCommentInfoModel, TipsCommentInfoModel>
  >
  get replies;
  $R call({
    String? id,
    String? tipId,
    String? userId,
    String? parentCommentId,
    String? comment,
    String? createdAt,
    String? updatedAt,
    TipsCommentUserInfo? user,
    bool? isCurrentUser,
    String? messageStatus,
    bool? hasReplies,
    int? replyCount,
    List<TipsCommentInfoModel>? replies,
  });
  TipsCommentInfoModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _TipsCommentInfoModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TipsCommentInfoModel, $Out>
    implements TipsCommentInfoModelCopyWith<$R, TipsCommentInfoModel, $Out> {
  _TipsCommentInfoModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TipsCommentInfoModel> $mapper =
      TipsCommentInfoModelMapper.ensureInitialized();
  @override
  TipsCommentUserInfoCopyWith<$R, TipsCommentUserInfo, TipsCommentUserInfo>?
  get user => $value.user?.copyWith.$chain((v) => call(user: v));
  @override
  ListCopyWith<
    $R,
    TipsCommentInfoModel,
    TipsCommentInfoModelCopyWith<$R, TipsCommentInfoModel, TipsCommentInfoModel>
  >
  get replies => ListCopyWith(
    $value.replies,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(replies: v),
  );
  @override
  $R call({
    String? id,
    String? tipId,
    String? userId,
    Object? parentCommentId = $none,
    String? comment,
    String? createdAt,
    String? updatedAt,
    Object? user = $none,
    bool? isCurrentUser,
    String? messageStatus,
    Object? hasReplies = $none,
    Object? replyCount = $none,
    List<TipsCommentInfoModel>? replies,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (tipId != null) #tipId: tipId,
      if (userId != null) #userId: userId,
      if (parentCommentId != $none) #parentCommentId: parentCommentId,
      if (comment != null) #comment: comment,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
      if (user != $none) #user: user,
      if (isCurrentUser != null) #isCurrentUser: isCurrentUser,
      if (messageStatus != null) #messageStatus: messageStatus,
      if (hasReplies != $none) #hasReplies: hasReplies,
      if (replyCount != $none) #replyCount: replyCount,
      if (replies != null) #replies: replies,
    }),
  );
  @override
  TipsCommentInfoModel $make(CopyWithData data) => TipsCommentInfoModel(
    id: data.get(#id, or: $value.id),
    tipId: data.get(#tipId, or: $value.tipId),
    userId: data.get(#userId, or: $value.userId),
    parentCommentId: data.get(#parentCommentId, or: $value.parentCommentId),
    comment: data.get(#comment, or: $value.comment),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    user: data.get(#user, or: $value.user),
    isCurrentUser: data.get(#isCurrentUser, or: $value.isCurrentUser),
    messageStatus: data.get(#messageStatus, or: $value.messageStatus),
    hasReplies: data.get(#hasReplies, or: $value.hasReplies),
    replyCount: data.get(#replyCount, or: $value.replyCount),
    replies: data.get(#replies, or: $value.replies),
  );

  @override
  TipsCommentInfoModelCopyWith<$R2, TipsCommentInfoModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _TipsCommentInfoModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class TipsCommentUserInfoMapper extends ClassMapperBase<TipsCommentUserInfo> {
  TipsCommentUserInfoMapper._();

  static TipsCommentUserInfoMapper? _instance;
  static TipsCommentUserInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TipsCommentUserInfoMapper._());
      TipsCommentUserProfileMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TipsCommentUserInfo';

  static String _$id(TipsCommentUserInfo v) => v.id;
  static const Field<TipsCommentUserInfo, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$name(TipsCommentUserInfo v) => v.name;
  static const Field<TipsCommentUserInfo, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$email(TipsCommentUserInfo v) => v.email;
  static const Field<TipsCommentUserInfo, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String? _$phone(TipsCommentUserInfo v) => v.phone;
  static const Field<TipsCommentUserInfo, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
  );
  static String? _$countryCode(TipsCommentUserInfo v) => v.countryCode;
  static const Field<TipsCommentUserInfo, String> _f$countryCode = Field(
    'countryCode',
    _$countryCode,
    opt: true,
  );
  static TipsCommentUserProfile? _$profile(TipsCommentUserInfo v) => v.profile;
  static const Field<TipsCommentUserInfo, TipsCommentUserProfile> _f$profile =
      Field('profile', _$profile, opt: true);

  @override
  final MappableFields<TipsCommentUserInfo> fields = const {
    #id: _f$id,
    #name: _f$name,
    #email: _f$email,
    #phone: _f$phone,
    #countryCode: _f$countryCode,
    #profile: _f$profile,
  };

  static TipsCommentUserInfo _instantiate(DecodingData data) {
    return TipsCommentUserInfo(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      email: data.dec(_f$email),
      phone: data.dec(_f$phone),
      countryCode: data.dec(_f$countryCode),
      profile: data.dec(_f$profile),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static TipsCommentUserInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TipsCommentUserInfo>(map);
  }

  static TipsCommentUserInfo fromJson(String json) {
    return ensureInitialized().decodeJson<TipsCommentUserInfo>(json);
  }
}

mixin TipsCommentUserInfoMappable {
  String toJson() {
    return TipsCommentUserInfoMapper.ensureInitialized()
        .encodeJson<TipsCommentUserInfo>(this as TipsCommentUserInfo);
  }

  Map<String, dynamic> toMap() {
    return TipsCommentUserInfoMapper.ensureInitialized()
        .encodeMap<TipsCommentUserInfo>(this as TipsCommentUserInfo);
  }

  TipsCommentUserInfoCopyWith<
    TipsCommentUserInfo,
    TipsCommentUserInfo,
    TipsCommentUserInfo
  >
  get copyWith =>
      _TipsCommentUserInfoCopyWithImpl<
        TipsCommentUserInfo,
        TipsCommentUserInfo
      >(this as TipsCommentUserInfo, $identity, $identity);
  @override
  String toString() {
    return TipsCommentUserInfoMapper.ensureInitialized().stringifyValue(
      this as TipsCommentUserInfo,
    );
  }

  @override
  bool operator ==(Object other) {
    return TipsCommentUserInfoMapper.ensureInitialized().equalsValue(
      this as TipsCommentUserInfo,
      other,
    );
  }

  @override
  int get hashCode {
    return TipsCommentUserInfoMapper.ensureInitialized().hashValue(
      this as TipsCommentUserInfo,
    );
  }
}

extension TipsCommentUserInfoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TipsCommentUserInfo, $Out> {
  TipsCommentUserInfoCopyWith<$R, TipsCommentUserInfo, $Out>
  get $asTipsCommentUserInfo => $base.as(
    (v, t, t2) => _TipsCommentUserInfoCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class TipsCommentUserInfoCopyWith<
  $R,
  $In extends TipsCommentUserInfo,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  TipsCommentUserProfileCopyWith<
    $R,
    TipsCommentUserProfile,
    TipsCommentUserProfile
  >?
  get profile;
  $R call({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? countryCode,
    TipsCommentUserProfile? profile,
  });
  TipsCommentUserInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _TipsCommentUserInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TipsCommentUserInfo, $Out>
    implements TipsCommentUserInfoCopyWith<$R, TipsCommentUserInfo, $Out> {
  _TipsCommentUserInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TipsCommentUserInfo> $mapper =
      TipsCommentUserInfoMapper.ensureInitialized();
  @override
  TipsCommentUserProfileCopyWith<
    $R,
    TipsCommentUserProfile,
    TipsCommentUserProfile
  >?
  get profile => $value.profile?.copyWith.$chain((v) => call(profile: v));
  @override
  $R call({
    String? id,
    String? name,
    String? email,
    Object? phone = $none,
    Object? countryCode = $none,
    Object? profile = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (email != null) #email: email,
      if (phone != $none) #phone: phone,
      if (countryCode != $none) #countryCode: countryCode,
      if (profile != $none) #profile: profile,
    }),
  );
  @override
  TipsCommentUserInfo $make(CopyWithData data) => TipsCommentUserInfo(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    email: data.get(#email, or: $value.email),
    phone: data.get(#phone, or: $value.phone),
    countryCode: data.get(#countryCode, or: $value.countryCode),
    profile: data.get(#profile, or: $value.profile),
  );

  @override
  TipsCommentUserInfoCopyWith<$R2, TipsCommentUserInfo, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _TipsCommentUserInfoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class TipsCommentUserProfileMapper
    extends ClassMapperBase<TipsCommentUserProfile> {
  TipsCommentUserProfileMapper._();

  static TipsCommentUserProfileMapper? _instance;
  static TipsCommentUserProfileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TipsCommentUserProfileMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TipsCommentUserProfile';

  static String? _$profilePicture(TipsCommentUserProfile v) => v.profilePicture;
  static const Field<TipsCommentUserProfile, String> _f$profilePicture = Field(
    'profilePicture',
    _$profilePicture,
    opt: true,
  );

  @override
  final MappableFields<TipsCommentUserProfile> fields = const {
    #profilePicture: _f$profilePicture,
  };

  static TipsCommentUserProfile _instantiate(DecodingData data) {
    return TipsCommentUserProfile(profilePicture: data.dec(_f$profilePicture));
  }

  @override
  final Function instantiate = _instantiate;

  static TipsCommentUserProfile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TipsCommentUserProfile>(map);
  }

  static TipsCommentUserProfile fromJson(String json) {
    return ensureInitialized().decodeJson<TipsCommentUserProfile>(json);
  }
}

mixin TipsCommentUserProfileMappable {
  String toJson() {
    return TipsCommentUserProfileMapper.ensureInitialized()
        .encodeJson<TipsCommentUserProfile>(this as TipsCommentUserProfile);
  }

  Map<String, dynamic> toMap() {
    return TipsCommentUserProfileMapper.ensureInitialized()
        .encodeMap<TipsCommentUserProfile>(this as TipsCommentUserProfile);
  }

  TipsCommentUserProfileCopyWith<
    TipsCommentUserProfile,
    TipsCommentUserProfile,
    TipsCommentUserProfile
  >
  get copyWith =>
      _TipsCommentUserProfileCopyWithImpl<
        TipsCommentUserProfile,
        TipsCommentUserProfile
      >(this as TipsCommentUserProfile, $identity, $identity);
  @override
  String toString() {
    return TipsCommentUserProfileMapper.ensureInitialized().stringifyValue(
      this as TipsCommentUserProfile,
    );
  }

  @override
  bool operator ==(Object other) {
    return TipsCommentUserProfileMapper.ensureInitialized().equalsValue(
      this as TipsCommentUserProfile,
      other,
    );
  }

  @override
  int get hashCode {
    return TipsCommentUserProfileMapper.ensureInitialized().hashValue(
      this as TipsCommentUserProfile,
    );
  }
}

extension TipsCommentUserProfileValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TipsCommentUserProfile, $Out> {
  TipsCommentUserProfileCopyWith<$R, TipsCommentUserProfile, $Out>
  get $asTipsCommentUserProfile => $base.as(
    (v, t, t2) => _TipsCommentUserProfileCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class TipsCommentUserProfileCopyWith<
  $R,
  $In extends TipsCommentUserProfile,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? profilePicture});
  TipsCommentUserProfileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _TipsCommentUserProfileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TipsCommentUserProfile, $Out>
    implements
        TipsCommentUserProfileCopyWith<$R, TipsCommentUserProfile, $Out> {
  _TipsCommentUserProfileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TipsCommentUserProfile> $mapper =
      TipsCommentUserProfileMapper.ensureInitialized();
  @override
  $R call({Object? profilePicture = $none}) => $apply(
    FieldCopyWithData({
      if (profilePicture != $none) #profilePicture: profilePicture,
    }),
  );
  @override
  TipsCommentUserProfile $make(CopyWithData data) => TipsCommentUserProfile(
    profilePicture: data.get(#profilePicture, or: $value.profilePicture),
  );

  @override
  TipsCommentUserProfileCopyWith<$R2, TipsCommentUserProfile, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _TipsCommentUserProfileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

