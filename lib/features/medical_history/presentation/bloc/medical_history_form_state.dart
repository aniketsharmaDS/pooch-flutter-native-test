import 'package:equatable/equatable.dart';
import 'package:poochcare/features/medical_history/domain/models/diagnosis_type.dart';
import 'package:poochcare/features/medical_history/domain/models/lab_report_type.dart';
import 'package:poochcare/features/medical_history/domain/models/vaccination_type.dart';

enum MedicalHistoryFormStatus { initial, loading, success, failure }

enum MedicalHistorySaveStatus { initial, loading, success, failure }

class MedicalHistoryFormState extends Equatable {
  const MedicalHistoryFormState({
    this.status = MedicalHistoryFormStatus.initial,
    this.vaccinationTypes = const <VaccinationType>[],
    this.diagnosisTypes = const <DiagnosisType>[],
    this.labReportTypes = const <LabReportType>[],
    this.saveStatus = MedicalHistorySaveStatus.initial,
    this.errorMessage,
    this.successMessage,
  });

  final MedicalHistoryFormStatus status;
  final List<VaccinationType> vaccinationTypes;
  final List<DiagnosisType> diagnosisTypes;
  final List<LabReportType> labReportTypes;
  final MedicalHistorySaveStatus saveStatus;
  final String? errorMessage;
  final String? successMessage;

  MedicalHistoryFormState copyWith({
    MedicalHistoryFormStatus? status,
    List<VaccinationType>? vaccinationTypes,
    List<DiagnosisType>? diagnosisTypes,
    List<LabReportType>? labReportTypes,
    MedicalHistorySaveStatus? saveStatus,
    String? errorMessage,
    String? successMessage,
    bool clearErrorMessage = false,
    bool clearSuccessMessage = false,
  }) {
    return MedicalHistoryFormState(
      status: status ?? this.status,
      vaccinationTypes: vaccinationTypes ?? this.vaccinationTypes,
      diagnosisTypes: diagnosisTypes ?? this.diagnosisTypes,
      labReportTypes: labReportTypes ?? this.labReportTypes,
      saveStatus: saveStatus ?? this.saveStatus,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccessMessage
          ? null
          : (successMessage ?? this.successMessage),
    );
  }

  @override
  List<Object?> get props => <Object?>[
    status,
    vaccinationTypes,
    diagnosisTypes,
    labReportTypes,
    saveStatus,
    errorMessage,
    successMessage,
  ];
}
