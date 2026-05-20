abstract class CategoriesState {
  const CategoriesState();
}

/// Initial state (nothing happened yet)
class CategoriesInitial extends CategoriesState {
  const CategoriesInitial();
}

/// While API is loading
class CategoriesLoading extends CategoriesState {
  const CategoriesLoading();
}

/// API success (data already goes to Store)
class CategoriesSuccess extends CategoriesState {
  const CategoriesSuccess();
}

/// API failed
class CategoriesError extends CategoriesState {
  final String message;

  const CategoriesError(this.message);
}
