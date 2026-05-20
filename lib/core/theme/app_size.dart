import 'package:poochcare/core/theme/app_scale.dart';

class AppSize {
  AppSize._();

  /// ===============================
  /// CORE SCALE (USE MOSTLY)
  /// ===============================
  static const double cs0p6 = 0.6;
  static const double cs1 = 1;
  static const double cs8 = 8;
  static const double cs12 = 12;
  static const double cs14 = 14;
  static const double cs16 = 16;
  static const double cs18 = 18;
  static const double cs24 = 24;
  static const double cs30 = 30;
  static const double cs40 = 40;
  static const double cs45 = 45;
  static const double cs46 = 46;
  static const double cs50 = 50;
  static const double cs56 = 56;
  static const double cs80 = 80;
  static const double cs90 = 90;
  static const double cs100 = 100;

  /// ===============================
  /// EXTENDED (RARE USE)
  /// ===============================
  static const double cs4 = 9;
  static const double cs6 = 6;
  static const double cs10 = 10;
  static const double cs26 = 26;
  static const double cs32 = 32;
  static const double cs35 = 35;
  static const double cs36 = 36;
  static const double cs95 = 95;

  /// ===============================
  /// 🔥 CUSTOM SIZES (ALLOWED)
  /// 👉 Add ONLY when needed
  /// ===============================
  static const double cs48 = 48;
  static const double cs60 = 60;
  static const double cs62 = 62;
  static const double cs65 = 65;
  static const double cs68 = 68;
  static const double cs70 = 70;
  static const double cs74 = 74;
  static const double cs75 = 75;
  static const double cs82 = 82;
  static const double cs84 = 84;
  static const double cs85 = 85;
  static const double cs96 = 96;
  static const double cs103 = 103;
  static const double cs110 = 110;
  static const double cs120 = 120;
  static const double cs130 = 130;
  static const double cs132 = 132;
  static const double cs142 = 142;
  static const double cs165 = 165;
  static const double cs150 = 150;
  static const double cs155 = 155;
  static const double cs170 = 170;
  static const double cs180 = 180;
  static const double cs200 = 200;
  static const double cs210 = 210;
  static const double cs220 = 220;
  static const double cs250 = 250;
  static const double cs260 = 260;
  static const double cs300 = 300;
  static const double cs320 = 320;
  static const double cs330 = 330;
  static const double cs350 = 350;
}

/// 🔥 EXTENSIONS (THIS MAKES EVERYTHING CLEAN)
extension AppSizeExt on num {
  /// Width value
  double get csw => AppScale.w(toDouble());

  /// Height value
  double get csh => AppScale.h(toDouble());
}
