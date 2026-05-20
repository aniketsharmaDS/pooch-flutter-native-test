import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_transaction_ui_model.dart';

class ExpenseTrackerDetailsUIModel {
  final String month;

  final String year;

  final List<ExpenseTransactionUIModel> transactions;

  final double totalAmount;

  final int totalTransactions;

  final String currency;

  final String formattedTotalAmount;

  const ExpenseTrackerDetailsUIModel({
    required this.month,
    required this.year,
    required this.transactions,
    required this.totalAmount,
    required this.totalTransactions,
    required this.currency,
    required this.formattedTotalAmount,
  });
}
