import 'package:flutter/material.dart';

class MedicalHistoryFiltersScope extends InheritedWidget {
  const MedicalHistoryFiltersScope({
    super.key,
    required this.selectedDateRangeNotifier,
    required this.selectedPetIdNotifier,
    required this.activeTabIndexNotifier,
    required this.refreshSignalNotifier,
    required super.child,
  });

  final ValueNotifier<DateTimeRange> selectedDateRangeNotifier;
  final ValueNotifier<String?> selectedPetIdNotifier;
  final ValueNotifier<int> activeTabIndexNotifier;
  final ValueNotifier<int> refreshSignalNotifier;

  static MedicalHistoryFiltersScope of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<MedicalHistoryFiltersScope>();
    assert(scope != null, 'MedicalHistoryFiltersScope not found in context.');
    return scope!;
  }

  @override
  bool updateShouldNotify(covariant MedicalHistoryFiltersScope oldWidget) {
    return selectedDateRangeNotifier != oldWidget.selectedDateRangeNotifier ||
        selectedPetIdNotifier != oldWidget.selectedPetIdNotifier;
  }
}
