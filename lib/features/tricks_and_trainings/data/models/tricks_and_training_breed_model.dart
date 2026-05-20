import 'package:poochcare/core/utils/parser_utils.dart';

class TricksAndTrainingBreedModel {
  final String id;
  final String breedName;
  final String petType;

  const TricksAndTrainingBreedModel({
    required this.id,
    required this.breedName,
    required this.petType,
  });

  factory TricksAndTrainingBreedModel.fromMap(Map<String, dynamic> map) {
    return TricksAndTrainingBreedModel(
      id: ParserUtils.readString(map['id']),
      breedName: ParserUtils.readString(map['breedName']),
      petType: ParserUtils.readString(map['petType']),
    );
  }
}
