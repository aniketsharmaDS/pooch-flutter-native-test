import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_option_ui_model.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/get_help/chat_option_button.dart';

class GetHelpOptionsGroup extends StatefulWidget {
  final List<GetHelpOptionUIModel> options;
  final void Function(GetHelpOptionUIModel) onOptionSelected;

  const GetHelpOptionsGroup({
    super.key,
    required this.options,
    required this.onOptionSelected,
  });

  @override
  State<GetHelpOptionsGroup> createState() => _GetHelpOptionsGroupState();
}

class _GetHelpOptionsGroupState extends State<GetHelpOptionsGroup> {
  String? selectedId;

  void _onSelect(GetHelpOptionUIModel option) {
    if (selectedId != null) return; // prevent re-selection

    setState(() {
      selectedId = option.id;
    });

    widget.onOptionSelected(option);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.s8.w,
      runSpacing: AppSpacing.s8.h,
      children: widget.options.map((option) {
        final isSelected = selectedId == option.id;

        return GetHelpOptionButton(
          text: option.text,
          isSelected: isSelected,
          onTap: () => _onSelect(option),
        );
      }).toList(),
    );
  }
}
