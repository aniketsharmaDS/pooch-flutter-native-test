import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';

class AppTimePicker {
  static Future<void> show({
    required BuildContext context,
    required DateTime selectedDate,
    TimeOfDay? initialTime,
    required void Function(TimeOfDay?) onTimeConfirmed,
  }) async {
    final now = DateTime.now();

    DateTime tempDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      initialTime?.hour ?? now.hour,
      initialTime?.minute ?? now.minute,
    );

    AppBottomSheet.show<void>(
      context: context,
      title: 'Select Time',

      content: StatefulBuilder(
        builder: (context, setModalState) {
          return SizedBox(
            height: 220,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: tempDateTime,

              onDateTimeChanged: (dateTime) {
                setModalState(() {
                  tempDateTime = dateTime;
                });
              },
            ),
          );
        },
      ),

      actions: [
        AppButton(
          label: 'Done',
          onPressed: () {
            final isToday = _isSameDay(selectedDate, now);

            final selectedDateTime = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              tempDateTime.hour,
              tempDateTime.minute,
            );

            /// Prevent past time for today
            if (isToday && selectedDateTime.isBefore(now)) {
              ToastService.showError('Please select a future time');

              return;
            }

            onTimeConfirmed(
              TimeOfDay(hour: tempDateTime.hour, minute: tempDateTime.minute),
            );

            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  static bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
