import 'package:poochcare/core/utils/parser_utils.dart';

class ExpenseTransactionModel {
  final String name;

  final String date;

  final String time;

  final double amount;

  final String currency;

  final String category;

  const ExpenseTransactionModel({
    required this.name,
    required this.date,
    required this.time,
    required this.amount,
    required this.currency,
    required this.category,
  });

  factory ExpenseTransactionModel.fromMap(Map<String, dynamic> map) {
    return ExpenseTransactionModel(
      name: ParserUtils.readString(map['name']),

      date: ParserUtils.readString(map['date']),

      time: ParserUtils.readString(map['time']),

      amount: ParserUtils.readDouble(map['amount']),

      currency: ParserUtils.readString(map['currency']),

      category: ParserUtils.readString(map['category']),
    );
  }
}
