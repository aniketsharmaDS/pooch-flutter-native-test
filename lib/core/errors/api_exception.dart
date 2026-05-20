class ApiException implements Exception {
  const ApiException(
    this.message, {
    this.code = 'UNKNOWN',
    this.statusCode = 0,
  });

  final String message;
  final String code; // e.g., 'INVALID_CREDENTIALS'
  final int statusCode; // e.g., 400, 401, 500

  @override
  String toString() => message;
}

class CreateUploadUrlException implements Exception {
  final String message;
  final int? statusCode;

  CreateUploadUrlException({required this.message, this.statusCode});

  @override
  String toString() {
    return 'CreateUploadUrlException: $message (Status code: $statusCode)';
  }
}

class S3UploadException implements Exception {
  final String message;
  final int? statusCode;

  S3UploadException({required this.message, this.statusCode});

  @override
  String toString() {
    return 'S3UploadException: $message (Status code: $statusCode)';
  }
}
