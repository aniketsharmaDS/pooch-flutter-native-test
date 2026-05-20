import 'package:equatable/equatable.dart';

sealed class MedicalHistoryFormEvent extends Equatable {
  const MedicalHistoryFormEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class LoadMedicalHistoryFormData extends MedicalHistoryFormEvent {
  const LoadMedicalHistoryFormData();
}

class SaveMedicalHistoryRecordRequested extends MedicalHistoryFormEvent {
  const SaveMedicalHistoryRecordRequested({
    required this.type,
    required this.payload,
  });

  final String type;
  final dynamic payload;

  @override
  List<Object?> get props => <Object?>[type, payload];
}
