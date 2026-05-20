import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/expense_tracker/data/models/expense_tracker_data_model.dart';

class ExpenseTrackerResponseModel {
  final bool success;
  final String message;
  final int status;

  final ExpenseTrackerDataModel data;

  const ExpenseTrackerResponseModel({
    required this.success,
    required this.message,
    required this.status,
    required this.data,
  });

  factory ExpenseTrackerResponseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseTrackerResponseModel(
      success: ParserUtils.readBool(map['success']),

      message: ParserUtils.readString(map['message']),

      status: ParserUtils.readInt(map['status']),

      data: ExpenseTrackerDataModel.fromMap(ParserUtils.readMap(map['data'])),
    );
  }
}
