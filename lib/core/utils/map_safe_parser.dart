import 'package:poochcare/core/utils/safe_parser_service.dart';

extension MapSafeParser on Map<String, dynamic>? {
  /// Safely get a String, defaults to empty string
  String s(String key, {String def = ''}) =>
      SafeParserService.parseString(this?[key], defaultValue: def);

  /// Safely get an Int, defaults to 0
  int i(String key, {int def = 0}) =>
      SafeParserService.parseInt(this?[key], defaultValue: def);

  /// Safely get a Double, defaults to 0.0
  double d(String key, {double def = 0.0}) =>
      SafeParserService.parseDouble(this?[key], defaultValue: def);

  /// Safely get a Bool, defaults to false
  bool b(String key, {bool def = false}) =>
      SafeParserService.parseBool(this?[key], defaultValue: def);

  /// Safely get a DateTime
  DateTime? date(String key) => SafeParserService.parseDateTime(this?[key]);

  /// Safely parse a List of objects
  List<T> list<T>(String key, T Function(dynamic) fromJson) =>
      SafeParserService.parseList<T>(this?[key], fromJson: fromJson);

  /// Safely parse a nested Map
  Map<String, dynamic> parseMap(String key) =>
      SafeParserService.parseMap(this?[key]);
}
