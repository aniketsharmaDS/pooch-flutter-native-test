import 'package:flutter/widgets.dart';
import 'package:poochcare/core/theme/app_scale.dart';

class AppSpacing {
  AppSpacing._();

  /// ===============================
  /// CORE SCALE (USE MOSTLY)
  /// ===============================
  static const double s1 = 1;
  static const double s2 = 2;
  static const double s4 = 4;
  static const double s8 = 8;
  static const double s12 = 12;
  static const double s16 = 16;
  static const double s24 = 24;
  static const double s32 = 32;
  static const double s40 = 40;
  static const double s48 = 48;
  static const double s50 = 50;

  /// ===============================
  /// EXTENDED (RARE USE)
  /// ===============================
  static const double s6 = 6;
  static const double s10 = 10;
  static const double s14 = 14;
  static const double s15 = 15;
  static const double s18 = 18;
  static const double s20 = 20;
  static const double s22 = 22;
  static const double s28 = 28;
  static const double s30 = 30;
  static const double s36 = 36;

  /// ===============================
  /// 🔥 CUSTOM SIZES (ALLOWED)
  /// 👉 Add ONLY when needed
  /// ===============================
  static const double s17 = 17;
  static const double s60 = 60;
  static const double s70 = 70;
  static const double s100 = 100;
  static const double s110 = 110;

  /// ===============================
  /// 🔥 Explore Card
  /// ===============================
  static const double s250 = 250;
  static const double s1p5 = 1.5;
  static const double s21 = 21;
  static const double s26 = 26;
  static const double s31 = 31;
  static const double s90 = 90;
  static const double s140 = 140;
  static const double s230 = 230;
  static const double s124 = 124;
  static const double s160 = 160;
  static const double s180 = 180;
  static const double s320 = 320;
  static const double s7 = 7;
  static const double s9 = 9;
  static const double s11 = 11;
  static const double s13 = 13;
  static const double s25 = 25;
  static const double s38 = 38;
  static const double s35 = 35;
  static const double s52 = 52;
  static const double s340 = 340;
  static const double s167 = 167;
  static const double s220 = 220;
  static const double s42 = 42;
  static const double s3 = 3;
  static const double s76 = 76;
  static const double s269 = 269;
  static const double s310 = 310;

  /// ===============================
  /// 🔥 ADDED AT BOTTOM
  /// ===============================
  static const double s5 = 5;
  static const double s44 = 44;
  static const double s56 = 56;
  static const double s72 = 72;
  static const double s80 = 80;
  static const double s108 = 108;
  static const double s112 = 112;
  static const double s300 = 300;
  static const double s12p7 = 12.7;
}

/// 🔥 EXTENSIONS (THIS MAKES EVERYTHING CLEAN)
extension AppSpacingExt on num {
  /// Vertical space → SizedBox
  SizedBox get hBox => SizedBox(height: AppScale.h(toDouble()));

  /// Horizontal space → SizedBox
  SizedBox get wBox => SizedBox(width: AppScale.w(toDouble()));

  /// Width value
  double get w => AppScale.w(toDouble());

  /// Height value
  double get h => AppScale.h(toDouble());

  double get r => AppScale.r(toDouble());
}

// Usage:
/*
1. Vertical Spacing (Column)
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text("Title"),
    AppSpacing.s16.hBox,
    Text("Subtitle"),
  ],
);

2. Horizontal Spacing (Row)
Row(
  children: [
    Icon(Icons.star),
    AppSpacing.s8.wBox,
    Text("4.5"),
  ],
);

3. Width / Height (Container)

Container(
  width: AppSpacing.s32.w,
  height: AppSpacing.s32.h,
  color: const Color(0xFFE0E0E0),
);

4. Padding
Padding(
  padding: EdgeInsets.all(AppSpacing.s16.w),
  child: Text("Hello"),
);

5. Symmetric Padding
Padding(
  padding: EdgeInsets.symmetric(
    horizontal: AppSpacing.s16.w,
    vertical: AppSpacing.s8.h,
  ),
  child: Text("Hello"),
);

6. SizedBox manually (if needed)
SizedBox(
  height: AppSpacing.s20.h,
  width: AppSpacing.s40.w,
);

*/
