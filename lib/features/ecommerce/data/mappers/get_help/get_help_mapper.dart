import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_option_ui_model.dart';
import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_question_ui_model.dart';
import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_stage_model.dart';

class GetHelpMapper {
  const GetHelpMapper._();

  static List<GetHelpQuestionUIModel> toUI(GetHelpStageModel dto) {
    return dto.questionSets
        .expand((set) => set.questions)
        .map(
          (q) => GetHelpQuestionUIModel(
            id: q.id,
            question: q.text,
            options: q.options
                .map(
                  (o) => GetHelpOptionUIModel(
                    id: o.id,
                    key: o.key, // 🔥 CRITICAL
                    text: o.text,
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }
}
