// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'create_event_payload_model.dart';

class CreateEventPayloadModelMapper
    extends ClassMapperBase<CreateEventPayloadModel> {
  CreateEventPayloadModelMapper._();

  static CreateEventPayloadModelMapper? _instance;
  static CreateEventPayloadModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = CreateEventPayloadModelMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'CreateEventPayloadModel';

  static String? _$eventId(CreateEventPayloadModel v) => v.eventId;
  static const Field<CreateEventPayloadModel, String> _f$eventId = Field(
    'eventId',
    _$eventId,
    opt: true,
  );
  static String _$title(CreateEventPayloadModel v) => v.title;
  static const Field<CreateEventPayloadModel, String> _f$title = Field(
    'title',
    _$title,
  );
  static String? _$description(CreateEventPayloadModel v) => v.description;
  static const Field<CreateEventPayloadModel, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
  );
  static String? _$categoryId(CreateEventPayloadModel v) => v.categoryId;
  static const Field<CreateEventPayloadModel, String> _f$categoryId = Field(
    'categoryId',
    _$categoryId,
    key: r'category',
    opt: true,
  );
  static String? _$eventStartDate(CreateEventPayloadModel v) =>
      v.eventStartDate;
  static const Field<CreateEventPayloadModel, String> _f$eventStartDate = Field(
    'eventStartDate',
    _$eventStartDate,
    key: r'event_start_date',
    opt: true,
  );
  static String? _$eventEndDate(CreateEventPayloadModel v) => v.eventEndDate;
  static const Field<CreateEventPayloadModel, String> _f$eventEndDate = Field(
    'eventEndDate',
    _$eventEndDate,
    key: r'event_end_date',
    opt: true,
  );
  static String? _$eventTime(CreateEventPayloadModel v) => v.eventTime;
  static const Field<CreateEventPayloadModel, String> _f$eventTime = Field(
    'eventTime',
    _$eventTime,
    key: r'event_time',
    opt: true,
  );
  static String? _$location(CreateEventPayloadModel v) => v.location;
  static const Field<CreateEventPayloadModel, String> _f$location = Field(
    'location',
    _$location,
    opt: true,
  );
  static String? _$addressDetails(CreateEventPayloadModel v) =>
      v.addressDetails;
  static const Field<CreateEventPayloadModel, String> _f$addressDetails = Field(
    'addressDetails',
    _$addressDetails,
    key: r'address_details',
    opt: true,
  );
  static double? _$latitude(CreateEventPayloadModel v) => v.latitude;
  static const Field<CreateEventPayloadModel, double> _f$latitude = Field(
    'latitude',
    _$latitude,
    opt: true,
  );
  static double? _$longitude(CreateEventPayloadModel v) => v.longitude;
  static const Field<CreateEventPayloadModel, double> _f$longitude = Field(
    'longitude',
    _$longitude,
    opt: true,
  );
  static bool? _$isPaid(CreateEventPayloadModel v) => v.isPaid;
  static const Field<CreateEventPayloadModel, bool> _f$isPaid = Field(
    'isPaid',
    _$isPaid,
    key: r'is_paid',
    opt: true,
  );
  static bool _$isDraft(CreateEventPayloadModel v) => v.isDraft;
  static const Field<CreateEventPayloadModel, bool> _f$isDraft = Field(
    'isDraft',
    _$isDraft,
    key: r'is_draft',
  );
  static List<dynamic>? _$images(CreateEventPayloadModel v) => v.images;
  static const Field<CreateEventPayloadModel, List<dynamic>> _f$images = Field(
    'images',
    _$images,
    opt: true,
  );

  @override
  final MappableFields<CreateEventPayloadModel> fields = const {
    #eventId: _f$eventId,
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
    #isDraft: _f$isDraft,
    #images: _f$images,
  };
  @override
  final bool ignoreNull = true;

  static CreateEventPayloadModel _instantiate(DecodingData data) {
    return CreateEventPayloadModel(
      eventId: data.dec(_f$eventId),
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
      isDraft: data.dec(_f$isDraft),
      images: data.dec(_f$images),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CreateEventPayloadModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CreateEventPayloadModel>(map);
  }

  static CreateEventPayloadModel fromJson(String json) {
    return ensureInitialized().decodeJson<CreateEventPayloadModel>(json);
  }
}

mixin CreateEventPayloadModelMappable {
  String toJson() {
    return CreateEventPayloadModelMapper.ensureInitialized()
        .encodeJson<CreateEventPayloadModel>(this as CreateEventPayloadModel);
  }

  Map<String, dynamic> toMap() {
    return CreateEventPayloadModelMapper.ensureInitialized()
        .encodeMap<CreateEventPayloadModel>(this as CreateEventPayloadModel);
  }

  CreateEventPayloadModelCopyWith<
    CreateEventPayloadModel,
    CreateEventPayloadModel,
    CreateEventPayloadModel
  >
  get copyWith =>
      _CreateEventPayloadModelCopyWithImpl<
        CreateEventPayloadModel,
        CreateEventPayloadModel
      >(this as CreateEventPayloadModel, $identity, $identity);
  @override
  String toString() {
    return CreateEventPayloadModelMapper.ensureInitialized().stringifyValue(
      this as CreateEventPayloadModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return CreateEventPayloadModelMapper.ensureInitialized().equalsValue(
      this as CreateEventPayloadModel,
      other,
    );
  }

  @override
  int get hashCode {
    return CreateEventPayloadModelMapper.ensureInitialized().hashValue(
      this as CreateEventPayloadModel,
    );
  }
}

extension CreateEventPayloadModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CreateEventPayloadModel, $Out> {
  CreateEventPayloadModelCopyWith<$R, CreateEventPayloadModel, $Out>
  get $asCreateEventPayloadModel => $base.as(
    (v, t, t2) => _CreateEventPayloadModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CreateEventPayloadModelCopyWith<
  $R,
  $In extends CreateEventPayloadModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>? get images;
  $R call({
    String? eventId,
    String? title,
    String? description,
    String? categoryId,
    String? eventStartDate,
    String? eventEndDate,
    String? eventTime,
    String? location,
    String? addressDetails,
    double? latitude,
    double? longitude,
    bool? isPaid,
    bool? isDraft,
    List<dynamic>? images,
  });
  CreateEventPayloadModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CreateEventPayloadModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CreateEventPayloadModel, $Out>
    implements
        CreateEventPayloadModelCopyWith<$R, CreateEventPayloadModel, $Out> {
  _CreateEventPayloadModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CreateEventPayloadModel> $mapper =
      CreateEventPayloadModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get images => $value.images != null
      ? ListCopyWith(
          $value.images!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(images: v),
        )
      : null;
  @override
  $R call({
    Object? eventId = $none,
    String? title,
    Object? description = $none,
    Object? categoryId = $none,
    Object? eventStartDate = $none,
    Object? eventEndDate = $none,
    Object? eventTime = $none,
    Object? location = $none,
    Object? addressDetails = $none,
    Object? latitude = $none,
    Object? longitude = $none,
    Object? isPaid = $none,
    bool? isDraft,
    Object? images = $none,
  }) => $apply(
    FieldCopyWithData({
      if (eventId != $none) #eventId: eventId,
      if (title != null) #title: title,
      if (description != $none) #description: description,
      if (categoryId != $none) #categoryId: categoryId,
      if (eventStartDate != $none) #eventStartDate: eventStartDate,
      if (eventEndDate != $none) #eventEndDate: eventEndDate,
      if (eventTime != $none) #eventTime: eventTime,
      if (location != $none) #location: location,
      if (addressDetails != $none) #addressDetails: addressDetails,
      if (latitude != $none) #latitude: latitude,
      if (longitude != $none) #longitude: longitude,
      if (isPaid != $none) #isPaid: isPaid,
      if (isDraft != null) #isDraft: isDraft,
      if (images != $none) #images: images,
    }),
  );
  @override
  CreateEventPayloadModel $make(CopyWithData data) => CreateEventPayloadModel(
    eventId: data.get(#eventId, or: $value.eventId),
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
    isDraft: data.get(#isDraft, or: $value.isDraft),
    images: data.get(#images, or: $value.images),
  );

  @override
  CreateEventPayloadModelCopyWith<$R2, CreateEventPayloadModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CreateEventPayloadModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

