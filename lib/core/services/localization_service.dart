import 'package:flutter/material.dart';
import 'package:poochcare/core/services/secure_storage_service.dart';

class LocalizationService {
  LocalizationService(this._storageService);

  final SecureStorageService _storageService;

  static const String defaultLanguage = 'en';

  static const List<String> supportedLanguages = ['en', 'ar'];

  Future<String> getCurrentLanguage() async {
    final language = await _storageService.readLanguage();

    return validateLanguage(language ?? defaultLanguage);
  }

  Future<void> setLanguage(String languageCode) async {
    final validatedLanguage = validateLanguage(languageCode);

    await _storageService.writeLanguage(validatedLanguage);
  }

  String validateLanguage(String code) {
    final normalizedCode = code.toLowerCase().trim();

    return supportedLanguages.contains(normalizedCode)
        ? normalizedCode
        : defaultLanguage;
  }

  bool isRTL(String languageCode) {
    return languageCode == 'ar';
  }

  TextDirection getTextDirection(String languageCode) {
    return isRTL(languageCode) ? TextDirection.rtl : TextDirection.ltr;
  }

  Future<Locale> getCurrentLocale() async {
    final language = await getCurrentLanguage();

    return Locale(language);
  }
}
