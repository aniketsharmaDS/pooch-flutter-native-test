import 'package:poochcare/core/utils/parser_utils.dart';

class ClinicOperatingHoursDayModel {
  const ClinicOperatingHoursDayModel({
    required this.isClosed,
    required this.openTime,
    required this.closeTime,
  });

  final bool isClosed;
  final String openTime;
  final String closeTime;

  factory ClinicOperatingHoursDayModel.fromMap(Map<String, dynamic> map) {
    return ClinicOperatingHoursDayModel(
      isClosed: ParserUtils.readBool(map['is_closed']),
      openTime: ParserUtils.readString(map['open_time']),
      closeTime: ParserUtils.readString(map['close_time']),
    );
  }

  @override
  String toString() {
    return '{isClosed: $isClosed, openTime: $openTime, closeTime: $closeTime}';
  }
}

class ClinicOperatingHoursModel {
  const ClinicOperatingHoursModel({required this.days});

  /// Keys: monday, tuesday, ...
  final Map<String, ClinicOperatingHoursDayModel> days;

  factory ClinicOperatingHoursModel.fromMap(Map<String, dynamic> map) {
    final result = <String, ClinicOperatingHoursDayModel>{};

    map.forEach((key, value) {
      final dayMap = ParserUtils.readMap(value);

      if (dayMap.isNotEmpty) {
        result[key] = ClinicOperatingHoursDayModel.fromMap(dayMap);
      }
    });

    return ClinicOperatingHoursModel(days: result);
  }

  @override
  String toString() {
    return 'ClinicOperatingHoursModel(days: $days)';
  }
}
