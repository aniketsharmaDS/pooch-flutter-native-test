abstract class CategoriesEvent {
  const CategoriesEvent();
}

/// Trigger API call
class FetchCategories extends CategoriesEvent {
  const FetchCategories();
}
