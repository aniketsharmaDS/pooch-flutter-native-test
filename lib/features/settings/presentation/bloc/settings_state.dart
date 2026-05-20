class SettingsState {
  final bool isLoadingLanguage;

  final bool isUpdatingLanguage;

  final String currentLanguage;

  final String? error;

  const SettingsState({
    this.isLoadingLanguage = false,
    this.isUpdatingLanguage = false,
    this.currentLanguage = 'en',
    this.error,
  });

  factory SettingsState.initial() {
    return const SettingsState();
  }

  SettingsState copyWith({
    bool? isLoadingLanguage,
    bool? isUpdatingLanguage,
    String? currentLanguage,
    String? error,
  }) {
    return SettingsState(
      isLoadingLanguage: isLoadingLanguage ?? this.isLoadingLanguage,

      isUpdatingLanguage: isUpdatingLanguage ?? this.isUpdatingLanguage,

      currentLanguage: currentLanguage ?? this.currentLanguage,

      error: error,
    );
  }
}
