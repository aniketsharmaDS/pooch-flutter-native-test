import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/tricks_and_trainings/data/models/tricks_and_training_carousel_model.dart';

class TricksAndTrainingSessionStepModel {
  final String image;
  final String title;
  final String description;
  final int stepNumber;

  final List<TricksAndTrainingCarouselModel> carousels;

  const TricksAndTrainingSessionStepModel({
    required this.image,
    required this.title,
    required this.description,
    required this.stepNumber,
    required this.carousels,
  });

  factory TricksAndTrainingSessionStepModel.fromMap(Map<String, dynamic> map) {
    return TricksAndTrainingSessionStepModel(
      image: ParserUtils.readString(map['image']),

      title: ParserUtils.readString(map['title']),

      description: ParserUtils.readString(map['description']),

      stepNumber: ParserUtils.readInt(map['stepNumber']),

      carousels: (map['carousels'] as List? ?? [])
          .map(
            (e) =>
                TricksAndTrainingCarouselModel.fromMap(ParserUtils.readMap(e)),
          )
          .toList(),
    );
  }
}
