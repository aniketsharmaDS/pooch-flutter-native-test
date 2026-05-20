import 'package:poochcare/core/utils/parser_utils.dart';

class ExpenseMonthlyExpenseModel {
  final int month;

  final String monthName;

  final double amount;

  final int transactions;

  const ExpenseMonthlyExpenseModel({
    required this.month,
    required this.monthName,
    required this.amount,
    required this.transactions,
  });

  factory ExpenseMonthlyExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseMonthlyExpenseModel(
      month: ParserUtils.readInt(map['month']),

      monthName: ParserUtils.readString(map['monthName']),

      amount: ParserUtils.readDouble(map['amount']),

      transactions: ParserUtils.readInt(map['transactions']),
    );
  }
}
