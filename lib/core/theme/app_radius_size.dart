import 'package:poochcare/core/theme/app_scale.dart';

class AppRadiusSize {
  AppRadiusSize._();

  /// ===============================
  /// CORE SCALE (USE MOSTLY)
  /// ===============================
  static const double r1 = 1;
  static const double r1p5 = 1.5;
  static const double r2 = 2;
  static const double r4 = 4;
  static const double r5 = 5;
  static const double r8 = 8;
  static const double r12 = 12;
  static const double r16 = 16;
  static const double r18 = 18;
  static const double r20 = 20;

  /// ===============================
  /// EXTENDED (RARE USE)
  /// ===============================
  static const double r6 = 6;
  static const double r10 = 10;

  /// ===============================
  /// 🔥 CUSTOM SIZES (ALLOWED)
  /// 👉 Add ONLY when needed
  /// ===============================
  static const double r15 = 15;
  static const double r24 = 24;
  static const double r25 = 25;
  static const double r36 = 36;
  static const double r50 = 50;
  static const double r56 = 56;
  static const double r58 = 58;
  static const double r60 = 60;
  static const double r76 = 76;
  static const double r80 = 80;
}

/// 🔥 EXTENSIONS (THIS MAKES EVERYTHING CLEAN)
extension AppRadiusSizeExt on num {
  double get rr => AppScale.r(toDouble());
}
