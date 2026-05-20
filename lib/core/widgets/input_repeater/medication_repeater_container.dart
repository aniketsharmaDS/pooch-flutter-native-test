// ignore_for_file: inference_failure_on_function_return_type

import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
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
                label: 'Medication Name',
                controller: entry.nameController,
              ),
            ),
            SizedBox(width: AppSize.cs8.csh),
            SizedBox(
              width: AppSize.cs90.csw,
              child: AppTextField(
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
              child: _SimpleDropdown(
                items: forms,
                value: entry.form,
                hint: 'Form',
                onChanged: (v) {
                  entry.form = v;
                  onChanged();
                },
              ),
            ),
            SizedBox(width: AppSize.cs8.csw),
            Expanded(
              child: AppTextField(
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
                label: 'Frequency',
                controller: entry.frequencyController,
              ),
            ),
            SizedBox(width: AppSize.cs8.csw),
            Expanded(
              child: _SimpleMultiSelect(
                items: timings,
                selected: entry.timing,
                onChanged: (v) {
                  entry.timing = v;
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

/// =======================
/// SIMPLE SAFE DROPDOWN (NO CRASH)
/// =======================
class _SimpleDropdown extends StatelessWidget {
  final List<String> items;
  final String? value;
  final String hint;

  final Function(String?) onChanged;

  const _SimpleDropdown({
    required this.items,
    required this.value,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      // ignore: deprecated_member_use
      value: value,
      decoration: const InputDecoration(labelText: 'Form'),
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
    );
  }
}

/// =======================
/// SIMPLE MULTI SELECT (SAFE PLACEHOLDER)
/// =======================
class _SimpleMultiSelect extends StatefulWidget {
  final List<String> items;
  final List<String> selected;
  final Function(List<String>) onChanged;

  const _SimpleMultiSelect({
    // ignore: unused_element_parameter
    super.key,
    required this.items,
    required this.selected,
    required this.onChanged,
  });

  @override
  State<_SimpleMultiSelect> createState() => _SimpleMultiSelectState();
}

class _SimpleMultiSelectState extends State<_SimpleMultiSelect> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool isOpen = false;

  void _toggleItem(String value) {
    final updated = List<String>.from(widget.selected);

    if (updated.contains(value)) {
      updated.remove(value);
    } else {
      updated.add(value);
    }

    widget.onChanged(updated);

    /// 🔥 IMPORTANT FIX: force overlay rebuild
    _overlayEntry?.markNeedsBuild();
  }

  void _openMenu() {
    _overlayEntry = _createOverlay();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => isOpen = true);
  }

  void _closeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => isOpen = false);
  }

  OverlayEntry _createOverlay() {
    RenderBox box = context.findRenderObject() as RenderBox;
    final size = box.size;
    final offset = box.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) {
        return GestureDetector(
          onTap: _closeMenu,
          behavior: HitTestBehavior.translucent,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: offset.dy + size.height + 5,
                width: size.width,
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.items.map((e) {
                      final selected = widget.selected.contains(e);

                      return ListTile(
                        dense: true,
                        onTap: () {
                          _toggleItem(e);
                        },
                        leading: Icon(
                          selected
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                        ),
                        title: Text(e),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: isOpen ? _closeMenu : _openMenu,
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.selected.isEmpty
                      ? 'Select Timing'
                      : widget.selected.join(', '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
