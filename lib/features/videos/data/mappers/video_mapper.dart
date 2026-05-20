import 'package:poochcare/features/videos/data/models/video_response.dart';
import 'package:poochcare/features/videos/domain/models/video_item.dart';

class VideoMapper {
  const VideoMapper._();

  static VideoItem toDomain(VideoResponse response) => VideoItem(
    id: response.id,
    title: response.title,
    durationLabel: response.durationLabel,
    thumbnailUrl: response.thumbnailUrl,
  );

  static List<VideoItem> listToDomain(List<VideoResponse> responses) =>
      responses.map(toDomain).toList();
}
