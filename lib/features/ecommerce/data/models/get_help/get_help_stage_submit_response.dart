import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_stage_model.dart';

class GetHelpStageSubmitResponse {
  final String status;
  final int? nextStage;
  final String? petContext;
  final GetHelpStageModel? nextStageData;

  const GetHelpStageSubmitResponse({
    required this.status,
    this.nextStage,
    this.petContext,
    this.nextStageData,
  });

  factory GetHelpStageSubmitResponse.fromMap(Map<String, dynamic> map) {
    final data = map['data'] ?? map;

    return GetHelpStageSubmitResponse(
      status: ParserUtils.readString(data['status']),
      nextStage: ParserUtils.readNullableInt(data['nextStage']),
      petContext: ParserUtils.readNullableString(data['petContext']),
      nextStageData: data['questions'] != null
          ? GetHelpStageModel.fromMap(ParserUtils.readMap(data['questions']))
          : null,
    );
  }
}
