abstract class SettingsEvent {}

class LoadSavedLanguage extends SettingsEvent {}

class ChangeLanguage extends SettingsEvent {
  final String languageCode;

  ChangeLanguage(this.languageCode);
}

class SyncLanguageLocally extends SettingsEvent {
  final String languageCode;

  SyncLanguageLocally(this.languageCode);
}
