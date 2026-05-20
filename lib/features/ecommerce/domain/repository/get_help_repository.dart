import 'package:poochcare/features/ecommerce/data/api/get_help_api_service.dart';
import 'package:poochcare/features/ecommerce/data/models/buy_pet/product_response_model.dart';
import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_question_ui_model.dart';
import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_stage_submit_response.dart';

abstract class GetHelpRepository {
  GetHelpRepository(GetHelpApiService getHelpApiService);

  Future<String> startSession();

  Future<List<GetHelpQuestionUIModel>> getStageQuestions({
    required int stage,
    String? petContext,
  });

  Future<GetHelpStageSubmitResponse> submitStage({
    required String sessionId,
    required int stage,
    required Map<String, String> answers,
  });

  Future<ProductResponseModel> getRecommendations({required String sessionId});
}
