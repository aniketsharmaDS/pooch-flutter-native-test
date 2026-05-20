abstract class TricksAndTrainingsEvent {}

class LoadTricksAndTrainings extends TricksAndTrainingsEvent {
  final String? petId;

  LoadTricksAndTrainings({this.petId});
}

class SearchTricksAndTrainings extends TricksAndTrainingsEvent {
  final String query;

  SearchTricksAndTrainings(this.query);
}

class ClearSearch extends TricksAndTrainingsEvent {}

class LoadListingContent extends TricksAndTrainingsEvent {
  final String contentType;
  final String? petId;

  final bool loadMore;

  LoadListingContent({
    required this.contentType,
    this.petId,
    this.loadMore = false,
  });
}

class LoadContentDetails extends TricksAndTrainingsEvent {
  final String id;

  LoadContentDetails(this.id);
}

class LoadMoreLikeThis extends TricksAndTrainingsEvent {
  final String parentId;
  final String contentType;

  LoadMoreLikeThis(this.parentId, this.contentType);
}

class LoadRelatedContent extends TricksAndTrainingsEvent {
  final String parentId;

  final String contentType;

  LoadRelatedContent({required this.parentId, required this.contentType});
}

class SearchContent extends TricksAndTrainingsEvent {
  final String query;

  SearchContent({required this.query});
}
