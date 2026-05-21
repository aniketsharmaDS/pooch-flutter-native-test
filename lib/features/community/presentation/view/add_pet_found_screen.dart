import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/dropdowns/app_dropdowns.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class AddPetFoundScreen extends StatefulWidget {
  const AddPetFoundScreen({super.key});

  @override
  State<AddPetFoundScreen> createState() => _AddPetFoundScreenState();
}

class _AddPetFoundScreenState extends State<AddPetFoundScreen> {
  final List<String> _petTypeList = ['Dog', 'Cat'];
  final List<String> _petGenderList = ['Male', 'Female'];
  final ValueNotifier<String?> _selectedPetTypeNotifier = ValueNotifier(null);
  final ValueNotifier<String?> _selectedPetGenderNotifier = ValueNotifier(null);
  String? _selectedPetType;
  String? _selectedPetGender;

  bool get _isFormValid =>
      _selectedPetType != null && _selectedPetGender != null;

  void _handleSubmit() {
    context.pushRoute<bool>(
      AllMissingPoochListRoute(
        listType: 'manual_found_pet',
        petGender: _selectedPetGender!.toLowerCase(),
        petType: _selectedPetType!.toLowerCase(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppPrimaryScreenContainer(
      title: 'community.addPetFound.title'.tr(),
      child: Column(
        children: [
          // CustomBackButtonWithTitle(
          //   title: lang.addManualFoundPet,
          //   padding: EdgeInsets.only(top: 10),
          // ),
          SizedBox(height: 10.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Title
                        AppDropdowns(
                          hint: AppText.bodyM(
                            'community.addPetFound.selectPetType'.tr(),
                          ),
                          valueListenable: _selectedPetTypeNotifier,
                          onChanged: (value) {
                            _selectedPetTypeNotifier.value = value;
                            _selectedPetType = value;
                            setState(() {});
                          },
                          isExpanded: true,
                          // valueListenable: selectedParentGroupId,
                          items: _petTypeList
                              .map(
                                (type) => DropdownItem<String>(
                                  value: type,
                                  child: Text(
                                    'community.addPetFound.${type.toLowerCase()}'
                                        .tr(),
                                  ),
                                ),
                              )
                              .toList(growable: false),
                        ),

                        SizedBox(height: 16.h),
                        AppDropdowns(
                          hint: AppText.bodyM(
                            'community.addPetFound.selectPetGender'.tr(),
                          ),
                          valueListenable: _selectedPetGenderNotifier,
                          onChanged: (value) {
                            _selectedPetGenderNotifier.value = value;
                            _selectedPetGender = value;
                            setState(() {});
                          },
                          isExpanded: true,
                          // valueListenable: selectedParentGroupId,
                          items: _petGenderList
                              .map(
                                (type) => DropdownItem<String>(
                                  value: type,
                                  child: Text(
                                    'community.addPetFound.${type.toLowerCase()}'
                                        .tr(),
                                  ),
                                ),
                              )
                              .toList(growable: false),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Pinned Action Button
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: SafeArea(
              top: false,
              child: AppButton(
                label: 'community.addPetFound.submit'.tr(),
                onPressed: _handleSubmit,
                isDisabled: !_isFormValid,
                // enabled: _isFormValid,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
