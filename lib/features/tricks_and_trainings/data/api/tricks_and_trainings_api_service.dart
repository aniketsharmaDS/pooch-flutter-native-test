import 'package:dio/dio.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/core/errors/error_mapper.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/tricks_and_trainings/data/models/tricks_and_training_content_model.dart';
import 'package:poochcare/features/tricks_and_trainings/data/models/tricks_and_training_listing_response_model.dart';
import 'package:poochcare/features/tricks_and_trainings/data/models/tricks_and_training_response_model.dart';

class TricksAndTrainingsApiService {
  const TricksAndTrainingsApiService(this._dio);

  final Dio _dio;

  static const _contentPath = '/content/for-my-pets';

  Future<TricksAndTrainingResponseModel> getContentForMyPets({
    String? petId,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        _contentPath,
        queryParameters: {
          if (petId != null && petId.isNotEmpty) 'petId': petId,
        },
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
      return TricksAndTrainingResponseModel.fromMap(ParserUtils.readMap(body));
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  Future<TricksAndTrainingListingResponseModel> getContentListing({
    String? contentType,
    String? petId,
    String? parentId,
    String? search,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        '/content',
        queryParameters: {
          if (contentType != null && contentType.isNotEmpty)
            'contentType': contentType,
          if (parentId != null && parentId.isNotEmpty) 'parentId': parentId,
          if (petId != null && petId.isNotEmpty) 'petId': petId,
          if (search != null && search.isNotEmpty) 'search': search,
          'page': page,
          'limit': limit,
        },
      );

      final dynamic body = response.data;

      return TricksAndTrainingListingResponseModel.fromMap(
        ParserUtils.readMap(body['data']),
      );
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  Future<TricksAndTrainingContentModel> getContentDetails(String id) async {
    try {
      final response = await _dio.get<dynamic>('/content/$id');

      final dynamic body = response.data;

      return TricksAndTrainingContentModel.fromMap(
        ParserUtils.readMap(body['data']),
      );
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }
}
