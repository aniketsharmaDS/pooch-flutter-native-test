class ApiResponseJsonParser {
  const ApiResponseJsonParser._(); // prevents instantiation

  // ---------------- STRING ----------------
  static String readString(dynamic value) {
    if (value is String) return value;
    if (value == null) return '';
    return value.toString();
  }

  static String? readNullableString(dynamic value) {
    final text = readString(value).trim();
    return text.isEmpty ? null : text;
  }

  // ---------------- INT ----------------
  static int readInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value.trim()) ?? 0;
    return 0;
  }

  // ---------------- DOUBLE ----------------
  static double readDouble(dynamic value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value.trim()) ?? 0.0;
    return 0.0;
  }

  static double? readNullableDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value.trim());
    return null;
  }

  // ---------------- BOOL ----------------
  static bool readBool(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final v = value.trim().toLowerCase();
      return v == 'true' || v == '1' || v == 'yes';
    }
    return false;
  }

  // ---------------- LIST ----------------
  static List<String> readStringList(dynamic value) {
    if (value is List) {
      return value
          .map((e) => readString(e))
          .where((e) => e.trim().isNotEmpty)
          .toList(growable: false);
    }
    return const <String>[];
  }

  // ---------------- MAP ----------------
  static Map<String, dynamic>? asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, value) => MapEntry(key.toString(), value));
    }
    return null;
  }

  // ---------------- SAFE MAP WRAPPER ----------------
  static T? mapTo<T>(dynamic value, T Function(Map<String, dynamic>) mapper) {
    final map = asMap(value);
    if (map == null) return null;
    return mapper(map);
  }

  // ---------------- UTIL ----------------
  static String firstNonEmpty(List<String?> values) {
    for (final value in values) {
      final v = value?.trim() ?? '';
      if (v.isNotEmpty) return v;
    }
    return '';
  }
}
