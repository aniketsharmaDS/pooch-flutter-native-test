import 'package:poochcare/core/utils/parser_utils.dart';

class ExpenseCategoryModel {
  final String category;

  final double amount;

  final int count;

  const ExpenseCategoryModel({
    required this.category,
    required this.amount,
    required this.count,
  });

  factory ExpenseCategoryModel.fromMap(Map<String, dynamic> map) {
    return ExpenseCategoryModel(
      category: ParserUtils.readString(map['category']),

      amount: ParserUtils.readDouble(map['amount']),

      count: ParserUtils.readInt(map['count']),
    );
  }
}
