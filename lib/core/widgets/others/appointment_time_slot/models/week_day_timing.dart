import 'package:flutter/material.dart';

class WeekDayTiming {
  final String openAtUtc;
  final String closeAtUtc;

  const WeekDayTiming({required this.openAtUtc, required this.closeAtUtc});

  DateTimeRange toLocalRangeForDate(DateTime selectedDate) {
    final openLocalReference = DateTime.parse(openAtUtc).toLocal();
    final closeLocalReference = DateTime.parse(closeAtUtc).toLocal();

    final openLocal = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      openLocalReference.hour,
      openLocalReference.minute,
      openLocalReference.second,
      openLocalReference.millisecond,
      openLocalReference.microsecond,
    );

    DateTime closeLocal = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      closeLocalReference.hour,
      closeLocalReference.minute,
      closeLocalReference.second,
      closeLocalReference.millisecond,
      closeLocalReference.microsecond,
    );

    if (!closeLocal.isAfter(openLocal)) {
      closeLocal = closeLocal.add(const Duration(days: 1));
    }

    return DateTimeRange(start: openLocal, end: closeLocal);
  }
}
