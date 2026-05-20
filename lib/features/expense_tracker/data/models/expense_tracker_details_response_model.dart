import 'package:poochcare/core/utils/parser_utils.dart';

import 'package:poochcare/features/expense_tracker/data/models/expense_tracker_details_data_model.dart';

class ExpenseTrackerDetailsResponseModel {
  final bool success;

  final String message;

  final int status;

  final ExpenseTrackerDetailsDataModel data;

  const ExpenseTrackerDetailsResponseModel({
    required this.success,
    required this.message,
    required this.status,
    required this.data,
  });

  factory ExpenseTrackerDetailsResponseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseTrackerDetailsResponseModel(
      success: ParserUtils.readBool(map['success']),

      message: ParserUtils.readString(map['message']),

      status: ParserUtils.readInt(map['status']),

      data: ExpenseTrackerDetailsDataModel.fromMap(
        ParserUtils.readMap(map['data']),
      ),
    );
  }
}
