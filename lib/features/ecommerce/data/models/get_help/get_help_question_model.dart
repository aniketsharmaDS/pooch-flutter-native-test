import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_option_model.dart';

class GetHelpQuestionModel {
  final String id;
  final String text;
  final List<GetHelpOptionModel> options;

  const GetHelpQuestionModel({
    required this.id,
    required this.text,
    required this.options,
  });

  factory GetHelpQuestionModel.fromMap(Map<String, dynamic> map) {
    return GetHelpQuestionModel(
      id: ParserUtils.readString(map['id']),
      text: ParserUtils.readString(map['questionText']),
      options: (map['options'] as List? ?? [])
          .map((e) => GetHelpOptionModel.fromMap(ParserUtils.readMap(e)))
          .toList(),
    );
  }
}
