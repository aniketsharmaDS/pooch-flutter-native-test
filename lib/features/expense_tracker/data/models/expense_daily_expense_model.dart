import 'package:poochcare/core/utils/parser_utils.dart';

class ExpenseDailyExpenseModel {
  final String date;

  final double amount;

  final int transactions;

  const ExpenseDailyExpenseModel({
    required this.date,
    required this.amount,
    required this.transactions,
  });

  factory ExpenseDailyExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseDailyExpenseModel(
      date: ParserUtils.readString(map['date']),

      amount: ParserUtils.readDouble(map['amount']),

      transactions: ParserUtils.readInt(map['transactions']),
    );
  }
}
