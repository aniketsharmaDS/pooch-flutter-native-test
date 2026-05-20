import 'dart:math';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/core/network/api_endpoints.dart';
import 'package:poochcare/core/network/api_response.dart';

class UploadUrlFileSpec {
  final String path;
  final String name;
  final String type;
  final String? size;

  const UploadUrlFileSpec({
    required this.path,
    required this.name,
    required this.type,
    this.size,
  });

  Map<String, dynamic> toJson() {
    return {'path': path, 'name': name, 'type': type, 'size': size};
  }
}

class UploadUrlInfo {
  final String name;
  final String uploadUrl;
  final String fullUrl;
  final String basePath;

  const UploadUrlInfo({
    required this.name,
    required this.uploadUrl,
    required this.fullUrl,
    required this.basePath,
  });

  factory UploadUrlInfo.fromJson(Map<String, dynamic> json) {
    return UploadUrlInfo(
      name: (json['name'] ?? '').toString(),
      uploadUrl: (json['uploadURL'] ?? '').toString(),
      fullUrl: (json['fullUrl'] ?? '').toString(),
      basePath: (json['basePath'] ?? '').toString(),
    );
  }
}

class CreateUploadUrlData {
  final List<UploadUrlInfo> urls;

  const CreateUploadUrlData({required this.urls});

  factory CreateUploadUrlData.fromJson(dynamic json) {
    final map = (json as Map<String, dynamic>);
    final list = (map['urls'] as List<dynamic>? ?? const <dynamic>[]);
    return CreateUploadUrlData(
      urls: list
          .whereType<Map<String, dynamic>>()
          .map(UploadUrlInfo.fromJson)
          .toList(),
    );
  }
}

class ImageUploadService {
  final Dio _dio;
  final Dio _rawDio;
  final String _createUploadUrlPath;

  static const String createUploadUrlPath = ApiEndpoints.createUploadUrlPath;

  ImageUploadService({
    Dio? dio,
    Dio? rawDio,
    String createUploadUrlPath = ImageUploadService.createUploadUrlPath,
  }) : _dio =
           dio ??
           Dio(
             BaseOptions(
               headers: const <String, String>{
                 'Content-Type': 'application/json',
               },
             ),
           ),
       _rawDio = rawDio ?? Dio(BaseOptions(headers: const <String, dynamic>{})),
       _createUploadUrlPath = createUploadUrlPath;

  Future<List<UploadUrlInfo>> createUploadUrls({
    required List<UploadUrlFileSpec> files,
  }) async {
    if (files.isEmpty) {
      throw ArgumentError.value(files, 'files', 'files cannot be empty');
    }

    if (_createUploadUrlPath.trim().isEmpty) {
      throw CreateUploadUrlException(
        message:
            'Create upload URL path is not configured for ImageUploadService.',
      );
    }

    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        _createUploadUrlPath,
        data: <String, dynamic>{'files': files.map((f) => f.toJson()).toList()},
      );

      final dynamic body = response.data;
      if (body is! Map<String, dynamic>) {
        throw CreateUploadUrlException(
          message: 'Invalid server response',
          statusCode: response.statusCode,
        );
      }

      final dynamic payload = _extractPayload(body);
      final CreateUploadUrlData data = CreateUploadUrlData.fromJson(payload);
      final urls = data.urls;
      if (urls.isEmpty) {
        throw CreateUploadUrlException(
          message: 'Create upload URL returned no URLs.',
        );
      }

      return urls;
    } on DioException catch (e) {
      throw _mapCreateUploadUrlError(e);
    }
  }

  Future<void> uploadToS3({
    required String uploadUrl,
    required Uint8List fileBytes,
    required String mimeType,
  }) async {
    try {
      final Response<dynamic> response = await _rawDio.put<dynamic>(
        uploadUrl,
        data:
            fileBytes, // raw bytes, not a stream (S3 pre-signed URLs don't support chunked transfer)
        options: Options(
          followRedirects: false,
          headers: {
            Headers.contentTypeHeader: mimeType,
            // Headers.contentLengthHeader: fileBytes.length.toString(),
            Headers.contentLengthHeader: fileBytes.length,
          },
          responseType: ResponseType.plain,
          validateStatus: (status) =>
              status != null && status >= 200 && status < 300,
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw S3UploadException(
          message: 'S3 upload failed with status ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw S3UploadException(
        message: e.message ?? 'S3 upload failed',
        statusCode: e.response?.statusCode,
      );
    }
  }

  dynamic _extractPayload(Map<String, dynamic> body) {
    if (body.containsKey('success') && body.containsKey('data')) {
      final ApiResponse envelope = ApiResponseMapper.fromMap(body);
      return envelope.data;
    }

    return body;
  }

  CreateUploadUrlException _mapCreateUploadUrlError(DioException error) {
    final int? statusCode = error.response?.statusCode;
    final dynamic responseData = error.response?.data;

    if (responseData is Map<String, dynamic>) {
      final String? message = responseData['message'] as String?;
      if (message != null && message.trim().isNotEmpty) {
        return CreateUploadUrlException(
          message: message,
          statusCode: statusCode,
        );
      }
    }

    return CreateUploadUrlException(
      message: error.message ?? 'Create upload URL failed',
      statusCode: statusCode,
    );
  }

  /// Convenience: request 1 pre-signed URL, upload bytes, return the public `fullUrl`.
  Future<String> uploadSingleAndGetFullUrl({
    required UploadUrlFileSpec file,
    required Uint8List fileBytes,
  }) async {
    final urls = await createUploadUrls(files: [file]);
    final first = urls.first;

    if (first.uploadUrl.isEmpty || first.fullUrl.isEmpty) {
      throw CreateUploadUrlException(
        message: 'Create upload URL returned invalid URL data.',
      );
    }

    await uploadToS3(
      uploadUrl: first.uploadUrl,
      fileBytes: fileBytes,
      mimeType: file.type,
    );

    // NOTE:
    // If the backend returns a presigned GET URL (common for private buckets),
    // the query parameters are required for the image to load. Do not strip.
    return first.fullUrl;
  }

  static String inferImageMimeTypeFromFileName(String fileName) {
    final lower = fileName.toLowerCase();
    if (lower.endsWith('.jpg') || lower.endsWith('.jpeg')) return 'image/jpeg';
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    if (lower.endsWith('.gif')) return 'image/gif';
    if (lower.endsWith('.heic')) return 'image/heic';
    if (lower.endsWith('.heif')) return 'image/heif';
    // ✅ PDF
    if (lower.endsWith('.pdf')) return 'application/pdf';
    return 'application/octet-stream';
  }

  /// Sanitizes a filename for upload URL creation.
  ///
  /// Why:
  /// - Some image pickers/compressors create files named like `scaled_<very-long>.jpg`.
  /// - The backend may reject very long names.
  ///
  /// Behavior:
  /// - Always strips a leading `scaled_`.
  /// - For images (`image/*`), generates a short unique name keeping the extension.
  /// - For non-images, returns a cleaned basename (no path segments).
  static String sanitizeUploadFileName({
    required String originalFileName,
    required String mimeType,
  }) {
    final base = _basename(originalFileName);
    final cleaned = base.startsWith('scaled_') ? base.substring(7) : base;

    if (!mimeType.startsWith('image/')) {
      return cleaned;
    }

    final ext = _extensionFromFileName(cleaned) ?? _extensionFromMime(mimeType);
    final shortBase = _shortId();
    return '$shortBase.$ext';
  }

  static String _basename(String pathOrName) {
    // Handles both Windows and Unix separators.
    final parts = pathOrName.split(RegExp(r'[\\/]'));
    return parts.isEmpty ? pathOrName : parts.last;
  }

  static String? _extensionFromFileName(String fileName) {
    final dot = fileName.lastIndexOf('.');
    if (dot <= 0 || dot == fileName.length - 1) return null;
    final ext = fileName.substring(dot + 1).toLowerCase();
    return ext.isEmpty ? null : ext;
  }

  static String _extensionFromMime(String mimeType) {
    switch (mimeType) {
      case 'image/png':
        return 'png';
      case 'image/webp':
        return 'webp';
      case 'image/gif':
        return 'gif';
      case 'image/heic':
        return 'heic';
      case 'image/heif':
        return 'heif';
      case 'image/jpeg':
      default:
        return 'jpg';
    }
  }

  static String _shortId() {
    final ts = DateTime.now().millisecondsSinceEpoch.toRadixString(36);
    final rand = Random.secure()
        .nextInt(0x7fffffff)
        .toRadixString(36)
        .padLeft(6, '0');
    return '$ts$rand';
  }
}
