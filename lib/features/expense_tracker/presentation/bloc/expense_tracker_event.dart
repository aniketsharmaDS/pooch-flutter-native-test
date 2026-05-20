abstract class ExpenseTrackerEvent {}

class LoadExpenseTracker extends ExpenseTrackerEvent {
  final String type;

  final int year;

  final int? month;

  final String? petId;

  LoadExpenseTracker({
    required this.type,
    required this.year,
    this.month,
    this.petId,
  });
}

class ChangeExpenseTrackerType extends ExpenseTrackerEvent {
  final String type;

  ChangeExpenseTrackerType(this.type);
}

class ChangeExpenseTrackerMonth extends ExpenseTrackerEvent {
  final int month;

  ChangeExpenseTrackerMonth(this.month);
}

class ChangeExpenseTrackerYear extends ExpenseTrackerEvent {
  final int year;

  ChangeExpenseTrackerYear(this.year);
}

class ChangeExpenseTrackerPet extends ExpenseTrackerEvent {
  final String? petId;

  ChangeExpenseTrackerPet(this.petId);
}

class LoadMonthlyTransactions extends ExpenseTrackerEvent {
  final int month;

  final int year;

  final String? petId;

  LoadMonthlyTransactions({
    required this.month,
    required this.year,
    this.petId,
  });
}

class LoadYearlyTransactions extends ExpenseTrackerEvent {
  final int year;

  final bool loadMore;

  final String? petId;

  LoadYearlyTransactions({
    required this.year,
    this.loadMore = false,
    this.petId,
  });
}
