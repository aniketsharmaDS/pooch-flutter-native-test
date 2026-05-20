import 'dart:io';

import 'package:flutter/material.dart';
import 'package:poochcare/core/services/image_upload_service.dart';
import 'package:poochcare/core/services/s3_upload_path_builder.dart';

class UploadedDocumentFile {
  const UploadedDocumentFile({
    required this.path,
    required this.url,
    required this.name,
    required this.sizeInBytes,
  });

  final String path;
  final String url;
  final String name;
  final int sizeInBytes;
}

class DocumentUploadResult {
  const DocumentUploadResult({
    required this.uploadedFilesByPath,
    required this.failedFiles,
    required this.retriedFailedUploads,
  });

  final Map<String, UploadedDocumentFile> uploadedFilesByPath;
  final List<File> failedFiles;
  final bool retriedFailedUploads;

  bool get hasFailures => failedFiles.isNotEmpty;
}

class PendingUploadDecisionResult {
  const PendingUploadDecisionResult({required this.shouldProceedWithSave});

  final bool shouldProceedWithSave;
}

class DocumentUploadService {
  const DocumentUploadService(this._imageUploadService);

  final ImageUploadService _imageUploadService;

  Future<PendingUploadDecisionResult> processPendingUploadsForSave({
    required BuildContext context,
    required String ownerId,
    required UploadEntityType entityType,
    required UploadPurpose purpose,
    required Iterable<File> selectedFiles,
    required Map<String, UploadedDocumentFile> uploadedFilesByPath,
    required bool enableRetryForFailed,
  }) async {
    final selected = selectedFiles.toList(growable: false);
    final pendingFiles = selected
        .where((file) => !uploadedFilesByPath.containsKey(file.path))
        .toList(growable: false);

    if (pendingFiles.isEmpty) {
      return const PendingUploadDecisionResult(shouldProceedWithSave: true);
    }

    var firstAttempt = await _uploadFilesToS3(
      ownerId: ownerId,
      entityType: entityType,
      purpose: purpose,
      files: pendingFiles,
      enableRetryForFailed: false,
    );

    _mergeUploadedFilesByPath(
      target: uploadedFilesByPath,
      incoming: firstAttempt.uploadedFilesByPath,
    );

    var failedFiles = firstAttempt.failedFiles;
    var retryAttempted = false;

    if (failedFiles.isNotEmpty && enableRetryForFailed) {
      if (!context.mounted) {
        return const PendingUploadDecisionResult(shouldProceedWithSave: false);
      }

      final shouldRetry = await _showRetryFailedUploadsDialog(
        context: context,
        failedCount: failedFiles.length,
      );

      if (shouldRetry) {
        retryAttempted = true;
        final retryAttempt = await _uploadFilesToS3(
          ownerId: ownerId,
          entityType: entityType,
          purpose: purpose,
          files: failedFiles,
          enableRetryForFailed: false,
        );

        _mergeUploadedFilesByPath(
          target: uploadedFilesByPath,
          incoming: retryAttempt.uploadedFilesByPath,
        );

        failedFiles = retryAttempt.failedFiles;
      }
    }

    if (!context.mounted) {
      return const PendingUploadDecisionResult(shouldProceedWithSave: false);
    }

    final uploadedCountForSelected = selected
        .where((file) => uploadedFilesByPath.containsKey(file.path))
        .length;

    if (failedFiles.isNotEmpty) {
      if (!context.mounted) {
        return const PendingUploadDecisionResult(shouldProceedWithSave: false);
      }
      final messenger = ScaffoldMessenger.of(context);
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            retryAttempted
                ? '${failedFiles.length} file(s) failed after retry and were skipped.'
                : '${failedFiles.length} file(s) failed to upload and were skipped.',
          ),
        ),
      );
    }

    if (selected.isNotEmpty && uploadedCountForSelected == 0) {
      if (!context.mounted) {
        return const PendingUploadDecisionResult(shouldProceedWithSave: false);
      }
      final messenger = ScaffoldMessenger.of(context);
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        const SnackBar(content: Text('Upload failed. Save failed.')),
      );
      return const PendingUploadDecisionResult(shouldProceedWithSave: false);
    }

    return const PendingUploadDecisionResult(shouldProceedWithSave: true);
  }

  void _mergeUploadedFilesByPath({
    required Map<String, UploadedDocumentFile> target,
    required Map<String, UploadedDocumentFile> incoming,
  }) {
    target.addAll(incoming);
  }

  Future<bool> _showRetryFailedUploadsDialog({
    required BuildContext context,
    required int failedCount,
  }) async {
    final shouldRetry = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Upload Failed'),
          content: Text(
            '$failedCount file(s) failed to upload. Do you want to retry?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Retry'),
            ),
          ],
        );
      },
    );

    return shouldRetry ?? false;
  }

  Future<DocumentUploadResult> _uploadFilesToS3({
    required String ownerId,
    required UploadEntityType entityType,
    required UploadPurpose purpose,
    required List<File> files,
    bool enableRetryForFailed = true,
  }) async {
    if (ownerId.trim().isEmpty) {
      throw ArgumentError.value(ownerId, 'ownerId', 'ownerId cannot be empty');
    }

    if (files.isEmpty) {
      return const DocumentUploadResult(
        uploadedFilesByPath: <String, UploadedDocumentFile>{},
        failedFiles: <File>[],
        retriedFailedUploads: false,
      );
    }

    final firstBatch = await _uploadBatch(
      ownerId: ownerId,
      entityType: entityType,
      purpose: purpose,
      files: files,
    );

    final mergedUploaded = <String, UploadedDocumentFile>{
      ...firstBatch.uploadedFilesByPath,
    };
    var finalFailedFiles = List<File>.from(firstBatch.failedFiles);
    var retriedFailedUploads = false;

    if (enableRetryForFailed && firstBatch.failedFiles.isNotEmpty) {
      retriedFailedUploads = true;
      final retryBatch = await _uploadBatch(
        ownerId: ownerId,
        entityType: entityType,
        purpose: purpose,
        files: firstBatch.failedFiles,
      );

      mergedUploaded.addAll(retryBatch.uploadedFilesByPath);
      finalFailedFiles = retryBatch.failedFiles;
    }

    return DocumentUploadResult(
      uploadedFilesByPath: mergedUploaded,
      failedFiles: finalFailedFiles,
      retriedFailedUploads: retriedFailedUploads,
    );
  }

  Future<DocumentUploadResult> _uploadBatch({
    required String ownerId,
    required UploadEntityType entityType,
    required UploadPurpose purpose,
    required List<File> files,
  }) async {
    final attempts = await Future.wait<_DocumentUploadAttempt>(
      files.map((file) async {
        try {
          final uploaded = await _uploadSingleFileToS3(
            ownerId: ownerId,
            entityType: entityType,
            purpose: purpose,
            file: file,
          );
          return _DocumentUploadAttempt.success(uploaded);
        } catch (error) {
          return _DocumentUploadAttempt.failure(path: file.path, error: error);
        }
      }),
    );

    final uploadedFilesByPath = <String, UploadedDocumentFile>{};
    final failedFiles = <File>[];

    for (final attempt in attempts) {
      if (attempt.uploadedFile != null) {
        final uploaded = attempt.uploadedFile!;
        uploadedFilesByPath[uploaded.path] = uploaded;
      } else {
        failedFiles.add(File(attempt.path));
      }
    }

    return DocumentUploadResult(
      uploadedFilesByPath: uploadedFilesByPath,
      failedFiles: failedFiles,
      retriedFailedUploads: false,
    );
  }

  Future<UploadedDocumentFile> _uploadSingleFileToS3({
    required String ownerId,
    required UploadEntityType entityType,
    required UploadPurpose purpose,
    required File file,
  }) async {
    if (!await file.exists()) {
      throw ArgumentError.value(file, 'file', 'file does not exist');
    }

    final originalFileName = file.path.split(Platform.pathSeparator).last;
    final mimeType = ImageUploadService.inferImageMimeTypeFromFileName(
      originalFileName,
    );
    final fileName = ImageUploadService.sanitizeUploadFileName(
      originalFileName: originalFileName,
      mimeType: mimeType,
    );
    final bytes = await file.readAsBytes();

    final basePath = S3UploadPathBuilder.build(
      entityType: entityType,
      userId: ownerId,
      purpose: purpose,
    );

    final uploadedUrl = await _imageUploadService.uploadSingleAndGetFullUrl(
      file: UploadUrlFileSpec(path: basePath, name: fileName, type: mimeType),
      fileBytes: bytes,
    );

    return UploadedDocumentFile(
      path: file.path,
      url: uploadedUrl,
      name: originalFileName,
      sizeInBytes: bytes.length,
    );
  }

  List<Map<String, dynamic>> buildUploadedDocumentEntries({
    required Iterable<File> selectedFiles,
    required Map<String, UploadedDocumentFile> uploadedFilesByPath,
  }) {
    final urls = <Map<String, dynamic>>[];

    for (final file in selectedFiles) {
      final uploaded = uploadedFilesByPath[file.path];
      if (uploaded == null || uploaded.url.trim().isEmpty) {
        continue;
      }

      urls.add(<String, dynamic>{
        'url': uploaded.url,
        'name': uploaded.name,
        'size': uploaded.sizeInBytes.toString(),
      });
    }

    return urls;
  }
}

class _DocumentUploadAttempt {
  const _DocumentUploadAttempt({
    required this.path,
    this.uploadedFile,
    this.error,
  });

  final String path;
  final UploadedDocumentFile? uploadedFile;
  final Object? error;

  factory _DocumentUploadAttempt.success(UploadedDocumentFile uploadedFile) {
    return _DocumentUploadAttempt(
      path: uploadedFile.path,
      uploadedFile: uploadedFile,
    );
  }

  factory _DocumentUploadAttempt.failure({
    required String path,
    required Object error,
  }) {
    return _DocumentUploadAttempt(path: path, error: error);
  }
}
