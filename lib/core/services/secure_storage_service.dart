import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum ChatReturnType {
  allMissingPetsTab,
  allMissingPetList,
  allMissingPetUserTab,
  allMissingPetUserList,
}

class SecureStorageKeys {
  // 💬 Chat
  static const chatReturn = 'chat_return';

  static const appLanguage = 'app_language';
}

class SecureStorageService {
  SecureStorageService({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  /// Write String
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Read String
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// Delete key
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// Delete all
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  /// Write String
  Future<void> writeChatJourney(String value) async {
    await _storage.write(key: SecureStorageKeys.chatReturn, value: value);
  }

  /// Read String
  Future<String?> readChatJourney() async {
    return await _storage.read(key: SecureStorageKeys.chatReturn);
  }

  // -------------------------------
  // 🔥 JSON support (very important)
  // -------------------------------

  Future<void> writeJson(String key, Map<String, dynamic> value) async {
    final jsonString = jsonEncode(value);
    await _storage.write(key: key, value: jsonString);
  }

  Future<Map<String, dynamic>?> readJson(String key) async {
    final value = await _storage.read(key: key);
    if (value == null) return null;

    final decoded = jsonDecode(value);

    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    return null; // or throw error if you want strict behavior
  }

  // -------------------------------
  // 🔥 Bool support
  // -------------------------------

  Future<void> writeBool(String key, bool value) async {
    await _storage.write(key: key, value: value.toString());
  }

  Future<bool?> readBool(String key) async {
    final value = await _storage.read(key: key);
    if (value == null) return null;
    return value == 'true';
  }

  // -------------------------------
  // 🔥 Int support
  // -------------------------------

  Future<void> writeInt(String key, int value) async {
    await _storage.write(key: key, value: value.toString());
  }

  Future<int?> readInt(String key) async {
    final value = await _storage.read(key: key);
    if (value == null) return null;
    return int.tryParse(value);
  }

  /// -------------------------------
  /// 🌍 Language
  /// -------------------------------

  Future<void> writeLanguage(String languageCode) async {
    await _storage.write(
      key: SecureStorageKeys.appLanguage,
      value: languageCode,
    );
  }

  Future<String?> readLanguage() async {
    return await _storage.read(key: SecureStorageKeys.appLanguage);
  }
}

//
/** Usage:
  final storage = getIt<SecureStorageService>();
  await storage.write('chat_return', 'community');
  await storage.writeBool('is_found_pet_flow', true);
  await storage.writeJson('user', {'id': 1, 'name': 'John'});

  final type = await storage.read('chat_return');
  final isFlow = await storage.readBool('is_found_pet_flow');
  final user = await storage.readJson('user');


  await storage.clearAll();

*/
