import 'package:equatable/equatable.dart';
import 'package:poochcare/features/medical_history/data/models/medical_details_response_model.dart';
import 'package:poochcare/features/medical_history/data/models/medical_record_details_response_model.dart';

enum MedicalDetailsStatus { initial, loading, success, failure }

enum MedicalRecordsStatus { initial, loading, success, failure }

class MedicalDetailsState extends Equatable {
  final MedicalDetailsStatus detailsStatus;
  final MedicalRecordsStatus recordsStatus;
  final MedicalDetailsData? medicalDetailsData;
  final MedicalRecordData? medicalRecordsData;
  final String? errorMessage;
  final String? successMessage;

  const MedicalDetailsState({
    this.detailsStatus = MedicalDetailsStatus.initial,
    this.recordsStatus = MedicalRecordsStatus.initial,
    this.errorMessage = '',
    this.successMessage = '',
    this.medicalDetailsData,
    this.medicalRecordsData,
  });

  MedicalDetailsState copyWith({
    MedicalDetailsStatus? detailsStatus,
    MedicalRecordsStatus? recordsStatus,
    String? errorMessage,
    String? successMessage,
    MedicalDetailsData? medicalDetailsData,
    MedicalRecordData? medicalRecordsData,
  }) {
    return MedicalDetailsState(
      detailsStatus: detailsStatus ?? this.detailsStatus,
      recordsStatus: recordsStatus ?? this.recordsStatus,
      errorMessage: errorMessage,
      successMessage: successMessage,
      medicalDetailsData: medicalDetailsData ?? this.medicalDetailsData,
      medicalRecordsData: medicalRecordsData ?? this.medicalRecordsData,
    );
  }

  @override
  List<Object?> get props => [
    detailsStatus,
    recordsStatus,
    errorMessage,
    successMessage,
    medicalDetailsData,
    medicalRecordsData,
  ];
}
