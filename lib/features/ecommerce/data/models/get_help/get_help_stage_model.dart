import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_question_set_model.dart';

class GetHelpStageModel {
  final int stageNumber;
  final String stageName;
  final List<GetHelpQuestionSetModel> questionSets;

  const GetHelpStageModel({
    required this.stageNumber,
    required this.stageName,
    required this.questionSets,
  });

  factory GetHelpStageModel.fromMap(Map<String, dynamic> map) {
    final data = map['data'] ?? map;

    return GetHelpStageModel(
      stageNumber: ParserUtils.readInt(data['stageNumber']),
      stageName: ParserUtils.readString(data['stageName']),
      questionSets: (data['questionSets'] as List? ?? [])
          .map((e) => GetHelpQuestionSetModel.fromMap(ParserUtils.readMap(e)))
          .toList(),
    );
  }
}
