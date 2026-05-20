import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/store/videos/videos_store_bloc.dart';
import 'package:poochcare/core/store/videos/videos_store_event.dart';
import 'package:poochcare/features/videos/repository/videos_repository.dart';

part 'videos_event.dart';
part 'videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  VideosBloc({
    required VideosRepository repository,
    required VideosStoreBloc videosStore,
  }) : _repository = repository,
       _videosStore = videosStore,
       super(const VideosState()) {
    on<VideosFetched>(_onVideosFetched);
    on<VideosLoadMoreRequested>(_onVideosLoadMoreRequested);
  }

  final VideosRepository _repository;
  final VideosStoreBloc _videosStore;

  Future<void> _onVideosFetched(
    VideosFetched event,
    Emitter<VideosState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    final videos = await _repository.fetchVideos(page: 1);
    _videosStore.add(VideosRefreshed(videos));
    emit(state.copyWith(isLoading: false, currentPage: 1, hasMore: true));
  }

  Future<void> _onVideosLoadMoreRequested(
    VideosLoadMoreRequested event,
    Emitter<VideosState> emit,
  ) async {
    if (!state.hasMore || state.isFetchingMore) {
      return;
    }
    emit(state.copyWith(isFetchingMore: true));
    final videos = await _repository.fetchVideos(page: state.currentPage + 1);
    _videosStore.add(VideosRefreshed(videos));
    emit(
      state.copyWith(
        isFetchingMore: false,
        currentPage: state.currentPage + 1,
        hasMore: state.currentPage < 3,
      ),
    );
  }
}
