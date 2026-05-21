import 'package:poochcare/features/tricks_and_trainings/domain/ui_models/tricks_and_training_ui_model.dart';

class TricksAndTrainingsState {
  final List<TricksAndTrainingUIModel> videos;

  final List<TricksAndTrainingUIModel> trainings;

  final List<TricksAndTrainingUIModel> tips;

  final List<TricksAndTrainingUIModel> searchResults;

  final List<TricksAndTrainingUIModel> listingItems;

  final TricksAndTrainingUIModel? selectedContent;

  final bool isDetailsLoading;

  final List<TricksAndTrainingUIModel> moreLikeThis;

  final List<TricksAndTrainingUIModel> relatedContent;

  final Map<String, List<TricksAndTrainingUIModel>> relatedContentCache;

  final bool isMoreLikeThisLoading;

  final bool isRelatedContentLoading;

  final String selectedRelatedTab;

  final bool isListingLoading;

  final bool isLoadingMore;

  final bool hasNextPage;

  final int currentPage;

  final String selectedContentType;

  final bool isLoading;

  final bool isSearching;

  final String searchQuery;

  final String? error;

  const TricksAndTrainingsState({
    this.videos = const [],
    this.trainings = const [],
    this.tips = const [],
    this.listingItems = const [],
    this.isListingLoading = false,
    this.isLoadingMore = false,
    this.hasNextPage = false,
    this.currentPage = 1,
    this.selectedContentType = '',
    this.searchResults = const [],
    this.selectedContent,
    this.isDetailsLoading = false,
    this.moreLikeThis = const [],
    this.relatedContent = const [],
    this.relatedContentCache = const {},
    this.isMoreLikeThisLoading = false,
    this.isRelatedContentLoading = false,
    this.selectedRelatedTab = '',
    this.isLoading = false,
    this.isSearching = false,
    this.searchQuery = '',
    this.error,
  });

  TricksAndTrainingsState copyWith({
    List<TricksAndTrainingUIModel>? videos,

    List<TricksAndTrainingUIModel>? trainings,

    List<TricksAndTrainingUIModel>? tips,

    List<TricksAndTrainingUIModel>? searchResults,

    List<TricksAndTrainingUIModel>? listingItems,

    bool? isListingLoading,

    bool? isLoadingMore,

    bool? hasNextPage,

    int? currentPage,

    String? selectedContentType,

    TricksAndTrainingUIModel? selectedContent,

    bool? isDetailsLoading,

    List<TricksAndTrainingUIModel>? moreLikeThis,

    List<TricksAndTrainingUIModel>? relatedContent,

    Map<String, List<TricksAndTrainingUIModel>>? relatedContentCache,

    bool? isMoreLikeThisLoading,

    bool? isRelatedContentLoading,

    String? selectedRelatedTab,

    bool? isLoading,

    bool? isSearching,

    String? searchQuery,

    String? error,
  }) {
    return TricksAndTrainingsState(
      videos: videos ?? this.videos,

      trainings: trainings ?? this.trainings,

      tips: tips ?? this.tips,

      searchResults: searchResults ?? this.searchResults,

      listingItems: listingItems ?? this.listingItems,

      isListingLoading: isListingLoading ?? this.isListingLoading,

      isLoadingMore: isLoadingMore ?? this.isLoadingMore,

      hasNextPage: hasNextPage ?? this.hasNextPage,

      currentPage: currentPage ?? this.currentPage,

      selectedContentType: selectedContentType ?? this.selectedContentType,

      selectedContent: selectedContent ?? this.selectedContent,

      isDetailsLoading: isDetailsLoading ?? this.isDetailsLoading,

      moreLikeThis: moreLikeThis ?? this.moreLikeThis,

      relatedContent: relatedContent ?? this.relatedContent,

      relatedContentCache: relatedContentCache ?? this.relatedContentCache,

      isMoreLikeThisLoading:
          isMoreLikeThisLoading ?? this.isMoreLikeThisLoading,

      isRelatedContentLoading:
          isRelatedContentLoading ?? this.isRelatedContentLoading,

      selectedRelatedTab: selectedRelatedTab ?? this.selectedRelatedTab,

      isLoading: isLoading ?? this.isLoading,

      isSearching: isSearching ?? this.isSearching,

      searchQuery: searchQuery ?? this.searchQuery,

      error: error,
    );
  }
}
