class ExpenseTransactionUIModel {
  final String name;

  final String date;

  final String time;

  final double amount;

  final String currency;

  final String category;

  final String formattedAmount;

  final String formattedDateTime;

  const ExpenseTransactionUIModel({
    required this.name,
    required this.date,
    required this.time,
    required this.amount,
    required this.currency,
    required this.category,
    required this.formattedAmount,
    required this.formattedDateTime,
  });
}
