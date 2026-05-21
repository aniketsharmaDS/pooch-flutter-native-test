import 'package:equatable/equatable.dart';
import 'package:poochcare/features/insight/data/models/symptom_response.dart';

enum SymptomsStatus { initial, loading, success, failure }

class ReportSymptomsState extends Equatable {
  final SymptomsStatus status;
  final SymptomResponse? symptomResponse;
  final String? errorMessage;
  final String? successMessage;
  final int actionId;

  const ReportSymptomsState({
    this.status = SymptomsStatus.initial,
    this.symptomResponse,
    this.errorMessage,
    this.successMessage,
    this.actionId = 0,
  });

  ReportSymptomsState copyWith({
    SymptomsStatus? status,
    SymptomResponse? symptomResponse,
    String? errorMessage,
    String? successMessage,
    int? actionId,
  }) {
    return ReportSymptomsState(
      status: status ?? this.status,
      symptomResponse: symptomResponse ?? this.symptomResponse,
      errorMessage: errorMessage,
      successMessage: successMessage,
      actionId: (actionId ?? this.actionId),
    );
  }

  @override
  List<Object?> get props => [
    status,
    symptomResponse,
    errorMessage,
    successMessage,
    actionId,
  ];
}
