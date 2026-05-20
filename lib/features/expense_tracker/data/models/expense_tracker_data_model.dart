import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/expense_tracker/data/models/expense_breakdown_model.dart';
import 'package:poochcare/features/expense_tracker/data/models/expense_daily_expense_model.dart';
import 'package:poochcare/features/expense_tracker/data/models/expense_monthly_expense_model.dart';

class ExpenseTrackerDataModel {
  final ExpenseBreakdownModel breakdown;

  final List<ExpenseDailyExpenseModel> dailyExpenses;

  final List<ExpenseMonthlyExpenseModel> monthlyExpenses;

  const ExpenseTrackerDataModel({
    required this.breakdown,
    required this.dailyExpenses,
    required this.monthlyExpenses,
  });

  factory ExpenseTrackerDataModel.fromMap(Map<String, dynamic> map) {
    return ExpenseTrackerDataModel(
      breakdown: ExpenseBreakdownModel.fromMap(
        ParserUtils.readMap(map['breakdown']),
      ),

      dailyExpenses: (map['dailyExpenses'] as List? ?? [])
          .map((e) => ExpenseDailyExpenseModel.fromMap(ParserUtils.readMap(e)))
          .toList(),

      monthlyExpenses: (map['monthlyExpenses'] as List? ?? [])
          .map(
            (e) => ExpenseMonthlyExpenseModel.fromMap(ParserUtils.readMap(e)),
          )
          .toList(),
    );
  }
}
