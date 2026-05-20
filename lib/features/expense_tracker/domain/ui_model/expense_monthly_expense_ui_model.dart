class ExpenseMonthlyExpenseUIModel {
  final int month;

  final String monthName;

  final double amount;

  final int transactions;

  final String formattedAmount;

  final String shortMonthName;

  const ExpenseMonthlyExpenseUIModel({
    required this.month,
    required this.monthName,
    required this.amount,
    required this.transactions,
    required this.formattedAmount,
    required this.shortMonthName,
  });
}
