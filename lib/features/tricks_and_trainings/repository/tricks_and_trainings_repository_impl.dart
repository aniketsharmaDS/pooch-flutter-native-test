import 'package:poochcare/features/tricks_and_trainings/data/api/tricks_and_trainings_api_service.dart';
import 'package:poochcare/features/tricks_and_trainings/data/mappers/tricks_and_training_mapper.dart';
import 'package:poochcare/features/tricks_and_trainings/domain/repository/tricks_and_trainings_repository.dart';
import 'package:poochcare/features/tricks_and_trainings/domain/ui_models/tricks_and_training_listing_ui_model.dart';
import 'package:poochcare/features/tricks_and_trainings/domain/ui_models/tricks_and_training_ui_model.dart';
import 'package:poochcare/features/tricks_and_trainings/domain/ui_models/tricks_and_trainings_home_ui_model.dart';

class TricksAndTrainingsRepositoryImpl implements TricksAndTrainingsRepository {
  final TricksAndTrainingsApiService _api;

  const TricksAndTrainingsRepositoryImpl(this._api);

  @override
  Future<TricksAndTrainingsHomeUIModel> getHomeContent({String? petId}) async {
    final response = await _api.getContentForMyPets(petId: petId);

    if (response.data.isEmpty) {
      return const TricksAndTrainingsHomeUIModel(
        videos: [],
        trainings: [],
        tips: [],
      );
    }

    final content = response.data.first.content;

    return TricksAndTrainingsHomeUIModel(
      videos: content.videos.map(TricksAndTrainingMapper.toUIModel).toList(),

      trainings: content.trainings
          .map(TricksAndTrainingMapper.toUIModel)
          .toList(),

      tips: content.tips.map(TricksAndTrainingMapper.toUIModel).toList(),
    );
  }

  @override
  Future<TricksAndTrainingListingUIModel> getContentListing({
    String? contentType,
    String? petId,
    String? parentId,
    String? search,
    int page = 1,
  }) async {
    final response = await _api.getContentListing(
      contentType: contentType,
      parentId: parentId,
      petId: petId,
      search: search,
      page: page,
    );

    return TricksAndTrainingListingUIModel(
      items: response.content.map(TricksAndTrainingMapper.toUIModel).toList(),

      page: response.pagination.page,

      totalPages: response.pagination.totalPages,

      hasNextPage: response.pagination.hasNextPage,
    );
  }

  @override
  Future<TricksAndTrainingUIModel> getContentDetails(String id) async {
    final response = await _api.getContentDetails(id);

    return TricksAndTrainingMapper.toUIModel(response);
  }

  @override
  Future<List<TricksAndTrainingUIModel>> getAllContent() async {
    final response = await _api.getContentForMyPets();
    if (response.data.isEmpty) {
      return [];
    }

    final content = response.data.first.content;

    final all = [...content.videos, ...content.trainings, ...content.tips];

    return all.map(TricksAndTrainingMapper.toUIModel).toList();
  }
}
