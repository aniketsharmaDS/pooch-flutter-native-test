import 'package:dart_mappable/dart_mappable.dart';

/// ----------------------
/// STRING
/// ----------------------
class SafeStringHook extends MappingHook {
  final String defaultValue;
  const SafeStringHook({this.defaultValue = ''});

  @override
  Object? beforeDecode(Object? value) {
    if (value == null) return defaultValue;
    if (value is String) return value;
    return value.toString();
  }
}

/// ----------------------
/// INT
/// ----------------------
class SafeIntHook extends MappingHook {
  const SafeIntHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value == null) return 0;

    if (value is int) return value;

    if (value is double) return value.toInt();

    if (value is num) return value.toInt();

    if (value is String) {
      final v = value.trim();
      if (v.isEmpty) return 0;

      return int.tryParse(v) ?? double.tryParse(v)?.toInt() ?? 0;
    }

    return 0;
  }
}

/// ----------------------
/// DOUBLE
/// ----------------------
class SafeDoubleHook extends MappingHook {
  const SafeDoubleHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value == null) return 0.0;

    if (value is double) return value;

    if (value is int) return value.toDouble();

    if (value is num) return value.toDouble();

    if (value is String) {
      final v = value.trim();
      if (v.isEmpty) return 0.0;

      return double.tryParse(v) ?? 0.0;
    }

    return 0.0;
  }
}

/// ----------------------
/// BOOL
/// ----------------------
class SafeBoolHook extends MappingHook {
  const SafeBoolHook();

  static const _trueValues = {'true', '1', 'yes', 'y', 'on'};

  static const _falseValues = {'false', '0', 'no', 'n', 'off'};

  @override
  Object? beforeDecode(Object? value) {
    if (value == null) return false;

    if (value is bool) return value;

    if (value is num) return value != 0;

    if (value is String) {
      final v = value.trim().toLowerCase();

      if (_trueValues.contains(v)) return true;
      if (_falseValues.contains(v)) return false;

      return false;
    }

    return false;
  }
}

/// ----------------------
/// DATETIME
/// ----------------------
class SafeDateTimeHook extends MappingHook {
  const SafeDateTimeHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value == null) return null;

    if (value is DateTime) return value;

    if (value is int) {
      // timestamp support (ms or sec)
      if (value > 1000000000000) {
        return DateTime.fromMillisecondsSinceEpoch(value);
      } else {
        return DateTime.fromMillisecondsSinceEpoch(value * 1000);
      }
    }

    if (value is String) {
      final v = value.trim();
      if (v.isEmpty) return null;

      try {
        return DateTime.parse(v);
      } catch (_) {
        return null;
      }
    }

    return null;
  }
}

/// ----------------------
/// LIST (GENERIC)
/// ----------------------
class SafeListHook<T> extends MappingHook {
  const SafeListHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is List) return value;
    return <T>[];
  }
}
