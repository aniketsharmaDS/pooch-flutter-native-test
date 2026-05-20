import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';

/// Reusable full-screen loader widget.
/// Customizable via parameters or by passing a custom child.
class AppLoader extends StatelessWidget {
  final Color? overlayColor;
  final double? size;
  final Color? spinnerColor;
  final Widget? child;

  const AppLoader({
    super.key,
    this.overlayColor,
    this.size,
    this.spinnerColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final overlayColor = this.overlayColor ?? AppColors.primaryBackdrop;
    final spinnerColor = this.spinnerColor ?? AppColors.primary;
    return Container(
      color: overlayColor,
      alignment: Alignment.center,
      child:
          child ??
          SizedBox(
            width: size ?? 32.w,
            height: size ?? 32.w,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(spinnerColor),
              strokeWidth: 5,
            ),
          ),
    );
  }
}
