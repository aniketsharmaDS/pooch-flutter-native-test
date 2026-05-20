import 'package:poochcare/core/utils/parser_utils.dart';

import 'package:poochcare/features/expense_tracker/data/models/expense_transaction_model.dart';

class ExpenseTrackerDetailsDataModel {
  final String month;

  final String year;

  final List<ExpenseTransactionModel> transactions;

  final double totalAmount;

  final int totalTransactions;

  final String currency;

  const ExpenseTrackerDetailsDataModel({
    required this.month,
    required this.year,
    required this.transactions,
    required this.totalAmount,
    required this.totalTransactions,
    required this.currency,
  });

  factory ExpenseTrackerDetailsDataModel.fromMap(Map<String, dynamic> map) {
    return ExpenseTrackerDetailsDataModel(
      month: ParserUtils.readString(map['month']),

      year: ParserUtils.readString(map['year']),

      transactions: (map['transactions'] as List? ?? [])
          .map((e) => ExpenseTransactionModel.fromMap(ParserUtils.readMap(e)))
          .toList(),

      totalAmount: ParserUtils.readDouble(map['totalAmount']),

      totalTransactions: ParserUtils.readInt(map['totalTransactions']),

      currency: ParserUtils.readString(map['currency']),
    );
  }
}
