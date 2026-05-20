import 'package:poochcare/features/ecommerce/data/api/get_help_api_service.dart';
import 'package:poochcare/features/ecommerce/data/mappers/get_help/get_help_mapper.dart';
import 'package:poochcare/features/ecommerce/data/models/buy_pet/product_response_model.dart';
import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_question_ui_model.dart';
import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_stage_submit_response.dart';
import 'package:poochcare/features/ecommerce/domain/repository/get_help_repository.dart';

class GetHelpRepositoryImpl implements GetHelpRepository {
  final GetHelpApiService _api;

  const GetHelpRepositoryImpl(this._api);

  @override
  Future<String> startSession() {
    return _api.startSession();
  }

  @override
  Future<List<GetHelpQuestionUIModel>> getStageQuestions({
    required int stage,
    String? petContext,
  }) async {
    final dto = await _api.getStageQuestions(
      stage: stage,
      petContext: petContext,
    );

    return GetHelpMapper.toUI(dto);
  }

  @override
  Future<GetHelpStageSubmitResponse> submitStage({
    required String sessionId,
    required int stage,
    required Map<String, String> answers,
  }) {
    return _api.submitStage(
      sessionId: sessionId,
      stage: stage,
      answers: answers,
    );
  }

  @override
  Future<ProductResponseModel> getRecommendations({required String sessionId}) {
    return _api.getRecommendations(sessionId: sessionId);
  }
}
