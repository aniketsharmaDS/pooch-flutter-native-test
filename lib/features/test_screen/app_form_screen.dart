import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/cards/app_wave_card.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/dialogs/app_select_pet_dialog.dart';
import 'package:poochcare/core/widgets/enums/notch_variant.dart';
import 'package:poochcare/core/widgets/others/pet_name_scroll/info_item.dart';
import 'package:poochcare/core/widgets/others/pet_name_scroll/name_scroller.dart';
import 'package:poochcare/core/widgets/others/upload_document_widget.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';

@RoutePage()
class AppFormScreen extends StatefulWidget {
  const AppFormScreen({super.key});

  @override
  State<AppFormScreen> createState() => _AppFormScreenState();
}

class _AppFormScreenState extends State<AppFormScreen> {
  final TextEditingController input1controller = TextEditingController();
  final TextEditingController input2controller = TextEditingController();
  final TextEditingController input3controller = TextEditingController();

  String? _selectedPetId;

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
  void initState() {
    super.initState();
    _selectedPetId = petsList.isNotEmpty ? petsList.first.id : null;
  }

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
                AppWaveCard(
                  notchHeight: 10.h,
                  notchWidth: 160.w,
                  // variant: AppCardNotchVariant.topRight,
                  actionWidget: Row(
                    children: [
                      AppCircleButton(icon: AppIcons.svg.generic.delete),
                      SizedBox(width: 10.w),
                      AppCircleButton(icon: AppIcons.svg.generic.edit),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 20.h),
                      Text(
                        'My pets',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          // fontFamily: "Gilroy",
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          height: 1.2.h,
                          letterSpacing: 0,
                        ),
                      ),

                      SizedBox(height: 18.h),

                      NameScroller(
                        items: petsList
                            .map(
                              (p) => NameScrollerItem(id: p.id, name: p.name),
                            )
                            .toList(),
                        selectedId: _selectedPetId,
                        onSelected: (item) {
                          setState(() => _selectedPetId = item.id);
                        },
                      ),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(18.r),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1552053831-71594a27632d',
                          height: 180.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      SizedBox(height: 18.h),

                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(),
                          1: FlexColumnWidth(),
                        },
                        children: [
                          const TableRow(
                            children: [
                              InfoItem(
                                label: 'Gender',
                                value: 'Female',
                                icon: 'assets/icons/svg/generic/paper.svg',
                              ),
                              InfoItem(
                                label: 'Size',
                                value: 'Small',
                                icon: 'assets/icons/svg/generic/paper.svg',
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              SizedBox(height: 14.h), // spacing row
                              const SizedBox(),
                            ],
                          ),
                          const TableRow(
                            children: [
                              InfoItem(
                                label: 'Birth date',
                                value: '10 Nov 22',
                                icon: 'assets/icons/svg/generic/paper.svg',
                              ),
                              InfoItem(
                                label: 'Breed',
                                value: 'Siberian Husky',
                                icon: 'assets/icons/svg/generic/paper.svg',
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 18.h),
                    ],
                  ),
                ),

                SizedBox(height: 18.h),

                AppWaveCard(
                  notchHeight: 10.h,
                  notchWidth: 50.w,
                  variant: AppCardNotchVariant.bottomRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 20.h),
                      Text(
                        'Co-Parent',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          // fontFamily: "Gilroy",
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          height: 1.2.h,
                          letterSpacing: 0,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Text(
                        'No Co-parents added at the moment',
                        // textAlign: TextAlign.start,
                        style: TextStyle(
                          // fontFamily: "Gilroy",
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          height: 1.2.h,
                          letterSpacing: 0,
                        ),
                      ),
                      Divider(thickness: 1.h, color: Colors.grey),
                      const SizedBox(width: double.infinity),
                      SizedBox(height: 18.h),
                      Text(
                        'Add co-parent',
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          // fontFamily: "Gilroy",
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          height: 1.2.h,
                          letterSpacing: 0,
                        ),
                      ),

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
                      AppButton(
                        label: 'Action1',
                        isLoading: true,
                        size: AppButtonSize.small,
                        onPressed: () => {
                          // Handle action
                        },
                      ),

                      SizedBox(height: 18.h),
                      AppButton(
                        label: 'Action1',
                        size: AppButtonSize.small,
                        onPressed: () => {
                          // Handle action
                          /// 1. SIMPLE DIALOG
                          AppDialog.show(
                            icon: const Icon(
                              Icons.warning,
                              size: 36,
                              color: Colors.red,
                            ),
                            context: context,
                            title: 'Simple Dialog',
                            content:
                                'This is a simple dialog with just a title and content.',
                            primaryLabel: 'Delete',
                            secondaryLabel: 'Cancel',
                            onPrimary: () async {
                              return true;
                            },
                          ),
                        },
                      ),
                      SizedBox(height: 18.h),

                      AppButton(
                        leadingIcon: const Icon(
                          Icons.female,
                          color: Colors.pink,
                        ),
                        trailingIcon: const Icon(
                          Icons.female,
                          color: Colors.pink,
                        ),
                        label: 'Action2',
                        size: AppButtonSize.small,
                        onPressed: () async {
                          final result = await AppSelectPetDialog.show(
                            context: context,
                            pets: petsList,
                          );
                          if (result != null) {
                            // print(result.selectedPet.name);
                            // print(result.note);
                          }
                        },
                      ),
                      SizedBox(height: 18.h),
                      AppButton(
                        label: 'Action3',
                        isDisabled: true,
                        size: AppButtonSize.small,
                        onPressed: () => {
                          // Handle action
                        },
                      ),
                      SizedBox(height: 18.h),
                      AppButton(
                        label: 'Action4',
                        isDisabled: true,
                        variant: AppButtonVariant.outlined,
                        size: AppButtonSize.small,
                        onPressed: () => {
                          // Handle action
                        },
                      ),
                      SizedBox(height: 18.h),
                      AppButton(
                        variant: AppButtonVariant.text,
                        label: 'Action5',
                        isDisabled: true,
                        size: AppButtonSize.small,
                        onPressed: () => {
                          // Handle action
                        },
                      ),

                      SizedBox(height: 18.h),
                      AppButton(
                        width: null,
                        label: 'Save (Wrap Content)',
                        leadingIcon: const Icon(Icons.save),
                        onPressed: () {},
                      ),

                      SizedBox(height: 18.h),
                      AppButton(
                        width: null,
                        label: 'Save (Wrap Content)',
                        variant: AppButtonVariant.text,
                        leadingIcon: const Icon(Icons.save),
                        onPressed: () {},
                      ),

                      SizedBox(height: 18.h),
                      AppButton(
                        variant: AppButtonVariant.text,
                        label: 'Continue (Full Width)',
                        size: AppButtonSize.small,
                        onPressed: () => {
                          // Handle action
                        },
                      ),

                      SizedBox(height: 18.h),
                      AppButton(
                        label: 'Custom Width (220)',
                        width: 220.w,
                        trailingIcon: const Icon(Icons.arrow_forward),
                        size: AppButtonSize.small,
                        onPressed: () => {
                          // Handle action
                        },
                      ),

                      SizedBox(height: 18.h),

                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              label: 'Cancel',
                              variant: AppButtonVariant.outlined,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: AppButton(
                              label: 'Confirm',
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 18.h),
                    ],
                  ),
                ),

                SizedBox(height: 18.h),

                AppWaveCard(
                  notchHeight: 10.h,
                  notchWidth: 50.w,
                  variant: AppCardNotchVariant.topRightBottomLeft,

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 20.h),
                      Text(
                        'Co-Parent',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          // fontFamily: "Gilroy",
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          height: 1.2.h,
                          letterSpacing: 0,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Text(
                        'No Co-parents added at the moment',
                        // textAlign: TextAlign.start,
                        style: TextStyle(
                          // fontFamily: "Gilroy",
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          height: 1.2.h,
                          letterSpacing: 0,
                        ),
                      ),
                      Divider(thickness: 1.h, color: Colors.grey),
                      const SizedBox(width: double.infinity),
                      SizedBox(height: 18.h),
                      Text(
                        'Add co-parent',
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          // fontFamily: "Gilroy",
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          height: 1.2.h,
                          letterSpacing: 0,
                        ),
                      ),
                      SizedBox(height: 18.h),
                    ],
                  ),
                ),

                SizedBox(height: 18.h),

                AppWaveCard(
                  notchHeight: 50.h,
                  notchWidth: 30.w,
                  variant: AppCardNotchVariant.bottomRight,

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 20.h),
                      Text(
                        'Co-Parent',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          // fontFamily: "Gilroy",
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          height: 1.2.h,
                          letterSpacing: 0,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Text(
                        'No Co-parents added at the moment',
                        // textAlign: TextAlign.start,
                        style: TextStyle(
                          // fontFamily: "Gilroy",
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          height: 1.2.h,
                          letterSpacing: 0,
                        ),
                      ),
                      Divider(thickness: 1.h, color: Colors.grey),
                      const SizedBox(width: double.infinity),
                      SizedBox(height: 18.h),
                      Text(
                        'Add co-parent',
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          // fontFamily: "Gilroy",
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          height: 1.2.h,
                          letterSpacing: 0,
                        ),
                      ),
                      SizedBox(height: 18.h),
                    ],
                  ),
                ),

                SizedBox(height: 18.h),

                UploadDocumentWidget(
                  // isUploading: false,
                  // progress: 0.5,
                  description:
                      'Upload medical reports, prescriptions and vaccination certificates.',
                  buttonText: 'Upload',
                  // initialFiles: _sampleUploadedDocuments,
                  onFilesChanged: (files) {
                    log('Selected Files - $files');
                  },
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
