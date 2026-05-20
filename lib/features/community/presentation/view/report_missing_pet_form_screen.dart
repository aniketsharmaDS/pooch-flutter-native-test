import 'dart:developer';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/document_upload_service.dart';
import 'package:poochcare/core/services/s3_upload_path_builder.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/theme/app_typography.dart';
import 'package:poochcare/core/widgets/bottom_sheet/address/address_search_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/checkbox/app_checkbox.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/forms/medical_form/pet_selection_form_field.dart';
import 'package:poochcare/core/widgets/headers/primary_widget_header.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/others/app_date_picker/app_date_picker.dart';
import 'package:poochcare/core/widgets/others/app_date_picker/app_time_picker.dart';
import 'package:poochcare/core/widgets/others/upload_image_widget.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';
import 'package:poochcare/features/community/domain/models/missing_pet_report_payload_model.dart';
import 'package:poochcare/features/community/presentation/bloc/missing_pet/all_missing_pets_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/missing_pet/my_missing_pets_bloc.dart';
import 'package:poochcare/router/app_router.dart';

enum ReportMissingPetFormType { create, edit }

@RoutePage()
class ReportMissingPetFormScreen extends StatefulWidget
    implements AutoRouteWrapper {
  const ReportMissingPetFormScreen({
    super.key,
    required this.type,
    this.reportId,
  });

  final ReportMissingPetFormType type;
  final String? reportId;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MyMissingPetsBloc>.value(
          value: getIt<MyMissingPetsBloc>(),
        ),
        BlocProvider<AllMissingPetsBloc>.value(
          value: getIt<AllMissingPetsBloc>(),
        ),
      ],
      child: this,
    );
  }

  @override
  State<ReportMissingPetFormScreen> createState() =>
      _ReportMissingPetFormState();
}

class _ReportMissingPetFormState extends State<ReportMissingPetFormScreen> {
  final TextEditingController descController = TextEditingController();
  final TextEditingController _lastSceenDateController =
      TextEditingController();
  final TextEditingController _lastSceenTimeController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController rewardController = TextEditingController();

  late final ValueNotifier<String?> selectedPetNotifier;

  bool isSubmitting = false;
  bool isAgreed = false;

  String? selectedPet;
  DateTime? missingDate;
  TimeOfDay? missingTime;
  AddressResult? selectedAddress;

  List<File> localFiles = [];
  List<dynamic> remoteFiles = [];

  /// =========================
  /// VALIDATION GETTERS
  /// =========================
  bool get isDateValid => missingDate != null;
  bool get isTimeValid => missingTime != null;
  bool get isAddressValid => addressController.text.trim().isNotEmpty;
  bool get isPetValid => selectedPet != null;
  bool get isTermsAccepted => isAgreed;

  bool get isSubmitEnabled =>
      isPetValid &&
      isDateValid &&
      isTimeValid &&
      isAddressValid &&
      isTermsAccepted;

  @override
  void initState() {
    super.initState();

    selectedPetNotifier = ValueNotifier<String?>(null);

    _prefillFromBloc();
  }

  @override
  void dispose() {
    descController.dispose();
    _lastSceenDateController.dispose();
    _lastSceenTimeController.dispose();
    rewardController.dispose();
    addressController.dispose();

    selectedPetNotifier.dispose();
    super.dispose();
  }

  void _prefillFromBloc() {
    if (widget.type != ReportMissingPetFormType.edit) {
      return;
    }
    isAgreed = true;
    final state = context.read<MyMissingPetsBloc>().state;
    final item = state.selectedItem;

    if (item == null) return;

    /// TEXT FIELDS
    descController.text = item.description;
    rewardController.text = item.rewardAmount != null
        ? item.rewardAmount!.toInt().toString()
        : '';
    addressController.text = item.lastKnownLocation;

    selectedAddress = AddressResult(
      description: item.lastKnownLocation,
      latitude: item.latitude ?? 0.0,
      longitude: item.longitude ?? 0.0,
      placeId: '',
    );

    selectedPet = item.petId;
    selectedPetNotifier.value = item.petId;

    /// DATE
    if (item.missingDate != null && item.missingDate != '') {
      try {
        final parsedDate = DateTime.parse(item.missingDate ?? '').toLocal();

        missingDate = parsedDate;
        _lastSceenDateController.text =
            '${parsedDate.day}-${parsedDate.month}-${parsedDate.year}';
      } catch (e) {
        log('Date parse error: $e');
      }
    }

    /// TIME
    if (item.missingTime != null && item.missingTime != '') {
      try {
        final parsedTime = _parseTime(item.missingTime ?? '');
        missingTime = parsedTime;

        _lastSceenTimeController.text = formatTimeOfDay(parsedTime) ?? '';
      } catch (e) {
        log('Time parse error: $e');
      }
    }

    /// IMAGES (IMPORTANT)

    remoteFiles =
        (item.images as List?)?.map((e) {
          return {
            'id': (e as dynamic).id?.toString() ?? '',
            'url': (e as dynamic)?.imageUrl ?? (e as dynamic)?.imageUrl ?? '',
            // 'name': (e as dynamic)?.name ?? '',
            // 'size': ((e as dynamic)?.size ?? '').toString(),
          };
        }).toList() ??
        [];
    setState(() {});
  }

  // ignore: unused_element
  TimeOfDay _parseTime(String time) {
    final parts = time.split(' ');
    final timeParts = parts[0].split(':');

    int hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    if (parts.length > 1) {
      final period = parts[1].toLowerCase();

      if (period == 'pm' && hour != 12) {
        hour += 12;
      } else if (period == 'am' && hour == 12) {
        hour = 0;
      }
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  Widget build(BuildContext context) {
    return AppPrimaryScreenContainer(
      title: widget.type == ReportMissingPetFormType.create
          ? 'Add a Missing pet report'
          : 'Edit a Missing pet report',
      child: SafeArea(
        child: Column(
          children: [
            /// =========================
            /// SCROLLABLE CONTENT
            /// =========================
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.only(
                  top: AppSpacing.s16.h,
                  bottom: AppSpacing.s16.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TITLE + DESCRIPTION
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16.w,
                      ),
                      child: Column(
                        children: [
                          PetSelectionFormField(
                            selectedPetNotifier: selectedPetNotifier,
                            onPetChanged: (id) {
                              selectedPet = id;
                            },
                          ),
                          AppSpacing.s20.hBox,

                          AppTextField(
                            floatingFontSize: AppFontSize.fs14,
                            isTextArea: true,
                            label: 'Add Description',
                            controller: descController,
                            height: 160.h,
                            textInputAction: TextInputAction.newline,
                            optionalText: 'Optional',
                            maxCount: 150,
                          ),
                          AppSpacing.s20.hBox,
                          AppTextField(
                            label: 'Select Last Seen date',
                            controller: _lastSceenDateController,
                            isReadOnly: true,
                            isMandatory: true,
                            onPressed: () => _pickDate(
                              initialDate: missingDate,
                              onSelected: (date) {
                                setState(() {
                                  missingDate = date;
                                  _lastSceenDateController.text =
                                      '${date.day}-${date.month}-${date.year}';
                                });
                              },
                            ),
                            suffixWidget: AppIcon(
                              AppIcons.svg.generic.calendar,
                              size: AppIconSize.is16.ir,
                            ),
                          ),
                          AppSpacing.s20.hBox,
                          AppTextField(
                            label: 'Select Last Seen time',
                            enabled:
                                missingDate !=
                                null, // time can only be picked after date
                            controller: _lastSceenTimeController,
                            isReadOnly: true,
                            isMandatory: true,
                            onPressed: () => _pickTime(
                              initialTime: missingTime,
                              selectedDate: missingDate ?? DateTime.now(),
                              onSelected: (time) {
                                setState(() {
                                  missingTime = time;
                                  String? formattedTime = formatTimeOfDay(time);
                                  _lastSceenTimeController.text =
                                      formattedTime ?? '';
                                });
                              },
                            ),
                            suffixWidget: AppIcon(
                              AppIcons.svg.generic.clock,
                              size: AppIconSize.is16.ir,
                            ),
                          ),
                          AppSpacing.s20.hBox,
                          AppTextField(
                            label: 'Add Last Seen Location',
                            controller: addressController,
                            isReadOnly: true,
                            isMandatory: true,
                            onPressed: () => selectAddress(),
                            suffixWidget: AppIcon(
                              AppIcons.svg.generic.location,
                              size: AppIconSize.is20.ir,
                            ),
                          ),
                          AppSpacing.s20.hBox,
                          AppTextField(
                            label: 'Add Reward Amount',
                            controller: rewardController,
                            keyboardType: TextInputType.number,
                            inputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(5),
                            ],
                            textInputAction: TextInputAction.next,
                            suffixWidget: AppIcon(
                              AppIcons.svg.generic.money,
                              size: AppIconSize.is20.ir,
                            ),
                          ),
                        ],
                      ),
                    ),

                    AppSpacing.s20.hBox,

                    /// UPLOAD
                    const PrimaryWidgetHeader(
                      title: 'Upload Images or Document',
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16.w,
                      ),
                      child: UploadImageWidget(
                        buttonText: 'Upload',
                        customeSupport:
                            'Upload medical reports, prescriptions and vaccination certificates.',
                        maxSizeLabel: 'Max 2MB',
                        initialUrls: remoteFiles,
                        onFilesChanged: _onFilesChanged,
                        onRemoteChanged: _onRemoteChanged,
                      ),
                    ),

                    AppSpacing.s20.hBox,

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16.w,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppCheckbox(
                            size: AppSize.cs24.csw,
                            borderColor: AppColors.black,
                            activeColor: AppColors.black,
                            checkColor: AppColors.white,
                            value: isAgreed,
                            onChanged: (val) {
                              setState(() {
                                isAgreed = val ?? false;
                              });
                            },
                            padding: EdgeInsets.zero,
                          ),
                          SizedBox(width: AppSpacing.s8.w),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        'By submitting this tip, you agree to our ',
                                    style: AppTypography.support.copyWith(
                                      color: AppColors.black,
                                      fontSize: AppFontSize.fs10,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'Terms & Conditions and Community Guidelines.',
                                    style: AppTypography.support.copyWith(
                                      color: AppColors.black,
                                      decoration: TextDecoration.underline,
                                      fontSize: AppFontSize.fs10,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // handle navigation
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: AppSpacing.s20.h),
                  ],
                ),
              ),
            ),

            /// =========================
            /// FIXED BOTTOM BUTTONS
            /// =========================
            SafeArea(
              top: false,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.s16.w,
                  vertical: AppSpacing.s16.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// SUBMIT
                    AppButton(
                      isLoading: isSubmitting,
                      label: widget.type == ReportMissingPetFormType.edit
                          ? 'Update'
                          : 'Submit',
                      onPressed: isSubmitEnabled
                          ? () => _createEvent(false)
                          : null,
                      isDisabled: !isSubmitEnabled,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate({
    required DateTime? initialDate,
    required ValueChanged<DateTime> onSelected,
  }) async {
    final now = DateTime.now();
    await AppDatePicker.show(
      context: context,
      initialDate: initialDate,
      currentDate: now,
      // firstDate: savedDate, in Edit mode we can set firstDate to the existing date to prevent going back in time, but for now keeping it open
      firstDate: DateTime(now.year - 10, now.month, now.day),
      lastDate: now,
      onDateConfirmed: (date, _) {
        if (date == null) return;
        onSelected(date);
      },
    );
  }

  Future<void> _pickTime({
    required DateTime selectedDate,
    required TimeOfDay? initialTime,
    required ValueChanged<TimeOfDay> onSelected,
  }) async {
    final updatedDate = selectedDate.add(const Duration(days: 1));
    await AppTimePicker.show(
      context: context,
      selectedDate: updatedDate,
      initialTime: initialTime,
      onTimeConfirmed: (time) {
        if (time == null) return;
        onSelected(time);
      },
    );
  }

  Future<void> selectAddress() async {
    final result = await AddressSearchBottomSheet.show(
      context: context,
      onSelectedApiCall: (place) async {
        selectedAddress = place;
        addressController.text =
            place.description; // show selected address in the field
      },
    );

    if (result != null) {
      // print('Address-Returned to screen: ${result.description}');
    }
  }

  void _onFilesChanged(List<File> files) {
    setState(() {
      localFiles = files;
    });
  }

  void _onRemoteChanged(List<String> urls) {
    setState(() {
      remoteFiles = urls;
    });
  }

  Future<List<Map<String, dynamic>>> _uploadAttachments() async {
    final uploadService = getIt<DocumentUploadService>();

    final uploadedFilesByPath = <String, UploadedDocumentFile>{};

    final result = await uploadService.processPendingUploadsForSave(
      context: context,
      ownerId: 'tip',
      entityType: UploadEntityType.community,
      purpose: UploadPurpose.otherDocuments,
      selectedFiles: localFiles,
      uploadedFilesByPath: uploadedFilesByPath,
      enableRetryForFailed: false, // 👈 keeps it simple
    );

    if (!result.shouldProceedWithSave) {
      throw Exception('Upload failed');
    }

    return uploadService.buildUploadedDocumentEntries(
      selectedFiles: localFiles,
      uploadedFilesByPath: uploadedFilesByPath,
    );
  }

  String? formatToUtc(DateTime? dt) {
    if (dt == null) return null;
    // return dt.toUtc().toIso8601String();
    final year = dt.year.toString().padLeft(4, '0');
    final month = dt.month.toString().padLeft(2, '0');
    final day = dt.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  DateTime? endOfDay(DateTime? date) {
    if (date == null) return null;
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  String? formatTimeOfDay(TimeOfDay? time) {
    if (time == null) return null;

    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  Future<void> _createEvent(bool isDraft) async {
    setState(() {
      isSubmitting = true;
    });

    final attachmentUrls = await _uploadAttachments();

    final List<String> newUrls = (attachmentUrls as List)
        .map((e) => e['url'].toString())
        .toList();

    final List<String> remoteUrls = (remoteFiles)
        .map((e) => e['url'].toString())
        .toList();

    try {
      // ignore: unused_local_variable
      final List<dynamic> urls = [
        ...remoteUrls, // remaining existing ones
        // ...attachmentUrls, // newly uploaded ones
        ...newUrls, // newly uploaded ones
      ];
      if (!mounted) return; // ✅ I

      final payload = MissingPetReportPayloadModel(
        petId: selectedPet ?? '',
        description: descController.text.trim().isEmpty
            ? null
            : descController.text.trim(),
        color: '',
        missingDate: formatToUtc(missingDate),
        missingTime: formatTimeOfDay(missingTime),
        lastKnownLocation: addressController.text.trim().isEmpty
            ? null
            : addressController.text.trim(),
        latitude: selectedAddress?.latitude ?? 0.0,
        longitude: selectedAddress?.longitude ?? 0.0,
        rewardAmount: int.tryParse(rewardController.text.trim()),
        images: (urls.isEmpty) ? null : urls,
      );

      log('selectedAddress in payload: ${payload.toJson()}');
      // log('selectedAddress in payload: ${payload.lastKnownLocation} lat: ${payload.latitude} long: ${payload.longitude}');

      if (widget.type == ReportMissingPetFormType.edit) {
        await context.read<MyMissingPetsBloc>().updatedMissingPetReport(
          reportId: widget.reportId ?? '',
          payload: payload,
        );
      } else {
        await context.read<MyMissingPetsBloc>().reprortMissingPet(
          payload: payload,
        );
      }
      if (!mounted) return; // ✅ I
      context.read<AllMissingPetsBloc>().fetchInitialMissingPets();
      context.read<MyMissingPetsBloc>().fetchInitialMissingPets();
      context.router.replace(
        ReportMissingPetTransitionRoute(petId: selectedPet ?? ''),
      );
    } catch (e) {
      String errorMessage = e.toString();
      if (errorMessage.contains(':')) {
        errorMessage = errorMessage.split(':').skip(1).join(':').trim();
      }
      if (!mounted) return; // ✅ I
      AppDialog.show(
        icon: Lottie.asset(AppIcons.lottie.successful, repeat: false),
        context: context,
        title: 'Oops! There was an error.',
        content: errorMessage,
        primaryLabel: 'Try Again',
        secondaryLabel: 'Later',
        onPrimary: () async {
          // Navigator.of(context).pop();
          _createEvent(isDraft);
          return true;
        },
        onSecondary: () async {
          // Navigator.of(context).pop();
          return true;
        },
      );
      setState(() {
        isSubmitting = false;
      });
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }
}
