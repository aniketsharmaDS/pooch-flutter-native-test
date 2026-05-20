import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/intro_transition/data/models/intro_transition_model.dart';

class TransitionFloatingCard extends StatelessWidget {
  final FloatingCardData data;

  const TransitionFloatingCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadiusSize.r16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.symmetric(
            // horizontal: AppSpacing.s16,
            // vertical: AppSpacing.s12,
            horizontal: data.contentPaddingHorizontal ?? AppSpacing.s16,
            vertical: data.contentPaddingVertical ?? AppSpacing.s12,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(AppRadiusSize.r16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment:
                (data.contentAlignment == FloatingCardContentAlignment.right ||
                    (data.contentAlignment == null && data.contentOnRight))
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (data.customContent != null &&
                  (data.contentAlignment == FloatingCardContentAlignment.left ||
                      (data.contentAlignment == null &&
                          !data.contentOnRight))) ...[
                SizedBox(
                  width: data.contentWidth ?? 30,
                  height: data.contentHeight ?? 30,
                  child: data.customContent!,
                ),
                AppSpacing.s8.wBox,
              ] else if (data.icon != null &&
                  (data.contentAlignment == FloatingCardContentAlignment.left ||
                      (data.contentAlignment == null &&
                          !data.contentOnRight))) ...[
                Icon(data.icon, size: 24, color: Colors.black87),
                AppSpacing.s8.wBox,
              ] else if (data.customContent != null &&
                  data.contentAlignment ==
                      FloatingCardContentAlignment.center) ...[
                SizedBox(
                  width: data.contentWidth ?? 30,
                  height: data.contentHeight ?? 30,
                  child: data.customContent!,
                ),
                if (data.title.isNotEmpty || data.subtitle != null)
                  AppSpacing.s8.wBox,
              ] else if (data.icon != null &&
                  data.contentAlignment ==
                      FloatingCardContentAlignment.center) ...[
                Icon(data.icon, size: 24, color: Colors.black87),
                if (data.title.isNotEmpty || data.subtitle != null)
                  AppSpacing.s8.wBox,
              ],
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data.title.isNotEmpty)
                    AppText.h1(
                      data.title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: AppFontSize.fs16,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  if (data.customSubtitle != null) ...[
                    AppSpacing.s2.hBox,
                    data.customSubtitle!,
                  ] else if (data.subtitle != null) ...[
                    // const SizedBox(height: 2),
                    AppSpacing.s2.hBox,
                    AppText.bodyM(
                      data.subtitle!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.textTertiary),
                    ),
                  ],
                ],
              ),
              if (data.customContent != null &&
                  data.contentOnRight &&
                  data.contentAlignment !=
                      FloatingCardContentAlignment.center) ...[
                AppSpacing.s8.wBox,
                SizedBox(
                  width: data.contentWidth ?? AppSize.cs30,
                  height: data.contentHeight ?? AppSize.cs30,
                  child: data.customContent!,
                ),
              ] else if (data.icon != null &&
                  data.contentOnRight &&
                  data.contentAlignment !=
                      FloatingCardContentAlignment.center) ...[
                AppSpacing.s8.wBox,
                Icon(data.icon, size: AppIconSize.is24, color: Colors.black87),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
