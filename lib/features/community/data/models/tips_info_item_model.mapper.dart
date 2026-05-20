// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'tips_info_item_model.dart';

class TipsInfoItemModelMapper extends ClassMapperBase<TipsInfoItemModel> {
  TipsInfoItemModelMapper._();

  static TipsInfoItemModelMapper? _instance;
  static TipsInfoItemModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TipsInfoItemModelMapper._());
      TipsImageInfoMapper.ensureInitialized();
      TipsUserInfoMapper.ensureInitialized();
      TipsCategoryInfoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TipsInfoItemModel';

  static String _$id(TipsInfoItemModel v) => v.id;
  static const Field<TipsInfoItemModel, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$userId(TipsInfoItemModel v) => v.userId;
  static const Field<TipsInfoItemModel, String> _f$userId = Field(
    'userId',
    _$userId,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$categoryId(TipsInfoItemModel v) => v.categoryId;
  static const Field<TipsInfoItemModel, String> _f$categoryId = Field(
    'categoryId',
    _$categoryId,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$title(TipsInfoItemModel v) => v.title;
  static const Field<TipsInfoItemModel, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$description(TipsInfoItemModel v) => v.description;
  static const Field<TipsInfoItemModel, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static List<TipsImageInfo> _$attachmentUrls(TipsInfoItemModel v) =>
      v.attachmentUrls;
  static const Field<TipsInfoItemModel, List<TipsImageInfo>> _f$attachmentUrls =
      Field('attachmentUrls', _$attachmentUrls, opt: true, def: const []);
  static int _$likesCount(TipsInfoItemModel v) => v.likesCount;
  static const Field<TipsInfoItemModel, int> _f$likesCount = Field(
    'likesCount',
    _$likesCount,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );
  static int _$commentsCount(TipsInfoItemModel v) => v.commentsCount;
  static const Field<TipsInfoItemModel, int> _f$commentsCount = Field(
    'commentsCount',
    _$commentsCount,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );
  static String _$status(TipsInfoItemModel v) => v.status;
  static const Field<TipsInfoItemModel, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String? _$rejectionReason(TipsInfoItemModel v) => v.rejectionReason;
  static const Field<TipsInfoItemModel, String> _f$rejectionReason = Field(
    'rejectionReason',
    _$rejectionReason,
    opt: true,
  );
  static bool _$isDraft(TipsInfoItemModel v) => v.isDraft;
  static const Field<TipsInfoItemModel, bool> _f$isDraft = Field(
    'isDraft',
    _$isDraft,
    opt: true,
    def: false,
  );
  static bool _$isActive(TipsInfoItemModel v) => v.isActive;
  static const Field<TipsInfoItemModel, bool> _f$isActive = Field(
    'isActive',
    _$isActive,
    opt: true,
    def: true,
  );
  static bool _$isDeleted(TipsInfoItemModel v) => v.isDeleted;
  static const Field<TipsInfoItemModel, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static int _$reportedCount(TipsInfoItemModel v) => v.reportedCount;
  static const Field<TipsInfoItemModel, int> _f$reportedCount = Field(
    'reportedCount',
    _$reportedCount,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );
  static bool _$isReported(TipsInfoItemModel v) => v.isReported;
  static const Field<TipsInfoItemModel, bool> _f$isReported = Field(
    'isReported',
    _$isReported,
    opt: true,
    def: false,
  );
  static String _$createdAt(TipsInfoItemModel v) => v.createdAt;
  static const Field<TipsInfoItemModel, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$updatedAt(TipsInfoItemModel v) => v.updatedAt;
  static const Field<TipsInfoItemModel, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static TipsUserInfo? _$user(TipsInfoItemModel v) => v.user;
  static const Field<TipsInfoItemModel, TipsUserInfo> _f$user = Field(
    'user',
    _$user,
    opt: true,
  );
  static TipsCategoryInfo? _$category(TipsInfoItemModel v) => v.category;
  static const Field<TipsInfoItemModel, TipsCategoryInfo> _f$category = Field(
    'category',
    _$category,
    opt: true,
  );
  static bool _$isLiked(TipsInfoItemModel v) => v.isLiked;
  static const Field<TipsInfoItemModel, bool> _f$isLiked = Field(
    'isLiked',
    _$isLiked,
    opt: true,
    def: false,
  );
  static bool _$isAuthor(TipsInfoItemModel v) => v.isAuthor;
  static const Field<TipsInfoItemModel, bool> _f$isAuthor = Field(
    'isAuthor',
    _$isAuthor,
    opt: true,
    def: false,
  );
  static bool _$showTipsBadge(TipsInfoItemModel v) => v.showTipsBadge;
  static const Field<TipsInfoItemModel, bool> _f$showTipsBadge = Field(
    'showTipsBadge',
    _$showTipsBadge,
    opt: true,
    def: false,
  );
  static List<String> _$hashtags(TipsInfoItemModel v) => v.hashtags;
  static const Field<TipsInfoItemModel, List<String>> _f$hashtags = Field(
    'hashtags',
    _$hashtags,
    opt: true,
    def: const [],
  );
  static List<String> _$tipsList(TipsInfoItemModel v) => v.tipsList;
  static const Field<TipsInfoItemModel, List<String>> _f$tipsList = Field(
    'tipsList',
    _$tipsList,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<TipsInfoItemModel> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #categoryId: _f$categoryId,
    #title: _f$title,
    #description: _f$description,
    #attachmentUrls: _f$attachmentUrls,
    #likesCount: _f$likesCount,
    #commentsCount: _f$commentsCount,
    #status: _f$status,
    #rejectionReason: _f$rejectionReason,
    #isDraft: _f$isDraft,
    #isActive: _f$isActive,
    #isDeleted: _f$isDeleted,
    #reportedCount: _f$reportedCount,
    #isReported: _f$isReported,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #user: _f$user,
    #category: _f$category,
    #isLiked: _f$isLiked,
    #isAuthor: _f$isAuthor,
    #showTipsBadge: _f$showTipsBadge,
    #hashtags: _f$hashtags,
    #tipsList: _f$tipsList,
  };

  static TipsInfoItemModel _instantiate(DecodingData data) {
    return TipsInfoItemModel(
      id: data.dec(_f$id),
      userId: data.dec(_f$userId),
      categoryId: data.dec(_f$categoryId),
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      attachmentUrls: data.dec(_f$attachmentUrls),
      likesCount: data.dec(_f$likesCount),
      commentsCount: data.dec(_f$commentsCount),
      status: data.dec(_f$status),
      rejectionReason: data.dec(_f$rejectionReason),
      isDraft: data.dec(_f$isDraft),
      isActive: data.dec(_f$isActive),
      isDeleted: data.dec(_f$isDeleted),
      reportedCount: data.dec(_f$reportedCount),
      isReported: data.dec(_f$isReported),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      user: data.dec(_f$user),
      category: data.dec(_f$category),
      isLiked: data.dec(_f$isLiked),
      isAuthor: data.dec(_f$isAuthor),
      showTipsBadge: data.dec(_f$showTipsBadge),
      hashtags: data.dec(_f$hashtags),
      tipsList: data.dec(_f$tipsList),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static TipsInfoItemModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TipsInfoItemModel>(map);
  }

  static TipsInfoItemModel fromJson(String json) {
    return ensureInitialized().decodeJson<TipsInfoItemModel>(json);
  }
}

mixin TipsInfoItemModelMappable {
  String toJson() {
    return TipsInfoItemModelMapper.ensureInitialized()
        .encodeJson<TipsInfoItemModel>(this as TipsInfoItemModel);
  }

  Map<String, dynamic> toMap() {
    return TipsInfoItemModelMapper.ensureInitialized()
        .encodeMap<TipsInfoItemModel>(this as TipsInfoItemModel);
  }

  TipsInfoItemModelCopyWith<
    TipsInfoItemModel,
    TipsInfoItemModel,
    TipsInfoItemModel
  >
  get copyWith =>
      _TipsInfoItemModelCopyWithImpl<TipsInfoItemModel, TipsInfoItemModel>(
        this as TipsInfoItemModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TipsInfoItemModelMapper.ensureInitialized().stringifyValue(
      this as TipsInfoItemModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return TipsInfoItemModelMapper.ensureInitialized().equalsValue(
      this as TipsInfoItemModel,
      other,
    );
  }

  @override
  int get hashCode {
    return TipsInfoItemModelMapper.ensureInitialized().hashValue(
      this as TipsInfoItemModel,
    );
  }
}

extension TipsInfoItemModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TipsInfoItemModel, $Out> {
  TipsInfoItemModelCopyWith<$R, TipsInfoItemModel, $Out>
  get $asTipsInfoItemModel => $base.as(
    (v, t, t2) => _TipsInfoItemModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class TipsInfoItemModelCopyWith<
  $R,
  $In extends TipsInfoItemModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    TipsImageInfo,
    TipsImageInfoCopyWith<$R, TipsImageInfo, TipsImageInfo>
  >
  get attachmentUrls;
  TipsUserInfoCopyWith<$R, TipsUserInfo, TipsUserInfo>? get user;
  TipsCategoryInfoCopyWith<$R, TipsCategoryInfo, TipsCategoryInfo>?
  get category;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get hashtags;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get tipsList;
  $R call({
    String? id,
    String? userId,
    String? categoryId,
    String? title,
    String? description,
    List<TipsImageInfo>? attachmentUrls,
    int? likesCount,
    int? commentsCount,
    String? status,
    String? rejectionReason,
    bool? isDraft,
    bool? isActive,
    bool? isDeleted,
    int? reportedCount,
    bool? isReported,
    String? createdAt,
    String? updatedAt,
    TipsUserInfo? user,
    TipsCategoryInfo? category,
    bool? isLiked,
    bool? isAuthor,
    bool? showTipsBadge,
    List<String>? hashtags,
    List<String>? tipsList,
  });
  TipsInfoItemModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _TipsInfoItemModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TipsInfoItemModel, $Out>
    implements TipsInfoItemModelCopyWith<$R, TipsInfoItemModel, $Out> {
  _TipsInfoItemModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TipsInfoItemModel> $mapper =
      TipsInfoItemModelMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    TipsImageInfo,
    TipsImageInfoCopyWith<$R, TipsImageInfo, TipsImageInfo>
  >
  get attachmentUrls => ListCopyWith(
    $value.attachmentUrls,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(attachmentUrls: v),
  );
  @override
  TipsUserInfoCopyWith<$R, TipsUserInfo, TipsUserInfo>? get user =>
      $value.user?.copyWith.$chain((v) => call(user: v));
  @override
  TipsCategoryInfoCopyWith<$R, TipsCategoryInfo, TipsCategoryInfo>?
  get category => $value.category?.copyWith.$chain((v) => call(category: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get hashtags =>
      ListCopyWith(
        $value.hashtags,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(hashtags: v),
      );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get tipsList =>
      ListCopyWith(
        $value.tipsList,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(tipsList: v),
      );
  @override
  $R call({
    String? id,
    String? userId,
    String? categoryId,
    String? title,
    String? description,
    List<TipsImageInfo>? attachmentUrls,
    int? likesCount,
    int? commentsCount,
    String? status,
    Object? rejectionReason = $none,
    bool? isDraft,
    bool? isActive,
    bool? isDeleted,
    int? reportedCount,
    bool? isReported,
    String? createdAt,
    String? updatedAt,
    Object? user = $none,
    Object? category = $none,
    bool? isLiked,
    bool? isAuthor,
    bool? showTipsBadge,
    List<String>? hashtags,
    List<String>? tipsList,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (userId != null) #userId: userId,
      if (categoryId != null) #categoryId: categoryId,
      if (title != null) #title: title,
      if (description != null) #description: description,
      if (attachmentUrls != null) #attachmentUrls: attachmentUrls,
      if (likesCount != null) #likesCount: likesCount,
      if (commentsCount != null) #commentsCount: commentsCount,
      if (status != null) #status: status,
      if (rejectionReason != $none) #rejectionReason: rejectionReason,
      if (isDraft != null) #isDraft: isDraft,
      if (isActive != null) #isActive: isActive,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (reportedCount != null) #reportedCount: reportedCount,
      if (isReported != null) #isReported: isReported,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
      if (user != $none) #user: user,
      if (category != $none) #category: category,
      if (isLiked != null) #isLiked: isLiked,
      if (isAuthor != null) #isAuthor: isAuthor,
      if (showTipsBadge != null) #showTipsBadge: showTipsBadge,
      if (hashtags != null) #hashtags: hashtags,
      if (tipsList != null) #tipsList: tipsList,
    }),
  );
  @override
  TipsInfoItemModel $make(CopyWithData data) => TipsInfoItemModel(
    id: data.get(#id, or: $value.id),
    userId: data.get(#userId, or: $value.userId),
    categoryId: data.get(#categoryId, or: $value.categoryId),
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    attachmentUrls: data.get(#attachmentUrls, or: $value.attachmentUrls),
    likesCount: data.get(#likesCount, or: $value.likesCount),
    commentsCount: data.get(#commentsCount, or: $value.commentsCount),
    status: data.get(#status, or: $value.status),
    rejectionReason: data.get(#rejectionReason, or: $value.rejectionReason),
    isDraft: data.get(#isDraft, or: $value.isDraft),
    isActive: data.get(#isActive, or: $value.isActive),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    reportedCount: data.get(#reportedCount, or: $value.reportedCount),
    isReported: data.get(#isReported, or: $value.isReported),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    user: data.get(#user, or: $value.user),
    category: data.get(#category, or: $value.category),
    isLiked: data.get(#isLiked, or: $value.isLiked),
    isAuthor: data.get(#isAuthor, or: $value.isAuthor),
    showTipsBadge: data.get(#showTipsBadge, or: $value.showTipsBadge),
    hashtags: data.get(#hashtags, or: $value.hashtags),
    tipsList: data.get(#tipsList, or: $value.tipsList),
  );

  @override
  TipsInfoItemModelCopyWith<$R2, TipsInfoItemModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TipsInfoItemModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class TipsImageInfoMapper extends ClassMapperBase<TipsImageInfo> {
  TipsImageInfoMapper._();

  static TipsImageInfoMapper? _instance;
  static TipsImageInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TipsImageInfoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TipsImageInfo';

  static String _$id(TipsImageInfo v) => v.id;
  static const Field<TipsImageInfo, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$imageUrl(TipsImageInfo v) => v.imageUrl;
  static const Field<TipsImageInfo, String> _f$imageUrl = Field(
    'imageUrl',
    _$imageUrl,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$url(TipsImageInfo v) => v.url;
  static const Field<TipsImageInfo, String> _f$url = Field(
    'url',
    _$url,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$name(TipsImageInfo v) => v.name;
  static const Field<TipsImageInfo, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static int _$size(TipsImageInfo v) => v.size;
  static const Field<TipsImageInfo, int> _f$size = Field(
    'size',
    _$size,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );

  @override
  final MappableFields<TipsImageInfo> fields = const {
    #id: _f$id,
    #imageUrl: _f$imageUrl,
    #url: _f$url,
    #name: _f$name,
    #size: _f$size,
  };

  static TipsImageInfo _instantiate(DecodingData data) {
    return TipsImageInfo(
      id: data.dec(_f$id),
      imageUrl: data.dec(_f$imageUrl),
      url: data.dec(_f$url),
      name: data.dec(_f$name),
      size: data.dec(_f$size),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static TipsImageInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TipsImageInfo>(map);
  }

  static TipsImageInfo fromJson(String json) {
    return ensureInitialized().decodeJson<TipsImageInfo>(json);
  }
}

mixin TipsImageInfoMappable {
  String toJson() {
    return TipsImageInfoMapper.ensureInitialized().encodeJson<TipsImageInfo>(
      this as TipsImageInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return TipsImageInfoMapper.ensureInitialized().encodeMap<TipsImageInfo>(
      this as TipsImageInfo,
    );
  }

  TipsImageInfoCopyWith<TipsImageInfo, TipsImageInfo, TipsImageInfo>
  get copyWith => _TipsImageInfoCopyWithImpl<TipsImageInfo, TipsImageInfo>(
    this as TipsImageInfo,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return TipsImageInfoMapper.ensureInitialized().stringifyValue(
      this as TipsImageInfo,
    );
  }

  @override
  bool operator ==(Object other) {
    return TipsImageInfoMapper.ensureInitialized().equalsValue(
      this as TipsImageInfo,
      other,
    );
  }

  @override
  int get hashCode {
    return TipsImageInfoMapper.ensureInitialized().hashValue(
      this as TipsImageInfo,
    );
  }
}

extension TipsImageInfoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TipsImageInfo, $Out> {
  TipsImageInfoCopyWith<$R, TipsImageInfo, $Out> get $asTipsImageInfo =>
      $base.as((v, t, t2) => _TipsImageInfoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TipsImageInfoCopyWith<$R, $In extends TipsImageInfo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? imageUrl, String? url, String? name, int? size});
  TipsImageInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TipsImageInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TipsImageInfo, $Out>
    implements TipsImageInfoCopyWith<$R, TipsImageInfo, $Out> {
  _TipsImageInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TipsImageInfo> $mapper =
      TipsImageInfoMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? imageUrl,
    String? url,
    String? name,
    int? size,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (imageUrl != null) #imageUrl: imageUrl,
      if (url != null) #url: url,
      if (name != null) #name: name,
      if (size != null) #size: size,
    }),
  );
  @override
  TipsImageInfo $make(CopyWithData data) => TipsImageInfo(
    id: data.get(#id, or: $value.id),
    imageUrl: data.get(#imageUrl, or: $value.imageUrl),
    url: data.get(#url, or: $value.url),
    name: data.get(#name, or: $value.name),
    size: data.get(#size, or: $value.size),
  );

  @override
  TipsImageInfoCopyWith<$R2, TipsImageInfo, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TipsImageInfoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class TipsUserInfoMapper extends ClassMapperBase<TipsUserInfo> {
  TipsUserInfoMapper._();

  static TipsUserInfoMapper? _instance;
  static TipsUserInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TipsUserInfoMapper._());
      TipsUserProfileMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TipsUserInfo';

  static String _$id(TipsUserInfo v) => v.id;
  static const Field<TipsUserInfo, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$name(TipsUserInfo v) => v.name;
  static const Field<TipsUserInfo, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$email(TipsUserInfo v) => v.email;
  static const Field<TipsUserInfo, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static TipsUserProfile? _$profile(TipsUserInfo v) => v.profile;
  static const Field<TipsUserInfo, TipsUserProfile> _f$profile = Field(
    'profile',
    _$profile,
    opt: true,
  );

  @override
  final MappableFields<TipsUserInfo> fields = const {
    #id: _f$id,
    #name: _f$name,
    #email: _f$email,
    #profile: _f$profile,
  };

  static TipsUserInfo _instantiate(DecodingData data) {
    return TipsUserInfo(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      email: data.dec(_f$email),
      profile: data.dec(_f$profile),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static TipsUserInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TipsUserInfo>(map);
  }

  static TipsUserInfo fromJson(String json) {
    return ensureInitialized().decodeJson<TipsUserInfo>(json);
  }
}

mixin TipsUserInfoMappable {
  String toJson() {
    return TipsUserInfoMapper.ensureInitialized().encodeJson<TipsUserInfo>(
      this as TipsUserInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return TipsUserInfoMapper.ensureInitialized().encodeMap<TipsUserInfo>(
      this as TipsUserInfo,
    );
  }

  TipsUserInfoCopyWith<TipsUserInfo, TipsUserInfo, TipsUserInfo> get copyWith =>
      _TipsUserInfoCopyWithImpl<TipsUserInfo, TipsUserInfo>(
        this as TipsUserInfo,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TipsUserInfoMapper.ensureInitialized().stringifyValue(
      this as TipsUserInfo,
    );
  }

  @override
  bool operator ==(Object other) {
    return TipsUserInfoMapper.ensureInitialized().equalsValue(
      this as TipsUserInfo,
      other,
    );
  }

  @override
  int get hashCode {
    return TipsUserInfoMapper.ensureInitialized().hashValue(
      this as TipsUserInfo,
    );
  }
}

extension TipsUserInfoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TipsUserInfo, $Out> {
  TipsUserInfoCopyWith<$R, TipsUserInfo, $Out> get $asTipsUserInfo =>
      $base.as((v, t, t2) => _TipsUserInfoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TipsUserInfoCopyWith<$R, $In extends TipsUserInfo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  TipsUserProfileCopyWith<$R, TipsUserProfile, TipsUserProfile>? get profile;
  $R call({String? id, String? name, String? email, TipsUserProfile? profile});
  TipsUserInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TipsUserInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TipsUserInfo, $Out>
    implements TipsUserInfoCopyWith<$R, TipsUserInfo, $Out> {
  _TipsUserInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TipsUserInfo> $mapper =
      TipsUserInfoMapper.ensureInitialized();
  @override
  TipsUserProfileCopyWith<$R, TipsUserProfile, TipsUserProfile>? get profile =>
      $value.profile?.copyWith.$chain((v) => call(profile: v));
  @override
  $R call({String? id, String? name, String? email, Object? profile = $none}) =>
      $apply(
        FieldCopyWithData({
          if (id != null) #id: id,
          if (name != null) #name: name,
          if (email != null) #email: email,
          if (profile != $none) #profile: profile,
        }),
      );
  @override
  TipsUserInfo $make(CopyWithData data) => TipsUserInfo(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    email: data.get(#email, or: $value.email),
    profile: data.get(#profile, or: $value.profile),
  );

  @override
  TipsUserInfoCopyWith<$R2, TipsUserInfo, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TipsUserInfoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class TipsUserProfileMapper extends ClassMapperBase<TipsUserProfile> {
  TipsUserProfileMapper._();

  static TipsUserProfileMapper? _instance;
  static TipsUserProfileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TipsUserProfileMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TipsUserProfile';

  static String? _$profilePicture(TipsUserProfile v) => v.profilePicture;
  static const Field<TipsUserProfile, String> _f$profilePicture = Field(
    'profilePicture',
    _$profilePicture,
    opt: true,
  );

  @override
  final MappableFields<TipsUserProfile> fields = const {
    #profilePicture: _f$profilePicture,
  };

  static TipsUserProfile _instantiate(DecodingData data) {
    return TipsUserProfile(profilePicture: data.dec(_f$profilePicture));
  }

  @override
  final Function instantiate = _instantiate;

  static TipsUserProfile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TipsUserProfile>(map);
  }

  static TipsUserProfile fromJson(String json) {
    return ensureInitialized().decodeJson<TipsUserProfile>(json);
  }
}

mixin TipsUserProfileMappable {
  String toJson() {
    return TipsUserProfileMapper.ensureInitialized()
        .encodeJson<TipsUserProfile>(this as TipsUserProfile);
  }

  Map<String, dynamic> toMap() {
    return TipsUserProfileMapper.ensureInitialized().encodeMap<TipsUserProfile>(
      this as TipsUserProfile,
    );
  }

  TipsUserProfileCopyWith<TipsUserProfile, TipsUserProfile, TipsUserProfile>
  get copyWith =>
      _TipsUserProfileCopyWithImpl<TipsUserProfile, TipsUserProfile>(
        this as TipsUserProfile,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TipsUserProfileMapper.ensureInitialized().stringifyValue(
      this as TipsUserProfile,
    );
  }

  @override
  bool operator ==(Object other) {
    return TipsUserProfileMapper.ensureInitialized().equalsValue(
      this as TipsUserProfile,
      other,
    );
  }

  @override
  int get hashCode {
    return TipsUserProfileMapper.ensureInitialized().hashValue(
      this as TipsUserProfile,
    );
  }
}

extension TipsUserProfileValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TipsUserProfile, $Out> {
  TipsUserProfileCopyWith<$R, TipsUserProfile, $Out> get $asTipsUserProfile =>
      $base.as((v, t, t2) => _TipsUserProfileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TipsUserProfileCopyWith<$R, $In extends TipsUserProfile, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? profilePicture});
  TipsUserProfileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _TipsUserProfileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TipsUserProfile, $Out>
    implements TipsUserProfileCopyWith<$R, TipsUserProfile, $Out> {
  _TipsUserProfileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TipsUserProfile> $mapper =
      TipsUserProfileMapper.ensureInitialized();
  @override
  $R call({Object? profilePicture = $none}) => $apply(
    FieldCopyWithData({
      if (profilePicture != $none) #profilePicture: profilePicture,
    }),
  );
  @override
  TipsUserProfile $make(CopyWithData data) => TipsUserProfile(
    profilePicture: data.get(#profilePicture, or: $value.profilePicture),
  );

  @override
  TipsUserProfileCopyWith<$R2, TipsUserProfile, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TipsUserProfileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class TipsCategoryInfoMapper extends ClassMapperBase<TipsCategoryInfo> {
  TipsCategoryInfoMapper._();

  static TipsCategoryInfoMapper? _instance;
  static TipsCategoryInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TipsCategoryInfoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TipsCategoryInfo';

  static String _$id(TipsCategoryInfo v) => v.id;
  static const Field<TipsCategoryInfo, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$name(TipsCategoryInfo v) => v.name;
  static const Field<TipsCategoryInfo, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<TipsCategoryInfo> fields = const {
    #id: _f$id,
    #name: _f$name,
  };

  static TipsCategoryInfo _instantiate(DecodingData data) {
    return TipsCategoryInfo(id: data.dec(_f$id), name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static TipsCategoryInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TipsCategoryInfo>(map);
  }

  static TipsCategoryInfo fromJson(String json) {
    return ensureInitialized().decodeJson<TipsCategoryInfo>(json);
  }
}

mixin TipsCategoryInfoMappable {
  String toJson() {
    return TipsCategoryInfoMapper.ensureInitialized()
        .encodeJson<TipsCategoryInfo>(this as TipsCategoryInfo);
  }

  Map<String, dynamic> toMap() {
    return TipsCategoryInfoMapper.ensureInitialized()
        .encodeMap<TipsCategoryInfo>(this as TipsCategoryInfo);
  }

  TipsCategoryInfoCopyWith<TipsCategoryInfo, TipsCategoryInfo, TipsCategoryInfo>
  get copyWith =>
      _TipsCategoryInfoCopyWithImpl<TipsCategoryInfo, TipsCategoryInfo>(
        this as TipsCategoryInfo,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TipsCategoryInfoMapper.ensureInitialized().stringifyValue(
      this as TipsCategoryInfo,
    );
  }

  @override
  bool operator ==(Object other) {
    return TipsCategoryInfoMapper.ensureInitialized().equalsValue(
      this as TipsCategoryInfo,
      other,
    );
  }

  @override
  int get hashCode {
    return TipsCategoryInfoMapper.ensureInitialized().hashValue(
      this as TipsCategoryInfo,
    );
  }
}

extension TipsCategoryInfoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TipsCategoryInfo, $Out> {
  TipsCategoryInfoCopyWith<$R, TipsCategoryInfo, $Out>
  get $asTipsCategoryInfo =>
      $base.as((v, t, t2) => _TipsCategoryInfoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TipsCategoryInfoCopyWith<$R, $In extends TipsCategoryInfo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name});
  TipsCategoryInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _TipsCategoryInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TipsCategoryInfo, $Out>
    implements TipsCategoryInfoCopyWith<$R, TipsCategoryInfo, $Out> {
  _TipsCategoryInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TipsCategoryInfo> $mapper =
      TipsCategoryInfoMapper.ensureInitialized();
  @override
  $R call({String? id, String? name}) => $apply(
    FieldCopyWithData({if (id != null) #id: id, if (name != null) #name: name}),
  );
  @override
  TipsCategoryInfo $make(CopyWithData data) => TipsCategoryInfo(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
  );

  @override
  TipsCategoryInfoCopyWith<$R2, TipsCategoryInfo, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TipsCategoryInfoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

