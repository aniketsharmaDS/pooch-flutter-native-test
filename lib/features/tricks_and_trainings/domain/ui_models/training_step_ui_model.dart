import 'package:poochcare/features/tricks_and_trainings/domain/ui_models/content_carousel_ui_model.dart';

class TrainingStepUIModel {
  final String image;
  final String title;
  final String description;

  final int stepNumber;

  final bool isCompleted;

  final List<ContentCarouselUIModel> carousels;

  const TrainingStepUIModel({
    required this.image,
    required this.title,
    required this.description,
    required this.stepNumber,
    required this.isCompleted,
    required this.carousels,
  });
}
