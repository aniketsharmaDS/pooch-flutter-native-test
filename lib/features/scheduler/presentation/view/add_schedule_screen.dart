import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/bottom_sheet/address/address_search_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/dropdowns/app_dropdowns.dart';
import 'package:poochcare/core/widgets/forms/medical_form/pet_selection_form_field.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/others/app_date_picker/app_date_picker.dart';
import 'package:poochcare/core/widgets/others/app_date_picker/app_time_picker.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';
import 'package:poochcare/features/scheduler/data/models/request_models/create_event_request_model.dart';
import 'package:poochcare/features/scheduler/data/models/request_models/create_reminder_request_model.dart';
import 'package:poochcare/features/scheduler/domain/ui_models/schedule_item_ui_model.dart';
import 'package:poochcare/features/scheduler/presentation/bloc/schedule_bloc.dart';
import 'package:poochcare/features/scheduler/presentation/bloc/schedule_event.dart';
import 'package:poochcare/features/scheduler/presentation/bloc/schedule_state.dart';

@RoutePage()
class AddScheduleScreen extends StatefulWidget {
  const AddScheduleScreen({
    super.key,
    this.initialItem,
    this.initialDate,
    this.isEditing = false,
  });

  final ScheduleItemUIModel? initialItem;
  final DateTime? initialDate;
  final bool isEditing;

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  bool isReminderSelected = true;

  final ValueNotifier<String?> _selectedCategory = ValueNotifier(null);

  final ValueNotifier<String?> selectedPetNotifier = ValueNotifier<String?>(
    null,
  );

  final TextEditingController _specifyCategoryController =
      TextEditingController();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _timeController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _endDateController = TextEditingController();

  final TextEditingController _notesController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  String _submitType = 'reminder';

  final TextEditingController _locationController = TextEditingController();

  DateTimeRange? selectedDateRange;

  String? selectedAddress;

  double? latitude;

  double? longitude;

  final reminderCategories = [
    'Feeding',
    'Walk',
    'Medication',
    'Diet',
    'Health Checkup',
    'Other',
  ];

  final eventTypes = ['Webinar', 'Visit', 'Training', 'Competition'];

  bool get isOtherSelected => _selectedCategory.value == 'Other';

  @override
  void initState() {
    super.initState();
    if (widget.initialItem != null) {
      _prefillFromItem(widget.initialItem);
    } else if (widget.initialDate != null) {
      _prefillFromDate(widget.initialDate!);
    }
  }

  void _prefillFromDate(DateTime date) {
    selectedDate = date;
    _dateController.text = '${date.day}-${date.month}-${date.year}';
    selectedDateRange = DateTimeRange(start: date, end: date);
  }

  void _prefillFromItem(ScheduleItemUIModel? item) {
    if (item == null) return;

    final isEvent = item.type.toLowerCase() == 'event';

    isReminderSelected = !isEvent;
    _submitType = isEvent ? 'event' : 'reminder';

    if (item.petId.isNotEmpty) {
      selectedPetNotifier.value = item.petId;
    }

    _titleController.text = item.title;
    _notesController.text = item.notes;

    selectedDate = item.startDateTime;
    selectedTime = TimeOfDay(
      hour: item.startDateTime.hour,
      minute: item.startDateTime.minute,
    );
    _timeController.text = formatTimeOfDay(selectedTime) ?? '';

    if (isEvent) {
      _prefillEventFields(item);
    } else {
      _prefillReminderFields(item);
    }
  }

  void _prefillReminderFields(ScheduleItemUIModel item) {
    if (selectedDate != null) {
      final date = selectedDate!;
      _dateController.text = '${date.day}-${date.month}-${date.year}';
    }

    final category = item.taskCategory.trim();
    if (category.isEmpty) return;

    if (reminderCategories.contains(category)) {
      _selectedCategory.value = category;
      return;
    }

    _selectedCategory.value = 'Other';
    _specifyCategoryController.text = category;
  }

  void _prefillEventFields(ScheduleItemUIModel item) {
    final start = selectedDate;
    final end = _parseDate(item.endDate) ?? start;

    if (start != null && end != null) {
      final safeEnd = end.isBefore(start) ? start : end;
      selectedDateRange = DateTimeRange(start: start, end: safeEnd);
      _dateController.text =
          '${start.day}-${start.month}-${start.year}'
          ' → '
          '${safeEnd.day}-${safeEnd.month}-${safeEnd.year}';
    }

    final eventType = item.eventType.trim();
    if (eventType.isNotEmpty && !eventTypes.contains(eventType)) {
      eventTypes.add(eventType);
    }
    if (eventType.isNotEmpty) {
      _selectedCategory.value = eventType;
    }

    if (item.location.isNotEmpty) {
      selectedAddress = item.location;
      _locationController.text = item.location;
    }
  }

  DateTime? _parseDate(String value) {
    if (value.isEmpty) return null;
    return DateTime.tryParse(value);
  }

  @override
  void dispose() {
    _selectedCategory.dispose();
    _specifyCategoryController.dispose();
    _titleController.dispose();
    _timeController.dispose();
    _dateController.dispose();
    _endDateController.dispose();
    _notesController.dispose();
    _locationController.dispose();
    selectedPetNotifier.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    /// EVENT -> DATE RANGE
    if (!isReminderSelected) {
      await AppDatePicker.show(
        context: context,

        datePickerType: DatePickerType.range,

        initialDateRange: selectedDateRange,

        currentDate: DateTime.now(),

        firstDate: DateTime.now(),

        lastDate: DateTime(2100),

        onDateConfirmed: (_, range) {
          if (range == null) return;

          setState(() {
            selectedDateRange = range;

            _dateController.text =
                '${range.start.day}-${range.start.month}-${range.start.year}'
                ' → '
                '${range.end.day}-${range.end.month}-${range.end.year}';

            /// IMPORTANT
            selectedDate = range.start;
          });
        },
      );

      return;
    }

    /// REMINDER -> SINGLE DATE
    await AppDatePicker.show(
      context: context,

      initialDate: selectedDate,

      currentDate: DateTime.now(),

      firstDate: DateTime.now(),

      lastDate: DateTime(2100),

      onDateConfirmed: (date, _) {
        if (date == null) return;

        setState(() {
          selectedDate = date;

          _dateController.text = '${date.day}-${date.month}-${date.year}';
        });
      },
    );
  }

  Future<void> _pickTime() async {
    if (selectedDate == null) return;

    await AppTimePicker.show(
      context: context,
      selectedDate: selectedDate!,
      initialTime: selectedTime,

      onTimeConfirmed: (time) {
        if (time == null) return;

        setState(() {
          selectedTime = time;

          _timeController.text = formatTimeOfDay(time) ?? '';
        });
      },
    );
  }

  Future<void> selectAddress() async {
    final result = await AddressSearchBottomSheet.show(
      context: context,

      onSelectedApiCall: (place) async {
        setState(() {
          selectedAddress = place.description;

          latitude = place.latitude;

          longitude = place.longitude;

          _locationController.text = place.description;
        });
      },
    );

    if (result != null) {}
  }

  String? formatTimeOfDay(TimeOfDay? time) {
    if (time == null) return null;

    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;

    final minute = time.minute.toString().padLeft(2, '0');

    final period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  void _resetFormFields() {
    _selectedCategory.value = null;

    selectedDate = null;
    selectedDateRange = null;
    selectedTime = null;

    selectedAddress = null;
    latitude = null;
    longitude = null;

    _dateController.clear();
    _timeController.clear();
    _locationController.clear();
  }

  void _submit(BuildContext context) {
    final bloc = context.read<ScheduleBloc>();
    if (bloc.state.isSubmitting) return;

    final petId = selectedPetNotifier.value;
    if (petId == null ||
        selectedDate == null ||
        selectedTime == null ||
        _selectedCategory.value == null) {
      return;
    }

    if (isReminderSelected) {
      final request = CreateReminderRequestModel(
        petId: petId,
        title: _titleController.text.trim(),
        date: DateFormat('yyyy-MM-dd').format(selectedDate!),
        time:
            '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}',
        taskCategory: _selectedCategory.value == 'Other'
            ? _specifyCategoryController.text.trim()
            : _selectedCategory.value!,
        notes: _notesController.text.trim(),
      );

      final currentItem = widget.initialItem;

      if (widget.isEditing && currentItem != null) {
        bloc.add(
          UpdateReminder(
            id: currentItem.id,
            request: request,
            currentItem: currentItem,
          ),
        );
        return;
      }

      bloc.add(CreateReminder(request));
      return;
    }

    final request = CreateEventRequestModel(
      petId: petId,
      title: _titleController.text.trim(),
      date: DateFormat('yyyy-MM-dd').format(selectedDate!),

      // temporary: same as date if no range picker used yet
      endDate: DateFormat(
        'yyyy-MM-dd',
      ).format(selectedDateRange?.end ?? selectedDate!),

      time:
          '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}',

      eventType: _selectedCategory.value!,
      location: selectedAddress ?? '',
      notes: _notesController.text.trim(),
    );

    final currentItem = widget.initialItem;

    if (widget.isEditing && currentItem != null) {
      bloc.add(
        UpdateEvent(
          id: currentItem.id,
          request: request,
          currentItem: currentItem,
        ),
      );
      return;
    }

    bloc.add(CreateEvent(request));
  }

  @override
  Widget build(BuildContext context) {
    final allowTypeChange = !widget.isEditing;

    return BlocListener<ScheduleBloc, ScheduleState>(
      listener: (context, state) {
        if (state.submitSuccess) {
          final message = state.successMessage ?? 'Success';

          if (_submitType == 'reminder') {
            ToastService.showSuccess(message);
          } else {
            ToastService.showSuccess(message);
          }

          if (context.router.canPop()) {
            context.router.pop();
          }
        }

        if (state.error != null) {
          ToastService.showError(state.error!);
        }
      },
      child: Scaffold(
        body: AppPrimaryBgContainer(
          child: SafeArea(
            child: Column(
              children: [
                PoochScreenAppBar(
                  title: widget.isEditing ? 'Edit task' : 'Add a new task',
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSpacing.s16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.h1('Select type', fontSize: AppFontSize.fs16),
                        const SizedBox(height: AppSpacing.s16),
                        Row(
                          children: [
                            _typeCard(
                              title: 'Reminder',
                              isSelected: isReminderSelected,
                              onTap: allowTypeChange
                                  ? () {
                                      setState(() {
                                        isReminderSelected = true;

                                        _submitType = 'reminder';

                                        _resetFormFields();
                                      });
                                    }
                                  : null,
                            ),
                            const SizedBox(width: AppSpacing.s12),
                            _typeCard(
                              title: 'Event',
                              isSelected: !isReminderSelected,
                              onTap: allowTypeChange
                                  ? () {
                                      setState(() {
                                        isReminderSelected = false;

                                        _submitType = 'event';

                                        _resetFormFields();
                                      });
                                    }
                                  : null,
                            ),
                          ],
                        ),
                        AppSpacing.s24.hBox,

                        /// PET SELECTION
                        PetSelectionFormField(
                          selectedPetNotifier: selectedPetNotifier,
                        ),

                        AppSpacing.s16.hBox,

                        /// CATEGORY / EVENT TYPE
                        ValueListenableBuilder(
                          valueListenable: _selectedCategory,
                          builder: (context, value, _) {
                            return Column(
                              children: [
                                AppDropdowns<String>(
                                  items:
                                      (isReminderSelected
                                              ? reminderCategories
                                              : eventTypes)
                                          .map(
                                            (item) => DropdownItem<String>(
                                              value: item,
                                              height: 40,
                                              child: Text(item),
                                            ),
                                          )
                                          .toList(growable: false),
                                  valueListenable: _selectedCategory,
                                  isExpanded: true,
                                  isMandatory: true,
                                  hint: AppText.bodyM(
                                    isReminderSelected
                                        ? 'Task Category'
                                        : 'Event type',
                                    color: AppColors.textFieldLabelDefault,
                                  ),
                                  onChanged: (v) {
                                    _selectedCategory.value = v;
                                  },
                                ),
                                if (isOtherSelected) ...[
                                  const SizedBox(height: AppSpacing.s16),

                                  AppTextField(
                                    label: 'Specify Category',
                                    controller: _specifyCategoryController,
                                    isMandatory: true,
                                  ),
                                ],
                              ],
                            );
                          },
                        ),

                        AppSpacing.s16.hBox,

                        /// TITLE
                        AppTextField(
                          label: 'Title',
                          controller: _titleController,
                          isMandatory: true,
                        ),

                        if (!isReminderSelected) ...[
                          AppSpacing.s16.hBox,

                          GestureDetector(
                            behavior: HitTestBehavior.opaque,

                            onTap: () {
                              selectAddress();
                            },

                            child: Container(
                              alignment: Alignment.centerLeft,

                              height: 56,

                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.s16,
                              ),

                              decoration: BoxDecoration(
                                color: AppColors.white,

                                borderRadius: BorderRadius.circular(
                                  AppRadiusSize.r16,
                                ),
                              ),

                              child: AppText.h4(
                                selectedAddress == null
                                    ? 'Choose location'
                                    : selectedAddress ?? '',

                                variant: AppTextVariant.noEllipsis,
                              ),
                            ),
                          ),
                        ],

                        AppSpacing.s16.hBox,

                        /// DATE
                        AppTextField(
                          label: isReminderSelected
                              ? 'Select date'
                              : 'Select date range',
                          controller: _dateController,
                          isReadOnly: true,
                          isMandatory: true,
                          onPressed: _pickDate,
                          suffixWidget: AppIcon(AppIcons.svg.generic.calendar),
                        ),

                        AppSpacing.s16.hBox,

                        /// TIME
                        AppTextField(
                          label: 'Select time',
                          controller: _timeController,
                          isReadOnly: true,
                          isMandatory: true,
                          onPressed: _pickTime,
                          suffixWidget: AppIcon(AppIcons.svg.generic.clock),
                        ),

                        AppSpacing.s16.hBox,

                        /// NOTES
                        AppTextField(
                          label: 'Additional Notes',
                          controller: _notesController,
                          height: AppSize.cs90,
                          isTextArea: true,
                        ),

                        AppSpacing.s32.hBox,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.s16),
                  child: BlocBuilder<ScheduleBloc, ScheduleState>(
                    buildWhen: (previous, current) =>
                        previous.isSubmitting != current.isSubmitting,
                    builder: (context, state) {
                      return AppButton(
                        label: widget.isEditing ? 'Update' : 'Submit',
                        isLoading: state.isSubmitting,
                        isDisabled: state.isSubmitting,
                        onPressed: state.isSubmitting
                            ? null
                            : () => _submit(context),
                        height: AppSize.cs48,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _typeCard({
    required String title,
    required bool isSelected,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadiusSize.r15),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 50,
        width: 120,
        padding: const EdgeInsets.all(AppSpacing.s10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.p1 : AppColors.s3_50,
          borderRadius: BorderRadius.circular(AppRadiusSize.r15),
          border: Border.all(color: AppColors.p4_50),
        ),
        child: AppText.h1(
          title,
          fontSize: AppFontSize.fs16,
          color: isSelected ? AppColors.white : AppColors.p4_900,
        ),
      ),
    );
  }
}
