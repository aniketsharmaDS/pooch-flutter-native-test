// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'video_response.dart';

class VideoResponseMapper extends ClassMapperBase<VideoResponse> {
  VideoResponseMapper._();

  static VideoResponseMapper? _instance;
  static VideoResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VideoResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'VideoResponse';

  static String _$id(VideoResponse v) => v.id;
  static const Field<VideoResponse, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$title(VideoResponse v) => v.title;
  static const Field<VideoResponse, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$durationLabel(VideoResponse v) => v.durationLabel;
  static const Field<VideoResponse, String> _f$durationLabel = Field(
    'durationLabel',
    _$durationLabel,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$thumbnailUrl(VideoResponse v) => v.thumbnailUrl;
  static const Field<VideoResponse, String> _f$thumbnailUrl = Field(
    'thumbnailUrl',
    _$thumbnailUrl,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<VideoResponse> fields = const {
    #id: _f$id,
    #title: _f$title,
    #durationLabel: _f$durationLabel,
    #thumbnailUrl: _f$thumbnailUrl,
  };

  static VideoResponse _instantiate(DecodingData data) {
    return VideoResponse(
      id: data.dec(_f$id),
      title: data.dec(_f$title),
      durationLabel: data.dec(_f$durationLabel),
      thumbnailUrl: data.dec(_f$thumbnailUrl),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static VideoResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VideoResponse>(map);
  }

  static VideoResponse fromJson(String json) {
    return ensureInitialized().decodeJson<VideoResponse>(json);
  }
}

mixin VideoResponseMappable {
  String toJson() {
    return VideoResponseMapper.ensureInitialized().encodeJson<VideoResponse>(
      this as VideoResponse,
    );
  }

  Map<String, dynamic> toMap() {
    return VideoResponseMapper.ensureInitialized().encodeMap<VideoResponse>(
      this as VideoResponse,
    );
  }

  VideoResponseCopyWith<VideoResponse, VideoResponse, VideoResponse>
  get copyWith => _VideoResponseCopyWithImpl<VideoResponse, VideoResponse>(
    this as VideoResponse,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return VideoResponseMapper.ensureInitialized().stringifyValue(
      this as VideoResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return VideoResponseMapper.ensureInitialized().equalsValue(
      this as VideoResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return VideoResponseMapper.ensureInitialized().hashValue(
      this as VideoResponse,
    );
  }
}

extension VideoResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VideoResponse, $Out> {
  VideoResponseCopyWith<$R, VideoResponse, $Out> get $asVideoResponse =>
      $base.as((v, t, t2) => _VideoResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class VideoResponseCopyWith<$R, $In extends VideoResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? title,
    String? durationLabel,
    String? thumbnailUrl,
  });
  VideoResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _VideoResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VideoResponse, $Out>
    implements VideoResponseCopyWith<$R, VideoResponse, $Out> {
  _VideoResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VideoResponse> $mapper =
      VideoResponseMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? title,
    String? durationLabel,
    String? thumbnailUrl,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (title != null) #title: title,
      if (durationLabel != null) #durationLabel: durationLabel,
      if (thumbnailUrl != null) #thumbnailUrl: thumbnailUrl,
    }),
  );
  @override
  VideoResponse $make(CopyWithData data) => VideoResponse(
    id: data.get(#id, or: $value.id),
    title: data.get(#title, or: $value.title),
    durationLabel: data.get(#durationLabel, or: $value.durationLabel),
    thumbnailUrl: data.get(#thumbnailUrl, or: $value.thumbnailUrl),
  );

  @override
  VideoResponseCopyWith<$R2, VideoResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _VideoResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

