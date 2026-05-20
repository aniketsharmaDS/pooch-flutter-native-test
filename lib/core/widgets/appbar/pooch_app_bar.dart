import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

enum PoochAppBarVariant {
  primary, // menu
  secondary, // back
}

class PoochAppBarAction {
  final Widget icon;
  final VoidCallback? onTap;

  const PoochAppBarAction({required this.icon, this.onTap});
}

class PoochAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PoochAppBar({
    super.key,
    required this.userName,
    this.greeting = 'Hey',
    this.welcomeText = 'Welcome',
    this.onMenuTap,
    this.onDateTap,
    this.onNotificationTap,
    this.backgroundColor = AppColors.transparent,
    this.variant = PoochAppBarVariant.primary, // 👈 variatn
    this.actions,
    this.glassEffect = false, // 👈 Glass Effect
  });
  final PoochAppBarVariant variant;
  final List<PoochAppBarAction>? actions;
  final bool glassEffect;
  final String userName;
  final String greeting;
  final String welcomeText;
  final VoidCallback? onMenuTap;
  final VoidCallback? onDateTap;
  final VoidCallback? onNotificationTap;
  final Color backgroundColor;

  @override
  Size get preferredSize => Size.fromHeight(AppSpacing.s60.h);

  @override
  Widget build(BuildContext context) {
    final content = Container(
      height: preferredSize.height,
      color: glassEffect
          ? AppColors.p5_50.withValues(alpha: 0.03) // 👈 semi transparent
          : backgroundColor,
      padding: EdgeInsets.only(right: AppSpacing.s16.w),
      child: Row(
        children: [
          AppCircleButton(
            variant: AppCircleButtonVariant.secondary,
            bgColor: AppColors.transparent,
            size: variant == PoochAppBarVariant.primary
                ? AppCircleButtonSize.large
                : AppCircleButtonSize.small,
            showShadow: false,
            icon: variant == PoochAppBarVariant.primary
                ? AppIcons.svg.appBar.menu
                : AppIcons.svg.generic.chevronLeft,
            iconColor: variant == PoochAppBarVariant.secondary
                ? AppColors.white
                : AppColors.black,
            onTap: () {
              if (variant == PoochAppBarVariant.secondary) {
                Navigator.of(context).maybePop();
              } else {
                onMenuTap?.call();
              }
            },
          ),
          Expanded(
            child: Transform.translate(
              offset: Offset(-10.w, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (userName.isNotEmpty) ...[
                    AppText.bodyM(
                      '$greeting $userName,',
                      color: const Color(0xFF74706C),
                      fontSize: AppFontSize.fs14,
                      maxLines: 1,
                    ),
                    SizedBox(height: AppSpacing.s2.h),
                  ],
                  AppText.h1(
                    welcomeText,
                    color: variant == PoochAppBarVariant.secondary
                        ? AppColors.white
                        : AppColors.black,
                    fontSize: AppFontSize.fs18,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
          // AppCircleButton(
          //   variant: AppCircleButtonVariant.secondary,
          //   showShadow: false,
          //   icon: AppIcons.svg.appBar.calendar,
          //   onTap: () => onDateTap?.call(),
          // ),
          // AppCircleButton(
          //   variant: AppCircleButtonVariant.secondary,
          //   showShadow: false,
          //   icon: AppIcons.svg.appBar.bell,
          //   onTap: () => onNotificationTap?.call(),
          // ),
          if (actions != null && actions!.isNotEmpty)
            ...actions!.map(
              (action) => Padding(
                padding: EdgeInsets.only(left: AppSpacing.s8.w),
                child: GestureDetector(onTap: action.onTap, child: action.icon),
              ),
            )
          else ...[
            /// ✅ DEFAULT ICONS (keep this)
            AppCircleButton(
              variant: AppCircleButtonVariant.secondary,
              showShadow: false,
              icon: AppIcons.svg.appBar.calendar,
              onTap: () => onDateTap?.call(),
            ),
            AppCircleButton(
              variant: AppCircleButtonVariant.secondary,
              showShadow: false,
              icon: AppIcons.svg.appBar.bell,
              onTap: () => onNotificationTap?.call(),
            ),
          ],
        ],
      ),
    );

    return SafeArea(
      bottom: false,
      child: glassEffect
          ? ClipRRect(
              borderRadius: BorderRadius.circular(0), // or 16 if needed
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 12,
                  sigmaY: 12,
                ), // 👈 blur strength
                child: content,
              ),
            )
          : content,
    );
  }
}
