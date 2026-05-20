import 'package:intl/intl.dart';

/// Helper to parse a date/time value stored as a string and render a friendly
/// human readable string. The function is defensive and handles common
/// input types: ISO 8601 strings, epoch milliseconds, or empty/null.
DateTime? _parseDateTime(String? raw) {
  if (raw == null) return null;
  final trimmed = raw.trim();
  if (trimmed.isEmpty) return null;

  DateTime? dt;

  // 1) Try ISO-8601 parsing
  try {
    dt = DateTime.tryParse(trimmed);
  } catch (_) {
    dt = null;
  }

  // 2) Maybe it's epoch millis or seconds
  if (dt == null) {
    final numeric = int.tryParse(trimmed);
    if (numeric != null) {
      // if it's in seconds (10 digits) convert to milliseconds
      if (numeric.abs() < 100000000000) {
        dt = DateTime.fromMillisecondsSinceEpoch(numeric * 1000);
      } else {
        dt = DateTime.fromMillisecondsSinceEpoch(numeric);
      }
    }
  }

  // 3) As a last resort try to parse some common patterns
  if (dt == null) {
    final patterns = [
      'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'',
      'yyyy-MM-dd\'T\'HH:mm:ss\'Z\'',
      'yyyy-MM-dd HH:mm:ss',
      'yyyy-MM-dd',
    ];
    for (final p in patterns) {
      try {
        final parser = DateFormat(p);
        dt = parser.parseLoose(trimmed);
        break; // parsed successfully
      } catch (_) {
        dt = null;
      }
    }
  }

  return dt;
}

String formatDateTimeString(
  String? raw, {
  String fallback = 'N/A',
  String pattern = 'MMM d, yyyy • h:mm a',
}) {
  final dt = _parseDateTime(raw);
  if (dt == null) return fallback;

  // Format according to the provided pattern using the current locale
  try {
    final formatter = DateFormat(pattern);
    return formatter.format(dt.toLocal());
  } catch (_) {
    // Fallback simple formatting
    return DateFormat.yMMMd().add_jm().format(dt.toLocal());
  }
}

String _getDaySuffix(int day) {
  if (day >= 11 && day <= 13) return 'th';
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}

String formatFancyDate(String? raw, {String fallback = 'N/A'}) {
  final dt = _parseDateTime(raw);
  if (dt == null) return fallback;

  final local = dt.toLocal(); // 🔥 important for IST

  final suffix = _getDaySuffix(local.day);

  final datePart = DateFormat('MMM d').format(local);
  final timePart = DateFormat('h:mm a').format(local);

  return '$datePart$suffix, $timePart';
}

/// Returns human-friendly relative time strings like "5m ago", "2h ago" or
/// a short date when older.
String formatRelativeTime(String? raw, {String fallback = 'N/A'}) {
  final dt = _parseDateTime(raw);
  if (dt == null) return fallback;

  final now = DateTime.now();
  final diff = now.difference(dt.toLocal());
  final seconds = diff.inSeconds;
  if (seconds < 5) return 'just now';
  if (seconds < 60) return '${seconds}s ago';

  final minutes = diff.inMinutes;
  if (minutes < 60) return '${minutes}m ago';

  final hours = diff.inHours;
  if (hours < 24) return '${hours}h ago';

  final days = diff.inDays;
  if (days < 7) return '$days ${days > 1 ? 'days' : 'day'} ago';
  if (days < 30) {
    return '${(days / 7).floor()} ${(days / 7).floor() > 1 ? 'weeks' : 'week'} ago';
  }

  // Older than a month: show a short date (e.g., "Feb 4")
  return DateFormat.MMMd().format(dt.toLocal());
}

/// Formats DateTime to custom string format "Tuesday . 05:15 PM" or similar
String formatDateTimeToCustomString(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays == 0) {
    return DateFormat('h:mm a').format(dateTime);
  } else if (difference.inDays < 7) {
    return '${DateFormat('EEEE').format(dateTime)} . ${DateFormat('h:mm a').format(dateTime)}';
  } else {
    return DateFormat('MMM d, y . h:mm a').format(dateTime);
  }
}

/// Formats DateTime to day and month format "Sat, 18 Jan"
String formatDateToDayMonth(DateTime date) {
  return DateFormat('EEE, d MMM').format(date);
}

/// Formats DateTime to day and month format "Sat, 18 Jan"
String formatStringDateToDayMonth(String isoDate) {
  try {
    final dateTime = DateTime.parse(isoDate).toLocal();
    return DateFormat('EEE, d MMM').format(dateTime);
  } catch (e) {
    return '';
  }
}

String formatDateToDateMonth(DateTime date) {
  return DateFormat('d MMM').format(date);
}

/// Formats DateTime to time format "10:00 AM"
String formatTime(DateTime dateTime) {
  return DateFormat('h:mm a').format(dateTime);
}

String formatTimeAgo(String createdAt, {bool isFullDate = true}) {
  try {
    final DateTime dateTime = DateTime.parse(createdAt);
    final Duration difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds < 60) {
      return isFullDate ? 'just now' : 'now';
    } else if (difference.inMinutes < 60) {
      final value = difference.inMinutes;
      return isFullDate
          ? '$value minute${value > 1 ? 's' : ''} ago'
          : '${value}m';
    } else if (difference.inHours < 24) {
      final value = difference.inHours;
      return isFullDate
          ? '$value hour${value > 1 ? 's' : ''} ago'
          : '${value}h';
    } else if (difference.inDays < 7) {
      final value = difference.inDays;
      return isFullDate ? '$value day${value > 1 ? 's' : ''} ago' : '${value}d';
    } else {
      final value = (difference.inDays / 7).floor();
      return isFullDate
          ? '$value week${value > 1 ? 's' : ''} ago'
          : '${value}w';
    }
  } catch (e) {
    return '';
  }
}

String formatDateAndTime({
  String? missingDate, // "2026-02-27"
  String? missingTime, // "4:57 PM" OR "16:57"
}) {
  try {
    // 1. Handle both null/empty
    final hasDate = missingDate != null && missingDate.trim().isNotEmpty;
    final hasTime = missingTime != null && missingTime.trim().isNotEmpty;

    if (!hasDate && !hasTime) return '-';

    DateTime? dateTime;

    // 2. If both date & time exist
    if (hasDate && hasTime) {
      // ignore: unnecessary_non_null_assertion
      final combined = '${missingDate!.trim()} ${missingTime!.trim()}';

      // Try multiple formats safely
      final formats = [
        DateFormat('yyyy-MM-dd h:mm a'), // 12-hour
        DateFormat('yyyy-MM-dd H:mm'), // 24-hour
      ];

      for (final format in formats) {
        try {
          dateTime = format.parseStrict(combined);
          break;
        } catch (_) {}
      }
    }

    // 3. If only date exists OR parsing failed
    if (dateTime == null && hasDate) {
      try {
        // ignore: unnecessary_non_null_assertion
        dateTime = DateFormat('yyyy-MM-dd').parseStrict(missingDate!.trim());
      } catch (_) {
        return '-';
      }
    }

    if (dateTime == null) return '-';

    // 4. Convert to local (safe)
    dateTime = dateTime.toLocal();

    // 5. Format output
    // ignore: unnecessary_non_null_assertion
    if (hasTime && missingTime!.trim().isNotEmpty && dateTime.hour != 0) {
      return DateFormat('d MMM, h:mm a').format(dateTime);
    } else {
      return DateFormat('d MMM').format(dateTime);
    }
  } catch (e) {
    return '-'; // fail-safe
  }
}

String formatPetAge({required DateTime? dob, bool showFullUnit = true}) {
  if (dob == null) return 'Age unknown';

  final now = DateTime.now();

  int years = now.year - dob.year;
  int months = now.month - dob.month;
  int days = now.day - dob.day;

  // Adjust negatives
  if (days < 0) {
    months -= 1;
    final previousMonth = DateTime(now.year, now.month, 0);
    days += previousMonth.day;
  }

  if (months < 0) {
    years -= 1;
    months += 12;
  }

  // Build readable string
  if (years > 0) {
    if (months > 0) {
      return '$years ${showFullUnit ? 'year' : 'Yr'}${years > 1 ? 's' : ''} $months ${showFullUnit ? 'month' : 'Mo'}${months > 1 ? 's' : ''}';
    }
    return '$years ${showFullUnit ? 'year' : 'Yr'}${years > 1 ? 's' : ''}';
  }

  if (months > 0) {
    return '$months ${showFullUnit ? 'months' : 'Mo'}${months > 1 ? 's' : ''}';
  }

  return '$days day${days > 1 ? 's' : ''}';
}

String monthName(int month, {bool short = false}) {
  const full = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  const shortNames = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  final index = month - 1;
  if (index < 0 || index >= full.length) {
    return '';
  }

  return short ? shortNames[index] : full[index];
}

String formatAppointmentDateTime1(String appointmentTime) {
  final dateTime = DateTime.parse(appointmentTime);

  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }

    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  final day = dateTime.day;
  final suffix = getDaySuffix(day);

  final monthYear = DateFormat('MMM, yyyy').format(dateTime);

  final time = DateFormat('hh:mm a').format(dateTime);

  return '$day$suffix $monthYear at $time';
}

String formatAppointmentDateTime(String appointmentTime) {
  final dateTime = DateTime.parse(appointmentTime).toLocal();

  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }

    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  final day = dateTime.day;
  final suffix = getDaySuffix(day);

  final monthYear = DateFormat('MMM, yyyy').format(dateTime);

  final time = DateFormat('hh:mm a').format(dateTime);

  return '$day$suffix $monthYear at $time';
}
