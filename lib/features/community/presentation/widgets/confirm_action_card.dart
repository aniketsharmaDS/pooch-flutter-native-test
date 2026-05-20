import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/theme/app_typography.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/checkbox/app_checkbox.dart';

class ConfirmActionCardModel {
  final String id;
  final String disclaimerText;
  final String primaryButtonLabel;
  final String secondaryButtonLabel;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;

  const ConfirmActionCardModel({
    required this.id,
    required this.disclaimerText,
    required this.primaryButtonLabel,
    required this.secondaryButtonLabel,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
  });
}

class ConfirmActionCard extends StatefulWidget {
  final ConfirmActionCardModel model;

  const ConfirmActionCard({super.key, required this.model});

  @override
  State<ConfirmActionCard> createState() => _ConfirmActionCardState();
}

class _ConfirmActionCardState extends State<ConfirmActionCard> {
  late bool _isAgreed;

  @override
  void initState() {
    super.initState();
    _isAgreed = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// CHECKBOX WITH DISCLAIMER TEXT (ROW)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// CHECKBOX
            Padding(
              padding: EdgeInsets.only(top: AppSpacing.s4.h),
              child: AppCheckbox(
                value: _isAgreed,
                onChanged: (val) {
                  setState(() => _isAgreed = val ?? false);
                },
                padding: EdgeInsets.zero,
              ),
            ),
            AppSpacing.s8.wBox,

            /// DISCLAIMER TEXT WITH UNDERLINED LINKS
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: AppTypography.support.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                  children: [
                    const TextSpan(
                      text: 'By submitting this tip, you agree to our ',
                    ),
                    TextSpan(
                      text: 'Terms & Conditions',
                      style: AppTypography.support.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.textSecondary,
                        decorationThickness: 1.5,
                      ),
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Community Guidelines',
                      style: AppTypography.support.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.textSecondary,
                        decorationThickness: 1.5,
                      ),
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
            ),
          ],
        ),
        AppSpacing.s16.hBox,

        /// BUTTONS COLUMN (FULL WIDTH, STACKED)
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// PRIMARY BUTTON (FILLED) - FULL WIDTH
            AppButton(
              label: widget.model.primaryButtonLabel,
              onPressed: _isAgreed ? widget.model.onPrimaryPressed : null,
              height: AppSpacing.s48.h,
            ),
            AppSpacing.s8.hBox,

            /// SECONDARY BUTTON (OUTLINED) - FULL WIDTH
            AppButton(
              label: widget.model.secondaryButtonLabel,
              variant: AppButtonVariant.outlined,
              onPressed: _isAgreed ? widget.model.onSecondaryPressed : null,
              backgroundColor: AppColors.white,
              height: AppSpacing.s48.h,
            ),
          ],
        ),
      ],
    );
  }
}
