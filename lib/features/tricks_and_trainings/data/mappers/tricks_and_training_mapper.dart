import 'package:poochcare/features/tricks_and_trainings/data/models/tricks_and_training_carousel_model.dart';
import 'package:poochcare/features/tricks_and_trainings/data/models/tricks_and_training_content_model.dart';
import 'package:poochcare/features/tricks_and_trainings/data/models/tricks_and_training_session_step_model.dart';
import 'package:poochcare/features/tricks_and_trainings/domain/ui_models/content_carousel_ui_model.dart';
import 'package:poochcare/features/tricks_and_trainings/domain/ui_models/training_step_ui_model.dart';
import 'package:poochcare/features/tricks_and_trainings/domain/ui_models/tricks_and_training_ui_model.dart';

class TricksAndTrainingMapper {
  static TricksAndTrainingUIModel toUIModel(
    TricksAndTrainingContentModel model,
  ) {
    return TricksAndTrainingUIModel(
      id: model.id,

      contentType: model.contentType,

      title: model.title,

      description: _stripHtml(model.description),

      shortDescription: _stripHtml(model.shortDescription),

      image: model.image,

      badgeTitle: _getBadgeTitle(model.contentType),

      /// Video
      thumbnail: model.thumbnail,

      videoUrl: model.videoUrl,

      formattedDuration: _formatDuration(model.videoDuration),

      /// Training
      numberOfSteps: model.numberOfSteps,

      stepsText: '${model.numberOfSteps} Step',

      sessionDuration: model.sessionDuration,

      sessionSteps: model.sessionSteps.map(toStepUIModel).toList(),

      /// Tips / Trainings
      carousels: model.carousels.map(toCarouselUIModel).toList(),
    );
  }

  static TrainingStepUIModel toStepUIModel(
    TricksAndTrainingSessionStepModel model,
  ) {
    return TrainingStepUIModel(
      image: model.image,

      title: model.title,

      description: model.description,

      stepNumber: model.stepNumber,

      /// API does not provide progress yet
      isCompleted: false,

      carousels: model.carousels.map(toCarouselUIModel).toList(),
    );
  }

  static ContentCarouselUIModel toCarouselUIModel(
    TricksAndTrainingCarouselModel model,
  ) {
    return ContentCarouselUIModel(
      image: model.image,
      title: model.title,
      description: model.description,
    );
  }

  static String _getBadgeTitle(String type) {
    switch (type.toLowerCase()) {
      case 'video':
        return 'Video';

      case 'training':
        return 'Training Guide';

      case 'tip':
        return 'Tip';

      default:
        return '';
    }
  }

  static String _formatDuration(int seconds) {
    if (seconds <= 0) {
      return '00:00';
    }

    final duration = Duration(seconds: seconds);

    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');

    final secs = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$minutes:$secs';
  }

  static String _stripHtml(String value) {
    return value
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .trim();
  }
}
