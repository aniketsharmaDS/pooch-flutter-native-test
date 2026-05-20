import 'package:poochcare/core/theme/app_scale.dart';

class AppIconSize {
  AppIconSize._();

  /// ===============================
  /// CORE SCALE (USE MOSTLY)
  /// ===============================
  static const double is2 = 2;
  static const double is4 = 4;
  static const double is8 = 8;
  static const double is12 = 12;
  static const double is16 = 16;
  static const double is24 = 24;
  static const double is32 = 32;
  static const double is40 = 40;
  static const double is48 = 48;
  static const double is50 = 50;

  /// ===============================
  /// EXTENDED (RARE USE)
  /// ===============================
  static const double is6 = 6;
  static const double is10 = 10;
  static const double is14 = 14;
  static const double is18 = 18;
  static const double is20 = 20;
  static const double is28 = 28;
  static const double is30 = 30;
  static const double is36 = 36;

  /// ===============================
  /// 🔥 CUSTOM SIZES (ALLOWED)
  /// 👉 Add ONLY when needed
  /// ===============================
  static const double is60 = 60;
}

/// 🔥 EXTENSIONS (THIS MAKES EVERYTHING CLEAN)
extension AppIconSizeExt on num {
  /// Width value
  double get iw => AppScale.w(toDouble());

  /// Height value
  double get ih => AppScale.h(toDouble());

  double get ir => AppScale.sp(toDouble());
}
