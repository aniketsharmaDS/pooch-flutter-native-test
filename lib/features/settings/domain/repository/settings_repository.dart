abstract class SettingsRepository {
  const SettingsRepository();

  Future<void> updateLanguagePreference({required String languageCode});
}
