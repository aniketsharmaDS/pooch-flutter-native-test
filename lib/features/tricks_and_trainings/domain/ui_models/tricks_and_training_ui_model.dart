import 'package:poochcare/features/tricks_and_trainings/domain/ui_models/content_carousel_ui_model.dart';
import 'package:poochcare/features/tricks_and_trainings/domain/ui_models/training_step_ui_model.dart';

class TricksAndTrainingUIModel {
  final String id;

  final String contentType;

  final String title;

  final String description;

  final String shortDescription;

  final String image;

  /// Search badge
  final String badgeTitle;

  /// Video
  final String thumbnail;

  final String videoUrl;

  final String formattedDuration;

  /// Training
  final int numberOfSteps;

  final String stepsText;

  final int sessionDuration;

  final List<TrainingStepUIModel> sessionSteps;

  /// Tips / Trainings
  final List<ContentCarouselUIModel> carousels;

  const TricksAndTrainingUIModel({
    required this.id,
    required this.contentType,
    required this.title,
    required this.description,
    required this.shortDescription,
    required this.image,
    required this.badgeTitle,
    required this.thumbnail,
    required this.videoUrl,
    required this.formattedDuration,
    required this.numberOfSteps,
    required this.stepsText,
    required this.sessionDuration,
    required this.sessionSteps,
    required this.carousels,
  });
}
