part of 'videos_bloc.dart';

sealed class VideosEvent extends Equatable {
  const VideosEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class VideosFetched extends VideosEvent {
  const VideosFetched();
}

class VideosLoadMoreRequested extends VideosEvent {
  const VideosLoadMoreRequested();
}
