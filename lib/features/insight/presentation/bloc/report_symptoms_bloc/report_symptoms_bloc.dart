import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/insight/presentation/bloc/report_symptoms_bloc/report_symptoms_event.dart';
import 'package:poochcare/features/insight/presentation/bloc/report_symptoms_bloc/report_symptoms_state.dart';
import 'package:poochcare/features/insight/repository/clinics_repository.dart';

class ReportSymptomsBloc
    extends Bloc<ReportSymptomsEvent, ReportSymptomsState> {
  final ClinicsRepository repository;

  ReportSymptomsBloc(this.repository) : super(const ReportSymptomsState()) {
    on<FetchSymptomsEvent>(_onFetchSymptoms);
  }

  Future<void> _onFetchSymptoms(
    FetchSymptomsEvent event,
    Emitter<ReportSymptomsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: SymptomsStatus.loading));

      final symptomResponse = await repository.getSymptoms();

      emit(
        state.copyWith(
          status: SymptomsStatus.success,
          symptomResponse: symptomResponse,
          actionId: state.actionId + 1,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SymptomsStatus.failure,
          errorMessage: e.toString(),
          actionId: state.actionId + 1,
        ),
      );
    }
  }
}
