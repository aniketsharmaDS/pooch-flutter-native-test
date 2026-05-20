class UpdateLanguagePreferenceRequestModel {
  const UpdateLanguagePreferenceRequestModel({
    required this.languagePreference,
  });

  final String languagePreference;

  Map<String, dynamic> toMap() {
    return {'languagePreference': languagePreference};
  }
}
