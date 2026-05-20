import 'package:poochcare/features/expense_tracker/data/api/expense_tracker_api_service.dart';
import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_tracker_details_ui_model.dart';
import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_tracker_ui_model.dart';
import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_yearly_transactions_ui_model.dart';

abstract class ExpenseTrackerRepository {
  ExpenseTrackerRepository(ExpenseTrackerApiService apiService);

  Future<ExpenseTrackerUIModel> getExpenseTracker({
    required String type,
    int? month,
    required int year,
    String? petId,
  });

  Future<ExpenseTrackerDetailsUIModel> getMonthlyTransactions({
    required int month,
    required int year,
    String? petId,
  });

  Future<ExpenseYearlyTransactionsUIModel> getYearlyTransactions({
    required int year,
    int page = 1,
    String? petId,
  });
}
