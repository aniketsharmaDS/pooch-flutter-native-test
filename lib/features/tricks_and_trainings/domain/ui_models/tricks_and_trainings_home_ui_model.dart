import 'package:poochcare/features/tricks_and_trainings/domain/ui_models/tricks_and_training_ui_model.dart';

class TricksAndTrainingsHomeUIModel {
  final List<TricksAndTrainingUIModel> videos;

  final List<TricksAndTrainingUIModel> trainings;

  final List<TricksAndTrainingUIModel> tips;

  const TricksAndTrainingsHomeUIModel({
    required this.videos,
    required this.trainings,
    required this.tips,
  });
}
