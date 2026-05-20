import 'package:poochcare/core/utils/parser_utils.dart';

class TricksAndTrainingPaginationModel {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  final bool hasNextPage;

  const TricksAndTrainingPaginationModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
    required this.hasNextPage,
  });

  factory TricksAndTrainingPaginationModel.fromMap(Map<String, dynamic> map) {
    return TricksAndTrainingPaginationModel(
      page: ParserUtils.readInt(map['page']),

      limit: ParserUtils.readInt(map['limit']),

      total: ParserUtils.readInt(map['total']),

      totalPages: ParserUtils.readInt(map['totalPages']),

      hasNextPage: ParserUtils.readBool(map['hasNextPage']),
    );
  }
}
