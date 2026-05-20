import 'package:equatable/equatable.dart';

abstract class MedicalDetailsEvent extends Equatable {
  const MedicalDetailsEvent();

  @override
  List<Object?> get props => [];
}

class FetchAppointmentDetailsEvent extends MedicalDetailsEvent {
  final String appointmentId;

  const FetchAppointmentDetailsEvent({required this.appointmentId});

  @override
  List<Object?> get props => [appointmentId];
}

class FetchMedicalRecordsDetailsEvent extends MedicalDetailsEvent {
  final String medicalRecordId;

  const FetchMedicalRecordsDetailsEvent({required this.medicalRecordId});

  @override
  List<Object?> get props => [medicalRecordId];
}
