import 'package:equatable/equatable.dart';
import 'package:poochcare/features/videos/domain/models/video_item.dart';

sealed class VideosStoreEvent extends Equatable {
  const VideosStoreEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class VideosRefreshed extends VideosStoreEvent {
  const VideosRefreshed(this.videos);

  final List<VideoItem> videos;

  @override
  List<Object> get props => <Object>[videos];
}

class VideoUpserted extends VideosStoreEvent {
  const VideoUpserted(this.video);

  final VideoItem video;

  @override
  List<Object> get props => <Object>[video];
}

class VideosCleared extends VideosStoreEvent {
  const VideosCleared();
}
