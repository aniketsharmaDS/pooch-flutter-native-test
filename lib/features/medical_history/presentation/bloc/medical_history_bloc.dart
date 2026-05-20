import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_event.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_state.dart';
import 'package:poochcare/features/medical_history/repository/medical_history_repository.dart';

class MedicalHistoryBloc
    extends Bloc<MedicalHistoryEvent, MedicalHistoryState> {
  MedicalHistoryBloc(this.repository) : super(const MedicalHistoryState()) {
    on<FetchMedicalHistoryRecords>(_onFetchMedicalHistoryRecords);
  }

  final MedicalHistoryRepository repository;

  Future<void> _onFetchMedicalHistoryRecords(
    FetchMedicalHistoryRecords event,
    Emitter<MedicalHistoryState> emit,
  ) async {
    emit(state.copyWith(status: MedicalHistoryStatus.loading));

    try {
      final response = await repository.getMedicalHistoryRecords(
        petId: event.petId,
        recordType: event.recordType,
        startDate: event.startDate,
        endDate: event.endDate,
        page: event.page,
        limit: event.limit,
      );
      emit(
        state.copyWith(
          status: MedicalHistoryStatus.success,
          records: response.records,
          hasMore: response.hasMore,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: MedicalHistoryStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
