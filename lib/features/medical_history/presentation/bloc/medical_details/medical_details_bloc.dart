import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_details/medical_details_event.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_details/medical_details_state.dart';
import 'package:poochcare/features/medical_history/repository/medical_details_repository.dart';

class MedicalDetailsBloc
    extends Bloc<MedicalDetailsEvent, MedicalDetailsState> {
  final MedicalDetailsRepository repository;

  MedicalDetailsBloc(this.repository) : super(const MedicalDetailsState()) {
    on<FetchAppointmentDetailsEvent>(_onFetchAppointmentDetails);
    on<FetchMedicalRecordsDetailsEvent>(_onFetchMedicalRecordsDetails);
  }
  Future<void> _onFetchAppointmentDetails(
    FetchAppointmentDetailsEvent event,
    Emitter<MedicalDetailsState> emit,
  ) async {
    emit(state.copyWith(detailsStatus: MedicalDetailsStatus.loading));

    try {
      final data = await repository.getAppointmentDetails(
        appointmentId: event.appointmentId,
      );
      emit(
        state.copyWith(
          detailsStatus: MedicalDetailsStatus.success,
          medicalDetailsData: data,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          detailsStatus: MedicalDetailsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onFetchMedicalRecordsDetails(
    FetchMedicalRecordsDetailsEvent event,
    Emitter<MedicalDetailsState> emit,
  ) async {
    emit(state.copyWith(recordsStatus: MedicalRecordsStatus.loading));

    try {
      final data = await repository.getMedicalRecordsDetails(
        medicalRecordId: event.medicalRecordId,
      );
      emit(
        state.copyWith(
          recordsStatus: MedicalRecordsStatus.success,
          medicalRecordsData: data,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          recordsStatus: MedicalRecordsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
