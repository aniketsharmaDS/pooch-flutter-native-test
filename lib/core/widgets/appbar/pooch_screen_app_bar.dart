import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class PoochScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? titleWidget;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  const PoochScreenAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.titleWidget,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: AppCircleButton(
        variant: AppCircleButtonVariant.secondary,
        bgColor: AppColors.transparent,
        showShadow: false,
        icon: Directionality.of(context) == TextDirection.rtl
            ? AppIcons.svg.generic.chevronRight
            : AppIcons.svg.generic.chevronLeft,
        size: AppCircleButtonSize.large,
        iconSize: AppIconSize.is20,
        onTap: onBack ?? () => Navigator.pop(context),
      ),
      title:
          titleWidget ??
          AppText.h1(
            title,
            fontSize: AppFontSize.fs16,
            style: const TextStyle(height: 1.2),
          ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
