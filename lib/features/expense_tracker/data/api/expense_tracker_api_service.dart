import 'package:dio/dio.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/core/errors/error_mapper.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/expense_tracker/data/models/expense_tracker_details_response_model.dart';

import 'package:poochcare/features/expense_tracker/data/models/expense_tracker_response_model.dart';
import 'package:poochcare/features/expense_tracker/data/models/expense_yearly_transactions_response_model.dart';

class ExpenseTrackerApiService {
  const ExpenseTrackerApiService(this._dio);

  final Dio _dio;

  static const _expenseTrackerPath = '/expense-tracker';
  static const _expenseTrackerMonthlyTransactionPath =
      '/expense-tracker/monthly-transactions';

  static const _expenseTrackerYearlyTransactionsPath =
      '/expense-tracker/yearly-transactions';

  Future<ExpenseTrackerResponseModel> getExpenseTracker({
    required String type,
    int? month,
    required int year,
    String? petId,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        _expenseTrackerPath,
        queryParameters: {
          'type': type,

          if (type == 'monthly' && month != null) 'month': month,

          'year': year,

          if (petId != null && petId.isNotEmpty) 'petId': petId,
        },
      );

      final dynamic body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(envelope.message);
      }

      return ExpenseTrackerResponseModel.fromMap(ParserUtils.readMap(body));
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  Future<ExpenseTrackerDetailsResponseModel> getMonthlyTransactions({
    required int month,
    required int year,
    String? petId,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        _expenseTrackerMonthlyTransactionPath,
        queryParameters: {
          'month': month,
          'year': year,
          if (petId != null && petId.isNotEmpty) 'petId': petId,
        },
      );

      final dynamic body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(envelope.message);
      }

      return ExpenseTrackerDetailsResponseModel.fromMap(
        ParserUtils.readMap(body),
      );
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }

  Future<ExpenseYearlyTransactionsResponseModel> getYearlyTransactions({
    required int year,
    int page = 1,
    int limit = 20,
    String? petId,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        _expenseTrackerYearlyTransactionsPath,

        queryParameters: {
          'year': year,
          'page': page,
          'limit': limit,
          if (petId != null && petId.isNotEmpty) 'petId': petId,
        },
      );

      final dynamic body = response.data;

      final ApiResponse? envelope =
          body is Map<String, dynamic> &&
              body.containsKey('success') &&
              body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(envelope.message);
      }

      return ExpenseYearlyTransactionsResponseModel.fromMap(
        ParserUtils.readMap(body),
      );
    } on DioException catch (e) {
      throw ErrorMapper.mapDioError(e);
    }
  }
}
