import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/expense_tracker/data/models/expense_category_model.dart';

class ExpenseBreakdownModel {
  final double total;

  final List<ExpenseCategoryModel> categories;

  final String currency;

  const ExpenseBreakdownModel({
    required this.total,
    required this.categories,
    required this.currency,
  });

  factory ExpenseBreakdownModel.fromMap(Map<String, dynamic> map) {
    return ExpenseBreakdownModel(
      total: ParserUtils.readDouble(map['total']),

      categories: (map['categories'] as List? ?? [])
          .map((e) => ExpenseCategoryModel.fromMap(ParserUtils.readMap(e)))
          .toList(),

      currency: ParserUtils.readString(map['currency']),
    );
  }
}
