import 'package:intl/intl.dart';

import 'package:poochcare/features/expense_tracker/data/models/expense_breakdown_model.dart';
import 'package:poochcare/features/expense_tracker/data/models/expense_category_model.dart';
import 'package:poochcare/features/expense_tracker/data/models/expense_daily_expense_model.dart';
import 'package:poochcare/features/expense_tracker/data/models/expense_monthly_expense_model.dart';
import 'package:poochcare/features/expense_tracker/data/models/expense_tracker_data_model.dart';
import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_breakdown_ui_model.dart';
import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_category_ui_model.dart';
import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_daily_expense_ui_model.dart';
import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_monthly_expense_ui_model.dart';
import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_tracker_ui_model.dart';

class ExpenseTrackerMapper {
  static ExpenseTrackerUIModel toUIModel(ExpenseTrackerDataModel model) {
    return ExpenseTrackerUIModel(
      breakdown: toBreakdownUIModel(model.breakdown),

      dailyExpenses: model.dailyExpenses.map(toDailyExpenseUIModel).toList(),

      monthlyExpenses: model.monthlyExpenses
          .map(toMonthlyExpenseUIModel)
          .toList(),
    );
  }

  static ExpenseBreakdownUIModel toBreakdownUIModel(
    ExpenseBreakdownModel model,
  ) {
    return ExpenseBreakdownUIModel(
      total: model.total,

      formattedTotal: _formatCurrency(model.total),

      currency: model.currency.toUpperCase(),

      categories: model.categories.map(toCategoryUIModel).toList(),
    );
  }

  static ExpenseCategoryUIModel toCategoryUIModel(ExpenseCategoryModel model) {
    return ExpenseCategoryUIModel(
      category: model.category,

      amount: model.amount,

      count: model.count,

      formattedAmount: _formatCurrency(model.amount),
    );
  }

  static ExpenseDailyExpenseUIModel toDailyExpenseUIModel(
    ExpenseDailyExpenseModel model,
  ) {
    final parsedDate = DateTime.tryParse(model.date);

    return ExpenseDailyExpenseUIModel(
      date: model.date,

      amount: model.amount,

      transactions: model.transactions,

      day: parsedDate?.day ?? 0,

      formattedAmount: _formatCurrency(model.amount),
    );
  }

  static ExpenseMonthlyExpenseUIModel toMonthlyExpenseUIModel(
    ExpenseMonthlyExpenseModel model,
  ) {
    return ExpenseMonthlyExpenseUIModel(
      month: model.month,

      monthName: model.monthName,

      amount: model.amount,

      transactions: model.transactions,

      formattedAmount: _formatCurrency(model.amount),

      shortMonthName: model.monthName.substring(0, 3),
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
