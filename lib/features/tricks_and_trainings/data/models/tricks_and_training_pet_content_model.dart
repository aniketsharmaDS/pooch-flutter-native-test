import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/tricks_and_trainings/data/models/tricks_and_training_content_model.dart';

class TricksAndTrainingPetContentModel {
  final List<TricksAndTrainingContentModel> tips;

  final List<TricksAndTrainingContentModel> trainings;

  final List<TricksAndTrainingContentModel> videos;

  const TricksAndTrainingPetContentModel({
    required this.tips,
    required this.trainings,
    required this.videos,
  });

  factory TricksAndTrainingPetContentModel.fromMap(Map<String, dynamic> map) {
    return TricksAndTrainingPetContentModel(
      tips: (map['tips'] as List? ?? [])
          .map(
            (e) =>
                TricksAndTrainingContentModel.fromMap(ParserUtils.readMap(e)),
          )
          .toList(),

      trainings: (map['trainings'] as List? ?? [])
          .map(
            (e) =>
                TricksAndTrainingContentModel.fromMap(ParserUtils.readMap(e)),
          )
          .toList(),

      videos: (map['videos'] as List? ?? [])
          .map(
            (e) =>
                TricksAndTrainingContentModel.fromMap(ParserUtils.readMap(e)),
          )
          .toList(),
    );
  }
}
