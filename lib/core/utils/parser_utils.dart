class ParserUtils {
  static String readString(dynamic value, {String def = ''}) {
    if (value is String && value.trim().isNotEmpty) return value;
    if (value == null) return def;
    final str = value.toString().trim();
    return str.isEmpty ? def : str;
  }

  static int readInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value.trim()) ?? 0;
    return 0;
  }

  static bool readBool(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final v = value.trim().toLowerCase();
      if (v == 'true' || v == '1' || v == 'yes') return true;
      if (v == 'false' || v == '0' || v == 'no') return false;
    }
    return false;
  }

  static int? readNullableInt(dynamic value) {
    if (value == null) return null;

    if (value is int) return value;
    if (value is num) return value.toInt();

    if (value is String) {
      final parsed = int.tryParse(value.trim());
      return parsed;
    }

    return null;
  }

  static double? readNullableDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value.trim());
    return null;
  }

  static Map<String, dynamic> readMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;

    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }

    return {};
  }

  static String? readNullableString(dynamic value) {
    if (value == null) return null;
    final text = readString(value);
    return text.trim().isEmpty ? null : text;
  }

  static List<String> readStringList(dynamic value) {
    if (value is List) {
      return value
          .map((e) => readString(e))
          .where((e) => e.trim().isNotEmpty)
          .toList(growable: false);
    }
    return const [];
  }

  static double readDouble(dynamic value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value.trim()) ?? 0.0;
    return 0.0;
  }
}
