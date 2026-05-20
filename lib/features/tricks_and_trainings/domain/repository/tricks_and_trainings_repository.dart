import 'package:poochcare/features/tricks_and_trainings/data/api/tricks_and_trainings_api_service.dart';
import 'package:poochcare/features/tricks_and_trainings/domain/ui_models/tricks_and_training_listing_ui_model.dart';
import 'package:poochcare/features/tricks_and_trainings/domain/ui_models/tricks_and_training_ui_model.dart';
import 'package:poochcare/features/tricks_and_trainings/domain/ui_models/tricks_and_trainings_home_ui_model.dart';

abstract class TricksAndTrainingsRepository {
  TricksAndTrainingsRepository(TricksAndTrainingsApiService apiService);

  Future<TricksAndTrainingsHomeUIModel> getHomeContent({String? petId});

  Future<TricksAndTrainingListingUIModel> getContentListing({
    String? contentType,
    String? parentId,
    String? petId,
    int page = 1,
    String? search,
  });

  Future<TricksAndTrainingUIModel> getContentDetails(String id);

  Future<List<TricksAndTrainingUIModel>> getAllContent();
}
