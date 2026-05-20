import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_option_ui_model.dart';

class GetHelpQuestionUIModel {
  final String id;
  final String question;
  final List<GetHelpOptionUIModel> options;

  const GetHelpQuestionUIModel({
    required this.id,
    required this.question,
    required this.options,
  });
}
