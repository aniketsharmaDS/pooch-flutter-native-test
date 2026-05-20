import 'package:poochcare/core/utils/parser_utils.dart';

import 'package:poochcare/features/expense_tracker/data/models/expense_pagination_model.dart';

import 'package:poochcare/features/expense_tracker/data/models/expense_transaction_model.dart';

class ExpenseYearlyTransactionsDataModel {
  final String year;

  final List<ExpenseTransactionModel> transactions;

  final double totalAmount;

  final int totalTransactions;

  final String currency;

  final ExpensePaginationModel pagination;

  const ExpenseYearlyTransactionsDataModel({
    required this.year,
    required this.transactions,
    required this.totalAmount,
    required this.totalTransactions,
    required this.currency,
    required this.pagination,
  });

  factory ExpenseYearlyTransactionsDataModel.fromMap(Map<String, dynamic> map) {
    return ExpenseYearlyTransactionsDataModel(
      year: ParserUtils.readString(map['year']),

      transactions: (map['transactions'] as List? ?? [])
          .map((e) => ExpenseTransactionModel.fromMap(ParserUtils.readMap(e)))
          .toList(),

      totalAmount: ParserUtils.readDouble(map['totalAmount']),

      totalTransactions: ParserUtils.readInt(map['totalTransactions']),

      currency: ParserUtils.readString(map['currency']),

      pagination: ExpensePaginationModel.fromMap(
        ParserUtils.readMap(map['pagination']),
      ),
    );
  }
}
