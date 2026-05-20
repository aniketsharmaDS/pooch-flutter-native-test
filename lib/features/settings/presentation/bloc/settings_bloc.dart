import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/services/localization_service.dart';
import 'package:poochcare/features/settings/domain/repository/settings_repository.dart';
import 'package:poochcare/features/settings/presentation/bloc/settings_event.dart';
import 'package:poochcare/features/settings/presentation/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required SettingsRepository repository,
    required LocalizationService localizationService,
  }) : _repository = repository,
       _localizationService = localizationService,
       super(SettingsState.initial()) {
    on<LoadSavedLanguage>(_onLoadSavedLanguage);

    on<ChangeLanguage>(_onChangeLanguage);

    on<SyncLanguageLocally>(_onSyncLanguageLocally);
  }

  final SettingsRepository _repository;

  final LocalizationService _localizationService;

  Future<void> _onLoadSavedLanguage(
    LoadSavedLanguage event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(isLoadingLanguage: true));

    try {
      final language = await _localizationService.getCurrentLanguage();

      emit(state.copyWith(currentLanguage: language, isLoadingLanguage: false));
    } catch (e) {
      emit(state.copyWith(isLoadingLanguage: false, error: e.toString()));
    }
  }

  Future<void> _onChangeLanguage(
    ChangeLanguage event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(isUpdatingLanguage: true));

    try {
      await _repository.updateLanguagePreference(
        languageCode: event.languageCode,
      );

      await _localizationService.setLanguage(event.languageCode);

      emit(
        state.copyWith(
          currentLanguage: event.languageCode,
          isUpdatingLanguage: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isUpdatingLanguage: false, error: e.toString()));
    }
  }

  Future<void> _onSyncLanguageLocally(
    SyncLanguageLocally event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      await _localizationService.setLanguage(event.languageCode);

      emit(state.copyWith(currentLanguage: event.languageCode));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
