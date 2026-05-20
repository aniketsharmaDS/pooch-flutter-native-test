import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/features/medical_history/domain/models/diagnosis_type.dart';
import 'package:poochcare/features/medical_history/domain/models/lab_report_type.dart';
import 'package:poochcare/features/medical_history/domain/models/vaccination_type.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_form_event.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_form_state.dart';
import 'package:poochcare/features/medical_history/repository/medical_history_repository.dart';

class MedicalHistoryFormBloc
    extends Bloc<MedicalHistoryFormEvent, MedicalHistoryFormState> {
  MedicalHistoryFormBloc(this._repository)
    : super(const MedicalHistoryFormState()) {
    on<LoadMedicalHistoryFormData>(_onLoadMedicalHistoryFormData);
    on<SaveMedicalHistoryRecordRequested>(_onSaveMedicalHistoryRecordRequested);
  }

  final MedicalHistoryRepository _repository;

  Future<void> _onLoadMedicalHistoryFormData(
    LoadMedicalHistoryFormData event,
    Emitter<MedicalHistoryFormState> emit,
  ) async {
    if (state.status == MedicalHistoryFormStatus.loading) {
      return;
    }

    emit(
      state.copyWith(
        status: MedicalHistoryFormStatus.loading,
        clearErrorMessage: true,
      ),
    );

    try {
      final List<Object> loadedData =
          await Future.wait<Object>(<Future<Object>>[
            _repository.getVaccinationTypes(),
            _repository.getDiagnosisTypes(),
            _repository.getLabReportTypes(),
          ]);

      final vaccinationTypes = loadedData[0] as List<VaccinationType>;
      final diagnosisTypes = loadedData[1] as List<DiagnosisType>;
      final labReportTypes = loadedData[2] as List<LabReportType>;

      emit(
        state.copyWith(
          status: MedicalHistoryFormStatus.success,
          vaccinationTypes: vaccinationTypes,
          diagnosisTypes: diagnosisTypes,
          labReportTypes: labReportTypes,
          clearErrorMessage: true,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          status: MedicalHistoryFormStatus.failure,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: MedicalHistoryFormStatus.failure,
          errorMessage: 'Unable to load medical history form data.',
        ),
      );
    }
  }

  Future<void> _onSaveMedicalHistoryRecordRequested(
    SaveMedicalHistoryRecordRequested event,
    Emitter<MedicalHistoryFormState> emit,
  ) async {
    if (state.saveStatus == MedicalHistorySaveStatus.loading) {
      return;
    }

    emit(
      state.copyWith(
        saveStatus: MedicalHistorySaveStatus.loading,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    try {
      final normalizedType = event.type.trim().toLowerCase();
      final endpoint = switch (normalizedType) {
        'previous_vaccinations' ||
        'previous vaccinations' => '/medical-history/vaccinations',
        'previous_diagnoses' ||
        'previous diagnoses' => '/medical-history/consultations',
        'clinic_visit' ||
        'clinic visit' ||
        'clinic_visit_record' => '/medical-history/consultations',
        'lab_reports' || 'lab reports' => '/medical-history/lab-reports',
        'current_medications' ||
        'current medications' => '/medical-history/medications',
        'health_record' ||
        'health records' ||
        'health_records' => '/medical-history/health-records',
        'other_documents' || 'other documents' => '/medical-history/documents',
        _ => '/medical-history',
      };

      await _repository.saveMedicalHistoryRecord(
        endpoint: endpoint,
        payload: event.payload,
      );

      emit(
        state.copyWith(
          saveStatus: MedicalHistorySaveStatus.success,
          successMessage: 'Medical record saved successfully.',
          clearErrorMessage: true,
        ),
      );
      emit(
        state.copyWith(
          saveStatus: MedicalHistorySaveStatus.initial,
          clearSuccessMessage: true,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          saveStatus: MedicalHistorySaveStatus.failure,
          errorMessage: error.message,
        ),
      );
      emit(state.copyWith(saveStatus: MedicalHistorySaveStatus.initial));
    } catch (_) {
      emit(
        state.copyWith(
          saveStatus: MedicalHistorySaveStatus.failure,
          errorMessage: 'Unable to save medical record.',
        ),
      );
      emit(state.copyWith(saveStatus: MedicalHistorySaveStatus.initial));
    }
  }
}
