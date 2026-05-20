import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_option_ui_model.dart';
import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_question_ui_model.dart';

abstract class GetHelpEvent {}

class StartGetHelp extends GetHelpEvent {}

class SelectOption extends GetHelpEvent {
  final GetHelpQuestionUIModel question;
  final GetHelpOptionUIModel option;

  SelectOption(this.question, this.option);
}

class SubmitStage extends GetHelpEvent {}

class LoadStage extends GetHelpEvent {
  final int stage;
  final String? petContext;

  LoadStage(this.stage, this.petContext);
}

class FetchRecommendations extends GetHelpEvent {}

class OpenRecommendations extends GetHelpEvent {}
