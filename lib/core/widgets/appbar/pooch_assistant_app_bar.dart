import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';

class PoochAssistantAppBar extends StatelessWidget {
  const PoochAssistantAppBar({super.key, this.onClose});

  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.s16.w,
        vertical: AppSpacing.s12.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 🔹 Left: Assistant Icon
          AppIcon(
            AppIcons.svg.generic.poochAssistant,
            height: AppSize.cs18.h,
            width: AppSize.cs18.w,
          ),

          // 🔹 Right: Close Button
          GestureDetector(
            onTap: onClose ?? () => context.router.maybePop(),
            child: AppIcon(
              AppIcons.svg.generic.close,
              height: AppSize.cs24.h,
              width: AppSize.cs24.w,
            ),
          ),
        ],
      ),
    );
  }
}
