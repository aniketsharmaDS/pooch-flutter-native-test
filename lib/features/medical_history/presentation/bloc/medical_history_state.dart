import 'package:equatable/equatable.dart';
import 'package:poochcare/features/medical_history/domain/models/medical_history_record.dart';

enum MedicalHistoryStatus { initial, loading, success, failure }

class MedicalHistoryState extends Equatable {
  const MedicalHistoryState({
    this.status = MedicalHistoryStatus.initial,
    this.errorMessage,
    this.records = const <MedicalHistoryRecord>[],
    this.hasMore = false,
  });

  final MedicalHistoryStatus status;
  final String? errorMessage;
  final List<MedicalHistoryRecord> records;
  final bool hasMore;

  MedicalHistoryState copyWith({
    MedicalHistoryStatus? status,
    String? errorMessage,
    List<MedicalHistoryRecord>? records,
    bool? hasMore,
  }) {
    return MedicalHistoryState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      records: records ?? this.records,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => <Object?>[status, errorMessage, records, hasMore];
}
