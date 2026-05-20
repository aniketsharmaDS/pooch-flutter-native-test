import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class DateDropdown extends StatelessWidget {
  const DateDropdown({
    super.key,
    required this.items,
    required this.valueListenable,
    required this.onChanged,
    this.hintText = 'Select',
  });

  final List<DropdownItem<String>> items;
  final ValueListenable<String?> valueListenable;
  final ValueChanged<String?> onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        items: items,
        valueListenable: valueListenable,
        onChanged: onChanged,

        customButton: ValueListenableBuilder<String?>(
          valueListenable: valueListenable,
          builder: (_, value, _) {
            final selectedText = value ?? hintText;

            return Container(
              padding: const EdgeInsets.only(
                left: AppSpacing.s16,
                right: AppSpacing.s10,
              ),
              constraints: const BoxConstraints(minHeight: 44),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: AppColors.textPrimary, width: 1.5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText.h2(selectedText, fontSize: AppFontSize.fs18),

                  const SizedBox(width: 12),

                  AppIcon(
                    AppIcons.svg.generic.chevronDown,
                    size: AppIconSize.is24,
                    color: AppColors.textPrimary,
                  ),
                ],
              ),
            );
          },
        ),

        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        // menuItemStyleData: const MenuItemStyleData(),
      ),
    );
  }
}
