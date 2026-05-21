import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:poochcare/core/services/file_validator_service.dart';
import 'package:poochcare/core/services/snackbar_service.dart';
import 'package:poochcare/router/app_router.dart';

enum PickerSourceType { camera, gallery, documents }

/// Service for picking and optionally cropping images from camera, gallery, or documents
class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<List<File>?> pickImage({
    required BuildContext context,
    required PickerSourceType source,
    bool allowMultiple = false,
    bool cropSquare = false,
  }) async {
    try {
      // Handle document picking separately
      if (source == PickerSourceType.documents) {
        return await _handleDocumentPick(
          context: context,
          allowMultiple: allowMultiple,
          cropSquare: cropSquare,
        );
      }

      // Check permissions for camera/gallery
      final hasPermission = await _requestPermission(source);
      if (!hasPermission) {
        return null;
      }
      if (!context.mounted) return null;

      // Handle camera
      if (source == PickerSourceType.camera) {
        return await _handleCameraPick(
          context: context,
          cropSquare: cropSquare,
        );
      }

      // Handle gallery
      return await _handleGalleryPick(
        context: context,
        allowMultiple: allowMultiple,
        cropSquare: cropSquare,
      );
    } catch (_) {
      return null;
    }
  }

  /// Handle document picking
  Future<List<File>?> _handleDocumentPick({
    required BuildContext context,
    required bool allowMultiple,
    required bool cropSquare,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiple,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
    );

    if (!context.mounted) return null;

    final files = _validateAndConvertFiles(result);
    if (files == null || files.isEmpty) return null;

    // Don't crop multiple files or if cropping not requested
    if (allowMultiple || !cropSquare) return files;

    final file = files.first;

    // Only crop image files
    if (!_isImageFile(file.path)) {
      return files;
    }

    if (!context.mounted) return null;
    return await _cropImage(context, file);
  }

  /// Handle camera image capture
  Future<List<File>?> _handleCameraPick({
    required BuildContext context,
    required bool cropSquare,
  }) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (!context.mounted) return null;

    if (pickedFile == null) {
      return null;
    }

    final file = File(pickedFile.path);

    if (!cropSquare) return [file];

    if (!context.mounted) return null;
    return await _cropImage(context, file);
  }

  /// Handle gallery image selection
  Future<List<File>?> _handleGalleryPick({
    required BuildContext context,
    required bool allowMultiple,
    required bool cropSquare,
  }) async {
    // Multiple selection uses FilePicker
    if (allowMultiple) {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
      );
      if (!context.mounted) return null;
      return _validateAndConvertFiles(result);
    }

    // Single selection uses ImagePicker

    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (!context.mounted) return null;

    if (pickedFile == null) {
      return null;
    }

    final file = File(pickedFile.path);

    if (!cropSquare) return [file];

    if (!context.mounted) return null;
    return await _cropImage(context, file);
  }

  /// Crop image by navigating to crop screen
  Future<List<File>?> _cropImage(BuildContext context, File imageFile) async {
    try {
      if (!context.mounted) return null;

      final router = context.router;
      final croppedFile = await router.push<File>(
        ImageCropRoute(imageFile: imageFile),
      );

      if (croppedFile == null) {
        return null;
      }

      return [croppedFile];
    } catch (_) {
      return null;
    }
  }

  /// Check if file is an image based on extension
  bool _isImageFile(String path) {
    final extension = path.toLowerCase();
    return extension.endsWith('.jpg') ||
        extension.endsWith('.jpeg') ||
        extension.endsWith('.png');
  }

  List<File>? _validateAndConvertFiles(FilePickerResult? result) {
    if (result == null || result.files.isEmpty) {
      return null;
    }

    final validFiles = <File>[];
    final invalidFiles = <String>[];

    for (final platformFile in result.files) {
      final path = platformFile.path;
      if (path == null) continue;

      final mimeType = lookupMimeType(path);
      if (mimeType == null) {
        invalidFiles.add(p.basename(path));
        continue;
      }

      // Accept images, PDFs, and Word documents
      if (_isAllowedMimeType(mimeType)) {
        final sizeInBytes = File(path).lengthSync();

        if (FileValidator.validateFile(mimeType, sizeInBytes)) {
          validFiles.add(File(path));
        } else {
          invalidFiles.add(p.basename(path));
        }
      }
    }

    if (invalidFiles.isNotEmpty) {
      CustomSnackbar.show(
        "${invalidFiles.join(', ')} exceeds size limits and were not added.",
        SnackbarType.error,
      );
    }

    return validFiles.isEmpty ? null : validFiles;
  }

  bool _isAllowedMimeType(String mimeType) {
    return mimeType.startsWith('image/') ||
        mimeType == 'application/pdf' ||
        mimeType == 'application/msword' ||
        mimeType ==
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
  }

  /// Request and check permission for camera or gallery
  Future<bool> _requestPermission(PickerSourceType source) async {
    final permission = await _getPermission(source);
    final status = await permission.status;

    if (status.isGranted) return true;

    // 🔴 CASE 1: first-time denial → ask again
    if (status.isDenied) {
      final result = await permission.request();
      return result.isGranted;
    }

    // 🔴 CASE 2: permanently denied → send user to settings
    if (status.isPermanentlyDenied) {
      CustomSnackbar.show(
        'Permission permanently denied. Please enable it from settings.',
        SnackbarType.error,
      );
      await openAppSettings(); // from permission_handler
      return false;
    }

    // 🔴 CASE 3: restricted (iOS parental / system restriction)
    if (status.isRestricted) {
      return false;
    }

    return false;
  }

  /// Get the appropriate permission based on source and platform
  Future<Permission> _getPermission(PickerSourceType source) async {
    if (source == PickerSourceType.camera) {
      return Permission.camera;
    }

    // Gallery/Photos permission varies by platform
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      // Android 13+ uses photos permission
      return androidInfo.version.sdkInt >= 33
          ? Permission.photos
          : Permission.storage;
    }

    // iOS uses photos permission
    return Permission.photos;
  }
}
