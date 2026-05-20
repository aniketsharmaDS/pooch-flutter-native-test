import 'package:poochcare/features/community/data/models/tips_category_model.dart';

abstract class CommunityStoreEvent {
  const CommunityStoreEvent();
}

/// UPSERT categories
class CommunityCategoriesUpserted extends CommunityStoreEvent {
  final List<TipsCategoryModel> categories;

  const CommunityCategoriesUpserted(this.categories);
}

/// CLEAR (logout)
class CommunityCleared extends CommunityStoreEvent {
  const CommunityCleared();
}
