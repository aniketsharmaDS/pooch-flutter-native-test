import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/tricks_and_trainings/data/models/tricks_and_training_pet_model.dart';

class TricksAndTrainingResponseModel {
  final bool success;
  final String message;
  final int status;

  final List<TricksAndTrainingPetModel> data;

  const TricksAndTrainingResponseModel({
    required this.success,
    required this.message,
    required this.status,
    required this.data,
  });

  factory TricksAndTrainingResponseModel.fromMap(Map<String, dynamic> map) {
    return TricksAndTrainingResponseModel(
      success: ParserUtils.readBool(map['success']),

      message: ParserUtils.readString(map['message']),

      status: ParserUtils.readInt(map['status']),

      data: (map['data'] as List? ?? [])
          .map((e) => TricksAndTrainingPetModel.fromMap(ParserUtils.readMap(e)))
          .toList(),
    );
  }
}
