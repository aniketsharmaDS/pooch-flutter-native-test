import 'package:poochcare/features/expense_tracker/data/api/expense_tracker_api_service.dart';
import 'package:poochcare/features/expense_tracker/data/mappers/expense_tracker_details_mapper.dart';
import 'package:poochcare/features/expense_tracker/data/mappers/expense_tracker_mapper.dart';
import 'package:poochcare/features/expense_tracker/data/mappers/expense_yearly_transactions_mapper.dart';
import 'package:poochcare/features/expense_tracker/domain/repository/expense_tracker_repository.dart';
import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_tracker_details_ui_model.dart';
import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_tracker_ui_model.dart';
import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_yearly_transactions_ui_model.dart';

class ExpenseTrackerRepositoryImpl implements ExpenseTrackerRepository {
  final ExpenseTrackerApiService _api;

  const ExpenseTrackerRepositoryImpl(this._api);

  @override
  Future<ExpenseTrackerUIModel> getExpenseTracker({
    required String type,
    int? month,
    required int year,
    String? petId,
  }) async {
    final response = await _api.getExpenseTracker(
      type: type,
      month: month,
      year: year,
      petId: petId,
    );

    return ExpenseTrackerMapper.toUIModel(response.data);
  }

  @override
  Future<ExpenseTrackerDetailsUIModel> getMonthlyTransactions({
    required int month,
    required int year,
    String? petId,
  }) async {
    final response = await _api.getMonthlyTransactions(
      month: month,
      year: year,
      petId: petId,
    );

    return ExpenseTrackerDetailsMapper.toUIModel(response.data);
  }

  @override
  Future<ExpenseYearlyTransactionsUIModel> getYearlyTransactions({
    required int year,
    String? petId,
    int page = 1,
  }) async {
    final response = await _api.getYearlyTransactions(
      year: year,
      page: page,
      petId: petId,
    );

    return ExpenseYearlyTransactionsMapper.toUIModel(response.data);
  }
}
