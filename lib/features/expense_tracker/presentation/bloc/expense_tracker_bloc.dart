import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/expense_tracker/domain/repository/expense_tracker_repository.dart';
import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_transaction_ui_model.dart';
import 'package:poochcare/features/expense_tracker/domain/ui_model/expense_yearly_transactions_ui_model.dart';
import 'package:poochcare/features/expense_tracker/presentation/bloc/expense_tracker_event.dart';
import 'package:poochcare/features/expense_tracker/presentation/bloc/expense_tracker_state.dart';

class ExpenseTrackerBloc
    extends Bloc<ExpenseTrackerEvent, ExpenseTrackerState> {
  final ExpenseTrackerRepository _repo;

  ExpenseTrackerBloc(this._repo) : super(const ExpenseTrackerState()) {
    on<LoadExpenseTracker>(_onLoad);

    on<ChangeExpenseTrackerType>(_onChangeType);

    on<ChangeExpenseTrackerMonth>(_onChangeMonth);

    on<ChangeExpenseTrackerYear>(_onChangeYear);

    on<ChangeExpenseTrackerPet>(_onChangePet);

    on<LoadMonthlyTransactions>(_onLoadMonthlyTransactions);

    on<LoadYearlyTransactions>(_onLoadYearlyTransactions);
  }

  Future<void> _onLoad(
    LoadExpenseTracker event,
    Emitter<ExpenseTrackerState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final data = await _repo.getExpenseTracker(
        type: event.type,
        month: event.month,
        year: event.year,
        petId: event.petId,
      );

      emit(
        state.copyWith(
          expenseTracker: data,
          isLoading: false,
          selectedType: event.type,
          selectedMonth: event.month ?? state.selectedMonth,
          selectedYear: event.year,
          selectedPetId: event.petId ?? state.selectedPetId,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onChangeType(
    ChangeExpenseTrackerType event,
    Emitter<ExpenseTrackerState> emit,
  ) async {
    emit(state.copyWith(selectedType: event.type));

    add(
      LoadExpenseTracker(
        type: event.type,
        month: event.type == 'monthly' ? state.selectedMonth : null,
        year: state.selectedYear,
        petId: state.selectedPetId,
      ),
    );
  }

  Future<void> _onChangeMonth(
    ChangeExpenseTrackerMonth event,
    Emitter<ExpenseTrackerState> emit,
  ) async {
    // GUARD: Only proceed if month is different
    if (event.month == state.selectedMonth) return;
    emit(state.copyWith(selectedMonth: event.month));

    add(
      LoadExpenseTracker(
        type: state.selectedType,
        month: event.month,
        year: state.selectedYear,
        petId: state.selectedPetId,
      ),
    );
  }

  Future<void> _onChangeYear(
    ChangeExpenseTrackerYear event,
    Emitter<ExpenseTrackerState> emit,
  ) async {
    // GUARD: Only proceed if year is different
    if (event.year == state.selectedYear) return;
    emit(state.copyWith(selectedYear: event.year));

    add(
      LoadExpenseTracker(
        type: state.selectedType,
        month: state.selectedType == 'monthly' ? state.selectedMonth : null,
        year: event.year,
        petId: state.selectedPetId,
      ),
    );
  }

  Future<void> _onChangePet(
    ChangeExpenseTrackerPet event,
    Emitter<ExpenseTrackerState> emit,
  ) async {
    // If petId is null or empty string, make sure we send null to API
    final petId = event.petId;

    // GUARD: Only proceed if petId is different
    if (petId == state.selectedPetId) return;
    // Immediately update the state so future API calls see null
    emit(state.copyWith(selectedPetId: petId));

    add(
      LoadExpenseTracker(
        type: state.selectedType,
        month: state.selectedType == 'monthly' ? state.selectedMonth : null,
        year: state.selectedYear,
        petId: petId,
      ),
    );
  }

  Future<void> _onLoadMonthlyTransactions(
    LoadMonthlyTransactions event,
    Emitter<ExpenseTrackerState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final data = await _repo.getMonthlyTransactions(
        month: event.month,
        year: event.year,
        petId: event.petId,
      );

      emit(state.copyWith(monthlyTransactions: data, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onLoadYearlyTransactions(
    LoadYearlyTransactions event,
    Emitter<ExpenseTrackerState> emit,
  ) async {
    final isLoadMore = event.loadMore;

    /// Prevent duplicate pagination calls
    if (isLoadMore &&
        (state.isLoadingMoreYearlyTransactions ||
            !state.hasMoreYearlyTransactions)) {
      return;
    }

    if (isLoadMore) {
      emit(state.copyWith(isLoadingMoreYearlyTransactions: true));
    } else {
      emit(state.copyWith(isLoading: true, yearlyTransactionsPage: 1));
    }

    try {
      final nextPage = isLoadMore ? state.yearlyTransactionsPage + 1 : 1;

      final response = await _repo.getYearlyTransactions(
        year: event.year,
        page: nextPage,
        petId: event.petId,
      );

      final previousTransactions = isLoadMore
          ? (state.yearlyTransactions?.transactions ?? [])
          : <ExpenseTransactionUIModel>[];

      final updatedTransactions = [
        ...previousTransactions,
        ...response.transactions,
      ];

      final updatedData = ExpenseYearlyTransactionsUIModel(
        year: response.year,

        transactions: updatedTransactions,

        totalAmount: response.totalAmount,

        totalTransactions: response.totalTransactions,

        currency: response.currency,

        formattedTotalAmount: response.formattedTotalAmount,

        currentPage: response.currentPage,

        totalPages: response.totalPages,

        hasNextPage: response.hasNextPage,
      );

      emit(
        state.copyWith(
          yearlyTransactions: updatedData,

          yearlyTransactionsPage: nextPage,

          hasMoreYearlyTransactions: response.hasNextPage,

          isLoading: false,

          isLoadingMoreYearlyTransactions: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,

          isLoadingMoreYearlyTransactions: false,

          error: e.toString(),
        ),
      );
    }
  }
}
