import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_transaction_ui_model.dart';

class ExpenseYearlyTransactionsUIModel {
  final String year;

  final List<ExpenseTransactionUIModel> transactions;

  final double totalAmount;

  final int totalTransactions;

  final String currency;

  final String formattedTotalAmount;

  final int currentPage;

  final int totalPages;

  final bool hasNextPage;

  const ExpenseYearlyTransactionsUIModel({
    required this.year,
    required this.transactions,
    required this.totalAmount,
    required this.totalTransactions,
    required this.currency,
    required this.formattedTotalAmount,
    required this.currentPage,
    required this.totalPages,
    required this.hasNextPage,
  });
}
