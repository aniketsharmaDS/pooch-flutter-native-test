// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'tip_event_item_model.dart';

class TipEventItemModelMapper extends ClassMapperBase<TipEventItemModel> {
  TipEventItemModelMapper._();

  static TipEventItemModelMapper? _instance;
  static TipEventItemModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TipEventItemModelMapper._());
      TipsCategoryInfoMapper.ensureInitialized();
      EventOrganizerInfoMapper.ensureInitialized();
      EventImageInfoMapper.ensureInitialized();
      EventReportInfoMapper.ensureInitialized();
      TipsUserInfoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TipEventItemModel';

  static String _$id(TipEventItemModel v) => v.id;
  static const Field<TipEventItemModel, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$type(TipEventItemModel v) => v.type;
  static const Field<TipEventItemModel, String> _f$type = Field(
    'type',
    _$type,
    opt: true,
    def: '',
  );
  static String _$title(TipEventItemModel v) => v.title;
  static const Field<TipEventItemModel, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
    def: '',
  );
  static String _$description(TipEventItemModel v) => v.description;
  static const Field<TipEventItemModel, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
  );
  static String _$status(TipEventItemModel v) => v.status;
  static const Field<TipEventItemModel, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
    def: '',
  );
  static String? _$rejectionReason(TipEventItemModel v) => v.rejectionReason;
  static const Field<TipEventItemModel, String> _f$rejectionReason = Field(
    'rejectionReason',
    _$rejectionReason,
    opt: true,
  );
  static bool _$isActive(TipEventItemModel v) => v.isActive;
  static const Field<TipEventItemModel, bool> _f$isActive = Field(
    'isActive',
    _$isActive,
    opt: true,
    def: true,
  );
  static bool _$isDeleted(TipEventItemModel v) => v.isDeleted;
  static const Field<TipEventItemModel, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static bool _$isReported(TipEventItemModel v) => v.isReported;
  static const Field<TipEventItemModel, bool> _f$isReported = Field(
    'isReported',
    _$isReported,
    opt: true,
    def: false,
  );
  static int _$reportedCount(TipEventItemModel v) => v.reportedCount;
  static const Field<TipEventItemModel, int> _f$reportedCount = Field(
    'reportedCount',
    _$reportedCount,
    opt: true,
    def: 0,
  );
  static int _$likesCount(TipEventItemModel v) => v.likesCount;
  static const Field<TipEventItemModel, int> _f$likesCount = Field(
    'likesCount',
    _$likesCount,
    opt: true,
    def: 0,
  );
  static bool _$isLiked(TipEventItemModel v) => v.isLiked;
  static const Field<TipEventItemModel, bool> _f$isLiked = Field(
    'isLiked',
    _$isLiked,
    opt: true,
    def: false,
  );
  static bool _$isAuthor(TipEventItemModel v) => v.isAuthor;
  static const Field<TipEventItemModel, bool> _f$isAuthor = Field(
    'isAuthor',
    _$isAuthor,
    opt: true,
    def: false,
  );
  static String _$createdAt(TipEventItemModel v) => v.createdAt;
  static const Field<TipEventItemModel, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
    def: '',
  );
  static String _$updatedAt(TipEventItemModel v) => v.updatedAt;
  static const Field<TipEventItemModel, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
    def: '',
  );
  static TipsCategoryInfo? _$category(TipEventItemModel v) => v.category;
  static const Field<TipEventItemModel, TipsCategoryInfo> _f$category = Field(
    'category',
    _$category,
    opt: true,
  );
  static String _$eventCategoryId(TipEventItemModel v) => v.eventCategoryId;
  static const Field<TipEventItemModel, String> _f$eventCategoryId = Field(
    'eventCategoryId',
    _$eventCategoryId,
    opt: true,
    def: '',
  );
  static String _$tipCategoryId(TipEventItemModel v) => v.tipCategoryId;
  static const Field<TipEventItemModel, String> _f$tipCategoryId = Field(
    'tipCategoryId',
    _$tipCategoryId,
    opt: true,
    def: '',
  );
  static String _$organizerId(TipEventItemModel v) => v.organizerId;
  static const Field<TipEventItemModel, String> _f$organizerId = Field(
    'organizerId',
    _$organizerId,
    opt: true,
    def: '',
  );
  static EventOrganizerInfo? _$eventOrganizer(TipEventItemModel v) =>
      v.eventOrganizer;
  static const Field<TipEventItemModel, EventOrganizerInfo> _f$eventOrganizer =
      Field('eventOrganizer', _$eventOrganizer, opt: true);
  static String _$eventStartDate(TipEventItemModel v) => v.eventStartDate;
  static const Field<TipEventItemModel, String> _f$eventStartDate = Field(
    'eventStartDate',
    _$eventStartDate,
    opt: true,
    def: '',
  );
  static String? _$eventEndDate(TipEventItemModel v) => v.eventEndDate;
  static const Field<TipEventItemModel, String> _f$eventEndDate = Field(
    'eventEndDate',
    _$eventEndDate,
    opt: true,
  );
  static String _$eventTime(TipEventItemModel v) => v.eventTime;
  static const Field<TipEventItemModel, String> _f$eventTime = Field(
    'eventTime',
    _$eventTime,
    opt: true,
    def: '',
  );
  static String _$location(TipEventItemModel v) => v.location;
  static const Field<TipEventItemModel, String> _f$location = Field(
    'location',
    _$location,
    opt: true,
    def: '',
  );
  static String _$addressDetails(TipEventItemModel v) => v.addressDetails;
  static const Field<TipEventItemModel, String> _f$addressDetails = Field(
    'addressDetails',
    _$addressDetails,
    opt: true,
    def: '',
  );
  static String _$latitude(TipEventItemModel v) => v.latitude;
  static const Field<TipEventItemModel, String> _f$latitude = Field(
    'latitude',
    _$latitude,
    opt: true,
    def: '',
  );
  static String _$longitude(TipEventItemModel v) => v.longitude;
  static const Field<TipEventItemModel, String> _f$longitude = Field(
    'longitude',
    _$longitude,
    opt: true,
    def: '',
  );
  static bool _$isPaid(TipEventItemModel v) => v.isPaid;
  static const Field<TipEventItemModel, bool> _f$isPaid = Field(
    'isPaid',
    _$isPaid,
    opt: true,
    def: false,
  );
  static int _$attendanceCount(TipEventItemModel v) => v.attendanceCount;
  static const Field<TipEventItemModel, int> _f$attendanceCount = Field(
    'attendanceCount',
    _$attendanceCount,
    opt: true,
    def: 0,
  );
  static String? _$userRsvpStatus(TipEventItemModel v) => v.userRsvpStatus;
  static const Field<TipEventItemModel, String> _f$userRsvpStatus = Field(
    'userRsvpStatus',
    _$userRsvpStatus,
    opt: true,
  );
  static List<EventImageInfo> _$images(TipEventItemModel v) => v.images;
  static const Field<TipEventItemModel, List<EventImageInfo>> _f$images = Field(
    'images',
    _$images,
    opt: true,
    def: const [],
  );
  static List<EventReportInfo> _$eventReports(TipEventItemModel v) =>
      v.eventReports;
  static const Field<TipEventItemModel, List<EventReportInfo>> _f$eventReports =
      Field('eventReports', _$eventReports, opt: true, def: const []);
  static int _$eventReportsCount(TipEventItemModel v) => v.eventReportsCount;
  static const Field<TipEventItemModel, int> _f$eventReportsCount = Field(
    'eventReportsCount',
    _$eventReportsCount,
    opt: true,
    def: 0,
  );
  static bool _$isUserReported(TipEventItemModel v) => v.isUserReported;
  static const Field<TipEventItemModel, bool> _f$isUserReported = Field(
    'isUserReported',
    _$isUserReported,
    opt: true,
    def: false,
  );
  static bool _$showEventsBadge(TipEventItemModel v) => v.showEventsBadge;
  static const Field<TipEventItemModel, bool> _f$showEventsBadge = Field(
    'showEventsBadge',
    _$showEventsBadge,
    opt: true,
    def: true,
  );
  static String _$userId(TipEventItemModel v) => v.userId;
  static const Field<TipEventItemModel, String> _f$userId = Field(
    'userId',
    _$userId,
    opt: true,
    def: '',
  );
  static TipsUserInfo? _$tipsUser(TipEventItemModel v) => v.tipsUser;
  static const Field<TipEventItemModel, TipsUserInfo> _f$tipsUser = Field(
    'tipsUser',
    _$tipsUser,
    opt: true,
  );
  static int _$commentsCount(TipEventItemModel v) => v.commentsCount;
  static const Field<TipEventItemModel, int> _f$commentsCount = Field(
    'commentsCount',
    _$commentsCount,
    opt: true,
    def: 0,
  );
  static bool _$isDraft(TipEventItemModel v) => v.isDraft;
  static const Field<TipEventItemModel, bool> _f$isDraft = Field(
    'isDraft',
    _$isDraft,
    opt: true,
    def: false,
  );
  static List<String> _$attachmentUrls(TipEventItemModel v) => v.attachmentUrls;
  static const Field<TipEventItemModel, List<String>> _f$attachmentUrls = Field(
    'attachmentUrls',
    _$attachmentUrls,
    opt: true,
    def: const [],
  );
  static List<String> _$hashtags(TipEventItemModel v) => v.hashtags;
  static const Field<TipEventItemModel, List<String>> _f$hashtags = Field(
    'hashtags',
    _$hashtags,
    opt: true,
    def: const [],
  );
  static List<String> _$tipsList(TipEventItemModel v) => v.tipsList;
  static const Field<TipEventItemModel, List<String>> _f$tipsList = Field(
    'tipsList',
    _$tipsList,
    opt: true,
    def: const [],
  );
  static bool _$showTipsBadge(TipEventItemModel v) => v.showTipsBadge;
  static const Field<TipEventItemModel, bool> _f$showTipsBadge = Field(
    'showTipsBadge',
    _$showTipsBadge,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<TipEventItemModel> fields = const {
    #id: _f$id,
    #type: _f$type,
    #title: _f$title,
    #description: _f$description,
    #status: _f$status,
    #rejectionReason: _f$rejectionReason,
    #isActive: _f$isActive,
    #isDeleted: _f$isDeleted,
    #isReported: _f$isReported,
    #reportedCount: _f$reportedCount,
    #likesCount: _f$likesCount,
    #isLiked: _f$isLiked,
    #isAuthor: _f$isAuthor,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #category: _f$category,
    #eventCategoryId: _f$eventCategoryId,
    #tipCategoryId: _f$tipCategoryId,
    #organizerId: _f$organizerId,
    #eventOrganizer: _f$eventOrganizer,
    #eventStartDate: _f$eventStartDate,
    #eventEndDate: _f$eventEndDate,
    #eventTime: _f$eventTime,
    #location: _f$location,
    #addressDetails: _f$addressDetails,
    #latitude: _f$latitude,
    #longitude: _f$longitude,
    #isPaid: _f$isPaid,
    #attendanceCount: _f$attendanceCount,
    #userRsvpStatus: _f$userRsvpStatus,
    #images: _f$images,
    #eventReports: _f$eventReports,
    #eventReportsCount: _f$eventReportsCount,
    #isUserReported: _f$isUserReported,
    #showEventsBadge: _f$showEventsBadge,
    #userId: _f$userId,
    #tipsUser: _f$tipsUser,
    #commentsCount: _f$commentsCount,
    #isDraft: _f$isDraft,
    #attachmentUrls: _f$attachmentUrls,
    #hashtags: _f$hashtags,
    #tipsList: _f$tipsList,
    #showTipsBadge: _f$showTipsBadge,
  };

  static TipEventItemModel _instantiate(DecodingData data) {
    return TipEventItemModel(
      id: data.dec(_f$id),
      type: data.dec(_f$type),
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      status: data.dec(_f$status),
      rejectionReason: data.dec(_f$rejectionReason),
      isActive: data.dec(_f$isActive),
      isDeleted: data.dec(_f$isDeleted),
      isReported: data.dec(_f$isReported),
      reportedCount: data.dec(_f$reportedCount),
      likesCount: data.dec(_f$likesCount),
      isLiked: data.dec(_f$isLiked),
      isAuthor: data.dec(_f$isAuthor),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      category: data.dec(_f$category),
      eventCategoryId: data.dec(_f$eventCategoryId),
      tipCategoryId: data.dec(_f$tipCategoryId),
      organizerId: data.dec(_f$organizerId),
      eventOrganizer: data.dec(_f$eventOrganizer),
      eventStartDate: data.dec(_f$eventStartDate),
      eventEndDate: data.dec(_f$eventEndDate),
      eventTime: data.dec(_f$eventTime),
      location: data.dec(_f$location),
      addressDetails: data.dec(_f$addressDetails),
      latitude: data.dec(_f$latitude),
      longitude: data.dec(_f$longitude),
      isPaid: data.dec(_f$isPaid),
      attendanceCount: data.dec(_f$attendanceCount),
      userRsvpStatus: data.dec(_f$userRsvpStatus),
      images: data.dec(_f$images),
      eventReports: data.dec(_f$eventReports),
      eventReportsCount: data.dec(_f$eventReportsCount),
      isUserReported: data.dec(_f$isUserReported),
      showEventsBadge: data.dec(_f$showEventsBadge),
      userId: data.dec(_f$userId),
      tipsUser: data.dec(_f$tipsUser),
      commentsCount: data.dec(_f$commentsCount),
      isDraft: data.dec(_f$isDraft),
      attachmentUrls: data.dec(_f$attachmentUrls),
      hashtags: data.dec(_f$hashtags),
      tipsList: data.dec(_f$tipsList),
      showTipsBadge: data.dec(_f$showTipsBadge),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static TipEventItemModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TipEventItemModel>(map);
  }

  static TipEventItemModel fromJson(String json) {
    return ensureInitialized().decodeJson<TipEventItemModel>(json);
  }
}

mixin TipEventItemModelMappable {
  String toJson() {
    return TipEventItemModelMapper.ensureInitialized()
        .encodeJson<TipEventItemModel>(this as TipEventItemModel);
  }

  Map<String, dynamic> toMap() {
    return TipEventItemModelMapper.ensureInitialized()
        .encodeMap<TipEventItemModel>(this as TipEventItemModel);
  }

  TipEventItemModelCopyWith<
    TipEventItemModel,
    TipEventItemModel,
    TipEventItemModel
  >
  get copyWith =>
      _TipEventItemModelCopyWithImpl<TipEventItemModel, TipEventItemModel>(
        this as TipEventItemModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TipEventItemModelMapper.ensureInitialized().stringifyValue(
      this as TipEventItemModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return TipEventItemModelMapper.ensureInitialized().equalsValue(
      this as TipEventItemModel,
      other,
    );
  }

  @override
  int get hashCode {
    return TipEventItemModelMapper.ensureInitialized().hashValue(
      this as TipEventItemModel,
    );
  }
}

extension TipEventItemModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TipEventItemModel, $Out> {
  TipEventItemModelCopyWith<$R, TipEventItemModel, $Out>
  get $asTipEventItemModel => $base.as(
    (v, t, t2) => _TipEventItemModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class TipEventItemModelCopyWith<
  $R,
  $In extends TipEventItemModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  TipsCategoryInfoCopyWith<$R, TipsCategoryInfo, TipsCategoryInfo>?
  get category;
  EventOrganizerInfoCopyWith<$R, EventOrganizerInfo, EventOrganizerInfo>?
  get eventOrganizer;
  ListCopyWith<
    $R,
    EventImageInfo,
    EventImageInfoCopyWith<$R, EventImageInfo, EventImageInfo>
  >
  get images;
  ListCopyWith<
    $R,
    EventReportInfo,
    EventReportInfoCopyWith<$R, EventReportInfo, EventReportInfo>
  >
  get eventReports;
  TipsUserInfoCopyWith<$R, TipsUserInfo, TipsUserInfo>? get tipsUser;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get attachmentUrls;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get hashtags;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get tipsList;
  $R call({
    String? id,
    String? type,
    String? title,
    String? description,
    String? status,
    String? rejectionReason,
    bool? isActive,
    bool? isDeleted,
    bool? isReported,
    int? reportedCount,
    int? likesCount,
    bool? isLiked,
    bool? isAuthor,
    String? createdAt,
    String? updatedAt,
    TipsCategoryInfo? category,
    String? eventCategoryId,
    String? tipCategoryId,
    String? organizerId,
    EventOrganizerInfo? eventOrganizer,
    String? eventStartDate,
    String? eventEndDate,
    String? eventTime,
    String? location,
    String? addressDetails,
    String? latitude,
    String? longitude,
    bool? isPaid,
    int? attendanceCount,
    String? userRsvpStatus,
    List<EventImageInfo>? images,
    List<EventReportInfo>? eventReports,
    int? eventReportsCount,
    bool? isUserReported,
    bool? showEventsBadge,
    String? userId,
    TipsUserInfo? tipsUser,
    int? commentsCount,
    bool? isDraft,
    List<String>? attachmentUrls,
    List<String>? hashtags,
    List<String>? tipsList,
    bool? showTipsBadge,
  });
  TipEventItemModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _TipEventItemModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TipEventItemModel, $Out>
    implements TipEventItemModelCopyWith<$R, TipEventItemModel, $Out> {
  _TipEventItemModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TipEventItemModel> $mapper =
      TipEventItemModelMapper.ensureInitialized();
  @override
  TipsCategoryInfoCopyWith<$R, TipsCategoryInfo, TipsCategoryInfo>?
  get category => $value.category?.copyWith.$chain((v) => call(category: v));
  @override
  EventOrganizerInfoCopyWith<$R, EventOrganizerInfo, EventOrganizerInfo>?
  get eventOrganizer =>
      $value.eventOrganizer?.copyWith.$chain((v) => call(eventOrganizer: v));
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
  ListCopyWith<
    $R,
    EventReportInfo,
    EventReportInfoCopyWith<$R, EventReportInfo, EventReportInfo>
  >
  get eventReports => ListCopyWith(
    $value.eventReports,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(eventReports: v),
  );
  @override
  TipsUserInfoCopyWith<$R, TipsUserInfo, TipsUserInfo>? get tipsUser =>
      $value.tipsUser?.copyWith.$chain((v) => call(tipsUser: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get attachmentUrls => ListCopyWith(
    $value.attachmentUrls,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(attachmentUrls: v),
  );
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
    String? type,
    String? title,
    String? description,
    String? status,
    Object? rejectionReason = $none,
    bool? isActive,
    bool? isDeleted,
    bool? isReported,
    int? reportedCount,
    int? likesCount,
    bool? isLiked,
    bool? isAuthor,
    String? createdAt,
    String? updatedAt,
    Object? category = $none,
    String? eventCategoryId,
    String? tipCategoryId,
    String? organizerId,
    Object? eventOrganizer = $none,
    String? eventStartDate,
    Object? eventEndDate = $none,
    String? eventTime,
    String? location,
    String? addressDetails,
    String? latitude,
    String? longitude,
    bool? isPaid,
    int? attendanceCount,
    Object? userRsvpStatus = $none,
    List<EventImageInfo>? images,
    List<EventReportInfo>? eventReports,
    int? eventReportsCount,
    bool? isUserReported,
    bool? showEventsBadge,
    String? userId,
    Object? tipsUser = $none,
    int? commentsCount,
    bool? isDraft,
    List<String>? attachmentUrls,
    List<String>? hashtags,
    List<String>? tipsList,
    bool? showTipsBadge,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (type != null) #type: type,
      if (title != null) #title: title,
      if (description != null) #description: description,
      if (status != null) #status: status,
      if (rejectionReason != $none) #rejectionReason: rejectionReason,
      if (isActive != null) #isActive: isActive,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (isReported != null) #isReported: isReported,
      if (reportedCount != null) #reportedCount: reportedCount,
      if (likesCount != null) #likesCount: likesCount,
      if (isLiked != null) #isLiked: isLiked,
      if (isAuthor != null) #isAuthor: isAuthor,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
      if (category != $none) #category: category,
      if (eventCategoryId != null) #eventCategoryId: eventCategoryId,
      if (tipCategoryId != null) #tipCategoryId: tipCategoryId,
      if (organizerId != null) #organizerId: organizerId,
      if (eventOrganizer != $none) #eventOrganizer: eventOrganizer,
      if (eventStartDate != null) #eventStartDate: eventStartDate,
      if (eventEndDate != $none) #eventEndDate: eventEndDate,
      if (eventTime != null) #eventTime: eventTime,
      if (location != null) #location: location,
      if (addressDetails != null) #addressDetails: addressDetails,
      if (latitude != null) #latitude: latitude,
      if (longitude != null) #longitude: longitude,
      if (isPaid != null) #isPaid: isPaid,
      if (attendanceCount != null) #attendanceCount: attendanceCount,
      if (userRsvpStatus != $none) #userRsvpStatus: userRsvpStatus,
      if (images != null) #images: images,
      if (eventReports != null) #eventReports: eventReports,
      if (eventReportsCount != null) #eventReportsCount: eventReportsCount,
      if (isUserReported != null) #isUserReported: isUserReported,
      if (showEventsBadge != null) #showEventsBadge: showEventsBadge,
      if (userId != null) #userId: userId,
      if (tipsUser != $none) #tipsUser: tipsUser,
      if (commentsCount != null) #commentsCount: commentsCount,
      if (isDraft != null) #isDraft: isDraft,
      if (attachmentUrls != null) #attachmentUrls: attachmentUrls,
      if (hashtags != null) #hashtags: hashtags,
      if (tipsList != null) #tipsList: tipsList,
      if (showTipsBadge != null) #showTipsBadge: showTipsBadge,
    }),
  );
  @override
  TipEventItemModel $make(CopyWithData data) => TipEventItemModel(
    id: data.get(#id, or: $value.id),
    type: data.get(#type, or: $value.type),
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    status: data.get(#status, or: $value.status),
    rejectionReason: data.get(#rejectionReason, or: $value.rejectionReason),
    isActive: data.get(#isActive, or: $value.isActive),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    isReported: data.get(#isReported, or: $value.isReported),
    reportedCount: data.get(#reportedCount, or: $value.reportedCount),
    likesCount: data.get(#likesCount, or: $value.likesCount),
    isLiked: data.get(#isLiked, or: $value.isLiked),
    isAuthor: data.get(#isAuthor, or: $value.isAuthor),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    category: data.get(#category, or: $value.category),
    eventCategoryId: data.get(#eventCategoryId, or: $value.eventCategoryId),
    tipCategoryId: data.get(#tipCategoryId, or: $value.tipCategoryId),
    organizerId: data.get(#organizerId, or: $value.organizerId),
    eventOrganizer: data.get(#eventOrganizer, or: $value.eventOrganizer),
    eventStartDate: data.get(#eventStartDate, or: $value.eventStartDate),
    eventEndDate: data.get(#eventEndDate, or: $value.eventEndDate),
    eventTime: data.get(#eventTime, or: $value.eventTime),
    location: data.get(#location, or: $value.location),
    addressDetails: data.get(#addressDetails, or: $value.addressDetails),
    latitude: data.get(#latitude, or: $value.latitude),
    longitude: data.get(#longitude, or: $value.longitude),
    isPaid: data.get(#isPaid, or: $value.isPaid),
    attendanceCount: data.get(#attendanceCount, or: $value.attendanceCount),
    userRsvpStatus: data.get(#userRsvpStatus, or: $value.userRsvpStatus),
    images: data.get(#images, or: $value.images),
    eventReports: data.get(#eventReports, or: $value.eventReports),
    eventReportsCount: data.get(
      #eventReportsCount,
      or: $value.eventReportsCount,
    ),
    isUserReported: data.get(#isUserReported, or: $value.isUserReported),
    showEventsBadge: data.get(#showEventsBadge, or: $value.showEventsBadge),
    userId: data.get(#userId, or: $value.userId),
    tipsUser: data.get(#tipsUser, or: $value.tipsUser),
    commentsCount: data.get(#commentsCount, or: $value.commentsCount),
    isDraft: data.get(#isDraft, or: $value.isDraft),
    attachmentUrls: data.get(#attachmentUrls, or: $value.attachmentUrls),
    hashtags: data.get(#hashtags, or: $value.hashtags),
    tipsList: data.get(#tipsList, or: $value.tipsList),
    showTipsBadge: data.get(#showTipsBadge, or: $value.showTipsBadge),
  );

  @override
  TipEventItemModelCopyWith<$R2, TipEventItemModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TipEventItemModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

