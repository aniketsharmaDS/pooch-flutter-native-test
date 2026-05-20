import 'package:path/path.dart' as p;

String inferDocumentFileType({required String? url, String fallback = 'jpeg'}) {
  final normalized = _normalizeDocumentType(_fileTypeFromValue(url));
  return normalized.isEmpty ? fallback : normalized;
}

String _fileTypeFromValue(String? value) {
  final input = (value ?? '').trim();
  if (input.isEmpty) {
    return '';
  }

  final uri = Uri.tryParse(input);
  if (uri != null && uri.hasScheme && uri.path.trim().isNotEmpty) {
    final extension = p.extension(uri.path);
    if (extension.isNotEmpty) {
      return extension;
    }
    return p.basename(uri.path);
  }

  return input;
}

String _normalizeDocumentType(String? rawType) {
  final value = (rawType ?? '').trim().toLowerCase();
  if (value.isEmpty) {
    return '';
  }

  final withoutDot = value.startsWith('.') ? value.substring(1) : value;

  switch (withoutDot) {
    case 'application/pdf':
    case 'pdf':
      return 'pdf';
    case 'image/jpeg':
    case 'image/jpg':
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
      return withoutDot;
  }
}

enum FileType { pdf, image, video, audio, document, unknown }

FileType getFileTypeSmart({
  String? fileType, // 👈 optional backend type
  String? fileName, // 👈 optional
  String? fileUrl, // 👈 optional
}) {
  // 1️⃣ PRIORITY: backend-provided fileType
  if (fileType != null && fileType.trim().isNotEmpty) {
    final normalized = fileType.toLowerCase().trim();

    switch (normalized) {
      case 'pdf':
        return FileType.pdf;
      case 'image':
      case 'img':
      case 'photo':
        return FileType.image;
      case 'video':
        return FileType.video;
      case 'audio':
        return FileType.audio;
      case 'document':
      case 'doc':
        return FileType.document;
    }
  }

  // 2️⃣ fallback: derive from fileName or fileUrl
  final name = (fileName ?? '').toLowerCase();
  final url = (fileUrl ?? '').toLowerCase();

  String? ext;

  // try filename
  if (name.contains('.')) {
    ext = name.split('.').last;
  }

  // fallback url (remove query params like S3 signed URLs)
  if (ext == null && url.isNotEmpty) {
    final cleanUrl = url.split('?').first;
    if (cleanUrl.contains('.')) {
      ext = cleanUrl.split('.').last;
    }
  }

  if (ext == null) return FileType.unknown;

  // 3️⃣ extension mapping
  const imageExt = ['jpg', 'jpeg', 'png', 'gif', 'webp', 'heic'];
  const videoExt = ['mp4', 'mov', 'avi', 'mkv', 'webm'];
  const audioExt = ['mp3', 'wav', 'aac', 'm4a', 'ogg'];
  const docExt = ['doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'txt'];

  if (ext == 'pdf') return FileType.pdf;
  if (imageExt.contains(ext)) return FileType.image;
  if (videoExt.contains(ext)) return FileType.video;
  if (audioExt.contains(ext)) return FileType.audio;
  if (docExt.contains(ext)) return FileType.document;

  return FileType.unknown;
}
