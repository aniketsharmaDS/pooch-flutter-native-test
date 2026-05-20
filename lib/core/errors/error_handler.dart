import 'package:dio/dio.dart';
import 'package:poochcare/core/errors/failure.dart';

class ErrorHandler {
  static Failure handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure(
          error.requestOptions.data['message'] as String? ??
              'Something Went Wrong!',
        );

      case DioExceptionType.badResponse:
        final message =
            error.requestOptions.data['message'] as String? ??
            'Server error occurred';
        return ServerFailure(message);

      case DioExceptionType.cancel:
        return const UnknownFailure('Request was cancelled');

      default:
        return const NetworkFailure();
    }
  }
}
