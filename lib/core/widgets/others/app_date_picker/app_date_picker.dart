import 'package:flutter/material.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';

enum DatePickerType { single, range }

class AppDatePicker extends StatefulWidget {
  const AppDatePicker({
    super.key,
    this.initialDate,
    required this.onDateConfirmed,
    this.datePickerType = DatePickerType.single,
    this.initialDateRange,
    this.firstDate,
    this.lastDate,
    this.currentDate,

    this.buttonTitle = 'Select date',
  });

  final DateTime? initialDate;
  final DateTimeRange? initialDateRange;
  final void Function(DateTime?, DateTimeRange?) onDateConfirmed;
  final DatePickerType datePickerType;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? currentDate;
  final String? buttonTitle;

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();

  static Future<void> show({
    required BuildContext context,
    DateTime? initialDate,
    DateTimeRange? initialDateRange,
    required void Function(DateTime?, DateTimeRange?) onDateConfirmed,
    DatePickerType datePickerType = DatePickerType.single,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? currentDate,
    String datePickerButtonTitle = 'Done',
    String datePickerHeaderTitle = 'Select Date',
  }) async {
    final datePickerKey = GlobalKey<_AppDatePickerState>();

    if (datePickerType == DatePickerType.range) {
      final today = _normalize(currentDate ?? DateTime.now());
      final startDate = _normalize(firstDate ?? DateTime(1900));
      final endDate = _normalize(lastDate ?? DateTime(2100));

      initialDateRange = await showDateRangePicker(
        context: context,
        firstDate: startDate,
        lastDate: endDate,
        initialDateRange: initialDateRange,
        currentDate: today,
      );
      if (initialDateRange?.start != null && initialDateRange?.end != null) {
        onDateConfirmed(null, initialDateRange);
      }
      return;
    }

    AppBottomSheet.show<DateTime>(
      context: context,
      title: datePickerHeaderTitle,
      content: AppDatePicker(
        currentDate: currentDate,
        firstDate: firstDate,
        lastDate: lastDate,
        key: datePickerKey,
        initialDateRange: initialDateRange,
        datePickerType: datePickerType,
        initialDate: initialDate,
        onDateConfirmed: onDateConfirmed,
      ),
      actions: [
        AppButton(
          label: datePickerButtonTitle,
          onPressed: () {
            datePickerKey.currentState?.confirmSelection(
              selectedDate: initialDate,
              selectedDateRange: initialDateRange,
            );
          },
        ),
      ],
    );
  }

  static Future<void> showSystemDatePicker({
    required BuildContext context,
    DateTime? currentDate,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    required void Function(DateTime?) onDateConfirmed,
  }) async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
      initialDate: initialDate ?? DateTime.now(),
      currentDate: currentDate ?? DateTime.now(),
    );

    if (pickedDate != null) {
      onDateConfirmed(pickedDate);
    }
    return;
  }

  static DateTime _normalize(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }
}

class _AppDatePickerState extends State<AppDatePicker> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = _normalize(widget.initialDate ?? DateTime.now());
  }

  @override
  void didUpdateWidget(covariant AppDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDate != oldWidget.initialDate &&
        widget.initialDate != null) {
      _selectedDate = _normalize(widget.initialDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = _normalize(widget.currentDate ?? DateTime.now());
    final firstDate = _normalize(widget.firstDate ?? DateTime(1900));
    final lastDate = _normalize(widget.lastDate ?? DateTime(2100));

    return CalendarDatePicker(
      initialDate: _selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
      currentDate: today,
      onDateChanged: (date) {
        _selectedDate = _normalize(date);
      },
    );
  }

  void confirmSelection({
    required DateTime? selectedDate,
    required DateTimeRange? selectedDateRange,
  }) {
    widget.onDateConfirmed(_selectedDate, null);
    Navigator.of(context).pop();
  }

  DateTime _normalize(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }
}
