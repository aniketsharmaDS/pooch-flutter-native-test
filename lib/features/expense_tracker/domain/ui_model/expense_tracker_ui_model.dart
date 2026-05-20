import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_breakdown_ui_model.dart';
import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_daily_expense_ui_model.dart';
import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_monthly_expense_ui_model.dart';

class ExpenseTrackerUIModel {
  final ExpenseBreakdownUIModel breakdown;

  final List<ExpenseDailyExpenseUIModel> dailyExpenses;

  final List<ExpenseMonthlyExpenseUIModel> monthlyExpenses;

  const ExpenseTrackerUIModel({
    required this.breakdown,
    required this.dailyExpenses,
    required this.monthlyExpenses,
  });
}
