import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:poochcare/main.dart';

class FileDownloadHelper {
  FileDownloadHelper({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;
  final Map<String, String> _downloadedPathsByUrl = <String, String>{};

  Future<bool> handleDownload({
    required String? url,
    required String fileName,
    required String fileType,
    Future<void> Function()? onDownload,
  }) async {
    final sourceUrl = (url ?? '').trim();

    if (sourceUrl.isEmpty) {
      if (onDownload != null) {
        try {
          await onDownload.call();
          _showMessage('File downloaded.');
          return true;
        } catch (_) {
          _showMessage('Failed to download file. Please try again.');
          return false;
        }
      }

      _showMessage('Document URL not available.');
      return false;
    }

    final existingPath = _downloadedPathsByUrl[sourceUrl];
    if (existingPath != null && await File(existingPath).exists()) {
      _showMessage('File already downloaded.');
      return true;
    }

    final hasPermission = await _ensureStoragePermission();
    if (!hasPermission) {
      return false;
    }

    try {
      final path = await _downloadDocument(
        sourceUrl,
        fileName: fileName,
        fileType: fileType,
      );
      _downloadedPathsByUrl[sourceUrl] = path;
      _showMessage('File downloaded in PoochCare folder. $path');
      return true;
    } catch (_) {
      _showMessage('Failed to download file. Please try again.');
      return false;
    }
  }

  Future<bool> openDownloadedFile({required String? url}) async {
    final sourceUrl = (url ?? '').trim();
    final path = sourceUrl.isEmpty ? null : _downloadedPathsByUrl[sourceUrl];

    if (path == null || path.isEmpty) {
      _showMessage('File is not available. Download it first.');
      return false;
    }

    final file = File(path);
    if (!await file.exists()) {
      _downloadedPathsByUrl.remove(sourceUrl);
      _showMessage('Downloaded file not found. Please download again.');
      return false;
    }

    try {
      final result = await OpenFilex.open(path);
      if (result.type == ResultType.done) {
        return true;
      }

      if (result.type == ResultType.noAppToOpen) {
        _showMessage('No app found to open this file type.');
        return false;
      }

      if (result.type == ResultType.fileNotFound) {
        _showMessage('File not found. Please download again.');
        return false;
      }

      if (result.type == ResultType.permissionDenied) {
        _showMessage('Permission denied while opening file.');
        return false;
      }

      final details = result.message.trim();
      _showMessage(
        details.isEmpty
            ? 'Unable to open file.'
            : 'Unable to open file: $details',
      );
      return false;
    } catch (_) {
      _showMessage('Unable to open file.');
      return false;
    }
  }

  Future<String> _downloadDocument(
    String sourceUrl, {
    required String fileName,
    required String fileType,
  }) async {
    final uri = Uri.tryParse(sourceUrl);
    if (uri == null || !uri.isAbsolute) {
      throw Exception('Invalid document URL');
    }

    final directory = await _resolveDownloadDirectory(fileType);
    final targetPath = p.join(
      directory.path,
      _resolveFileName(fileName: fileName, fileType: fileType, uri: uri),
    );

    await _dio.download(
      sourceUrl,
      targetPath,
      options: Options(responseType: ResponseType.bytes),
    );

    return targetPath;
  }

  Future<Directory> _resolveDownloadDirectory(String fileType) async {
    if (kIsWeb) {
      // ❌ No directory access in web
      log('File download is not supported on web platform.');
      return Directory.systemTemp;
    }
    final Directory baseDirectory;
    if (Platform.isAndroid) {
      baseDirectory = Directory('/storage/emulated/0/Download');
    } else {
      baseDirectory = await getApplicationDocumentsDirectory();
    }

    final poochCareDirectory = Directory(
      p.join(baseDirectory.path, 'PoochCare'),
    );
    if (!await poochCareDirectory.exists()) {
      await poochCareDirectory.create(recursive: true);
    }

    return poochCareDirectory;
  }

  Future<bool> _ensureStoragePermission() async {
    if (!Platform.isAndroid) {
      return true;
    }

    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final sdkInt = androidInfo.version.sdkInt;

    final permission = sdkInt >= 30
        ? Permission.manageExternalStorage
        : Permission.storage;

    var status = await permission.status;
    if (status.isGranted) {
      return true;
    }

    status = await permission.request();
    if (status.isGranted) {
      return true;
    }

    if (status.isPermanentlyDenied || status.isRestricted) {
      _showMessage(
        'Storage permission is required. Please enable it from settings.',
      );
      await openAppSettings();
      return false;
    }

    _showMessage('Storage permission denied. Unable to download file.');
    return false;
  }

  String _resolveFileName({
    required String fileName,
    required String fileType,
    required Uri uri,
  }) {
    final rawName = fileName.trim().isEmpty
        ? p.basename(uri.path)
        : fileName.trim();
    final resolvedFileName = rawName.isEmpty ? 'medical_document' : rawName;
    final normalizedExt = _normalizedExtension(fileType);
    if (p.extension(resolvedFileName).isNotEmpty || normalizedExt.isEmpty) {
      return resolvedFileName;
    }
    return '$resolvedFileName.$normalizedExt';
  }

  String _normalizedExtension(String rawType) {
    final type = rawType.trim().replaceAll('.', '').toLowerCase();
    switch (type) {
      case 'application/pdf':
      case 'pdf':
        return 'pdf';
      case 'image/jpeg':
      case 'jpeg':
      case 'jpg':
        return 'jpg';
      case 'image/png':
      case 'png':
        return 'png';
      case 'application/msword':
      case 'doc':
        return 'doc';
      case 'application/vnd.openxmlformats-officedocument.wordprocessingml.document':
      case 'docx':
        return 'docx';
      default:
        return type;
    }
  }

  void _showMessage(String message) {
    final messenger = scaffoldMessengerKey.currentState;
    if (messenger == null) {
      return;
    }

    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(SnackBar(content: Text(message)));
  }
}
