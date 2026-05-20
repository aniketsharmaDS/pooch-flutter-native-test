import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/others/pet_weight_height_row.dart';
import 'package:poochcare/core/widgets/slider/app_bcs_slider_section.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';

class HealthOfPet extends StatefulWidget {
  const HealthOfPet({
    super.key,
    required this.petType,
    required this.weightController,
    required this.heightController,
    required this.otherHealthInfoController,
    required this.selectedSize,
    required this.weightUnit,
    required this.heightUnit,
    required this.onWeightHeightChanged,
    required this.bcsValue,
    required this.onBcsChanged,
    this.isSizeEditable = true,
    this.showWeightHeightErrors = false,
  });

  final String petType;

  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController otherHealthInfoController;
  final ValueNotifier<String?> selectedSize;

  final String weightUnit;
  final String heightUnit;
  final void Function(
    String weight,
    String weightUnit,
    String height,
    String heightUnit,
  )
  onWeightHeightChanged;

  final bool isSizeEditable;
  final bool showWeightHeightErrors;

  final double bcsValue;
  final ValueChanged<double> onBcsChanged;

  @override
  State<HealthOfPet> createState() => _HealthOfPetState();
}

class _HealthOfPetState extends State<HealthOfPet> {
  late final FocusNode _healthInfoFocusNode;
  late final FocusNode _bcsInputFocusNode;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _healthInfoFocusNode = FocusNode();
    _healthInfoFocusNode.addListener(_onHealthInfoFocusChanged);

    _bcsInputFocusNode = FocusNode();
    _bcsInputFocusNode.addListener(_onBcsInputFocusChanged);
  }

  @override
  void dispose() {
    _healthInfoFocusNode.removeListener(_onHealthInfoFocusChanged);
    _healthInfoFocusNode.dispose();

    _bcsInputFocusNode.removeListener(_onBcsInputFocusChanged);
    _bcsInputFocusNode.dispose();

    _scrollController.dispose();
    super.dispose();
  }

  void _onHealthInfoFocusChanged() {
    if (_healthInfoFocusNode.hasFocus) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void _onBcsInputFocusChanged() {
    if (_bcsInputFocusNode.hasFocus) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  String _getTitle() {
    return 'Health of \nyour ${widget.petType}';
  }

  // static const List<String> _sizeValues = [
  //   'Toy',
  //   'Small',
  //   'Medium',
  //   'Large',
  //   'Giant',
  // ];

  // List<DropdownItem<String>> get _sizeItems {
  //   return _sizeValues
  //       .map(
  //         (size) => DropdownItem<String>(
  //           value: size,
  //           height: AppSpacing.s40.h,
  //           child: Text(size),
  //         ),
  //       )
  //       .toList();
  // }

  @override
  Widget build(BuildContext context) {
    final String petImage = widget.petType == 'cat'
        ? AppIcons.jpg.onboarding.catSpecies
        : AppIcons.jpg.onboarding.dogSpecies;

    return SingleChildScrollView(
      controller: _scrollController,
      // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.s32.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: AppText.h4(
              _getTitle(),
              fontSize: AppFontSize.fs32,
              color: AppColors.textPrimary,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
          AppSpacing.s25.hBox,
          PetWeightHeightRow(
            weightController: widget.weightController,
            heightController: widget.heightController,
            weightUnit: widget.weightUnit,
            heightUnit: widget.heightUnit,
            showRequiredErrors: widget.showWeightHeightErrors,
            onChanged: widget.onWeightHeightChanged,
          ),
          AppSpacing.s20.hBox,
          Container(
            height: 56.h,
            width: double.maxFinite,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFEFD),
              borderRadius: BorderRadius.circular(AppRadiusSize.r16),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: AppSpacing.s20),

              child: AppText.bodyS(
                widget.selectedSize.value ?? '',
                fontSize: AppFontSize.fs14,
                color: AppColors.buttonDisabledBg,
              ),
            ),
          ),

          // AppDropdowns<String>(
          //   items: _sizeItems,
          //   valueListenable: widget.selectedSize,
          //   isExpanded: true,
          //   isMandatory: true,
          //   hint: AppText.bodyM(
          //     'Select size',
          //     color: AppColors.textFieldLabelDefault,
          //   ),
          //   onChanged: widget.isSizeEditable
          //       ? (_) {
          //           ScaffoldMessenger.of(context).showSnackBar(
          //             const SnackBar(
          //               content: Text(
          //                 'Pet size is automatically set based on breed.',
          //               ),
          //               duration: Duration(seconds: 2),
          //             ),
          //           );
          //         }
          //       : null,
          // ),
          AppSpacing.s12.hBox,
          Container(
            height: AppSpacing.s220.h,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(AppRadiusSize.r20),
              border: Border.all(color: AppColors.textFieldBorderDefault),
            ),
            clipBehavior: Clip.antiAlias,
            child: AppIcon(petImage, fit: BoxFit.cover),
          ),
          AppSpacing.s12.hBox,
          Container(
            padding: EdgeInsets.all(AppSpacing.s12.w),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(AppRadiusSize.r20),
              border: Border.all(color: AppColors.textFieldBorderDefault),
            ),
            child: AppBscSliderSection(
              value: widget.bcsValue,
              onChanged: widget.onBcsChanged,
              focusNode: _bcsInputFocusNode,
            ),
          ),
          AppSpacing.s16.hBox,
          AppTextField(
            label: 'Other Health Information',
            hintText: 'E.g. Any allergies, medical conditions, etc.',
            isTextArea: true,
            optionalText: 'Optional',
            minLines: 3,
            maxLines: 6,
            height: AppSize.cs100.h,
            maxCount: 150,
            controller: widget.otherHealthInfoController,
            textInputAction: TextInputAction.next,
            focusNode: _healthInfoFocusNode,
          ),
          AppSpacing.s48.hBox,
        ],
      ),
    );
  }
}
