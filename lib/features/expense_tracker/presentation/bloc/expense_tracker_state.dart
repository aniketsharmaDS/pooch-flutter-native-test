import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_tracker_details_ui_model.dart';
import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_tracker_ui_model.dart';
import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_yearly_transactions_ui_model.dart';

class ExpenseTrackerState {
  final ExpenseTrackerUIModel? expenseTracker;

  final ExpenseTrackerDetailsUIModel? monthlyTransactions;

  final ExpenseYearlyTransactionsUIModel? yearlyTransactions;

  final bool isLoadingMoreYearlyTransactions;

  final int yearlyTransactionsPage;

  final bool hasMoreYearlyTransactions;

  final bool isLoading;

  final String selectedType;

  final int selectedMonth;

  final int selectedYear;

  final String? selectedPetId;

  final String? error;

  const ExpenseTrackerState({
    this.expenseTracker,
    this.monthlyTransactions,
    this.yearlyTransactions,
    this.isLoadingMoreYearlyTransactions = false,
    this.yearlyTransactionsPage = 1,
    this.hasMoreYearlyTransactions = false,
    this.isLoading = false,
    this.selectedType = 'monthly',
    this.selectedMonth = 1,
    this.selectedYear = 2026,
    this.selectedPetId,
    this.error,
  });

  ExpenseTrackerState copyWith({
    ExpenseTrackerUIModel? expenseTracker,
    ExpenseTrackerDetailsUIModel? monthlyTransactions,
    ExpenseYearlyTransactionsUIModel? yearlyTransactions,
    bool? isLoadingMoreYearlyTransactions,
    int? yearlyTransactionsPage,
    bool? hasMoreYearlyTransactions,
    bool? isLoading,
    String? selectedType,
    int? selectedMonth,
    int? selectedYear,
    String? selectedPetId,
    String? error,
  }) {
    return ExpenseTrackerState(
      expenseTracker: expenseTracker ?? this.expenseTracker,

      monthlyTransactions: monthlyTransactions ?? this.monthlyTransactions,

      yearlyTransactions: yearlyTransactions ?? this.yearlyTransactions,

      isLoadingMoreYearlyTransactions:
          isLoadingMoreYearlyTransactions ??
          this.isLoadingMoreYearlyTransactions,

      yearlyTransactionsPage:
          yearlyTransactionsPage ?? this.yearlyTransactionsPage,

      hasMoreYearlyTransactions:
          hasMoreYearlyTransactions ?? this.hasMoreYearlyTransactions,

      isLoading: isLoading ?? this.isLoading,

      selectedType: selectedType ?? this.selectedType,

      selectedMonth: selectedMonth ?? this.selectedMonth,

      selectedYear: selectedYear ?? this.selectedYear,

      selectedPetId: selectedPetId,

      error: error,
    );
  }
}
