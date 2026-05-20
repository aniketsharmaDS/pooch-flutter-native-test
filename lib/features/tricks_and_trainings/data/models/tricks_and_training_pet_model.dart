import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/tricks_and_trainings/data/models/tricks_and_training_pet_content_model.dart';

class TricksAndTrainingPetModel {
  final String petId;
  final String petName;

  final List<String> breedIds;

  final TricksAndTrainingPetContentModel content;

  const TricksAndTrainingPetModel({
    required this.petId,
    required this.petName,
    required this.breedIds,
    required this.content,
  });

  factory TricksAndTrainingPetModel.fromMap(Map<String, dynamic> map) {
    return TricksAndTrainingPetModel(
      petId: ParserUtils.readString(map['petId']),

      petName: ParserUtils.readString(map['petName']),

      breedIds: (map['breedIds'] as List? ?? [])
          .map((e) => ParserUtils.readString(e))
          .toList(),

      content: TricksAndTrainingPetContentModel.fromMap(
        ParserUtils.readMap(map['content']),
      ),
    );
  }
}
