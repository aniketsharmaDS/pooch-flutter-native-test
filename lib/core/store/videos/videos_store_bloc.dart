import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/store/videos/videos_store_event.dart';
import 'package:poochcare/core/store/videos/videos_store_state.dart';
import 'package:poochcare/features/videos/domain/models/video_item.dart';

class VideosStoreBloc extends Bloc<VideosStoreEvent, VideosStoreState> {
  VideosStoreBloc() : super(const VideosStoreState()) {
    on<VideosRefreshed>(_onVideosRefreshed);
    on<VideoUpserted>(_onVideoUpserted);
    on<VideosCleared>(_onVideosCleared);
  }

  void _onVideosRefreshed(
    VideosRefreshed event,
    Emitter<VideosStoreState> emit,
  ) {
    final Map<String, VideoItem> byId = <String, VideoItem>{
      for (final VideoItem item in event.videos) item.id: item,
    };
    final List<String> ids = event.videos.map((VideoItem v) => v.id).toList();
    emit(state.copyWith(videosById: byId, videoIds: ids));
  }

  void _onVideoUpserted(VideoUpserted event, Emitter<VideosStoreState> emit) {
    final Map<String, VideoItem> byId = Map<String, VideoItem>.from(
      state.videosById,
    );
    final List<String> ids = List<String>.from(state.videoIds);

    byId[event.video.id] = event.video;
    if (!ids.contains(event.video.id)) {
      ids.add(event.video.id);
    }

    emit(state.copyWith(videosById: byId, videoIds: ids));
  }

  void _onVideosCleared(VideosCleared event, Emitter<VideosStoreState> emit) {
    emit(const VideosStoreState());
  }
}
