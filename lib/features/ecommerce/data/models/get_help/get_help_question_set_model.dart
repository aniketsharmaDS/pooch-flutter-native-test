import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_question_model.dart';

class GetHelpQuestionSetModel {
  final List<GetHelpQuestionModel> questions;

  const GetHelpQuestionSetModel({required this.questions});

  factory GetHelpQuestionSetModel.fromMap(Map<String, dynamic> map) {
    return GetHelpQuestionSetModel(
      questions: (map['questions'] as List? ?? [])
          .map((e) => GetHelpQuestionModel.fromMap(ParserUtils.readMap(e)))
          .toList(),
    );
  }
}
