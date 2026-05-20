import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';

class PetWeightHeightRow extends StatefulWidget {
  final TextEditingController? weightController;
  final TextEditingController? heightController;

  final String initialWeightUnit;
  final String initialHeightUnit;

  final String? weightUnit; // controlled (API)
  final String? heightUnit; // controlled (API)
  final bool showRequiredErrors;

  final void Function(
    String weight,
    String weightUnit,
    String height,
    String heightUnit,
  )
  onChanged;

  const PetWeightHeightRow({
    super.key,
    this.weightController,
    this.heightController,
    this.initialWeightUnit = 'kgs',
    this.initialHeightUnit = 'cms',
    this.weightUnit,
    this.heightUnit,
    this.showRequiredErrors = false,
    required this.onChanged,
  });

  @override
  State<PetWeightHeightRow> createState() => _PetWeightHeightRowState();
}

class _PetWeightHeightRowState extends State<PetWeightHeightRow> {
  late TextEditingController _weightController;
  late TextEditingController _heightController;

  late String _weightUnit;
  late String _heightUnit;

  String? _weightError;
  String? _heightError;

  @override
  void initState() {
    super.initState();

    _weightController = widget.weightController ?? TextEditingController();

    _heightController = widget.heightController ?? TextEditingController();

    // ✅ Initial + controlled fallback
    _weightUnit = widget.weightUnit ?? widget.initialWeightUnit;
    _heightUnit = widget.heightUnit ?? widget.initialHeightUnit;

    _weightController.addListener(_emitChange);
    _heightController.addListener(_emitChange);
  }

  @override
  void didUpdateWidget(covariant PetWeightHeightRow oldWidget) {
    super.didUpdateWidget(oldWidget);

    var shouldRebuild = false;

    // ✅ Handle API updates after load
    if (widget.weightUnit != null &&
        widget.weightUnit != oldWidget.weightUnit) {
      _weightUnit = widget.weightUnit!;
      shouldRebuild = true;
    }

    if (widget.heightUnit != null &&
        widget.heightUnit != oldWidget.heightUnit) {
      _heightUnit = widget.heightUnit!;
      shouldRebuild = true;
    }

    if (widget.showRequiredErrors != oldWidget.showRequiredErrors) {
      shouldRebuild = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _emitChange();
        }
      });
    }

    if (shouldRebuild) {
      setState(() {});
    }
  }

  void _emitChange() {
    final weightError = _validateValue(
      label: 'Weight',
      selectedUnit: _weightUnit,
      value: _weightController.text,
    );
    final heightError = _validateValue(
      label: 'Height',
      selectedUnit: _heightUnit,
      value: _heightController.text,
    );

    if (weightError != _weightError || heightError != _heightError) {
      setState(() {
        _weightError = weightError;
        _heightError = heightError;
      });
    }

    widget.onChanged(
      _weightController.text.trim(),
      _weightUnit,
      _heightController.text.trim(),
      _heightUnit,
    );
  }

  String? _validateValue({
    required String label,
    required String selectedUnit,
    required String value,
  }) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return widget.showRequiredErrors ? 'This field is required' : null;
    }

    final double? parsedValue = double.tryParse(trimmed);
    if (parsedValue == null) {
      return 'Enter a valid number';
    }

    if (label == 'Weight') {
      if (selectedUnit == 'kgs') {
        if (parsedValue <= 0 || parsedValue > 200) {
          return 'Weight must be 0-200 kgs';
        }
      } else if (selectedUnit == 'lbs') {
        if (parsedValue <= 0 || parsedValue > 440) {
          return 'Weight must be 0-440 lbs';
        }
      }
    }

    if (label == 'Height') {
      if (selectedUnit == 'cms') {
        if (parsedValue < 5 || parsedValue > 200) {
          return 'Height must be 5-200 cms';
        }
      } else if (selectedUnit == 'fts') {
        if (parsedValue < 0.5 || parsedValue > 6.5) {
          return 'Height must be 0.5-6.5 fts';
        }
      }
    }

    return null;
  }

  @override
  void dispose() {
    _weightController.removeListener(_emitChange);
    _heightController.removeListener(_emitChange);

    if (widget.weightController == null) {
      _weightController.dispose();
    }
    if (widget.heightController == null) {
      _heightController.dispose();
    }

    super.dispose();
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String selectedUnit,
    required List<String> units,
    required void Function(String) onUnitChanged,
    required TextInputAction action,
    required String? errorText,
  }) {
    return AppTextField(
      isMandatory: true,
      controller: controller,
      label: label,
      keyboardType: TextInputType.number,
      textInputAction: action,
      errorText: errorText,
      suffixWidget: PopupMenuButton<String>(
        initialValue: selectedUnit,
        onSelected: onUnitChanged,
        itemBuilder: (context) {
          return units
              .map((e) => PopupMenuItem(value: e, child: Text(e)))
              .toList();
        },
        child: Padding(
          padding: EdgeInsets.only(right: 4.w),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText.bodyS(selectedUnit, color: AppColors.p5_300),
                SizedBox(width: 4.w),
                AppIcon(
                  AppIcons.svg.generic.chevronDown,
                  size: 16,
                  color: AppColors.p4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _buildField(
              controller: _weightController,
              label: 'Weight',
              selectedUnit: _weightUnit,
              units: const ['kgs', 'lbs'],
              action: TextInputAction.next,
              errorText: _weightError,
              onUnitChanged: (val) {
                setState(() => _weightUnit = val);
                _emitChange();
              },
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _buildField(
              controller: _heightController,
              label: 'Height',
              selectedUnit: _heightUnit,
              units: const ['cms', 'fts'],
              action: TextInputAction.done,
              errorText: _heightError,
              onUnitChanged: (val) {
                setState(() => _heightUnit = val);
                _emitChange();
              },
            ),
          ),
        ],
      ),
    );
  }
}

/** Usage:
WeightHeightRow(
  weightController: _weightController,
  heightController: _heightController,
  weightUnit: weightUnitFromApi,
  heightUnit: heightUnitFromApi,
  onChanged: (w, wu, h, hu) {
    setState(() {
      weightUnitFromApi = wu;
      heightUnitFromApi = hu;
    });
  },
)
*/
