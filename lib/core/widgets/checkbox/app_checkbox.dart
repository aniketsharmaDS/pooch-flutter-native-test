import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class AppCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String? label;
  final bool isDisabled;
  final double size;
  final Color? activeColor;
  final Color? borderColor;
  final Color? checkColor;
  final EdgeInsetsGeometry padding;

  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.isDisabled = false,
    this.size = 20,
    this.activeColor,
    this.borderColor,
    this.checkColor,
    this.padding = const EdgeInsets.all(4),
  });

  @override
  Widget build(BuildContext context) {
    final effectiveActiveColor = activeColor ?? AppColors.activeColor;

    final effectiveBorderColor = borderColor ?? AppColors.inActiveColor;

    final checkbox = SizedBox(
      height: size,
      width: size,
      child: Checkbox.adaptive(
        side: WidgetStateBorderSide.resolveWith((states) {
          // final isChecked = states.contains(WidgetState.selected);
          return BorderSide(
            width: AppSize.cs0p6.csh,
            // width: isChecked ? AppSize.cs1.csh : AppSize.cs0p6.csh,
            color: effectiveBorderColor,
          );
        }),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(AppRadiusSize.r1.rr),
        ),
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (isDisabled) {
            return AppColors.activeColor.withValues(alpha: 0.5);
          }
          if (value) {
            return effectiveActiveColor; // checked
          }
          return Colors.transparent; // unchecked (no more grey)
        }),
        activeColor: effectiveActiveColor,
        value: value,
        onChanged: isDisabled ? null : onChanged,
      ),
    );

    return Opacity(
      opacity: isDisabled ? 0.5 : 1,
      child: InkWell(
        onTap: isDisabled ? null : () => onChanged?.call(!value),
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: padding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              checkbox,
              if (label != null) ...[
                AppSpacing.s8.wBox,
                Flexible(
                  child: AppText.support(
                    label!,
                    variant: AppTextVariant.noEllipsis,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/*

1. Simple Checkbox
AppCheckbox(
  value: isChecked,
  onChanged: (val) {
    setState(() => isChecked = val ?? false);
  },
),

2. With Label
AppCheckbox(
  value: isChecked,
  label: "Accept Terms & Conditions",
  onChanged: (val) {
    setState(() => isChecked = val ?? false);
  },
),

3. Disabled State
AppCheckbox(
  value: true,
  isDisabled: true,
  onChanged: null,
),


4. Custom Styling
AppCheckbox(
  value: isChecked,
  label: "Custom Style",
  activeColor: Colors.orange,
  borderColor: Colors.orange,
  size: 24,
  onChanged: (val) {
    setState(() => isChecked = val ?? false);
  },
),

* */
