import 'package:dio/dio.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/core/errors/error_mapper.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/ecommerce/data/models/buy_pet/product_response_model.dart';
import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_stage_model.dart';
import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_stage_submit_response.dart';

class GetHelpApiService {
  const GetHelpApiService(this._dio);

  final Dio _dio;

  static const _startPath = '/questionnaire/start';
  static const _stageQuestionsPath = '/questionnaire/stages';
  static const _submitStagePath = '/questionnaire/sessions';
  static const _recommendationsPath = '/questionnaire/sessions';

  /// 🔹 Start session
  Future<String> startSession() async {
    try {
      final response = await _dio.post<dynamic>(_startPath);

      final body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(envelope.message);
      }

      final payload = envelope?.data ?? body;

      final sessionId = ParserUtils.readMap(payload)['session']?['id'];

      return ParserUtils.readString(sessionId);
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  /// 🔹 Get stage questions
  Future<GetHelpStageModel> getStageQuestions({
    required int stage,
    String? petContext,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        '$_stageQuestionsPath/$stage/questions',
        queryParameters: {'petContext': ?petContext},
      );

      final dynamic body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(envelope.message);
      }

      final payload = envelope?.data ?? body;

      return GetHelpStageModel.fromMap(ParserUtils.readMap(payload));
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  /// 🔹 Submit stage
  Future<GetHelpStageSubmitResponse> submitStage({
    required String sessionId,
    required int stage,
    required Map<String, String> answers,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        '$_submitStagePath/$sessionId/stages/$stage',
        data: {'answers': answers},
      );

      final dynamic body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(envelope.message);
      }

      final payload = envelope?.data ?? body;

      return GetHelpStageSubmitResponse.fromMap(ParserUtils.readMap(payload));
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  Future<ProductResponseModel> getRecommendations({
    required String sessionId,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        '$_recommendationsPath/$sessionId/recommendation',
      );

      final dynamic body = response.data;

      final envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(envelope.message);
      }

      final payload = envelope?.data ?? body;

      return ProductResponseModel.fromMap(ParserUtils.readMap(payload));
    } catch (e) {
      rethrow;
    }
  }
}
