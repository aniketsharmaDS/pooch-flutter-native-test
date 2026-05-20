import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_option_ui_model.dart';
import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_question_ui_model.dart';

class GetHelpMessageModel {
  final String id;
  final String text;
  final bool isUser;
  final GetHelpQuestionUIModel? question;
  final List<GetHelpOptionUIModel>? options;
  final bool isCTA;
  final bool isHooray;
  final bool isEmpty;
  final bool isStageSeparator;
  final String? stageTitle;
  final DateTime? createdAt;
  final bool isTyping;

  GetHelpMessageModel({
    required this.id,
    required this.text,
    required this.isUser,
    this.question,
    this.options,
    this.isCTA = false,
    this.isHooray = false,
    this.isEmpty = false,
    this.isStageSeparator = false,
    this.stageTitle,
    this.createdAt,
    this.isTyping = false,
  });
}
