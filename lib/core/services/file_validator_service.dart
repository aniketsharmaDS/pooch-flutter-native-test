import 'package:poochcare/core/services/snackbar_service.dart';

class FileValidator {
  // Define your Maximum Limits (in Bytes)
  static const int maxImageBytes = 1 * 1024 * 1024; // 1 MB
  static const int maxPdfBytes = 5 * 1024 * 1024; // 5 MB
  static const int maxDocBytes = 5 * 1024 * 1024;

  static bool validateSize(int fileSize, int maxLimit, String typeName) {
    if (fileSize > maxLimit) {
      double sizeMB = fileSize / (1024 * 1024);
      double limitMB = maxLimit / (1024 * 1024);
      CustomSnackbar.show(
        '$typeName size (${sizeMB.toStringAsFixed(2)} MB) exceeds the limit of ${limitMB.toStringAsFixed(2)} MB.',
        SnackbarType.error,
      );
      return false;
    }
    return true;
  }

  static bool validateFile(String? mimeType, int sizeInBytes) {
    bool isValid = true;
    if (mimeType == null) {
      CustomSnackbar.show('Could not determine file type', SnackbarType.error);
      return false;
    } else if (mimeType.startsWith('image/')) {
      isValid = FileValidator.validateSize(
        sizeInBytes,
        FileValidator.maxImageBytes,
        'Image',
      );
    } else if (mimeType == 'application/pdf') {
      isValid = FileValidator.validateSize(
        sizeInBytes,
        FileValidator.maxPdfBytes,
        'PDF',
      );
    } else if (mimeType ==
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document') {
      isValid = FileValidator.validateSize(
        sizeInBytes,
        FileValidator.maxDocBytes,
        'DOC',
      );
    } else {
      return false;
    }
    return isValid;
  }
}
