import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_category_ui_model.dart';

class ExpenseBreakdownUIModel {
  final double total;

  final String formattedTotal;

  final String currency;

  final List<ExpenseCategoryUIModel> categories;

  const ExpenseBreakdownUIModel({
    required this.total,
    required this.formattedTotal,
    required this.currency,
    required this.categories,
  });
}
