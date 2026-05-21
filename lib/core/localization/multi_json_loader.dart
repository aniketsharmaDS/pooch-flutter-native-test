import 'dart:convert';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class MultiJsonLoader extends AssetLoader {
  const MultiJsonLoader();

  static const List<String> modules = [
    'common',
    'drawer',
    'settings',
    'community',
    'cart',
    'expense',
  ];

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    final Map<String, dynamic> translations = {};

    for (final module in modules) {
      try {
        final jsonString = await rootBundle.loadString(
          '$path/${locale.languageCode}/$module.json',
        );

        final Map<String, dynamic> jsonMap =
            json.decode(jsonString) as Map<String, dynamic>;

        _deepMerge(translations, jsonMap);
      } catch (e) {
        debugPrint('Localization load error: $e');
      }
    }

    return translations;
  }

  void _deepMerge(Map<String, dynamic> original, Map<String, dynamic> newMap) {
    for (final key in newMap.keys) {
      if (original[key] is Map && newMap[key] is Map) {
        _deepMerge(
          original[key] as Map<String, dynamic>,
          newMap[key] as Map<String, dynamic>,
        );
      } else {
        original[key] = newMap[key];
      }
    }
  }
}
