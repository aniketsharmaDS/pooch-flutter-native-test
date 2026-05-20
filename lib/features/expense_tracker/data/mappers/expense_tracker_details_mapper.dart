import 'package:intl/intl.dart';

import 'package:poochcare/features/expense_tracker/data/models/expense_tracker_details_data_model.dart';
import 'package:poochcare/features/expense_tracker/data/models/expense_transaction_model.dart';
import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_tracker_details_ui_model.dart';
import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_transaction_ui_model.dart';

class ExpenseTrackerDetailsMapper {
  static ExpenseTrackerDetailsUIModel toUIModel(
    ExpenseTrackerDetailsDataModel model,
  ) {
    return ExpenseTrackerDetailsUIModel(
      month: model.month,

      year: model.year,

      transactions: model.transactions.map(toTransactionUIModel).toList(),

      totalAmount: model.totalAmount,

      totalTransactions: model.totalTransactions,

      currency: model.currency,

      formattedTotalAmount: _formatCurrency(model.totalAmount),
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
