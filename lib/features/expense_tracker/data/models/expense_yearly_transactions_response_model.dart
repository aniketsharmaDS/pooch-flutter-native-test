import 'package:poochcare/core/utils/parser_utils.dart';

import 'package:poochcare/features/expense_tracker/data/models/expense_yearly_transactions_data_model.dart';

class ExpenseYearlyTransactionsResponseModel {
  final bool success;

  final String message;

  final int status;

  final ExpenseYearlyTransactionsDataModel data;

  const ExpenseYearlyTransactionsResponseModel({
    required this.success,
    required this.message,
    required this.status,
    required this.data,
  });

  factory ExpenseYearlyTransactionsResponseModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return ExpenseYearlyTransactionsResponseModel(
      success: ParserUtils.readBool(map['success']),

      message: ParserUtils.readString(map['message']),

      status: ParserUtils.readInt(map['status']),

      data: ExpenseYearlyTransactionsDataModel.fromMap(
        ParserUtils.readMap(map['data']),
      ),
    );
  }
}
