import 'package:poochcare/features/settings/data/api/settings_api_service.dart';
import 'package:poochcare/features/settings/data/models/update_language_preference_request_model.dart';
import 'package:poochcare/features/settings/domain/repository/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._apiService);

  final SettingsApiService _apiService;

  @override
  Future<void> updateLanguagePreference({required String languageCode}) async {
    await _apiService.updateLanguagePreference(
      request: UpdateLanguagePreferenceRequestModel(
        languagePreference: languageCode,
      ),
    );
  }
}
