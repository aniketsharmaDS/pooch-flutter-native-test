import 'package:poochcare/core/utils/parser_utils.dart';

class GetHelpOptionModel {
  final String id;
  final String key; // 🔥 optionKey
  final String text;

  const GetHelpOptionModel({
    required this.id,
    required this.key,
    required this.text,
  });

  factory GetHelpOptionModel.fromMap(Map<String, dynamic> map) {
    return GetHelpOptionModel(
      id: ParserUtils.readString(map['id']),
      key: ParserUtils.readString(map['optionKey']), // ❗ IMPORTANT
      text: ParserUtils.readString(map['optionText']),
    );
  }
}
