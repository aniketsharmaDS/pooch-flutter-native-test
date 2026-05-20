import 'package:poochcare/core/utils/parser_utils.dart';

class TricksAndTrainingCarouselModel {
  final String image;
  final String title;
  final String description;

  const TricksAndTrainingCarouselModel({
    required this.image,
    required this.title,
    required this.description,
  });

  factory TricksAndTrainingCarouselModel.fromMap(Map<String, dynamic> map) {
    return TricksAndTrainingCarouselModel(
      image: ParserUtils.readString(map['image']),
      title: ParserUtils.readString(map['title']),
      description: ParserUtils.readString(map['description']),
    );
  }
}
