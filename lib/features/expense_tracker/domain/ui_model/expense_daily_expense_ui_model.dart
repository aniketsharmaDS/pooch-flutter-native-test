class ExpenseDailyExpenseUIModel {
  final String date;

  final double amount;

  final int transactions;

  final int day;

  final String formattedAmount;

  const ExpenseDailyExpenseUIModel({
    required this.date,
    required this.amount,
    required this.transactions,
    required this.day,
    required this.formattedAmount,
  });
}
