// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'my_submitted_posts_model.dart';

class MySubmittedPostsModelMapper
    extends ClassMapperBase<MySubmittedPostsModel> {
  MySubmittedPostsModelMapper._();

  static MySubmittedPostsModelMapper? _instance;
  static MySubmittedPostsModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MySubmittedPostsModelMapper._());
      AttachmentMapper.ensureInitialized();
      CategoryMapper.ensureInitialized();
      UserMapper.ensureInitialized();
      EventOrganizerInfoMapper.ensureInitialized();
      EventImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MySubmittedPostsModel';

  static String _$id(MySubmittedPostsModel v) => v.id;
  static const Field<MySubmittedPostsModel, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$type(MySubmittedPostsModel v) => v.type;
  static const Field<MySubmittedPostsModel, String> _f$type = Field(
    'type',
    _$type,
    opt: true,
    def: '',
  );
  static String _$title(MySubmittedPostsModel v) => v.title;
  static const Field<MySubmittedPostsModel, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
    def: '',
  );
  static String _$description(MySubmittedPostsModel v) => v.description;
  static const Field<MySubmittedPostsModel, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
  );
  static List<Attachment> _$attachmentUrls(MySubmittedPostsModel v) =>
      v.attachmentUrls;
  static const Field<MySubmittedPostsModel, List<Attachment>>
  _f$attachmentUrls = Field(
    'attachmentUrls',
    _$attachmentUrls,
    opt: true,
    def: const [],
    hook: SafeListHook(),
  );
  static String _$status(MySubmittedPostsModel v) => v.status;
  static const Field<MySubmittedPostsModel, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
    def: '',
  );
  static int _$likesCount(MySubmittedPostsModel v) => v.likesCount;
  static const Field<MySubmittedPostsModel, int> _f$likesCount = Field(
    'likesCount',
    _$likesCount,
    opt: true,
    def: 0,
  );
  static int _$commentsCount(MySubmittedPostsModel v) => v.commentsCount;
  static const Field<MySubmittedPostsModel, int> _f$commentsCount = Field(
    'commentsCount',
    _$commentsCount,
    opt: true,
    def: 0,
  );
  static int _$attendanceCount(MySubmittedPostsModel v) => v.attendanceCount;
  static const Field<MySubmittedPostsModel, int> _f$attendanceCount = Field(
    'attendanceCount',
    _$attendanceCount,
    opt: true,
    def: 0,
  );
  static bool _$isDraft(MySubmittedPostsModel v) => v.isDraft;
  static const Field<MySubmittedPostsModel, bool> _f$isDraft = Field(
    'isDraft',
    _$isDraft,
    opt: true,
    def: false,
  );
  static bool _$isDeleted(MySubmittedPostsModel v) => v.isDeleted;
  static const Field<MySubmittedPostsModel, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static bool _$isLiked(MySubmittedPostsModel v) => v.isLiked;
  static const Field<MySubmittedPostsModel, bool> _f$isLiked = Field(
    'isLiked',
    _$isLiked,
    opt: true,
    def: false,
  );
  static Category? _$category(MySubmittedPostsModel v) => v.category;
  static const Field<MySubmittedPostsModel, Category> _f$category = Field(
    'category',
    _$category,
    opt: true,
  );
  static User? _$user(MySubmittedPostsModel v) => v.user;
  static const Field<MySubmittedPostsModel, User> _f$user = Field(
    'user',
    _$user,
    opt: true,
  );
  static EventOrganizerInfo? _$organizer(MySubmittedPostsModel v) =>
      v.organizer;
  static const Field<MySubmittedPostsModel, EventOrganizerInfo> _f$organizer =
      Field('organizer', _$organizer, opt: true);
  static String _$location(MySubmittedPostsModel v) => v.location;
  static const Field<MySubmittedPostsModel, String> _f$location = Field(
    'location',
    _$location,
    opt: true,
    def: '',
  );
  static String? _$eventStartDate(MySubmittedPostsModel v) => v.eventStartDate;
  static const Field<MySubmittedPostsModel, String> _f$eventStartDate = Field(
    'eventStartDate',
    _$eventStartDate,
    opt: true,
  );
  static String? _$eventEndDate(MySubmittedPostsModel v) => v.eventEndDate;
  static const Field<MySubmittedPostsModel, String> _f$eventEndDate = Field(
    'eventEndDate',
    _$eventEndDate,
    opt: true,
  );
  static String _$eventTime(MySubmittedPostsModel v) => v.eventTime;
  static const Field<MySubmittedPostsModel, String> _f$eventTime = Field(
    'eventTime',
    _$eventTime,
    opt: true,
    def: '',
  );
  static List<EventImage> _$images(MySubmittedPostsModel v) => v.images;
  static const Field<MySubmittedPostsModel, List<EventImage>> _f$images = Field(
    'images',
    _$images,
    opt: true,
    def: const [],
    hook: SafeListHook(),
  );
  static String? _$createdAt(MySubmittedPostsModel v) => v.createdAt;
  static const Field<MySubmittedPostsModel, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );
  static String? _$updatedAt(MySubmittedPostsModel v) => v.updatedAt;
  static const Field<MySubmittedPostsModel, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
  );

  @override
  final MappableFields<MySubmittedPostsModel> fields = const {
    #id: _f$id,
    #type: _f$type,
    #title: _f$title,
    #description: _f$description,
    #attachmentUrls: _f$attachmentUrls,
    #status: _f$status,
    #likesCount: _f$likesCount,
    #commentsCount: _f$commentsCount,
    #attendanceCount: _f$attendanceCount,
    #isDraft: _f$isDraft,
    #isDeleted: _f$isDeleted,
    #isLiked: _f$isLiked,
    #category: _f$category,
    #user: _f$user,
    #organizer: _f$organizer,
    #location: _f$location,
    #eventStartDate: _f$eventStartDate,
    #eventEndDate: _f$eventEndDate,
    #eventTime: _f$eventTime,
    #images: _f$images,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static MySubmittedPostsModel _instantiate(DecodingData data) {
    return MySubmittedPostsModel(
      id: data.dec(_f$id),
      type: data.dec(_f$type),
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      attachmentUrls: data.dec(_f$attachmentUrls),
      status: data.dec(_f$status),
      likesCount: data.dec(_f$likesCount),
      commentsCount: data.dec(_f$commentsCount),
      attendanceCount: data.dec(_f$attendanceCount),
      isDraft: data.dec(_f$isDraft),
      isDeleted: data.dec(_f$isDeleted),
      isLiked: data.dec(_f$isLiked),
      category: data.dec(_f$category),
      user: data.dec(_f$user),
      organizer: data.dec(_f$organizer),
      location: data.dec(_f$location),
      eventStartDate: data.dec(_f$eventStartDate),
      eventEndDate: data.dec(_f$eventEndDate),
      eventTime: data.dec(_f$eventTime),
      images: data.dec(_f$images),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MySubmittedPostsModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MySubmittedPostsModel>(map);
  }

  static MySubmittedPostsModel fromJson(String json) {
    return ensureInitialized().decodeJson<MySubmittedPostsModel>(json);
  }
}

mixin MySubmittedPostsModelMappable {
  String toJson() {
    return MySubmittedPostsModelMapper.ensureInitialized()
        .encodeJson<MySubmittedPostsModel>(this as MySubmittedPostsModel);
  }

  Map<String, dynamic> toMap() {
    return MySubmittedPostsModelMapper.ensureInitialized()
        .encodeMap<MySubmittedPostsModel>(this as MySubmittedPostsModel);
  }

  MySubmittedPostsModelCopyWith<
    MySubmittedPostsModel,
    MySubmittedPostsModel,
    MySubmittedPostsModel
  >
  get copyWith =>
      _MySubmittedPostsModelCopyWithImpl<
        MySubmittedPostsModel,
        MySubmittedPostsModel
      >(this as MySubmittedPostsModel, $identity, $identity);
  @override
  String toString() {
    return MySubmittedPostsModelMapper.ensureInitialized().stringifyValue(
      this as MySubmittedPostsModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return MySubmittedPostsModelMapper.ensureInitialized().equalsValue(
      this as MySubmittedPostsModel,
      other,
    );
  }

  @override
  int get hashCode {
    return MySubmittedPostsModelMapper.ensureInitialized().hashValue(
      this as MySubmittedPostsModel,
    );
  }
}

extension MySubmittedPostsModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MySubmittedPostsModel, $Out> {
  MySubmittedPostsModelCopyWith<$R, MySubmittedPostsModel, $Out>
  get $asMySubmittedPostsModel => $base.as(
    (v, t, t2) => _MySubmittedPostsModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class MySubmittedPostsModelCopyWith<
  $R,
  $In extends MySubmittedPostsModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Attachment, AttachmentCopyWith<$R, Attachment, Attachment>>
  get attachmentUrls;
  CategoryCopyWith<$R, Category, Category>? get category;
  UserCopyWith<$R, User, User>? get user;
  EventOrganizerInfoCopyWith<$R, EventOrganizerInfo, EventOrganizerInfo>?
  get organizer;
  ListCopyWith<$R, EventImage, EventImageCopyWith<$R, EventImage, EventImage>>
  get images;
  $R call({
    String? id,
    String? type,
    String? title,
    String? description,
    List<Attachment>? attachmentUrls,
    String? status,
    int? likesCount,
    int? commentsCount,
    int? attendanceCount,
    bool? isDraft,
    bool? isDeleted,
    bool? isLiked,
    Category? category,
    User? user,
    EventOrganizerInfo? organizer,
    String? location,
    String? eventStartDate,
    String? eventEndDate,
    String? eventTime,
    List<EventImage>? images,
    String? createdAt,
    String? updatedAt,
  });
  MySubmittedPostsModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MySubmittedPostsModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MySubmittedPostsModel, $Out>
    implements MySubmittedPostsModelCopyWith<$R, MySubmittedPostsModel, $Out> {
  _MySubmittedPostsModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MySubmittedPostsModel> $mapper =
      MySubmittedPostsModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Attachment, AttachmentCopyWith<$R, Attachment, Attachment>>
  get attachmentUrls => ListCopyWith(
    $value.attachmentUrls,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(attachmentUrls: v),
  );
  @override
  CategoryCopyWith<$R, Category, Category>? get category =>
      $value.category?.copyWith.$chain((v) => call(category: v));
  @override
  UserCopyWith<$R, User, User>? get user =>
      $value.user?.copyWith.$chain((v) => call(user: v));
  @override
  EventOrganizerInfoCopyWith<$R, EventOrganizerInfo, EventOrganizerInfo>?
  get organizer => $value.organizer?.copyWith.$chain((v) => call(organizer: v));
  @override
  ListCopyWith<$R, EventImage, EventImageCopyWith<$R, EventImage, EventImage>>
  get images => ListCopyWith(
    $value.images,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(images: v),
  );
  @override
  $R call({
    String? id,
    String? type,
    String? title,
    String? description,
    List<Attachment>? attachmentUrls,
    String? status,
    int? likesCount,
    int? commentsCount,
    int? attendanceCount,
    bool? isDraft,
    bool? isDeleted,
    bool? isLiked,
    Object? category = $none,
    Object? user = $none,
    Object? organizer = $none,
    String? location,
    Object? eventStartDate = $none,
    Object? eventEndDate = $none,
    String? eventTime,
    List<EventImage>? images,
    Object? createdAt = $none,
    Object? updatedAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (type != null) #type: type,
      if (title != null) #title: title,
      if (description != null) #description: description,
      if (attachmentUrls != null) #attachmentUrls: attachmentUrls,
      if (status != null) #status: status,
      if (likesCount != null) #likesCount: likesCount,
      if (commentsCount != null) #commentsCount: commentsCount,
      if (attendanceCount != null) #attendanceCount: attendanceCount,
      if (isDraft != null) #isDraft: isDraft,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (isLiked != null) #isLiked: isLiked,
      if (category != $none) #category: category,
      if (user != $none) #user: user,
      if (organizer != $none) #organizer: organizer,
      if (location != null) #location: location,
      if (eventStartDate != $none) #eventStartDate: eventStartDate,
      if (eventEndDate != $none) #eventEndDate: eventEndDate,
      if (eventTime != null) #eventTime: eventTime,
      if (images != null) #images: images,
      if (createdAt != $none) #createdAt: createdAt,
      if (updatedAt != $none) #updatedAt: updatedAt,
    }),
  );
  @override
  MySubmittedPostsModel $make(CopyWithData data) => MySubmittedPostsModel(
    id: data.get(#id, or: $value.id),
    type: data.get(#type, or: $value.type),
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    attachmentUrls: data.get(#attachmentUrls, or: $value.attachmentUrls),
    status: data.get(#status, or: $value.status),
    likesCount: data.get(#likesCount, or: $value.likesCount),
    commentsCount: data.get(#commentsCount, or: $value.commentsCount),
    attendanceCount: data.get(#attendanceCount, or: $value.attendanceCount),
    isDraft: data.get(#isDraft, or: $value.isDraft),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    isLiked: data.get(#isLiked, or: $value.isLiked),
    category: data.get(#category, or: $value.category),
    user: data.get(#user, or: $value.user),
    organizer: data.get(#organizer, or: $value.organizer),
    location: data.get(#location, or: $value.location),
    eventStartDate: data.get(#eventStartDate, or: $value.eventStartDate),
    eventEndDate: data.get(#eventEndDate, or: $value.eventEndDate),
    eventTime: data.get(#eventTime, or: $value.eventTime),
    images: data.get(#images, or: $value.images),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
  );

  @override
  MySubmittedPostsModelCopyWith<$R2, MySubmittedPostsModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MySubmittedPostsModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AttachmentMapper extends ClassMapperBase<Attachment> {
  AttachmentMapper._();

  static AttachmentMapper? _instance;
  static AttachmentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AttachmentMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Attachment';

  static String _$id(Attachment v) => v.id;
  static const Field<Attachment, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$url(Attachment v) => v.url;
  static const Field<Attachment, String> _f$url = Field(
    'url',
    _$url,
    opt: true,
    def: '',
  );
  static String _$name(Attachment v) => v.name;
  static const Field<Attachment, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
  );
  static String _$size(Attachment v) => v.size;
  static const Field<Attachment, String> _f$size = Field(
    'size',
    _$size,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<Attachment> fields = const {
    #id: _f$id,
    #url: _f$url,
    #name: _f$name,
    #size: _f$size,
  };

  static Attachment _instantiate(DecodingData data) {
    return Attachment(
      id: data.dec(_f$id),
      url: data.dec(_f$url),
      name: data.dec(_f$name),
      size: data.dec(_f$size),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Attachment fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Attachment>(map);
  }

  static Attachment fromJson(String json) {
    return ensureInitialized().decodeJson<Attachment>(json);
  }
}

mixin AttachmentMappable {
  String toJson() {
    return AttachmentMapper.ensureInitialized().encodeJson<Attachment>(
      this as Attachment,
    );
  }

  Map<String, dynamic> toMap() {
    return AttachmentMapper.ensureInitialized().encodeMap<Attachment>(
      this as Attachment,
    );
  }

  AttachmentCopyWith<Attachment, Attachment, Attachment> get copyWith =>
      _AttachmentCopyWithImpl<Attachment, Attachment>(
        this as Attachment,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AttachmentMapper.ensureInitialized().stringifyValue(
      this as Attachment,
    );
  }

  @override
  bool operator ==(Object other) {
    return AttachmentMapper.ensureInitialized().equalsValue(
      this as Attachment,
      other,
    );
  }

  @override
  int get hashCode {
    return AttachmentMapper.ensureInitialized().hashValue(this as Attachment);
  }
}

extension AttachmentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Attachment, $Out> {
  AttachmentCopyWith<$R, Attachment, $Out> get $asAttachment =>
      $base.as((v, t, t2) => _AttachmentCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AttachmentCopyWith<$R, $In extends Attachment, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? url, String? name, String? size});
  AttachmentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AttachmentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Attachment, $Out>
    implements AttachmentCopyWith<$R, Attachment, $Out> {
  _AttachmentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Attachment> $mapper =
      AttachmentMapper.ensureInitialized();
  @override
  $R call({String? id, String? url, String? name, String? size}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (url != null) #url: url,
      if (name != null) #name: name,
      if (size != null) #size: size,
    }),
  );
  @override
  Attachment $make(CopyWithData data) => Attachment(
    id: data.get(#id, or: $value.id),
    url: data.get(#url, or: $value.url),
    name: data.get(#name, or: $value.name),
    size: data.get(#size, or: $value.size),
  );

  @override
  AttachmentCopyWith<$R2, Attachment, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AttachmentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CategoryMapper extends ClassMapperBase<Category> {
  CategoryMapper._();

  static CategoryMapper? _instance;
  static CategoryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CategoryMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Category';

  static String _$id(Category v) => v.id;
  static const Field<Category, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$name(Category v) => v.name;
  static const Field<Category, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<Category> fields = const {#id: _f$id, #name: _f$name};

  static Category _instantiate(DecodingData data) {
    return Category(id: data.dec(_f$id), name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static Category fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Category>(map);
  }

  static Category fromJson(String json) {
    return ensureInitialized().decodeJson<Category>(json);
  }
}

mixin CategoryMappable {
  String toJson() {
    return CategoryMapper.ensureInitialized().encodeJson<Category>(
      this as Category,
    );
  }

  Map<String, dynamic> toMap() {
    return CategoryMapper.ensureInitialized().encodeMap<Category>(
      this as Category,
    );
  }

  CategoryCopyWith<Category, Category, Category> get copyWith =>
      _CategoryCopyWithImpl<Category, Category>(
        this as Category,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CategoryMapper.ensureInitialized().stringifyValue(this as Category);
  }

  @override
  bool operator ==(Object other) {
    return CategoryMapper.ensureInitialized().equalsValue(
      this as Category,
      other,
    );
  }

  @override
  int get hashCode {
    return CategoryMapper.ensureInitialized().hashValue(this as Category);
  }
}

extension CategoryValueCopy<$R, $Out> on ObjectCopyWith<$R, Category, $Out> {
  CategoryCopyWith<$R, Category, $Out> get $asCategory =>
      $base.as((v, t, t2) => _CategoryCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CategoryCopyWith<$R, $In extends Category, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name});
  CategoryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CategoryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Category, $Out>
    implements CategoryCopyWith<$R, Category, $Out> {
  _CategoryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Category> $mapper =
      CategoryMapper.ensureInitialized();
  @override
  $R call({String? id, String? name}) => $apply(
    FieldCopyWithData({if (id != null) #id: id, if (name != null) #name: name}),
  );
  @override
  Category $make(CopyWithData data) => Category(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
  );

  @override
  CategoryCopyWith<$R2, Category, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CategoryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class UserMapper extends ClassMapperBase<User> {
  UserMapper._();

  static UserMapper? _instance;
  static UserMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserMapper._());
      UserProfileMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'User';

  static String _$id(User v) => v.id;
  static const Field<User, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$name(User v) => v.name;
  static const Field<User, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
  );
  static String _$email(User v) => v.email;
  static const Field<User, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
    def: '',
  );
  static UserProfile _$profile(User v) => v.profile;
  static const Field<User, UserProfile> _f$profile = Field(
    'profile',
    _$profile,
    opt: true,
    def: const UserProfile(),
  );

  @override
  final MappableFields<User> fields = const {
    #id: _f$id,
    #name: _f$name,
    #email: _f$email,
    #profile: _f$profile,
  };

  static User _instantiate(DecodingData data) {
    return User(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      email: data.dec(_f$email),
      profile: data.dec(_f$profile),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static User fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<User>(map);
  }

  static User fromJson(String json) {
    return ensureInitialized().decodeJson<User>(json);
  }
}

mixin UserMappable {
  String toJson() {
    return UserMapper.ensureInitialized().encodeJson<User>(this as User);
  }

  Map<String, dynamic> toMap() {
    return UserMapper.ensureInitialized().encodeMap<User>(this as User);
  }

  UserCopyWith<User, User, User> get copyWith =>
      _UserCopyWithImpl<User, User>(this as User, $identity, $identity);
  @override
  String toString() {
    return UserMapper.ensureInitialized().stringifyValue(this as User);
  }

  @override
  bool operator ==(Object other) {
    return UserMapper.ensureInitialized().equalsValue(this as User, other);
  }

  @override
  int get hashCode {
    return UserMapper.ensureInitialized().hashValue(this as User);
  }
}

extension UserValueCopy<$R, $Out> on ObjectCopyWith<$R, User, $Out> {
  UserCopyWith<$R, User, $Out> get $asUser =>
      $base.as((v, t, t2) => _UserCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserCopyWith<$R, $In extends User, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  UserProfileCopyWith<$R, UserProfile, UserProfile> get profile;
  $R call({String? id, String? name, String? email, UserProfile? profile});
  UserCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, User, $Out>
    implements UserCopyWith<$R, User, $Out> {
  _UserCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<User> $mapper = UserMapper.ensureInitialized();
  @override
  UserProfileCopyWith<$R, UserProfile, UserProfile> get profile =>
      $value.profile.copyWith.$chain((v) => call(profile: v));
  @override
  $R call({String? id, String? name, String? email, UserProfile? profile}) =>
      $apply(
        FieldCopyWithData({
          if (id != null) #id: id,
          if (name != null) #name: name,
          if (email != null) #email: email,
          if (profile != null) #profile: profile,
        }),
      );
  @override
  User $make(CopyWithData data) => User(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    email: data.get(#email, or: $value.email),
    profile: data.get(#profile, or: $value.profile),
  );

  @override
  UserCopyWith<$R2, User, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _UserCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class UserProfileMapper extends ClassMapperBase<UserProfile> {
  UserProfileMapper._();

  static UserProfileMapper? _instance;
  static UserProfileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserProfileMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserProfile';

  static String _$profilePicture(UserProfile v) => v.profilePicture;
  static const Field<UserProfile, String> _f$profilePicture = Field(
    'profilePicture',
    _$profilePicture,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<UserProfile> fields = const {
    #profilePicture: _f$profilePicture,
  };

  static UserProfile _instantiate(DecodingData data) {
    return UserProfile(profilePicture: data.dec(_f$profilePicture));
  }

  @override
  final Function instantiate = _instantiate;

  static UserProfile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserProfile>(map);
  }

  static UserProfile fromJson(String json) {
    return ensureInitialized().decodeJson<UserProfile>(json);
  }
}

mixin UserProfileMappable {
  String toJson() {
    return UserProfileMapper.ensureInitialized().encodeJson<UserProfile>(
      this as UserProfile,
    );
  }

  Map<String, dynamic> toMap() {
    return UserProfileMapper.ensureInitialized().encodeMap<UserProfile>(
      this as UserProfile,
    );
  }

  UserProfileCopyWith<UserProfile, UserProfile, UserProfile> get copyWith =>
      _UserProfileCopyWithImpl<UserProfile, UserProfile>(
        this as UserProfile,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return UserProfileMapper.ensureInitialized().stringifyValue(
      this as UserProfile,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserProfileMapper.ensureInitialized().equalsValue(
      this as UserProfile,
      other,
    );
  }

  @override
  int get hashCode {
    return UserProfileMapper.ensureInitialized().hashValue(this as UserProfile);
  }
}

extension UserProfileValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserProfile, $Out> {
  UserProfileCopyWith<$R, UserProfile, $Out> get $asUserProfile =>
      $base.as((v, t, t2) => _UserProfileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserProfileCopyWith<$R, $In extends UserProfile, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? profilePicture});
  UserProfileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserProfileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserProfile, $Out>
    implements UserProfileCopyWith<$R, UserProfile, $Out> {
  _UserProfileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserProfile> $mapper =
      UserProfileMapper.ensureInitialized();
  @override
  $R call({String? profilePicture}) => $apply(
    FieldCopyWithData({
      if (profilePicture != null) #profilePicture: profilePicture,
    }),
  );
  @override
  UserProfile $make(CopyWithData data) => UserProfile(
    profilePicture: data.get(#profilePicture, or: $value.profilePicture),
  );

  @override
  UserProfileCopyWith<$R2, UserProfile, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserProfileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class EventImageMapper extends ClassMapperBase<EventImage> {
  EventImageMapper._();

  static EventImageMapper? _instance;
  static EventImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventImageMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'EventImage';

  static String _$id(EventImage v) => v.id;
  static const Field<EventImage, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$url(EventImage v) => v.url;
  static const Field<EventImage, String> _f$url = Field(
    'url',
    _$url,
    opt: true,
    def: '',
  );
  static String _$name(EventImage v) => v.name;
  static const Field<EventImage, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
  );
  static String _$size(EventImage v) => v.size;
  static const Field<EventImage, String> _f$size = Field(
    'size',
    _$size,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<EventImage> fields = const {
    #id: _f$id,
    #url: _f$url,
    #name: _f$name,
    #size: _f$size,
  };

  static EventImage _instantiate(DecodingData data) {
    return EventImage(
      id: data.dec(_f$id),
      url: data.dec(_f$url),
      name: data.dec(_f$name),
      size: data.dec(_f$size),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static EventImage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EventImage>(map);
  }

  static EventImage fromJson(String json) {
    return ensureInitialized().decodeJson<EventImage>(json);
  }
}

mixin EventImageMappable {
  String toJson() {
    return EventImageMapper.ensureInitialized().encodeJson<EventImage>(
      this as EventImage,
    );
  }

  Map<String, dynamic> toMap() {
    return EventImageMapper.ensureInitialized().encodeMap<EventImage>(
      this as EventImage,
    );
  }

  EventImageCopyWith<EventImage, EventImage, EventImage> get copyWith =>
      _EventImageCopyWithImpl<EventImage, EventImage>(
        this as EventImage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return EventImageMapper.ensureInitialized().stringifyValue(
      this as EventImage,
    );
  }

  @override
  bool operator ==(Object other) {
    return EventImageMapper.ensureInitialized().equalsValue(
      this as EventImage,
      other,
    );
  }

  @override
  int get hashCode {
    return EventImageMapper.ensureInitialized().hashValue(this as EventImage);
  }
}

extension EventImageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EventImage, $Out> {
  EventImageCopyWith<$R, EventImage, $Out> get $asEventImage =>
      $base.as((v, t, t2) => _EventImageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EventImageCopyWith<$R, $In extends EventImage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? url, String? name, String? size});
  EventImageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EventImageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EventImage, $Out>
    implements EventImageCopyWith<$R, EventImage, $Out> {
  _EventImageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EventImage> $mapper =
      EventImageMapper.ensureInitialized();
  @override
  $R call({String? id, String? url, String? name, String? size}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (url != null) #url: url,
      if (name != null) #name: name,
      if (size != null) #size: size,
    }),
  );
  @override
  EventImage $make(CopyWithData data) => EventImage(
    id: data.get(#id, or: $value.id),
    url: data.get(#url, or: $value.url),
    name: data.get(#name, or: $value.name),
    size: data.get(#size, or: $value.size),
  );

  @override
  EventImageCopyWith<$R2, EventImage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _EventImageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

