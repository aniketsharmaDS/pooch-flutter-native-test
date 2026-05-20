import 'package:poochcare/features/community/data/models/tips_category_model.dart';

class CommunityStoreState {
  final Map<String, TipsCategoryModel> categoriesById;
  final List<String> categoryIds;

  const CommunityStoreState({
    this.categoriesById = const {},
    this.categoryIds = const [],
  });

  CommunityStoreState copyWith({
    Map<String, TipsCategoryModel>? categoriesById,
    List<String>? categoryIds,
  }) {
    return CommunityStoreState(
      categoriesById: categoriesById ?? this.categoriesById,
      categoryIds: categoryIds ?? this.categoryIds,
    );
  }
}
