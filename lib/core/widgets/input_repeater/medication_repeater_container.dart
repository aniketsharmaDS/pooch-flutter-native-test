import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/dropdowns/app_dropdowns.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';

/// =======================
/// MODEL (UPDATED)
/// =======================
class MedicationModel {
  String name;
  String? days;

  /// NEW FIELDS
  String? form;
  String? strength;
  String? frequency;
  List<String> timing;
  String? instructions;

  MedicationModel({
    this.name = '',
    this.days,
    this.form,
    this.strength,
    this.frequency,
    this.timing = const [],
    this.instructions,
  });
}

/// =======================
/// REPEATER (UNCHANGED CORE)
/// =======================
class MedicationRepeaterContainer extends StatefulWidget {
  final void Function(List<MedicationModel>) onChanged;

  const MedicationRepeaterContainer({super.key, required this.onChanged});

  @override
  State<MedicationRepeaterContainer> createState() =>
      _MedicationRepeaterContainerState();
}

class _MedicationEntry {
  final Key key;
  final TextEditingController nameController;
  final TextEditingController daysController;

  /// NEW CONTROLLERS
  final TextEditingController strengthController;
  final TextEditingController frequencyController;
  final TextEditingController instructionsController;

  String? form;
  final ValueNotifier<String?> formNotifier = ValueNotifier<String?>(null);
  final ValueNotifier<List<String>> timingNotifier = ValueNotifier([]);
  List<String> timing = [];

  _MedicationEntry({
    required this.key,
    required this.nameController,
    required this.daysController,
    required this.strengthController,
    required this.frequencyController,
    required this.instructionsController,
  });

  void dispose() {
    nameController.dispose();
    daysController.dispose();
    strengthController.dispose();
    frequencyController.dispose();
    instructionsController.dispose();
    formNotifier.dispose();
    timingNotifier.dispose();
  }
}

/// =======================
/// STATE
/// =======================
class _MedicationRepeaterContainerState
    extends State<MedicationRepeaterContainer> {
  final List<_MedicationEntry> _entries = [];

  final List<String> forms = [
    'Tablet',
    'Capsule',
    'Liquid',
    'Injection',
    'Cream',
    'Syrup',
    'Powder',
    'Other',
  ];

  final List<String> timings = ['morning', 'afternoon', 'evening', 'night'];

  @override
  void initState() {
    super.initState();
    _addNewRow();
  }

  void _addNewRow() {
    final entry = _MedicationEntry(
      key: UniqueKey(),
      nameController: TextEditingController(),
      daysController: TextEditingController(),
      strengthController: TextEditingController(),
      frequencyController: TextEditingController(),
      instructionsController: TextEditingController(),
    );

    setState(() {
      _entries.add(entry);
    });
  }

  void _removeRow(int index) {
    if (_entries.length > 1) {
      final entry = _entries[index];
      entry.nameController.removeListener(_notifyChanges);
      entry.daysController.removeListener(_notifyChanges);
      entry.strengthController.removeListener(_notifyChanges);
      entry.frequencyController.removeListener(_notifyChanges);
      entry.instructionsController.removeListener(_notifyChanges);
      entry.form = null;
      entry.timing.clear();

      setState(() {
        _entries.removeAt(index);
      });

      entry.dispose();
      _notifyChanges();
    }
  }

  void _notifyChanges() {
    final data = _entries.map((e) {
      return MedicationModel(
        name: e.nameController.text.trim(),
        days: e.daysController.text.trim(),

        /// NEW MAPPING
        form: e.form,
        strength: e.strengthController.text.trim(),
        frequency: e.frequencyController.text.trim(),
        timing: e.timing,
        instructions: e.instructionsController.text.trim(),
      );
    }).toList();

    widget.onChanged(data);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(_entries.length, (index) {
        final entry = _entries[index];
        final isLast = index == _entries.length - 1;

        return Padding(
          key: entry.key,
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.s6.w,
          ).copyWith(bottom: AppSpacing.s12.h),
          child: Container(
            padding: EdgeInsets.all(AppSpacing.s5.h),
            decoration: BoxDecoration(
              color: AppColors.white_50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: _MedicationRow(
              entry: entry,
              forms: forms,
              timings: timings,
              isLast: isLast,
              onAdd: _addNewRow,
              onRemove: () => _removeRow(index),
              onChanged: _notifyChanges,
            ),
          ),
        );
      }),
    );
  }
}

/// =======================
/// ROW UI (UPDATED CLEANLY)
/// =======================
class _MedicationRow extends StatelessWidget {
  final _MedicationEntry entry;
  final List<String> forms;
  final List<String> timings;
  final bool isLast;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onChanged;

  const _MedicationRow({
    required this.entry,
    required this.forms,
    required this.timings,
    required this.isLast,
    required this.onAdd,
    required this.onRemove,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// ROW 1
        Row(
          children: [
            Expanded(
              child: AppTextField(
                isMandatory: true,
                label: 'Medication Name',
                controller: entry.nameController,
              ),
            ),
            SizedBox(width: AppSize.cs8.csw),
            SizedBox(
              width: AppSize.cs90.csw,
              child: AppTextField(
                isMandatory: true,
                label: 'Days',
                controller: entry.daysController,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),

        SizedBox(height: AppSize.cs10.csh),

        /// ROW 2
        Row(
          children: [
            Expanded(
              child: AppDropdowns<String>(
                isExpanded: true,
                items: forms.map((e) {
                  return DropdownItem<String>(value: e, child: Text(e));
                }).toList(),
                valueListenable: entry.formNotifier,
                isMandatory: true,
                hint: AppText.bodyM(
                  'Form',
                  color: AppColors.textFieldLabelDefault,
                ),
                onChanged: (v) {
                  entry.formNotifier.value = v;
                  entry.form = v;
                  onChanged();
                },
              ),
            ),
            SizedBox(width: AppSize.cs8.csw),
            Expanded(
              child: AppTextField(
                isMandatory: true,
                label: 'Strength',
                controller: entry.strengthController,
              ),
            ),
          ],
        ),

        SizedBox(height: AppSize.cs10.csh),

        /// ROW 3
        Row(
          children: [
            Expanded(
              child: AppTextField(
                isMandatory: true,
                label: 'Frequency',
                controller: entry.frequencyController,
              ),
            ),
            SizedBox(width: AppSize.cs8.csw),
            Expanded(
              child: AppDropdowns<String>(
                isExpanded: true,

                multiValueListenable: entry.timingNotifier,

                items: timings.map((e) {
                  return DropdownItem<String>(
                    value: e,

                    closeOnTap: false,

                    child: ValueListenableBuilder<List<String>>(
                      valueListenable: entry.timingNotifier,
                      builder: (_, selected, _) {
                        final isSelected = selected.contains(e);

                        return Row(
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                            ),

                            const SizedBox(width: 8),

                            Text(e),
                          ],
                        );
                      },
                    ),
                  );
                }).toList(),
                isMandatory: true,
                hint: AppText.bodyM(
                  'Select Timing',
                  color: AppColors.textFieldLabelDefault,
                ),

                selectedItemBuilder: (context) {
                  return timings.map((e) {
                    return ValueListenableBuilder<List<String>>(
                      valueListenable: entry.timingNotifier,
                      builder: (_, selected, _) {
                        return Text(
                          selected.isEmpty
                              ? 'Select Timing'
                              : selected.join(', '),
                          overflow: TextOverflow.ellipsis,
                        );
                      },
                    );
                  }).toList();
                },

                onChanged: (value) {
                  final current = List<String>.from(entry.timingNotifier.value);
                  if (current.contains(value)) {
                    current.remove(value);
                  } else {
                    current.add(value!);
                  }
                  entry.timingNotifier.value = current;
                  entry.timing = current;
                  onChanged();
                },
              ),
            ),
          ],
        ),

        SizedBox(height: AppSize.cs10.csh),

        /// ROW 4
        Row(
          children: [
            Expanded(
              child: AppTextField(
                isMandatory: true,
                label: 'Instructions',
                controller: entry.instructionsController,
              ),
            ),
            SizedBox(width: AppSize.cs12.csw),
            AppCircleButton(
              bgColor: AppColors.white,
              icon: isLast
                  ? AppIcons.svg.generic.plusSign
                  : AppIcons.svg.generic.close,
              onTap: isLast ? onAdd : onRemove,
              size: AppCircleButtonSize.small,
            ),
          ],
        ),
      ],
    );
  }
}
