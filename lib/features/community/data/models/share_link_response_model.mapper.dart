// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'share_link_response_model.dart';

class ShareLinkResponseModelMapper
    extends ClassMapperBase<ShareLinkResponseModel> {
  ShareLinkResponseModelMapper._();

  static ShareLinkResponseModelMapper? _instance;
  static ShareLinkResponseModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ShareLinkResponseModelMapper._());
      ShareLinkResponseDataMapper.ensureInitialized();
      ShareMetaMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ShareLinkResponseModel';

  static bool _$success(ShareLinkResponseModel v) => v.success;
  static const Field<ShareLinkResponseModel, bool> _f$success = Field(
    'success',
    _$success,
    opt: true,
    def: false,
  );
  static String _$message(ShareLinkResponseModel v) => v.message;
  static const Field<ShareLinkResponseModel, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
    def: '',
  );
  static int _$status(ShareLinkResponseModel v) => v.status;
  static const Field<ShareLinkResponseModel, int> _f$status = Field(
    'status',
    _$status,
    opt: true,
    def: 0,
  );
  static ShareLinkResponseData _$data(ShareLinkResponseModel v) => v.data;
  static const Field<ShareLinkResponseModel, ShareLinkResponseData> _f$data =
      Field('data', _$data, opt: true, def: const ShareLinkResponseData());
  static ShareMeta _$meta(ShareLinkResponseModel v) => v.meta;
  static const Field<ShareLinkResponseModel, ShareMeta> _f$meta = Field(
    'meta',
    _$meta,
    opt: true,
    def: const ShareMeta(),
  );

  @override
  final MappableFields<ShareLinkResponseModel> fields = const {
    #success: _f$success,
    #message: _f$message,
    #status: _f$status,
    #data: _f$data,
    #meta: _f$meta,
  };

  static ShareLinkResponseModel _instantiate(DecodingData data) {
    return ShareLinkResponseModel(
      success: data.dec(_f$success),
      message: data.dec(_f$message),
      status: data.dec(_f$status),
      data: data.dec(_f$data),
      meta: data.dec(_f$meta),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ShareLinkResponseModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ShareLinkResponseModel>(map);
  }

  static ShareLinkResponseModel fromJson(String json) {
    return ensureInitialized().decodeJson<ShareLinkResponseModel>(json);
  }
}

mixin ShareLinkResponseModelMappable {
  String toJson() {
    return ShareLinkResponseModelMapper.ensureInitialized()
        .encodeJson<ShareLinkResponseModel>(this as ShareLinkResponseModel);
  }

  Map<String, dynamic> toMap() {
    return ShareLinkResponseModelMapper.ensureInitialized()
        .encodeMap<ShareLinkResponseModel>(this as ShareLinkResponseModel);
  }

  ShareLinkResponseModelCopyWith<
    ShareLinkResponseModel,
    ShareLinkResponseModel,
    ShareLinkResponseModel
  >
  get copyWith =>
      _ShareLinkResponseModelCopyWithImpl<
        ShareLinkResponseModel,
        ShareLinkResponseModel
      >(this as ShareLinkResponseModel, $identity, $identity);
  @override
  String toString() {
    return ShareLinkResponseModelMapper.ensureInitialized().stringifyValue(
      this as ShareLinkResponseModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ShareLinkResponseModelMapper.ensureInitialized().equalsValue(
      this as ShareLinkResponseModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ShareLinkResponseModelMapper.ensureInitialized().hashValue(
      this as ShareLinkResponseModel,
    );
  }
}

extension ShareLinkResponseModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ShareLinkResponseModel, $Out> {
  ShareLinkResponseModelCopyWith<$R, ShareLinkResponseModel, $Out>
  get $asShareLinkResponseModel => $base.as(
    (v, t, t2) => _ShareLinkResponseModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ShareLinkResponseModelCopyWith<
  $R,
  $In extends ShareLinkResponseModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ShareLinkResponseDataCopyWith<
    $R,
    ShareLinkResponseData,
    ShareLinkResponseData
  >
  get data;
  ShareMetaCopyWith<$R, ShareMeta, ShareMeta> get meta;
  $R call({
    bool? success,
    String? message,
    int? status,
    ShareLinkResponseData? data,
    ShareMeta? meta,
  });
  ShareLinkResponseModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ShareLinkResponseModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ShareLinkResponseModel, $Out>
    implements
        ShareLinkResponseModelCopyWith<$R, ShareLinkResponseModel, $Out> {
  _ShareLinkResponseModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ShareLinkResponseModel> $mapper =
      ShareLinkResponseModelMapper.ensureInitialized();
  @override
  ShareLinkResponseDataCopyWith<
    $R,
    ShareLinkResponseData,
    ShareLinkResponseData
  >
  get data => $value.data.copyWith.$chain((v) => call(data: v));
  @override
  ShareMetaCopyWith<$R, ShareMeta, ShareMeta> get meta =>
      $value.meta.copyWith.$chain((v) => call(meta: v));
  @override
  $R call({
    bool? success,
    String? message,
    int? status,
    ShareLinkResponseData? data,
    ShareMeta? meta,
  }) => $apply(
    FieldCopyWithData({
      if (success != null) #success: success,
      if (message != null) #message: message,
      if (status != null) #status: status,
      if (data != null) #data: data,
      if (meta != null) #meta: meta,
    }),
  );
  @override
  ShareLinkResponseModel $make(CopyWithData data) => ShareLinkResponseModel(
    success: data.get(#success, or: $value.success),
    message: data.get(#message, or: $value.message),
    status: data.get(#status, or: $value.status),
    data: data.get(#data, or: $value.data),
    meta: data.get(#meta, or: $value.meta),
  );

  @override
  ShareLinkResponseModelCopyWith<$R2, ShareLinkResponseModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ShareLinkResponseModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ShareLinkResponseDataMapper
    extends ClassMapperBase<ShareLinkResponseData> {
  ShareLinkResponseDataMapper._();

  static ShareLinkResponseDataMapper? _instance;
  static ShareLinkResponseDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ShareLinkResponseDataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ShareLinkResponseData';

  static String _$id(ShareLinkResponseData v) => v.id;
  static const Field<ShareLinkResponseData, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$contentType(ShareLinkResponseData v) => v.contentType;
  static const Field<ShareLinkResponseData, String> _f$contentType = Field(
    'contentType',
    _$contentType,
    opt: true,
    def: '',
  );
  static String _$title(ShareLinkResponseData v) => v.title;
  static const Field<ShareLinkResponseData, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
    def: '',
  );
  static String _$description(ShareLinkResponseData v) => v.description;
  static const Field<ShareLinkResponseData, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
  );
  static List<String> _$attachmentUrls(ShareLinkResponseData v) =>
      v.attachmentUrls;
  static const Field<ShareLinkResponseData, List<String>> _f$attachmentUrls =
      Field(
        'attachmentUrls',
        _$attachmentUrls,
        opt: true,
        def: const [],
        hook: SafeListHook(),
      );
  static int _$likesCount(ShareLinkResponseData v) => v.likesCount;
  static const Field<ShareLinkResponseData, int> _f$likesCount = Field(
    'likesCount',
    _$likesCount,
    opt: true,
    def: 0,
  );
  static int _$commentsCount(ShareLinkResponseData v) => v.commentsCount;
  static const Field<ShareLinkResponseData, int> _f$commentsCount = Field(
    'commentsCount',
    _$commentsCount,
    opt: true,
    def: 0,
  );
  static String _$createdAt(ShareLinkResponseData v) => v.createdAt;
  static const Field<ShareLinkResponseData, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
    def: '',
  );
  static String _$updatedAt(ShareLinkResponseData v) => v.updatedAt;
  static const Field<ShareLinkResponseData, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
    def: '',
  );
  static String? _$startDate(ShareLinkResponseData v) => v.startDate;
  static const Field<ShareLinkResponseData, String> _f$startDate = Field(
    'startDate',
    _$startDate,
    opt: true,
  );
  static String? _$endDate(ShareLinkResponseData v) => v.endDate;
  static const Field<ShareLinkResponseData, String> _f$endDate = Field(
    'endDate',
    _$endDate,
    opt: true,
  );
  static String? _$eventTime(ShareLinkResponseData v) => v.eventTime;
  static const Field<ShareLinkResponseData, String> _f$eventTime = Field(
    'eventTime',
    _$eventTime,
    opt: true,
  );
  static String? _$location(ShareLinkResponseData v) => v.location;
  static const Field<ShareLinkResponseData, String> _f$location = Field(
    'location',
    _$location,
    opt: true,
  );
  static String? _$addressDetails(ShareLinkResponseData v) => v.addressDetails;
  static const Field<ShareLinkResponseData, String> _f$addressDetails = Field(
    'addressDetails',
    _$addressDetails,
    opt: true,
  );
  static String? _$latitude(ShareLinkResponseData v) => v.latitude;
  static const Field<ShareLinkResponseData, String> _f$latitude = Field(
    'latitude',
    _$latitude,
    opt: true,
  );
  static String? _$longitude(ShareLinkResponseData v) => v.longitude;
  static const Field<ShareLinkResponseData, String> _f$longitude = Field(
    'longitude',
    _$longitude,
    opt: true,
  );
  static bool? _$isPaid(ShareLinkResponseData v) => v.isPaid;
  static const Field<ShareLinkResponseData, bool> _f$isPaid = Field(
    'isPaid',
    _$isPaid,
    opt: true,
  );
  static int? _$attendanceCount(ShareLinkResponseData v) => v.attendanceCount;
  static const Field<ShareLinkResponseData, int> _f$attendanceCount = Field(
    'attendanceCount',
    _$attendanceCount,
    opt: true,
  );

  @override
  final MappableFields<ShareLinkResponseData> fields = const {
    #id: _f$id,
    #contentType: _f$contentType,
    #title: _f$title,
    #description: _f$description,
    #attachmentUrls: _f$attachmentUrls,
    #likesCount: _f$likesCount,
    #commentsCount: _f$commentsCount,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
    #eventTime: _f$eventTime,
    #location: _f$location,
    #addressDetails: _f$addressDetails,
    #latitude: _f$latitude,
    #longitude: _f$longitude,
    #isPaid: _f$isPaid,
    #attendanceCount: _f$attendanceCount,
  };

  static ShareLinkResponseData _instantiate(DecodingData data) {
    return ShareLinkResponseData(
      id: data.dec(_f$id),
      contentType: data.dec(_f$contentType),
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      attachmentUrls: data.dec(_f$attachmentUrls),
      likesCount: data.dec(_f$likesCount),
      commentsCount: data.dec(_f$commentsCount),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      startDate: data.dec(_f$startDate),
      endDate: data.dec(_f$endDate),
      eventTime: data.dec(_f$eventTime),
      location: data.dec(_f$location),
      addressDetails: data.dec(_f$addressDetails),
      latitude: data.dec(_f$latitude),
      longitude: data.dec(_f$longitude),
      isPaid: data.dec(_f$isPaid),
      attendanceCount: data.dec(_f$attendanceCount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ShareLinkResponseData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ShareLinkResponseData>(map);
  }

  static ShareLinkResponseData fromJson(String json) {
    return ensureInitialized().decodeJson<ShareLinkResponseData>(json);
  }
}

mixin ShareLinkResponseDataMappable {
  String toJson() {
    return ShareLinkResponseDataMapper.ensureInitialized()
        .encodeJson<ShareLinkResponseData>(this as ShareLinkResponseData);
  }

  Map<String, dynamic> toMap() {
    return ShareLinkResponseDataMapper.ensureInitialized()
        .encodeMap<ShareLinkResponseData>(this as ShareLinkResponseData);
  }

  ShareLinkResponseDataCopyWith<
    ShareLinkResponseData,
    ShareLinkResponseData,
    ShareLinkResponseData
  >
  get copyWith =>
      _ShareLinkResponseDataCopyWithImpl<
        ShareLinkResponseData,
        ShareLinkResponseData
      >(this as ShareLinkResponseData, $identity, $identity);
  @override
  String toString() {
    return ShareLinkResponseDataMapper.ensureInitialized().stringifyValue(
      this as ShareLinkResponseData,
    );
  }

  @override
  bool operator ==(Object other) {
    return ShareLinkResponseDataMapper.ensureInitialized().equalsValue(
      this as ShareLinkResponseData,
      other,
    );
  }

  @override
  int get hashCode {
    return ShareLinkResponseDataMapper.ensureInitialized().hashValue(
      this as ShareLinkResponseData,
    );
  }
}

extension ShareLinkResponseDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ShareLinkResponseData, $Out> {
  ShareLinkResponseDataCopyWith<$R, ShareLinkResponseData, $Out>
  get $asShareLinkResponseData => $base.as(
    (v, t, t2) => _ShareLinkResponseDataCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ShareLinkResponseDataCopyWith<
  $R,
  $In extends ShareLinkResponseData,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get attachmentUrls;
  $R call({
    String? id,
    String? contentType,
    String? title,
    String? description,
    List<String>? attachmentUrls,
    int? likesCount,
    int? commentsCount,
    String? createdAt,
    String? updatedAt,
    String? startDate,
    String? endDate,
    String? eventTime,
    String? location,
    String? addressDetails,
    String? latitude,
    String? longitude,
    bool? isPaid,
    int? attendanceCount,
  });
  ShareLinkResponseDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ShareLinkResponseDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ShareLinkResponseData, $Out>
    implements ShareLinkResponseDataCopyWith<$R, ShareLinkResponseData, $Out> {
  _ShareLinkResponseDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ShareLinkResponseData> $mapper =
      ShareLinkResponseDataMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get attachmentUrls => ListCopyWith(
    $value.attachmentUrls,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(attachmentUrls: v),
  );
  @override
  $R call({
    String? id,
    String? contentType,
    String? title,
    String? description,
    List<String>? attachmentUrls,
    int? likesCount,
    int? commentsCount,
    String? createdAt,
    String? updatedAt,
    Object? startDate = $none,
    Object? endDate = $none,
    Object? eventTime = $none,
    Object? location = $none,
    Object? addressDetails = $none,
    Object? latitude = $none,
    Object? longitude = $none,
    Object? isPaid = $none,
    Object? attendanceCount = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (contentType != null) #contentType: contentType,
      if (title != null) #title: title,
      if (description != null) #description: description,
      if (attachmentUrls != null) #attachmentUrls: attachmentUrls,
      if (likesCount != null) #likesCount: likesCount,
      if (commentsCount != null) #commentsCount: commentsCount,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
      if (startDate != $none) #startDate: startDate,
      if (endDate != $none) #endDate: endDate,
      if (eventTime != $none) #eventTime: eventTime,
      if (location != $none) #location: location,
      if (addressDetails != $none) #addressDetails: addressDetails,
      if (latitude != $none) #latitude: latitude,
      if (longitude != $none) #longitude: longitude,
      if (isPaid != $none) #isPaid: isPaid,
      if (attendanceCount != $none) #attendanceCount: attendanceCount,
    }),
  );
  @override
  ShareLinkResponseData $make(CopyWithData data) => ShareLinkResponseData(
    id: data.get(#id, or: $value.id),
    contentType: data.get(#contentType, or: $value.contentType),
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    attachmentUrls: data.get(#attachmentUrls, or: $value.attachmentUrls),
    likesCount: data.get(#likesCount, or: $value.likesCount),
    commentsCount: data.get(#commentsCount, or: $value.commentsCount),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    startDate: data.get(#startDate, or: $value.startDate),
    endDate: data.get(#endDate, or: $value.endDate),
    eventTime: data.get(#eventTime, or: $value.eventTime),
    location: data.get(#location, or: $value.location),
    addressDetails: data.get(#addressDetails, or: $value.addressDetails),
    latitude: data.get(#latitude, or: $value.latitude),
    longitude: data.get(#longitude, or: $value.longitude),
    isPaid: data.get(#isPaid, or: $value.isPaid),
    attendanceCount: data.get(#attendanceCount, or: $value.attendanceCount),
  );

  @override
  ShareLinkResponseDataCopyWith<$R2, ShareLinkResponseData, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ShareLinkResponseDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ShareMetaMapper extends ClassMapperBase<ShareMeta> {
  ShareMetaMapper._();

  static ShareMetaMapper? _instance;
  static ShareMetaMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ShareMetaMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ShareMeta';

  static String _$lang(ShareMeta v) => v.lang;
  static const Field<ShareMeta, String> _f$lang = Field(
    'lang',
    _$lang,
    opt: true,
    def: '',
  );
  static String _$timestamp(ShareMeta v) => v.timestamp;
  static const Field<ShareMeta, String> _f$timestamp = Field(
    'timestamp',
    _$timestamp,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<ShareMeta> fields = const {
    #lang: _f$lang,
    #timestamp: _f$timestamp,
  };

  static ShareMeta _instantiate(DecodingData data) {
    return ShareMeta(
      lang: data.dec(_f$lang),
      timestamp: data.dec(_f$timestamp),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ShareMeta fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ShareMeta>(map);
  }

  static ShareMeta fromJson(String json) {
    return ensureInitialized().decodeJson<ShareMeta>(json);
  }
}

mixin ShareMetaMappable {
  String toJson() {
    return ShareMetaMapper.ensureInitialized().encodeJson<ShareMeta>(
      this as ShareMeta,
    );
  }

  Map<String, dynamic> toMap() {
    return ShareMetaMapper.ensureInitialized().encodeMap<ShareMeta>(
      this as ShareMeta,
    );
  }

  ShareMetaCopyWith<ShareMeta, ShareMeta, ShareMeta> get copyWith =>
      _ShareMetaCopyWithImpl<ShareMeta, ShareMeta>(
        this as ShareMeta,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ShareMetaMapper.ensureInitialized().stringifyValue(
      this as ShareMeta,
    );
  }

  @override
  bool operator ==(Object other) {
    return ShareMetaMapper.ensureInitialized().equalsValue(
      this as ShareMeta,
      other,
    );
  }

  @override
  int get hashCode {
    return ShareMetaMapper.ensureInitialized().hashValue(this as ShareMeta);
  }
}

extension ShareMetaValueCopy<$R, $Out> on ObjectCopyWith<$R, ShareMeta, $Out> {
  ShareMetaCopyWith<$R, ShareMeta, $Out> get $asShareMeta =>
      $base.as((v, t, t2) => _ShareMetaCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ShareMetaCopyWith<$R, $In extends ShareMeta, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? lang, String? timestamp});
  ShareMetaCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ShareMetaCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ShareMeta, $Out>
    implements ShareMetaCopyWith<$R, ShareMeta, $Out> {
  _ShareMetaCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ShareMeta> $mapper =
      ShareMetaMapper.ensureInitialized();
  @override
  $R call({String? lang, String? timestamp}) => $apply(
    FieldCopyWithData({
      if (lang != null) #lang: lang,
      if (timestamp != null) #timestamp: timestamp,
    }),
  );
  @override
  ShareMeta $make(CopyWithData data) => ShareMeta(
    lang: data.get(#lang, or: $value.lang),
    timestamp: data.get(#timestamp, or: $value.timestamp),
  );

  @override
  ShareMetaCopyWith<$R2, ShareMeta, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ShareMetaCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

