import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/document_upload_service.dart';
import 'package:poochcare/core/services/s3_upload_path_builder.dart';
import 'package:poochcare/core/store/community/community_store_bloc.dart';
import 'package:poochcare/core/store/community/community_store_state.dart';
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
import 'package:poochcare/core/widgets/chips/app_chip.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/headers/primary_widget_header.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/others/app_date_picker/app_date_picker.dart';
import 'package:poochcare/core/widgets/others/app_date_picker/app_time_picker.dart';
import 'package:poochcare/core/widgets/others/upload_image_widget.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';
import 'package:poochcare/features/community/domain/models/create_event_payload_model.dart';
import 'package:poochcare/features/community/presentation/bloc/categories/categories_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/categories/categories_event.dart';
import 'package:poochcare/features/community/presentation/bloc/categories/categories_state.dart';
import 'package:poochcare/features/community/presentation/bloc/events/events_bloc.dart';

enum MyEventFormType { create, edit }

@RoutePage()
class MyEventFormScreen extends StatefulWidget implements AutoRouteWrapper {
  const MyEventFormScreen({super.key, required this.type, this.eventId});

  final MyEventFormType type;
  final String? eventId;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CommunityStoreBloc>.value(
          value: getIt<CommunityStoreBloc>(),
        ),
        BlocProvider<CategoriesBloc>.value(value: getIt<CategoriesBloc>()),
        BlocProvider<EventsBloc>.value(value: getIt<EventsBloc>()),
      ],
      child: this,
    );
  }

  @override
  State<MyEventFormScreen> createState() => _MyEventFormScreenState();
}

class _MyEventFormScreenState extends State<MyEventFormScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool isSubmitting = false;
  String? selectedCategory;
  bool isAgreed = false;
  String tipStatus =
      'DRAFT'; // default to draft, can be changed to 'published' on submit
  DateTime? eventStartDate;
  DateTime? eventEndDate;
  TimeOfDay? eventTime;
  List<File> localFiles = [];
  List<dynamic> remoteFiles = [];
  AddressResult? selectedAddress;

  /// =========================
  /// VALIDATION GETTERS
  /// =========================
  bool get isTitleValid => titleController.text.trim().isNotEmpty;
  bool get isDateValid => eventStartDate != null;
  bool get isTimeValid => eventTime != null;
  bool get isLocationValid => locationController.text.trim().isNotEmpty;
  bool get isAddressValid => addressController.text.trim().isNotEmpty;
  bool get isCategoryValid => selectedCategory != null;
  bool get isTermsAccepted => isAgreed;
  bool get isFileAdded => remoteFiles.isNotEmpty || localFiles.isNotEmpty;

  // bool get isSubmitEnabled =>
  //     isTitleValid && selectedCategory != null && isAgreed;

  bool get isSubmitEnabled =>
      isTitleValid &&
      isCategoryValid &&
      isDateValid &&
      isTimeValid &&
      isLocationValid &&
      isAddressValid &&
      isTermsAccepted &&
      isFileAdded;

  bool get isDraftEnabled => isTitleValid;

  @override
  void initState() {
    super.initState();

    /// Rebuild on title change
    titleController.addListener(() {
      setState(() {});
    });

    /// 🔥 CALL API
    context.read<CategoriesBloc>().add(const FetchCategories());

    _prefillFromBloc();
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _timeController.dispose();
    locationController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void _prefillFromBloc() {
    if (widget.type != MyEventFormType.edit) return;

    final state = context.read<EventsBloc>().state;
    final item = state.selectedItem;

    if (item == null) return;

    /// TEXT FIELDS
    titleController.text = item.title;
    descController.text = item.description;
    locationController.text = item.location;
    addressController.text = item.addressDetails;

    selectedAddress = AddressResult(
      description: item.addressDetails,
      latitude: double.tryParse(item.latitude) ?? 0.0,
      longitude: double.tryParse(item.longitude) ?? 0.0,
      placeId: '',
    );

    selectedCategory = item.categoryId;

    tipStatus = item.status;

    /// STATUS
    tipStatus = item.status;
    isAgreed = item.status != 'DRAFT';

    /// DATE
    if (item.eventStartDate.isNotEmpty) {
      try {
        // final parsedDate = DateTime.parse(item.eventStartDate).toLocal();
        final parsedDate = DateTime.parse(item.eventStartDate).toLocal();

        eventStartDate = parsedDate;
        eventEndDate = parsedDate;
        _startDateController.text =
            '${parsedDate.day}-${parsedDate.month}-${parsedDate.year}';
        _endDateController.text =
            '${parsedDate.day}-${parsedDate.month}-${parsedDate.year}';
      } catch (e) {
        log('Date parse error: $e');
      }
    }

    /// TIME
    if (item.eventTime.isNotEmpty) {
      try {
        final parsedTime = _parseTime(item.eventTime);
        eventTime = parsedTime;

        _timeController.text = formatTimeOfDay(parsedTime) ?? '';
      } catch (e) {
        log('Time parse error: $e');
      }
    }

    /// IMAGES (IMPORTANT)

    remoteFiles =
        (item.images as List?)?.map((e) {
          return {
            'id': (e as dynamic).id?.toString() ?? '',
            'url': (e as dynamic).url ?? (e as dynamic).imageUrl ?? '',
            'name': (e as dynamic).name ?? '',
            'size': ((e as dynamic).size ?? '').toString(),
          };
        }).toList() ??
        [];
    log('remoteFiles prefill: $remoteFiles');
    setState(() {});
  }

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
      title: widget.type == MyEventFormType.create
          ? 'Add a new Event'
          : 'Edit a Event',
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
                          AppTextField(
                            label: 'Add event title',
                            controller: titleController,
                            isMandatory: true,
                            textInputAction: TextInputAction.next,
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
                            label: 'Select date',
                            controller: _startDateController,
                            isReadOnly: true,
                            isMandatory: true,
                            onPressed: () => _pickDate(
                              initialDate: eventStartDate,
                              onSelected: (date) {
                                setState(() {
                                  eventStartDate = date;
                                  _startDateController.text =
                                      '${date.day}-${date.month}-${date.year}';
                                });
                              },
                            ),
                            suffixWidget: AppIcon(
                              AppIcons.svg.generic.calendar,
                              size: AppIconSize.is16.ir,
                            ),
                          ),
                          // AppSpacing.s20.hBox,
                          // AppTextField(
                          //   label: 'Select date',
                          //   controller: _endDateController,
                          //   isReadOnly: true,
                          //   isMandatory: true,
                          //   onPressed: () => _pickDate(
                          //     initialDate: eventEndDate,
                          //     onSelected: (date) {
                          //       setState(() {
                          //         eventEndDate = date;
                          //         _endDateController.text =
                          //             '${date.day}-${date.month}-${date.year}';
                          //       });
                          //     },
                          //   ),
                          //   suffixWidget: AppIcon(
                          //     AppIcons.svg.generic.calendar,
                          //     size: AppIconSize.is16.ir,
                          //   ),
                          // ),
                          AppSpacing.s20.hBox,
                          AppTextField(
                            label: 'Select time',
                            enabled:
                                eventStartDate !=
                                null, // time can only be picked after date
                            controller: _timeController,
                            isReadOnly: true,
                            isMandatory: true,
                            onPressed: () => _pickTime(
                              initialTime: eventTime,
                              selectedDate: eventStartDate ?? DateTime.now(),
                              onSelected: (time) {
                                setState(() {
                                  eventTime = time;
                                  String? formattedTime = formatTimeOfDay(time);
                                  _timeController.text = formattedTime ?? '';
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
                            label: 'Add location',
                            controller: locationController,
                            isMandatory: true,
                            textInputAction: TextInputAction.next,
                          ),
                          AppSpacing.s20.hBox,
                          AppTextField(
                            label: 'Add Address',
                            controller: addressController,
                            isReadOnly: true,
                            isMandatory: true,
                            onPressed: () => selectAddress(),
                            suffixWidget: AppIcon(
                              AppIcons.svg.generic.location,
                              size: AppIconSize.is20.ir,
                            ),
                          ),
                        ],
                      ),
                    ),

                    AppSpacing.s40.hBox,

                    /// CATEGORY
                    const PrimaryWidgetHeader(title: 'Select Category'),

                    BlocBuilder<CategoriesBloc, CategoriesState>(
                      builder: (context, state) {
                        if (state is CategoriesLoading) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        if (state is CategoriesError) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(state.message),
                          );
                        }
                        return BlocBuilder<
                          CommunityStoreBloc,
                          CommunityStoreState
                        >(
                          builder: (context, storeState) {
                            final categories = storeState.categoryIds
                                .map((id) => storeState.categoriesById[id]!)
                                .toList();

                            if (categories.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Text('No categories found'),
                              );
                            }

                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSpacing.s16.w,
                              ),
                              child: Row(
                                children: categories.map((item) {
                                  final isSelected =
                                      selectedCategory == item.id;

                                  return Padding(
                                    padding: EdgeInsets.only(
                                      right: AppSpacing.s20.w,
                                    ),
                                    child: AppChip(
                                      label: item.name,
                                      isSelected: isSelected,
                                      onSelected: (_) {
                                        setState(() {
                                          selectedCategory = item.id;
                                        });
                                      },
                                      unselectedBgColor: AppColors.white,
                                      selectedBgColor: AppColors.white,
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    AppSpacing.s30.hBox,

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

                    /// TERMS
                    if (tipStatus == 'DRAFT') // Only show for create, not edit
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.s16.w,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppCheckbox(
                              size: AppSize.cs24.csw,
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
                      label: 'Submit',
                      onPressed: isSubmitEnabled
                          ? () => _createEvent(false)
                          : null,
                      isDisabled: !isSubmitEnabled,
                    ),

                    //  Save as draft is not for the event
                    // SizedBox(height: AppSpacing.s10.h),
                    // /// SAVE AS DRAFT
                    // AppButton(
                    //   isLoading: isSubmitting,
                    //   variant: AppButtonVariant.outlined,
                    //   label: 'Save as Draft',
                    //   onPressed: isDraftEnabled
                    //       ? () => _createEvent(true)
                    //       : null,
                    //   isDisabled: !isDraftEnabled,
                    // ),
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

    final safeInitialDate = (initialDate != null && initialDate.isBefore(now))
        ? now
        : (initialDate ?? now);

    await AppDatePicker.show(
      context: context,
      initialDate: safeInitialDate,
      currentDate: DateTime.now(),
      // firstDate: savedDate, in Edit mode we can set firstDate to the existing date to prevent going back in time, but for now keeping it open
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
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
    await AppTimePicker.show(
      context: context,
      selectedDate: selectedDate,
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
    return dt.toUtc().toIso8601String();
    // final year = dt.year.toString().padLeft(4, '0');
    // final month = dt.month.toString().padLeft(2, '0');
    // final day = dt.day.toString().padLeft(2, '0');
    // return '$year-$month-$day';
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
    log('Creating event with title: ${titleController.text.trim()}');
    setState(() {
      isSubmitting = true;
    });

    final attachmentUrls = await _uploadAttachments();

    log('Attachment URLs: $attachmentUrls');

    // final List<String> newUrls = (attachmentUrls as List)
    //     .map((e) => e['url'].toString())
    //     .toList();

    try {
      // ignore: unused_local_variable
      final List<dynamic> urls = [
        ...remoteFiles, // remaining existing ones
        ...attachmentUrls, // newly uploaded ones
      ];
      log('Attachment urls: $attachmentUrls');
      if (!mounted) return; // ✅ I

      final payload = CreateEventPayloadModel(
        eventId: widget.type == MyEventFormType.edit ? widget.eventId : null,
        title: titleController.text.trim(),

        description: descController.text.trim().isEmpty
            ? null
            : descController.text.trim(),

        categoryId: selectedCategory,

        isDraft: isDraft,

        eventStartDate: formatToUtc(eventStartDate), // if using DateTime
        eventEndDate: formatToUtc(endOfDay(eventStartDate)),

        eventTime: formatTimeOfDay(
          eventTime,
        ), // ideally DateTime or formatted string

        location: locationController.text.trim().isEmpty
            ? null
            : locationController.text.trim(),

        addressDetails: addressController.text.trim().isEmpty
            ? null
            : addressController.text.trim(),

        latitude: selectedAddress?.latitude,
        longitude: selectedAddress?.longitude,

        isPaid: false,

        images: (urls.isEmpty) ? null : urls,
      );

      if (widget.type == MyEventFormType.edit) {
        await context.read<EventsBloc>().updateEvent(payload: payload);
      } else {
        await context.read<EventsBloc>().createEvent(payload: payload);
      }

      if (!mounted) return; // ✅ I
      AppDialog.show(
        icon: Lottie.asset(AppIcons.lottie.successful, repeat: false),
        context: context,
        title: isDraft
            ? 'Event Saved as Draft'
            : 'Event Submitted Successfully!',
        content: isDraft
            ? 'Your Event has been saved as a draft and will be reviewed when you choose to submit it.'
            : 'Your Event will be reviewed by our team and published to the community once approved.',
        primaryLabel: 'Done',
        secondaryLabel: 'Close',
        onPrimary: () async {
          Navigator.of(context).pop();
          return true;
        },
        onSecondary: () async {
          Navigator.of(context).pop();
          return true;
        },
      );
    } catch (e) {
      if (!mounted) return; // ✅ I
      AppDialog.show(
        icon: Lottie.asset(AppIcons.lottie.successful, repeat: false),
        context: context,
        title: 'Oops! There was an error.',
        content:
            'Your event was not saved successfully. Please retry posting again.',
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
