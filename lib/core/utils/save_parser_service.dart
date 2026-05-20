class SafeParserService {
  /// Safely parses any value to a String.
  static String parseString(dynamic value, {String defaultValue = ''}) {
    if (value == null) return defaultValue;
    try {
      return value.toString();
    } catch (_) {
      return defaultValue;
    }
  }

  /// Safely parses any value to an int.
  static int parseInt(dynamic value, {int defaultValue = 0}) {
    if (value == null) return defaultValue;
    try {
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value) ?? defaultValue;
      return defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }

  /// Safely parses any value to a double.
  static double parseDouble(dynamic value, {double defaultValue = 0.0}) {
    if (value == null) return defaultValue;
    try {
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? defaultValue;
      return defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }

  /// Safely parses any value to a bool.
  static bool parseBool(dynamic value, {bool defaultValue = false}) {
    if (value == null) return defaultValue;
    try {
      if (value is bool) return value;
      if (value is num) return value != 0;
      if (value is String) {
        final lower = value.toLowerCase();
        if (['true', 'yes', '1'].contains(lower)) return true;
        if (['false', 'no', '0'].contains(lower)) return false;
      }
      return defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }

  /// Safely parses any value to a DateTime.
  static DateTime? parseDateTime(dynamic value, {DateTime? defaultValue}) {
    if (value == null) return defaultValue;
    try {
      if (value is DateTime) return value;
      if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
      if (value is String && value.isNotEmpty) return DateTime.tryParse(value);
      return defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }

  /// Safely parses any list.
  static List<T> parseList<T>(
    dynamic value, {
    T Function(dynamic)? fromJson,
    List<T> defaultValue = const [],
  }) {
    // 1. Basic check: if it's not a list, return default.
    if (value == null || value is! List) return defaultValue;

    try {
      if (fromJson != null) {
        // 2. Map items individually with internal safety
        return value
            .map((e) {
              try {
                return fromJson(e);
              } catch (e) {
                return null; // Temporarily mark as null if one item fails
              }
            })
            .whereType<
              T
            >() // 3. This removes any nulls or mismatched types safely
            .toList();
      } else {
        // 4. Safe casting: only take items that actually match type T
        return value.whereType<T>().toList();
      }
    } catch (_) {
      return defaultValue;
    }
  }

  /// Safely parses any map.
  static Map<String, dynamic> parseMap(
    dynamic value, {
    Map<String, dynamic> defaultValue = const {},
  }) {
    if (value == null || value is! Map) return defaultValue;
    try {
      return Map<String, dynamic>.from(value);
    } catch (_) {
      return defaultValue;
    }
  }

  static String formatPrice(dynamic price) {
    final value = double.tryParse(price.toString()) ?? 0;

    return value % 1 == 0 ? value.toInt().toString() : value.toString();
  }
}
