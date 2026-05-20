import 'package:equatable/equatable.dart';

sealed class MedicalHistoryEvent extends Equatable {
  const MedicalHistoryEvent();

  @override
  List<Object?> get props => const <Object?>[];
}

class FetchMedicalHistoryRecords extends MedicalHistoryEvent {
  const FetchMedicalHistoryRecords({
    required this.page,
    required this.limit,
    this.petId,
    this.recordType,
    this.startDate,
    this.endDate,
    this.isForceRefresh = false,
  });

  final int page;
  final int limit;
  final String? petId;
  final String? recordType;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isForceRefresh;

  @override
  List<Object?> get props => <Object?>[
    page,
    limit,
    petId,
    recordType,
    startDate,
    endDate,
    isForceRefresh,
  ];
}
