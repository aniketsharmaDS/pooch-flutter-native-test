import 'package:equatable/equatable.dart';
import 'package:poochcare/features/videos/domain/models/video_item.dart';

class VideosStoreState extends Equatable {
  const VideosStoreState({
    this.videosById = const <String, VideoItem>{},
    this.videoIds = const <String>[],
  });

  final Map<String, VideoItem> videosById;
  final List<String> videoIds;

  List<VideoItem> get videos =>
      videoIds.map((String id) => videosById[id]!).toList();

  VideosStoreState copyWith({
    Map<String, VideoItem>? videosById,
    List<String>? videoIds,
  }) {
    return VideosStoreState(
      videosById: videosById ?? this.videosById,
      videoIds: videoIds ?? this.videoIds,
    );
  }

  @override
  List<Object?> get props => <Object?>[videosById, videoIds];
}
