import 'package:poochcare/features/tricks_and_trainings/domain/ui_models/tricks_and_training_ui_model.dart';

class TricksAndTrainingListingUIModel {
  final List<TricksAndTrainingUIModel> items;

  final int page;

  final int totalPages;

  final bool hasNextPage;

  const TricksAndTrainingListingUIModel({
    required this.items,
    required this.page,
    required this.totalPages,
    required this.hasNextPage,
  });
}
