import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/tricks_and_trainings/data/models/tricks_and_training_content_model.dart';
import 'package:poochcare/features/tricks_and_trainings/data/models/tricks_and_training_pagination_model.dart';

class TricksAndTrainingListingResponseModel {
  final List<TricksAndTrainingContentModel> content;

  final TricksAndTrainingPaginationModel pagination;

  const TricksAndTrainingListingResponseModel({
    required this.content,
    required this.pagination,
  });

  factory TricksAndTrainingListingResponseModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return TricksAndTrainingListingResponseModel(
      content: (map['content'] as List? ?? [])
          .map(
            (e) =>
                TricksAndTrainingContentModel.fromMap(ParserUtils.readMap(e)),
          )
          .toList(),

      pagination: TricksAndTrainingPaginationModel.fromMap(
        ParserUtils.readMap(map['pagination']),
      ),
    );
  }
}
