import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

enum PrimaryWidgetHeaderVariant { standard, centered }

class PrimaryWidgetHeader extends StatelessWidget {
  final String title;
  final String? buttonTitle;
  final VoidCallback? onButtonTap;
  final PrimaryWidgetHeaderVariant variant;
  final double? fontSize;
  final bool removePadding;

  const PrimaryWidgetHeader({
    super.key,
    required this.title,
    this.buttonTitle,
    this.onButtonTap,
    this.variant = PrimaryWidgetHeaderVariant.standard,
    this.fontSize,
    this.removePadding = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool showButton =
        buttonTitle != null && buttonTitle!.trim().isNotEmpty;

    if (variant == PrimaryWidgetHeaderVariant.centered) {
      return Padding(
        padding: removePadding
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(
                horizontal: AppSpacing.s16.w,
                vertical: AppSpacing.s10.h,
              ),
        child: SizedBox(
          height: AppSize.cs32.csh,
          child: Center(
            child: AppText.h1(
              title,
              fontSize: AppFontSize.fs18,
              color: const Color(0XFF3F3C36),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: removePadding
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(
              horizontal: AppSpacing.s16.w,
              vertical: AppSpacing.s10.h,
            ),
      child: SizedBox(
        height: AppSize.cs32.csh,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// TITLE
            Expanded(
              child: AppText.h1(
                title,
                fontSize: fontSize ?? AppFontSize.fs18,
                color: const Color(0XFF3F3C36),
              ),
            ),

            /// BUTTON (optional)
            if (showButton)
              AppButton(
                disableRippleEffect: true,
                width: null,
                label: buttonTitle!,
                size: AppButtonSize.xSmall,
                onPressed: onButtonTap,
                variant: AppButtonVariant.text,
                padding: EdgeInsets.only(
                  right: AppSpacing.s1.w,
                  left: AppSpacing.s10.w,
                ),
                trailingSvgAsset: AppIcons.svg.generic.chevronRight,
              ),
          ],
        ),
      ),
    );
  }
}
