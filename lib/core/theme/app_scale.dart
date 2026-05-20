import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppScale {
  AppScale._();

  /// 🔥 Toggle this to disable scaling globally
  static const bool enableScaling = true;

  static double w(double size) {
    return enableScaling ? size.w : size;
  }

  static double h(double size) {
    return enableScaling ? size.h : size;
  }

  static double r(double size) {
    return enableScaling ? size.r : size;
  }

  static double sp(double size) {
    return enableScaling ? size.sp : size;
  }
}

// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class AppScale {
//   AppScale._();

//   /// 🔥 Toggle this to disable scaling globally
//   static const bool enableScaling = true;

//   /// Returns a custom multiplier based on screen width
//   static double _getConditionalFactor() {
//     double width = ScreenUtil().screenWidth;

//     // Tablet Breakpoint (typically > 600dp)
//     if (width > 600) return 1.25;

//     // Large Phone Breakpoint (typically > 400dp, e.g., iPhone Pro Max)
//     if (width > 400) return 1.1;

//     // Standard Phone
//     return 1.0;
//   }

//   static double w(double size) {
//     return enableScaling
//         ? (size.w * _getConditionalFactor())
//         : (size * _getConditionalFactor());
//   }

//   static double h(double size) {
//     return enableScaling
//         ? (size.h * _getConditionalFactor())
//         : (size * _getConditionalFactor());
//   }

//   static double r(double size) {
//     return enableScaling
//         ? (size.r * _getConditionalFactor())
//         : (size * _getConditionalFactor());
//   }

//   static double sp(double size) {
//     return enableScaling
//         ? (size.sp * _getConditionalFactor())
//         : (size * _getConditionalFactor());
//   }
// }
