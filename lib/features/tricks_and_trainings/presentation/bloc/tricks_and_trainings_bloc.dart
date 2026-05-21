import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/tricks_and_trainings/domain/repository/tricks_and_trainings_repository.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/bloc/tricks_and_trainings_event.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/bloc/tricks_and_trainings_state.dart';

class TricksAndTrainingsBloc
    extends Bloc<TricksAndTrainingsEvent, TricksAndTrainingsState> {
  final TricksAndTrainingsRepository _repo;

  TricksAndTrainingsBloc(this._repo) : super(const TricksAndTrainingsState()) {
    on<LoadTricksAndTrainings>(_onLoad);

    on<SearchTricksAndTrainings>(_onSearch);

    on<ClearSearch>(_onClearSearch);

    on<LoadListingContent>(_onLoadListingContent);

    on<LoadContentDetails>(_onLoadContentDetails);

    on<LoadMoreLikeThis>(_onLoadMoreLikeThis);

    on<LoadRelatedContent>(_onLoadRelatedContent);

    on<SearchContent>(_onSearchContent);
  }

  Future<void> _onLoad(
    LoadTricksAndTrainings event,
    Emitter<TricksAndTrainingsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final home = await _repo.getHomeContent(petId: event.petId);

      emit(
        state.copyWith(
          videos: home.videos,
          trainings: home.trainings,
          tips: home.tips,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onSearch(
    SearchTricksAndTrainings event,
    Emitter<TricksAndTrainingsState> emit,
  ) async {
    emit(state.copyWith(isSearching: true, searchQuery: event.query));

    try {
      final all = await _repo.getAllContent();

      final query = event.query.toLowerCase().trim();

      final results = all.where((item) {
        return item.title.toLowerCase().contains(query) ||
            item.description.toLowerCase().contains(query);
      }).toList();

      emit(state.copyWith(searchResults: results, isSearching: false));
    } catch (e) {
      emit(state.copyWith(isSearching: false, error: e.toString()));
    }
  }

  void _onClearSearch(
    ClearSearch event,
    Emitter<TricksAndTrainingsState> emit,
  ) {
    emit(state.copyWith(searchResults: [], searchQuery: ''));
  }

  Future<void> _onLoadListingContent(
    LoadListingContent event,
    Emitter<TricksAndTrainingsState> emit,
  ) async {
    /// Prevent duplicate pagination calls
    if (event.loadMore && !state.hasNextPage) {
      return;
    }

    try {
      /// Initial loading
      if (!event.loadMore) {
        emit(
          state.copyWith(
            isListingLoading: true,
            selectedContentType: event.contentType,
          ),
        );
      } else {
        /// Pagination loading
        emit(state.copyWith(isLoadingMore: true));
      }

      final nextPage = event.loadMore ? state.currentPage + 1 : 1;

      final response = await _repo.getContentListing(
        contentType: event.contentType,
        petId: event.petId,
        page: nextPage,
      );

      final updatedItems = event.loadMore
          ? [...state.listingItems, ...response.items]
          : response.items;

      emit(
        state.copyWith(
          listingItems: updatedItems,

          currentPage: response.page,

          hasNextPage: response.hasNextPage,

          isListingLoading: false,

          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isListingLoading: false,
          isLoadingMore: false,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoadContentDetails(
    LoadContentDetails event,
    Emitter<TricksAndTrainingsState> emit,
  ) async {
    emit(state.copyWith(isDetailsLoading: true));

    try {
      final item = await _repo.getContentDetails(event.id);

      emit(state.copyWith(selectedContent: item, isDetailsLoading: false));
    } catch (e) {
      emit(state.copyWith(isDetailsLoading: false, error: e.toString()));
    }
  }

  Future<void> _onLoadMoreLikeThis(
    LoadMoreLikeThis event,
    Emitter<TricksAndTrainingsState> emit,
  ) async {
    emit(state.copyWith(isMoreLikeThisLoading: true));

    try {
      final response = await _repo.getContentListing(
        parentId: event.parentId,
        contentType: event.contentType,
      );

      emit(
        state.copyWith(
          moreLikeThis: response.items,

          isMoreLikeThisLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isMoreLikeThisLoading: false, error: e.toString()));
    }
  }

  Future<void> _onLoadRelatedContent(
    LoadRelatedContent event,
    Emitter<TricksAndTrainingsState> emit,
  ) async {
    /// ALWAYS update selected tab first
    emit(state.copyWith(selectedRelatedTab: event.contentType));

    /// CHECK CACHE
    final cached = state.relatedContentCache[event.contentType];

    if (cached != null && cached.isNotEmpty) {
      emit(
        state.copyWith(relatedContent: cached, isRelatedContentLoading: false),
      );

      return;
    }

    /// FIRST TIME LOADING ONLY
    emit(state.copyWith(isRelatedContentLoading: true, relatedContent: []));

    try {
      final response = await _repo.getContentListing(
        parentId: event.parentId,

        contentType: event.contentType,
      );

      final updatedCache = {
        ...state.relatedContentCache,
        event.contentType: response.items,
      };

      emit(
        state.copyWith(
          relatedContent: response.items,
          relatedContentCache: updatedCache,
          isRelatedContentLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isRelatedContentLoading: false, error: e.toString()));
    }
  }

  Future<void> _onSearchContent(
    SearchContent event,
    Emitter<TricksAndTrainingsState> emit,
  ) async {
    emit(state.copyWith(isSearching: true, searchResults: []));

    try {
      final response = await _repo.getContentListing(search: event.query);

      emit(state.copyWith(searchResults: response.items, isSearching: false));
    } catch (e) {
      emit(state.copyWith(isSearching: false, error: e.toString()));
    }
  }
}
