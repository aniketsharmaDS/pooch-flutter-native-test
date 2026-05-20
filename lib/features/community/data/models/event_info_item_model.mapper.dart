// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'event_info_item_model.dart';

class EventInfoItemModelMapper extends ClassMapperBase<EventInfoItemModel> {
  EventInfoItemModelMapper._();

  static EventInfoItemModelMapper? _instance;
  static EventInfoItemModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventInfoItemModelMapper._());
      EventOrganizerInfoMapper.ensureInitialized();
      EventImageInfoMapper.ensureInitialized();
      EventCategoryInfoMapper.ensureInitialized();
      EventReportInfoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'EventInfoItemModel';

  static String _$id(EventInfoItemModel v) => v.id;
  static const Field<EventInfoItemModel, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$organizerId(EventInfoItemModel v) => v.organizerId;
  static const Field<EventInfoItemModel, String> _f$organizerId = Field(
    'organizerId',
    _$organizerId,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$title(EventInfoItemModel v) => v.title;
  static const Field<EventInfoItemModel, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$description(EventInfoItemModel v) => v.description;
  static const Field<EventInfoItemModel, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$categoryId(EventInfoItemModel v) => v.categoryId;
  static const Field<EventInfoItemModel, String> _f$categoryId = Field(
    'categoryId',
    _$categoryId,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$eventStartDate(EventInfoItemModel v) => v.eventStartDate;
  static const Field<EventInfoItemModel, String> _f$eventStartDate = Field(
    'eventStartDate',
    _$eventStartDate,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String? _$eventEndDate(EventInfoItemModel v) => v.eventEndDate;
  static const Field<EventInfoItemModel, String> _f$eventEndDate = Field(
    'eventEndDate',
    _$eventEndDate,
    opt: true,
  );
  static String _$eventTime(EventInfoItemModel v) => v.eventTime;
  static const Field<EventInfoItemModel, String> _f$eventTime = Field(
    'eventTime',
    _$eventTime,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$location(EventInfoItemModel v) => v.location;
  static const Field<EventInfoItemModel, String> _f$location = Field(
    'location',
    _$location,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$addressDetails(EventInfoItemModel v) => v.addressDetails;
  static const Field<EventInfoItemModel, String> _f$addressDetails = Field(
    'addressDetails',
    _$addressDetails,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$latitude(EventInfoItemModel v) => v.latitude;
  static const Field<EventInfoItemModel, String> _f$latitude = Field(
    'latitude',
    _$latitude,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$longitude(EventInfoItemModel v) => v.longitude;
  static const Field<EventInfoItemModel, String> _f$longitude = Field(
    'longitude',
    _$longitude,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static bool _$isPaid(EventInfoItemModel v) => v.isPaid;
  static const Field<EventInfoItemModel, bool> _f$isPaid = Field(
    'isPaid',
    _$isPaid,
    opt: true,
    def: false,
  );
  static int _$attendanceCount(EventInfoItemModel v) => v.attendanceCount;
  static const Field<EventInfoItemModel, int> _f$attendanceCount = Field(
    'attendanceCount',
    _$attendanceCount,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );
  static int _$likesCount(EventInfoItemModel v) => v.likesCount;
  static const Field<EventInfoItemModel, int> _f$likesCount = Field(
    'likesCount',
    _$likesCount,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );
  static int _$reportedCount(EventInfoItemModel v) => v.reportedCount;
  static const Field<EventInfoItemModel, int> _f$reportedCount = Field(
    'reportedCount',
    _$reportedCount,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );
  static bool _$isReported(EventInfoItemModel v) => v.isReported;
  static const Field<EventInfoItemModel, bool> _f$isReported = Field(
    'isReported',
    _$isReported,
    opt: true,
    def: false,
  );
  static String _$status(EventInfoItemModel v) => v.status;
  static const Field<EventInfoItemModel, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String? _$rejectionReason(EventInfoItemModel v) => v.rejectionReason;
  static const Field<EventInfoItemModel, String> _f$rejectionReason = Field(
    'rejectionReason',
    _$rejectionReason,
    opt: true,
  );
  static bool _$isActive(EventInfoItemModel v) => v.isActive;
  static const Field<EventInfoItemModel, bool> _f$isActive = Field(
    'isActive',
    _$isActive,
    opt: true,
    def: true,
  );
  static bool _$isDeleted(EventInfoItemModel v) => v.isDeleted;
  static const Field<EventInfoItemModel, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static String _$createdAt(EventInfoItemModel v) => v.createdAt;
  static const Field<EventInfoItemModel, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$updatedAt(EventInfoItemModel v) => v.updatedAt;
  static const Field<EventInfoItemModel, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static EventOrganizerInfo? _$organizer(EventInfoItemModel v) => v.organizer;
  static const Field<EventInfoItemModel, EventOrganizerInfo> _f$organizer =
      Field('organizer', _$organizer, opt: true);
  static List<EventImageInfo> _$images(EventInfoItemModel v) => v.images;
  static const Field<EventInfoItemModel, List<EventImageInfo>> _f$images =
      Field('images', _$images, opt: true, def: const []);
  static EventCategoryInfo? _$category(EventInfoItemModel v) => v.category;
  static const Field<EventInfoItemModel, EventCategoryInfo> _f$category = Field(
    'category',
    _$category,
    opt: true,
  );
  static String? _$userRsvpStatus(EventInfoItemModel v) => v.userRsvpStatus;
  static const Field<EventInfoItemModel, String> _f$userRsvpStatus = Field(
    'userRsvpStatus',
    _$userRsvpStatus,
    opt: true,
  );
  static bool _$isLiked(EventInfoItemModel v) => v.isLiked;
  static const Field<EventInfoItemModel, bool> _f$isLiked = Field(
    'isLiked',
    _$isLiked,
    opt: true,
    def: false,
  );
  static bool _$isAuthor(EventInfoItemModel v) => v.isAuthor;
  static const Field<EventInfoItemModel, bool> _f$isAuthor = Field(
    'isAuthor',
    _$isAuthor,
    opt: true,
    def: false,
  );
  static bool _$showEventsBadge(EventInfoItemModel v) => v.showEventsBadge;
  static const Field<EventInfoItemModel, bool> _f$showEventsBadge = Field(
    'showEventsBadge',
    _$showEventsBadge,
    opt: true,
    def: true,
  );
  static List<EventReportInfo> _$reports(EventInfoItemModel v) => v.reports;
  static const Field<EventInfoItemModel, List<EventReportInfo>> _f$reports =
      Field('reports', _$reports, opt: true, def: const []);
  static int _$reportsCount(EventInfoItemModel v) => v.reportsCount;
  static const Field<EventInfoItemModel, int> _f$reportsCount = Field(
    'reportsCount',
    _$reportsCount,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );
  static bool _$isUserReported(EventInfoItemModel v) => v.isUserReported;
  static const Field<EventInfoItemModel, bool> _f$isUserReported = Field(
    'isUserReported',
    _$isUserReported,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<EventInfoItemModel> fields = const {
    #id: _f$id,
    #organizerId: _f$organizerId,
    #title: _f$title,
    #description: _f$description,
    #categoryId: _f$categoryId,
    #eventStartDate: _f$eventStartDate,
    #eventEndDate: _f$eventEndDate,
    #eventTime: _f$eventTime,
    #location: _f$location,
    #addressDetails: _f$addressDetails,
    #latitude: _f$latitude,
    #longitude: _f$longitude,
    #isPaid: _f$isPaid,
    #attendanceCount: _f$attendanceCount,
    #likesCount: _f$likesCount,
    #reportedCount: _f$reportedCount,
    #isReported: _f$isReported,
    #status: _f$status,
    #rejectionReason: _f$rejectionReason,
    #isActive: _f$isActive,
    #isDeleted: _f$isDeleted,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #organizer: _f$organizer,
    #images: _f$images,
    #category: _f$category,
    #userRsvpStatus: _f$userRsvpStatus,
    #isLiked: _f$isLiked,
    #isAuthor: _f$isAuthor,
    #showEventsBadge: _f$showEventsBadge,
    #reports: _f$reports,
    #reportsCount: _f$reportsCount,
    #isUserReported: _f$isUserReported,
  };

  static EventInfoItemModel _instantiate(DecodingData data) {
    return EventInfoItemModel(
      id: data.dec(_f$id),
      organizerId: data.dec(_f$organizerId),
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      categoryId: data.dec(_f$categoryId),
      eventStartDate: data.dec(_f$eventStartDate),
      eventEndDate: data.dec(_f$eventEndDate),
      eventTime: data.dec(_f$eventTime),
      location: data.dec(_f$location),
      addressDetails: data.dec(_f$addressDetails),
      latitude: data.dec(_f$latitude),
      longitude: data.dec(_f$longitude),
      isPaid: data.dec(_f$isPaid),
      attendanceCount: data.dec(_f$attendanceCount),
      likesCount: data.dec(_f$likesCount),
      reportedCount: data.dec(_f$reportedCount),
      isReported: data.dec(_f$isReported),
      status: data.dec(_f$status),
      rejectionReason: data.dec(_f$rejectionReason),
      isActive: data.dec(_f$isActive),
      isDeleted: data.dec(_f$isDeleted),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      organizer: data.dec(_f$organizer),
      images: data.dec(_f$images),
      category: data.dec(_f$category),
      userRsvpStatus: data.dec(_f$userRsvpStatus),
      isLiked: data.dec(_f$isLiked),
      isAuthor: data.dec(_f$isAuthor),
      showEventsBadge: data.dec(_f$showEventsBadge),
      reports: data.dec(_f$reports),
      reportsCount: data.dec(_f$reportsCount),
      isUserReported: data.dec(_f$isUserReported),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static EventInfoItemModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EventInfoItemModel>(map);
  }

  static EventInfoItemModel fromJson(String json) {
    return ensureInitialized().decodeJson<EventInfoItemModel>(json);
  }
}

mixin EventInfoItemModelMappable {
  String toJson() {
    return EventInfoItemModelMapper.ensureInitialized()
        .encodeJson<EventInfoItemModel>(this as EventInfoItemModel);
  }

  Map<String, dynamic> toMap() {
    return EventInfoItemModelMapper.ensureInitialized()
        .encodeMap<EventInfoItemModel>(this as EventInfoItemModel);
  }

  EventInfoItemModelCopyWith<
    EventInfoItemModel,
    EventInfoItemModel,
    EventInfoItemModel
  >
  get copyWith =>
      _EventInfoItemModelCopyWithImpl<EventInfoItemModel, EventInfoItemModel>(
        this as EventInfoItemModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return EventInfoItemModelMapper.ensureInitialized().stringifyValue(
      this as EventInfoItemModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return EventInfoItemModelMapper.ensureInitialized().equalsValue(
      this as EventInfoItemModel,
      other,
    );
  }

  @override
  int get hashCode {
    return EventInfoItemModelMapper.ensureInitialized().hashValue(
      this as EventInfoItemModel,
    );
  }
}

extension EventInfoItemModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EventInfoItemModel, $Out> {
  EventInfoItemModelCopyWith<$R, EventInfoItemModel, $Out>
  get $asEventInfoItemModel => $base.as(
    (v, t, t2) => _EventInfoItemModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class EventInfoItemModelCopyWith<
  $R,
  $In extends EventInfoItemModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  EventOrganizerInfoCopyWith<$R, EventOrganizerInfo, EventOrganizerInfo>?
  get organizer;
  ListCopyWith<
    $R,
    EventImageInfo,
    EventImageInfoCopyWith<$R, EventImageInfo, EventImageInfo>
  >
  get images;
  EventCategoryInfoCopyWith<$R, EventCategoryInfo, EventCategoryInfo>?
  get category;
  ListCopyWith<
    $R,
    EventReportInfo,
    EventReportInfoCopyWith<$R, EventReportInfo, EventReportInfo>
  >
  get reports;
  $R call({
    String? id,
    String? organizerId,
    String? title,
    String? description,
    String? categoryId,
    String? eventStartDate,
    String? eventEndDate,
    String? eventTime,
    String? location,
    String? addressDetails,
    String? latitude,
    String? longitude,
    bool? isPaid,
    int? attendanceCount,
    int? likesCount,
    int? reportedCount,
    bool? isReported,
    String? status,
    String? rejectionReason,
    bool? isActive,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
    EventOrganizerInfo? organizer,
    List<EventImageInfo>? images,
    EventCategoryInfo? category,
    String? userRsvpStatus,
    bool? isLiked,
    bool? isAuthor,
    bool? showEventsBadge,
    List<EventReportInfo>? reports,
    int? reportsCount,
    bool? isUserReported,
  });
  EventInfoItemModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _EventInfoItemModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EventInfoItemModel, $Out>
    implements EventInfoItemModelCopyWith<$R, EventInfoItemModel, $Out> {
  _EventInfoItemModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EventInfoItemModel> $mapper =
      EventInfoItemModelMapper.ensureInitialized();
  @override
  EventOrganizerInfoCopyWith<$R, EventOrganizerInfo, EventOrganizerInfo>?
  get organizer => $value.organizer?.copyWith.$chain((v) => call(organizer: v));
  @override
  ListCopyWith<
    $R,
    EventImageInfo,
    EventImageInfoCopyWith<$R, EventImageInfo, EventImageInfo>
  >
  get images => ListCopyWith(
    $value.images,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(images: v),
  );
  @override
  EventCategoryInfoCopyWith<$R, EventCategoryInfo, EventCategoryInfo>?
  get category => $value.category?.copyWith.$chain((v) => call(category: v));
  @override
  ListCopyWith<
    $R,
    EventReportInfo,
    EventReportInfoCopyWith<$R, EventReportInfo, EventReportInfo>
  >
  get reports => ListCopyWith(
    $value.reports,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(reports: v),
  );
  @override
  $R call({
    String? id,
    String? organizerId,
    String? title,
    String? description,
    String? categoryId,
    String? eventStartDate,
    Object? eventEndDate = $none,
    String? eventTime,
    String? location,
    String? addressDetails,
    String? latitude,
    String? longitude,
    bool? isPaid,
    int? attendanceCount,
    int? likesCount,
    int? reportedCount,
    bool? isReported,
    String? status,
    Object? rejectionReason = $none,
    bool? isActive,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
    Object? organizer = $none,
    List<EventImageInfo>? images,
    Object? category = $none,
    Object? userRsvpStatus = $none,
    bool? isLiked,
    bool? isAuthor,
    bool? showEventsBadge,
    List<EventReportInfo>? reports,
    int? reportsCount,
    bool? isUserReported,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (organizerId != null) #organizerId: organizerId,
      if (title != null) #title: title,
      if (description != null) #description: description,
      if (categoryId != null) #categoryId: categoryId,
      if (eventStartDate != null) #eventStartDate: eventStartDate,
      if (eventEndDate != $none) #eventEndDate: eventEndDate,
      if (eventTime != null) #eventTime: eventTime,
      if (location != null) #location: location,
      if (addressDetails != null) #addressDetails: addressDetails,
      if (latitude != null) #latitude: latitude,
      if (longitude != null) #longitude: longitude,
      if (isPaid != null) #isPaid: isPaid,
      if (attendanceCount != null) #attendanceCount: attendanceCount,
      if (likesCount != null) #likesCount: likesCount,
      if (reportedCount != null) #reportedCount: reportedCount,
      if (isReported != null) #isReported: isReported,
      if (status != null) #status: status,
      if (rejectionReason != $none) #rejectionReason: rejectionReason,
      if (isActive != null) #isActive: isActive,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
      if (organizer != $none) #organizer: organizer,
      if (images != null) #images: images,
      if (category != $none) #category: category,
      if (userRsvpStatus != $none) #userRsvpStatus: userRsvpStatus,
      if (isLiked != null) #isLiked: isLiked,
      if (isAuthor != null) #isAuthor: isAuthor,
      if (showEventsBadge != null) #showEventsBadge: showEventsBadge,
      if (reports != null) #reports: reports,
      if (reportsCount != null) #reportsCount: reportsCount,
      if (isUserReported != null) #isUserReported: isUserReported,
    }),
  );
  @override
  EventInfoItemModel $make(CopyWithData data) => EventInfoItemModel(
    id: data.get(#id, or: $value.id),
    organizerId: data.get(#organizerId, or: $value.organizerId),
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    categoryId: data.get(#categoryId, or: $value.categoryId),
    eventStartDate: data.get(#eventStartDate, or: $value.eventStartDate),
    eventEndDate: data.get(#eventEndDate, or: $value.eventEndDate),
    eventTime: data.get(#eventTime, or: $value.eventTime),
    location: data.get(#location, or: $value.location),
    addressDetails: data.get(#addressDetails, or: $value.addressDetails),
    latitude: data.get(#latitude, or: $value.latitude),
    longitude: data.get(#longitude, or: $value.longitude),
    isPaid: data.get(#isPaid, or: $value.isPaid),
    attendanceCount: data.get(#attendanceCount, or: $value.attendanceCount),
    likesCount: data.get(#likesCount, or: $value.likesCount),
    reportedCount: data.get(#reportedCount, or: $value.reportedCount),
    isReported: data.get(#isReported, or: $value.isReported),
    status: data.get(#status, or: $value.status),
    rejectionReason: data.get(#rejectionReason, or: $value.rejectionReason),
    isActive: data.get(#isActive, or: $value.isActive),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    organizer: data.get(#organizer, or: $value.organizer),
    images: data.get(#images, or: $value.images),
    category: data.get(#category, or: $value.category),
    userRsvpStatus: data.get(#userRsvpStatus, or: $value.userRsvpStatus),
    isLiked: data.get(#isLiked, or: $value.isLiked),
    isAuthor: data.get(#isAuthor, or: $value.isAuthor),
    showEventsBadge: data.get(#showEventsBadge, or: $value.showEventsBadge),
    reports: data.get(#reports, or: $value.reports),
    reportsCount: data.get(#reportsCount, or: $value.reportsCount),
    isUserReported: data.get(#isUserReported, or: $value.isUserReported),
  );

  @override
  EventInfoItemModelCopyWith<$R2, EventInfoItemModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _EventInfoItemModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class EventOrganizerInfoMapper extends ClassMapperBase<EventOrganizerInfo> {
  EventOrganizerInfoMapper._();

  static EventOrganizerInfoMapper? _instance;
  static EventOrganizerInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventOrganizerInfoMapper._());
      EventOrganizerProfileMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'EventOrganizerInfo';

  static String _$id(EventOrganizerInfo v) => v.id;
  static const Field<EventOrganizerInfo, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$name(EventOrganizerInfo v) => v.name;
  static const Field<EventOrganizerInfo, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$email(EventOrganizerInfo v) => v.email;
  static const Field<EventOrganizerInfo, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static EventOrganizerProfile? _$profile(EventOrganizerInfo v) => v.profile;
  static const Field<EventOrganizerInfo, EventOrganizerProfile> _f$profile =
      Field('profile', _$profile, opt: true);

  @override
  final MappableFields<EventOrganizerInfo> fields = const {
    #id: _f$id,
    #name: _f$name,
    #email: _f$email,
    #profile: _f$profile,
  };

  static EventOrganizerInfo _instantiate(DecodingData data) {
    return EventOrganizerInfo(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      email: data.dec(_f$email),
      profile: data.dec(_f$profile),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static EventOrganizerInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EventOrganizerInfo>(map);
  }

  static EventOrganizerInfo fromJson(String json) {
    return ensureInitialized().decodeJson<EventOrganizerInfo>(json);
  }
}

mixin EventOrganizerInfoMappable {
  String toJson() {
    return EventOrganizerInfoMapper.ensureInitialized()
        .encodeJson<EventOrganizerInfo>(this as EventOrganizerInfo);
  }

  Map<String, dynamic> toMap() {
    return EventOrganizerInfoMapper.ensureInitialized()
        .encodeMap<EventOrganizerInfo>(this as EventOrganizerInfo);
  }

  EventOrganizerInfoCopyWith<
    EventOrganizerInfo,
    EventOrganizerInfo,
    EventOrganizerInfo
  >
  get copyWith =>
      _EventOrganizerInfoCopyWithImpl<EventOrganizerInfo, EventOrganizerInfo>(
        this as EventOrganizerInfo,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return EventOrganizerInfoMapper.ensureInitialized().stringifyValue(
      this as EventOrganizerInfo,
    );
  }

  @override
  bool operator ==(Object other) {
    return EventOrganizerInfoMapper.ensureInitialized().equalsValue(
      this as EventOrganizerInfo,
      other,
    );
  }

  @override
  int get hashCode {
    return EventOrganizerInfoMapper.ensureInitialized().hashValue(
      this as EventOrganizerInfo,
    );
  }
}

extension EventOrganizerInfoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EventOrganizerInfo, $Out> {
  EventOrganizerInfoCopyWith<$R, EventOrganizerInfo, $Out>
  get $asEventOrganizerInfo => $base.as(
    (v, t, t2) => _EventOrganizerInfoCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class EventOrganizerInfoCopyWith<
  $R,
  $In extends EventOrganizerInfo,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  EventOrganizerProfileCopyWith<
    $R,
    EventOrganizerProfile,
    EventOrganizerProfile
  >?
  get profile;
  $R call({
    String? id,
    String? name,
    String? email,
    EventOrganizerProfile? profile,
  });
  EventOrganizerInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _EventOrganizerInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EventOrganizerInfo, $Out>
    implements EventOrganizerInfoCopyWith<$R, EventOrganizerInfo, $Out> {
  _EventOrganizerInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EventOrganizerInfo> $mapper =
      EventOrganizerInfoMapper.ensureInitialized();
  @override
  EventOrganizerProfileCopyWith<
    $R,
    EventOrganizerProfile,
    EventOrganizerProfile
  >?
  get profile => $value.profile?.copyWith.$chain((v) => call(profile: v));
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
  EventOrganizerInfo $make(CopyWithData data) => EventOrganizerInfo(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    email: data.get(#email, or: $value.email),
    profile: data.get(#profile, or: $value.profile),
  );

  @override
  EventOrganizerInfoCopyWith<$R2, EventOrganizerInfo, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _EventOrganizerInfoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class EventOrganizerProfileMapper
    extends ClassMapperBase<EventOrganizerProfile> {
  EventOrganizerProfileMapper._();

  static EventOrganizerProfileMapper? _instance;
  static EventOrganizerProfileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventOrganizerProfileMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'EventOrganizerProfile';

  static String? _$profilePicture(EventOrganizerProfile v) => v.profilePicture;
  static const Field<EventOrganizerProfile, String> _f$profilePicture = Field(
    'profilePicture',
    _$profilePicture,
    opt: true,
  );

  @override
  final MappableFields<EventOrganizerProfile> fields = const {
    #profilePicture: _f$profilePicture,
  };

  static EventOrganizerProfile _instantiate(DecodingData data) {
    return EventOrganizerProfile(profilePicture: data.dec(_f$profilePicture));
  }

  @override
  final Function instantiate = _instantiate;

  static EventOrganizerProfile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EventOrganizerProfile>(map);
  }

  static EventOrganizerProfile fromJson(String json) {
    return ensureInitialized().decodeJson<EventOrganizerProfile>(json);
  }
}

mixin EventOrganizerProfileMappable {
  String toJson() {
    return EventOrganizerProfileMapper.ensureInitialized()
        .encodeJson<EventOrganizerProfile>(this as EventOrganizerProfile);
  }

  Map<String, dynamic> toMap() {
    return EventOrganizerProfileMapper.ensureInitialized()
        .encodeMap<EventOrganizerProfile>(this as EventOrganizerProfile);
  }

  EventOrganizerProfileCopyWith<
    EventOrganizerProfile,
    EventOrganizerProfile,
    EventOrganizerProfile
  >
  get copyWith =>
      _EventOrganizerProfileCopyWithImpl<
        EventOrganizerProfile,
        EventOrganizerProfile
      >(this as EventOrganizerProfile, $identity, $identity);
  @override
  String toString() {
    return EventOrganizerProfileMapper.ensureInitialized().stringifyValue(
      this as EventOrganizerProfile,
    );
  }

  @override
  bool operator ==(Object other) {
    return EventOrganizerProfileMapper.ensureInitialized().equalsValue(
      this as EventOrganizerProfile,
      other,
    );
  }

  @override
  int get hashCode {
    return EventOrganizerProfileMapper.ensureInitialized().hashValue(
      this as EventOrganizerProfile,
    );
  }
}

extension EventOrganizerProfileValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EventOrganizerProfile, $Out> {
  EventOrganizerProfileCopyWith<$R, EventOrganizerProfile, $Out>
  get $asEventOrganizerProfile => $base.as(
    (v, t, t2) => _EventOrganizerProfileCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class EventOrganizerProfileCopyWith<
  $R,
  $In extends EventOrganizerProfile,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? profilePicture});
  EventOrganizerProfileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _EventOrganizerProfileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EventOrganizerProfile, $Out>
    implements EventOrganizerProfileCopyWith<$R, EventOrganizerProfile, $Out> {
  _EventOrganizerProfileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EventOrganizerProfile> $mapper =
      EventOrganizerProfileMapper.ensureInitialized();
  @override
  $R call({Object? profilePicture = $none}) => $apply(
    FieldCopyWithData({
      if (profilePicture != $none) #profilePicture: profilePicture,
    }),
  );
  @override
  EventOrganizerProfile $make(CopyWithData data) => EventOrganizerProfile(
    profilePicture: data.get(#profilePicture, or: $value.profilePicture),
  );

  @override
  EventOrganizerProfileCopyWith<$R2, EventOrganizerProfile, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _EventOrganizerProfileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class EventImageInfoMapper extends ClassMapperBase<EventImageInfo> {
  EventImageInfoMapper._();

  static EventImageInfoMapper? _instance;
  static EventImageInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventImageInfoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'EventImageInfo';

  static String _$id(EventImageInfo v) => v.id;
  static const Field<EventImageInfo, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$imageUrl(EventImageInfo v) => v.imageUrl;
  static const Field<EventImageInfo, String> _f$imageUrl = Field(
    'imageUrl',
    _$imageUrl,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$url(EventImageInfo v) => v.url;
  static const Field<EventImageInfo, String> _f$url = Field(
    'url',
    _$url,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$name(EventImageInfo v) => v.name;
  static const Field<EventImageInfo, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static int _$size(EventImageInfo v) => v.size;
  static const Field<EventImageInfo, int> _f$size = Field(
    'size',
    _$size,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );

  @override
  final MappableFields<EventImageInfo> fields = const {
    #id: _f$id,
    #imageUrl: _f$imageUrl,
    #url: _f$url,
    #name: _f$name,
    #size: _f$size,
  };

  static EventImageInfo _instantiate(DecodingData data) {
    return EventImageInfo(
      id: data.dec(_f$id),
      imageUrl: data.dec(_f$imageUrl),
      url: data.dec(_f$url),
      name: data.dec(_f$name),
      size: data.dec(_f$size),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static EventImageInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EventImageInfo>(map);
  }

  static EventImageInfo fromJson(String json) {
    return ensureInitialized().decodeJson<EventImageInfo>(json);
  }
}

mixin EventImageInfoMappable {
  String toJson() {
    return EventImageInfoMapper.ensureInitialized().encodeJson<EventImageInfo>(
      this as EventImageInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return EventImageInfoMapper.ensureInitialized().encodeMap<EventImageInfo>(
      this as EventImageInfo,
    );
  }

  EventImageInfoCopyWith<EventImageInfo, EventImageInfo, EventImageInfo>
  get copyWith => _EventImageInfoCopyWithImpl<EventImageInfo, EventImageInfo>(
    this as EventImageInfo,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return EventImageInfoMapper.ensureInitialized().stringifyValue(
      this as EventImageInfo,
    );
  }

  @override
  bool operator ==(Object other) {
    return EventImageInfoMapper.ensureInitialized().equalsValue(
      this as EventImageInfo,
      other,
    );
  }

  @override
  int get hashCode {
    return EventImageInfoMapper.ensureInitialized().hashValue(
      this as EventImageInfo,
    );
  }
}

extension EventImageInfoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EventImageInfo, $Out> {
  EventImageInfoCopyWith<$R, EventImageInfo, $Out> get $asEventImageInfo =>
      $base.as((v, t, t2) => _EventImageInfoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EventImageInfoCopyWith<$R, $In extends EventImageInfo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? imageUrl, String? url, String? name, int? size});
  EventImageInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _EventImageInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EventImageInfo, $Out>
    implements EventImageInfoCopyWith<$R, EventImageInfo, $Out> {
  _EventImageInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EventImageInfo> $mapper =
      EventImageInfoMapper.ensureInitialized();
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
  EventImageInfo $make(CopyWithData data) => EventImageInfo(
    id: data.get(#id, or: $value.id),
    imageUrl: data.get(#imageUrl, or: $value.imageUrl),
    url: data.get(#url, or: $value.url),
    name: data.get(#name, or: $value.name),
    size: data.get(#size, or: $value.size),
  );

  @override
  EventImageInfoCopyWith<$R2, EventImageInfo, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _EventImageInfoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class EventCategoryInfoMapper extends ClassMapperBase<EventCategoryInfo> {
  EventCategoryInfoMapper._();

  static EventCategoryInfoMapper? _instance;
  static EventCategoryInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventCategoryInfoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'EventCategoryInfo';

  static String _$id(EventCategoryInfo v) => v.id;
  static const Field<EventCategoryInfo, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$name(EventCategoryInfo v) => v.name;
  static const Field<EventCategoryInfo, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<EventCategoryInfo> fields = const {
    #id: _f$id,
    #name: _f$name,
  };

  static EventCategoryInfo _instantiate(DecodingData data) {
    return EventCategoryInfo(id: data.dec(_f$id), name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static EventCategoryInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EventCategoryInfo>(map);
  }

  static EventCategoryInfo fromJson(String json) {
    return ensureInitialized().decodeJson<EventCategoryInfo>(json);
  }
}

mixin EventCategoryInfoMappable {
  String toJson() {
    return EventCategoryInfoMapper.ensureInitialized()
        .encodeJson<EventCategoryInfo>(this as EventCategoryInfo);
  }

  Map<String, dynamic> toMap() {
    return EventCategoryInfoMapper.ensureInitialized()
        .encodeMap<EventCategoryInfo>(this as EventCategoryInfo);
  }

  EventCategoryInfoCopyWith<
    EventCategoryInfo,
    EventCategoryInfo,
    EventCategoryInfo
  >
  get copyWith =>
      _EventCategoryInfoCopyWithImpl<EventCategoryInfo, EventCategoryInfo>(
        this as EventCategoryInfo,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return EventCategoryInfoMapper.ensureInitialized().stringifyValue(
      this as EventCategoryInfo,
    );
  }

  @override
  bool operator ==(Object other) {
    return EventCategoryInfoMapper.ensureInitialized().equalsValue(
      this as EventCategoryInfo,
      other,
    );
  }

  @override
  int get hashCode {
    return EventCategoryInfoMapper.ensureInitialized().hashValue(
      this as EventCategoryInfo,
    );
  }
}

extension EventCategoryInfoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EventCategoryInfo, $Out> {
  EventCategoryInfoCopyWith<$R, EventCategoryInfo, $Out>
  get $asEventCategoryInfo => $base.as(
    (v, t, t2) => _EventCategoryInfoCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class EventCategoryInfoCopyWith<
  $R,
  $In extends EventCategoryInfo,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name});
  EventCategoryInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _EventCategoryInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EventCategoryInfo, $Out>
    implements EventCategoryInfoCopyWith<$R, EventCategoryInfo, $Out> {
  _EventCategoryInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EventCategoryInfo> $mapper =
      EventCategoryInfoMapper.ensureInitialized();
  @override
  $R call({String? id, String? name}) => $apply(
    FieldCopyWithData({if (id != null) #id: id, if (name != null) #name: name}),
  );
  @override
  EventCategoryInfo $make(CopyWithData data) => EventCategoryInfo(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
  );

  @override
  EventCategoryInfoCopyWith<$R2, EventCategoryInfo, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _EventCategoryInfoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class EventReportInfoMapper extends ClassMapperBase<EventReportInfo> {
  EventReportInfoMapper._();

  static EventReportInfoMapper? _instance;
  static EventReportInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventReportInfoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'EventReportInfo';

  static String _$id(EventReportInfo v) => v.id;
  static const Field<EventReportInfo, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$reason(EventReportInfo v) => v.reason;
  static const Field<EventReportInfo, String> _f$reason = Field(
    'reason',
    _$reason,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$status(EventReportInfo v) => v.status;
  static const Field<EventReportInfo, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<EventReportInfo> fields = const {
    #id: _f$id,
    #reason: _f$reason,
    #status: _f$status,
  };

  static EventReportInfo _instantiate(DecodingData data) {
    return EventReportInfo(
      id: data.dec(_f$id),
      reason: data.dec(_f$reason),
      status: data.dec(_f$status),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static EventReportInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EventReportInfo>(map);
  }

  static EventReportInfo fromJson(String json) {
    return ensureInitialized().decodeJson<EventReportInfo>(json);
  }
}

mixin EventReportInfoMappable {
  String toJson() {
    return EventReportInfoMapper.ensureInitialized()
        .encodeJson<EventReportInfo>(this as EventReportInfo);
  }

  Map<String, dynamic> toMap() {
    return EventReportInfoMapper.ensureInitialized().encodeMap<EventReportInfo>(
      this as EventReportInfo,
    );
  }

  EventReportInfoCopyWith<EventReportInfo, EventReportInfo, EventReportInfo>
  get copyWith =>
      _EventReportInfoCopyWithImpl<EventReportInfo, EventReportInfo>(
        this as EventReportInfo,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return EventReportInfoMapper.ensureInitialized().stringifyValue(
      this as EventReportInfo,
    );
  }

  @override
  bool operator ==(Object other) {
    return EventReportInfoMapper.ensureInitialized().equalsValue(
      this as EventReportInfo,
      other,
    );
  }

  @override
  int get hashCode {
    return EventReportInfoMapper.ensureInitialized().hashValue(
      this as EventReportInfo,
    );
  }
}

extension EventReportInfoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EventReportInfo, $Out> {
  EventReportInfoCopyWith<$R, EventReportInfo, $Out> get $asEventReportInfo =>
      $base.as((v, t, t2) => _EventReportInfoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EventReportInfoCopyWith<$R, $In extends EventReportInfo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? reason, String? status});
  EventReportInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _EventReportInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EventReportInfo, $Out>
    implements EventReportInfoCopyWith<$R, EventReportInfo, $Out> {
  _EventReportInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EventReportInfo> $mapper =
      EventReportInfoMapper.ensureInitialized();
  @override
  $R call({String? id, String? reason, String? status}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (reason != null) #reason: reason,
      if (status != null) #status: status,
    }),
  );
  @override
  EventReportInfo $make(CopyWithData data) => EventReportInfo(
    id: data.get(#id, or: $value.id),
    reason: data.get(#reason, or: $value.reason),
    status: data.get(#status, or: $value.status),
  );

  @override
  EventReportInfoCopyWith<$R2, EventReportInfo, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _EventReportInfoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

