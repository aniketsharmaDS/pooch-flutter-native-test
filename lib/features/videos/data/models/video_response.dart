import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'video_response.mapper.dart';

@MappableClass()
class VideoResponse with VideoResponseMappable {
  const VideoResponse({
    this.id = '',
    this.title = '',
    this.durationLabel = '',
    this.thumbnailUrl = '',
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String title;

  @MappableField(hook: SafeStringHook())
  final String durationLabel;

  @MappableField(hook: SafeStringHook())
  final String thumbnailUrl;
}
