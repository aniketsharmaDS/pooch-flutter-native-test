// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'missing_pet_report_payload_model.dart';

class MissingPetReportPayloadModelMapper
    extends ClassMapperBase<MissingPetReportPayloadModel> {
  MissingPetReportPayloadModelMapper._();

  static MissingPetReportPayloadModelMapper? _instance;
  static MissingPetReportPayloadModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = MissingPetReportPayloadModelMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'MissingPetReportPayloadModel';

  static String _$petId(MissingPetReportPayloadModel v) => v.petId;
  static const Field<MissingPetReportPayloadModel, String> _f$petId = Field(
    'petId',
    _$petId,
    key: r'pet_id',
  );
  static String? _$missingDate(MissingPetReportPayloadModel v) => v.missingDate;
  static const Field<MissingPetReportPayloadModel, String> _f$missingDate =
      Field('missingDate', _$missingDate, key: r'missing_date', opt: true);
  static String? _$missingTime(MissingPetReportPayloadModel v) => v.missingTime;
  static const Field<MissingPetReportPayloadModel, String> _f$missingTime =
      Field('missingTime', _$missingTime, key: r'missing_time', opt: true);
  static String? _$color(MissingPetReportPayloadModel v) => v.color;
  static const Field<MissingPetReportPayloadModel, String> _f$color = Field(
    'color',
    _$color,
    opt: true,
  );
  static String? _$lastKnownLocation(MissingPetReportPayloadModel v) =>
      v.lastKnownLocation;
  static const Field<MissingPetReportPayloadModel, String>
  _f$lastKnownLocation = Field(
    'lastKnownLocation',
    _$lastKnownLocation,
    key: r'last_known_location',
    opt: true,
  );
  static double? _$latitude(MissingPetReportPayloadModel v) => v.latitude;
  static const Field<MissingPetReportPayloadModel, double> _f$latitude = Field(
    'latitude',
    _$latitude,
    opt: true,
  );
  static double? _$longitude(MissingPetReportPayloadModel v) => v.longitude;
  static const Field<MissingPetReportPayloadModel, double> _f$longitude = Field(
    'longitude',
    _$longitude,
    opt: true,
  );
  static String? _$description(MissingPetReportPayloadModel v) => v.description;
  static const Field<MissingPetReportPayloadModel, String> _f$description =
      Field('description', _$description, opt: true);
  static int? _$rewardAmount(MissingPetReportPayloadModel v) => v.rewardAmount;
  static const Field<MissingPetReportPayloadModel, int> _f$rewardAmount = Field(
    'rewardAmount',
    _$rewardAmount,
    key: r'reward_amount',
    opt: true,
  );
  static List<dynamic>? _$images(MissingPetReportPayloadModel v) => v.images;
  static const Field<MissingPetReportPayloadModel, List<dynamic>> _f$images =
      Field('images', _$images, opt: true);

  @override
  final MappableFields<MissingPetReportPayloadModel> fields = const {
    #petId: _f$petId,
    #missingDate: _f$missingDate,
    #missingTime: _f$missingTime,
    #color: _f$color,
    #lastKnownLocation: _f$lastKnownLocation,
    #latitude: _f$latitude,
    #longitude: _f$longitude,
    #description: _f$description,
    #rewardAmount: _f$rewardAmount,
    #images: _f$images,
  };
  @override
  final bool ignoreNull = true;

  static MissingPetReportPayloadModel _instantiate(DecodingData data) {
    return MissingPetReportPayloadModel(
      petId: data.dec(_f$petId),
      missingDate: data.dec(_f$missingDate),
      missingTime: data.dec(_f$missingTime),
      color: data.dec(_f$color),
      lastKnownLocation: data.dec(_f$lastKnownLocation),
      latitude: data.dec(_f$latitude),
      longitude: data.dec(_f$longitude),
      description: data.dec(_f$description),
      rewardAmount: data.dec(_f$rewardAmount),
      images: data.dec(_f$images),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MissingPetReportPayloadModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MissingPetReportPayloadModel>(map);
  }

  static MissingPetReportPayloadModel fromJson(String json) {
    return ensureInitialized().decodeJson<MissingPetReportPayloadModel>(json);
  }
}

mixin MissingPetReportPayloadModelMappable {
  String toJson() {
    return MissingPetReportPayloadModelMapper.ensureInitialized()
        .encodeJson<MissingPetReportPayloadModel>(
          this as MissingPetReportPayloadModel,
        );
  }

  Map<String, dynamic> toMap() {
    return MissingPetReportPayloadModelMapper.ensureInitialized()
        .encodeMap<MissingPetReportPayloadModel>(
          this as MissingPetReportPayloadModel,
        );
  }

  MissingPetReportPayloadModelCopyWith<
    MissingPetReportPayloadModel,
    MissingPetReportPayloadModel,
    MissingPetReportPayloadModel
  >
  get copyWith =>
      _MissingPetReportPayloadModelCopyWithImpl<
        MissingPetReportPayloadModel,
        MissingPetReportPayloadModel
      >(this as MissingPetReportPayloadModel, $identity, $identity);
  @override
  String toString() {
    return MissingPetReportPayloadModelMapper.ensureInitialized()
        .stringifyValue(this as MissingPetReportPayloadModel);
  }

  @override
  bool operator ==(Object other) {
    return MissingPetReportPayloadModelMapper.ensureInitialized().equalsValue(
      this as MissingPetReportPayloadModel,
      other,
    );
  }

  @override
  int get hashCode {
    return MissingPetReportPayloadModelMapper.ensureInitialized().hashValue(
      this as MissingPetReportPayloadModel,
    );
  }
}

extension MissingPetReportPayloadModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MissingPetReportPayloadModel, $Out> {
  MissingPetReportPayloadModelCopyWith<$R, MissingPetReportPayloadModel, $Out>
  get $asMissingPetReportPayloadModel => $base.as(
    (v, t, t2) => _MissingPetReportPayloadModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class MissingPetReportPayloadModelCopyWith<
  $R,
  $In extends MissingPetReportPayloadModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>? get images;
  $R call({
    String? petId,
    String? missingDate,
    String? missingTime,
    String? color,
    String? lastKnownLocation,
    double? latitude,
    double? longitude,
    String? description,
    int? rewardAmount,
    List<dynamic>? images,
  });
  MissingPetReportPayloadModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MissingPetReportPayloadModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MissingPetReportPayloadModel, $Out>
    implements
        MissingPetReportPayloadModelCopyWith<
          $R,
          MissingPetReportPayloadModel,
          $Out
        > {
  _MissingPetReportPayloadModelCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<MissingPetReportPayloadModel> $mapper =
      MissingPetReportPayloadModelMapper.ensureInitialized();
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
    String? petId,
    Object? missingDate = $none,
    Object? missingTime = $none,
    Object? color = $none,
    Object? lastKnownLocation = $none,
    Object? latitude = $none,
    Object? longitude = $none,
    Object? description = $none,
    Object? rewardAmount = $none,
    Object? images = $none,
  }) => $apply(
    FieldCopyWithData({
      if (petId != null) #petId: petId,
      if (missingDate != $none) #missingDate: missingDate,
      if (missingTime != $none) #missingTime: missingTime,
      if (color != $none) #color: color,
      if (lastKnownLocation != $none) #lastKnownLocation: lastKnownLocation,
      if (latitude != $none) #latitude: latitude,
      if (longitude != $none) #longitude: longitude,
      if (description != $none) #description: description,
      if (rewardAmount != $none) #rewardAmount: rewardAmount,
      if (images != $none) #images: images,
    }),
  );
  @override
  MissingPetReportPayloadModel $make(CopyWithData data) =>
      MissingPetReportPayloadModel(
        petId: data.get(#petId, or: $value.petId),
        missingDate: data.get(#missingDate, or: $value.missingDate),
        missingTime: data.get(#missingTime, or: $value.missingTime),
        color: data.get(#color, or: $value.color),
        lastKnownLocation: data.get(
          #lastKnownLocation,
          or: $value.lastKnownLocation,
        ),
        latitude: data.get(#latitude, or: $value.latitude),
        longitude: data.get(#longitude, or: $value.longitude),
        description: data.get(#description, or: $value.description),
        rewardAmount: data.get(#rewardAmount, or: $value.rewardAmount),
        images: data.get(#images, or: $value.images),
      );

  @override
  MissingPetReportPayloadModelCopyWith<$R2, MissingPetReportPayloadModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MissingPetReportPayloadModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

