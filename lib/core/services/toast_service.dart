import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:poochcare/core/theme/app_colors.dart';

class ToastService {
  const ToastService._();
  static Future<bool?> show(
    String message, {
    Toast length = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Color backgroundColor = AppColors.p5_900,
    Color textColor = AppColors.white,
    double fontSize = 14,
  }) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: gravity,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  static Future<bool?> showSuccess(String message) {
    return show(message, backgroundColor: AppColors.messageSuccess);
  }

  static Future<bool?> showError(String message) {
    return show(message, backgroundColor: AppColors.messageError);
  }

  static Future<bool?> showInfo(String message) {
    return show(message, backgroundColor: AppColors.messageInfo);
  }
}
