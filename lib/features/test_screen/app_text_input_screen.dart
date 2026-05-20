import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/widgets/checkbox/app_checkbox.dart';
import 'package:poochcare/core/widgets/dialogs/app_select_pet_dialog.dart';
import 'package:poochcare/core/widgets/radio/app_circle_radio.dart';
import 'package:poochcare/core/widgets/radio/app_radio.dart';
import 'package:poochcare/core/widgets/radio/app_radio_pet_gender.dart';
import 'package:poochcare/core/widgets/radio/app_radio_user_gender.dart';
import 'package:poochcare/core/widgets/slider/app_bcs_slider_section.dart';
import 'package:poochcare/core/widgets/slider/app_slider.dart';
import 'package:poochcare/core/widgets/switch/app_switch.dart';
import 'package:poochcare/core/widgets/texts/app_otp_field.dart';
import 'package:poochcare/core/widgets/texts/app_phone_email_input_field.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';

@RoutePage()
class AppTextInputScreen extends StatefulWidget {
  const AppTextInputScreen({super.key});

  @override
  State<AppTextInputScreen> createState() => _AppTextInputScreenState();
}

class _AppTextInputScreenState extends State<AppTextInputScreen> {
  final TextEditingController input1controller = TextEditingController();
  final TextEditingController input2controller = TextEditingController();
  final TextEditingController input3controller = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();

  bool isChecked = false;
  bool isRadioSelected = false;
  String? selectedGender = 'female';
  String? selectedGender3D = 'male';
  double sliderValue = 3.0;

  String _phoneEmailCountryCode = '91';

  final TextEditingController _peEmailController = TextEditingController();
  final TextEditingController _pePhoneController = TextEditingController();

  final List<Pet> petsList = [
    Pet(
      id: '1',
      name: 'Rudolph',
      imageUrl: 'https://images.unsplash.com/photo-1558788353-f76d92427f16',
    ),
    Pet(
      id: '2',
      name: 'Cadbury',
      imageUrl: 'https://images.unsplash.com/photo-1537151625747-768eb6cf92b2',
    ),
    Pet(
      id: '3',
      name: 'Bella',
      imageUrl: 'https://images.unsplash.com/photo-1598133894008-61f7fdb8cc3a',
    ),
    Pet(
      id: '4',
      name: 'Max',
      imageUrl: 'https://images.unsplash.com/photo-1543466835-00a7907e9de1',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 18.h),

                AppTextField(
                  prefix: const Icon(Icons.search),
                  suffixWidget: const Icon(Icons.clear),
                  label: 'Name',
                  controller: input1controller,
                ),
                SizedBox(height: 18.h),
                AppTextField(
                  label: 'Name',
                  controller: input2controller,
                  // errorText: 'This field is required',
                ),
                SizedBox(height: 18.h),
                AppTextField(
                  obscureText: true,
                  label: 'Password',
                  controller: input2controller,
                  // errorText: 'This field is required',
                ),
                SizedBox(height: 18.h),
                AppTextField(
                  label: 'Select Pet this',
                  controller: input3controller,
                  isReadOnly: true,
                  onPressed: () async {
                    final result = await AppSelectPetDialog.show(
                      context: context,
                      pets: petsList,
                      initiallySelectedPet:
                          petsList.any((pet) => pet.isSelected)
                          ? petsList.firstWhere((pet) => pet.isSelected)
                          : null,
                    );

                    if (result != null) {
                      for (final pet in petsList) {
                        if (pet.id == result.selectedPet.id) {
                          pet.isSelected = true;
                        } else {
                          pet.isSelected = false;
                        }
                      }
                      input3controller.text = result.selectedPet.name;
                    }
                  },
                  suffixWidget: const Icon(Icons.keyboard_arrow_down),
                ),
                SizedBox(height: 18.h),
                AppTextField(
                  label: 'Select Pet',
                  controller: input2controller,
                  errorText: 'Please select a pet',
                  isMandatory: true,
                ),
                SizedBox(height: 18.h),
                AppTextField(
                  label: 'Name',
                  controller: input2controller,
                  enabled: false,
                  optionalText: 'Optional',
                  // errorText: 'This field is required',
                ),
                SizedBox(height: 18.h),
                AppTextField(
                  label: 'Name',
                  controller: input2controller,
                  // isValidInput: true,
                ),

                SizedBox(height: 18.h),
                AppOtpField(
                  controller: _otpController,
                  focusNode: _otpFocusNode,
                  onChanged: (value) {
                    log('OTP Changed: $value');
                  },
                ),
                SizedBox(height: 18.h),
                AppPhoneEmailInputField(
                  emailController: _peEmailController,
                  phoneController: _pePhoneController,
                  countryCode: _phoneEmailCountryCode,
                  // textInputAction: TextInputAction.next,
                  onCountryCodeChanged: (dialCode) {
                    setState(() {
                      _phoneEmailCountryCode = dialCode;
                    });
                  },
                  onInputTypeChanged: (inputType) {
                    setState(() {});
                  },
                ),
                SizedBox(height: 18.h),
                SizedBox(height: 18.h),
                SizedBox(height: 18.h),
                SizedBox(height: 18.h),

                AppSwitch(
                  // label: 'Active',
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value;
                    });
                  },
                ),
                SizedBox(height: 18.h),
                AppSwitch(
                  label: 'Active',
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value;
                    });
                  },
                ),
                SizedBox(height: 18.h),
                AppCheckbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                ),
                SizedBox(height: 18.h),
                AppCheckbox(
                  label: 'Accept Terms',
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                ),
                SizedBox(height: 18.h),
                AppRadioUserGender(
                  initialGender: selectedGender,
                  onGenderSelected: (String gender) {
                    setState(() {
                      selectedGender = gender;
                    });
                    // ignore: avoid_print
                    print('Selected gender: $gender');
                  },
                ),
                SizedBox(height: 18.h),
                AppRadioPetGender(
                  initialGender: selectedGender3D,
                  onGenderSelected: (gender) {
                    setState(() {
                      selectedGender3D = gender;
                    });
                  },
                ),
                SizedBox(height: 18.h),
                Row(
                  children: [
                    Expanded(
                      child: AppRadio(
                        label: 'Option 1',
                        isSelected: isRadioSelected,
                        onTap: () => setState(() {
                          isRadioSelected = true;
                        }),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18.h),
                AppCircleRadio(
                  isSelected: isRadioSelected,
                  onTap: () => setState(() => isRadioSelected = true),
                ),
                SizedBox(height: 18.h),
                Row(
                  children: [
                    AppCircleRadio(
                      isSelected: isRadioSelected,
                      onTap: () => setState(() => isRadioSelected = true),
                      label: 'Male', // optional
                    ),
                    SizedBox(width: 16.w),
                    AppCircleRadio(
                      isSelected: isRadioSelected,
                      onTap: () => setState(() => isRadioSelected = true),
                      label: 'Female', // optional
                    ),
                    SizedBox(width: 16.w),
                    AppCircleRadio(
                      isSelected: isRadioSelected,
                      onTap: () => setState(() => isRadioSelected = false),
                      label: 'Other', // optional
                    ),
                  ],
                ),
                SizedBox(height: 18.h),
                AppCircleRadio(
                  isSelected: isRadioSelected,
                  onTap: () => setState(() => isRadioSelected = true),
                  label: 'Male', // optional
                ),
                SizedBox(height: 18.h),
                AppSlider(
                  value: sliderValue,
                  min: 0,
                  max: 9,
                  onChanged: (double v) => setState(() => sliderValue = v),
                ),
                SizedBox(height: 18.h),
                AppBscSliderSection(
                  value: sliderValue,
                  onChanged: (v) => setState(() => sliderValue = v),
                ),
                SizedBox(height: 18.h),
                SizedBox(height: 18.h),
                SizedBox(height: 18.h),
                SizedBox(height: 18.h),
                SizedBox(height: 18.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
