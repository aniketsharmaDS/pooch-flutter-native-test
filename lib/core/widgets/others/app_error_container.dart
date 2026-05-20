import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class AppErrorContainer extends StatelessWidget {
  final bool showError;
  final String? errorMessage;
  final Widget child;

  const AppErrorContainer({
    super.key,
    this.errorMessage,
    required this.showError,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        errorBorder: InputBorder.none,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,

        // errorText: showError ? errorMessage : null,
        error: showError
            ? Padding(
                padding: EdgeInsetsGeometry.only(left: 18.w),
                child: AppText.bodyS(
                  errorMessage ?? 'Please select a value',
                  color: AppColors.error,
                ),
              )
            : null,
      ),
      child: child,
    );
  }
}
