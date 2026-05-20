class OperatingHours {
  final DayConfig? monday;
  final DayConfig? tuesday;
  final DayConfig? wednesday;
  final DayConfig? thursday;
  final DayConfig? friday;
  final DayConfig? saturday;
  final DayConfig? sunday;

  OperatingHours({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  factory OperatingHours.fromMap(Map<String, dynamic> map) {
    return OperatingHours(
      monday: _parseDayConfig(map['monday']),
      tuesday: _parseDayConfig(map['tuesday']),
      wednesday: _parseDayConfig(map['wednesday']),
      thursday: _parseDayConfig(map['thursday']),
      friday: _parseDayConfig(map['friday']),
      saturday: _parseDayConfig(map['saturday']),
      sunday: _parseDayConfig(map['sunday']),
    );
  }

  static DayConfig? _parseDayConfig(dynamic value) =>
      value is Map<String, dynamic> ? DayConfig.fromJson(value) : null;

  /// Helper to get config by DateTime weekday (1 = Monday, 7 = Sunday)
  DayConfig? getByWeekday(int day) {
    switch (day) {
      case DateTime.monday:
        return monday;
      case DateTime.tuesday:
        return tuesday;
      case DateTime.wednesday:
        return wednesday;
      case DateTime.thursday:
        return thursday;
      case DateTime.friday:
        return friday;
      case DateTime.saturday:
        return saturday;
      case DateTime.sunday:
        return sunday;
      default:
        return null;
    }
  }
}

class DayConfig {
  final bool isClosed;
  final String openTime;
  final String closeTime;

  DayConfig({
    required this.isClosed,
    required this.openTime,
    required this.closeTime,
  });

  // Manual mapping from Map
  factory DayConfig.fromJson(Map<String, dynamic> map) {
    return DayConfig(
      isClosed: (map['is_closed'] as bool?) ?? false,
      openTime: (map['open_time'] as String?) ?? '',
      closeTime: (map['close_time'] as String?) ?? '',
    );
  }
}
