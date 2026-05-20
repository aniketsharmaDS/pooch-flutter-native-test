import 'package:intl/intl.dart';

import 'package:poochcare/features/expense_tracker/data/models/expense_transaction_model.dart';

import 'package:poochcare/features/expense_tracker/data/models/expense_yearly_transactions_data_model.dart';
import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_transaction_ui_model.dart';
import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_yearly_transactions_ui_model.dart';

class ExpenseYearlyTransactionsMapper {
  static ExpenseYearlyTransactionsUIModel toUIModel(
    ExpenseYearlyTransactionsDataModel model,
  ) {
    return ExpenseYearlyTransactionsUIModel(
      year: model.year,

      transactions: model.transactions.map(toTransactionUIModel).toList(),

      totalAmount: model.totalAmount,

      totalTransactions: model.totalTransactions,

      currency: model.currency,

      formattedTotalAmount: _formatCurrency(model.totalAmount),

      currentPage: model.pagination.currentPage,

      totalPages: model.pagination.totalPages,

      hasNextPage: model.pagination.hasNextPage,
    );
  }

  static ExpenseTransactionUIModel toTransactionUIModel(
    ExpenseTransactionModel model,
  ) {
    return ExpenseTransactionUIModel(
      name: model.name,

      date: model.date,

      time: model.time,

      amount: model.amount,

      currency: model.currency,

      category: model.category,

      formattedAmount: _formatCurrency(model.amount),

      formattedDateTime: '${model.date}, ${model.time}',
    );
  }

  static String _formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: 'INR ',
      decimalDigits: 0,
    );

    return formatter.format(amount);
  }
}
