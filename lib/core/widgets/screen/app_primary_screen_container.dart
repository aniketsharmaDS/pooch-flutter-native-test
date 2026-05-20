import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart'
    show PoochScreenAppBar;
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';

class AppPrimaryScreenContainer extends StatelessWidget {
  final String title;
  final Widget child;
  final bool showBack;
  final List<Widget>? actions;
  final VoidCallback? onBack;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;

  const AppPrimaryScreenContainer({
    super.key,
    required this.title,
    required this.child,
    this.onBack,
    this.showBack = true,
    this.actions,
    this.backgroundColor = AppColors.transparent,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppPrimaryBgContainer(
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: backgroundColor,
        appBar: PoochScreenAppBar(
          title: title,
          onBack: showBack
              ? (onBack ?? () => Navigator.of(context).pop())
              : null,
          actions: actions ?? [],
        ),
        body: child,
        bottomNavigationBar: bottomNavigationBar == null
            ? null
            : SafeArea(
                child: bottomNavigationBar!,
              ), // If no bottomNavigationBar is provided, set it to null
      ),
    );
  }
}
