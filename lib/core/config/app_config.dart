import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Application configuration loaded from .env file
///
/// This class manages all environment variables and provides
/// centralized access to configuration throughout the app.
class AppConfig {
  static late final String apiBaseUrl;
  static late final int apiTimeoutSeconds;
  static late final bool enableLogging;
  static late final String? apiKey;
  static late final String? googlePlacesApiKey;
  static late final bool debugMode;
  static late final String? serverClientId;

  /// Initialize configuration from .env file
  ///
  /// Call this in main() before setupDI()
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await AppConfig.init();
  ///   setupDI();
  ///   runApp(const PoochCareApp());
  /// }
  /// ```
  static Future<void> init() async {
    try {
      // Load .env file from project root
      await dotenv.load();

      // Read and assign configuration values with defaults
      apiBaseUrl = dotenv.env['API_BASE_URL'] ?? 'https://dev-api.pooch.app';
      googlePlacesApiKey = dotenv.env['GOOGLE_PLACES_API_KEY'] ?? '';
      apiTimeoutSeconds =
          int.tryParse(dotenv.env['API_TIMEOUT_SECONDS'] ?? '20') ?? 20;
      enableLogging = dotenv.env['ENABLE_LOGGING']?.toLowerCase() == 'true';
      debugMode = dotenv.env['DEBUG_MODE']?.toLowerCase() == 'true';
      apiKey = dotenv.env['API_KEY'];
      serverClientId =
          dotenv.env['SERVER_CLIENT_ID'] ??
          '811126899873-3talsukdajq84tsv18shac7j14rjo20r.apps.googleusercontent.com';
      if (kDebugMode) {
        _printConfig();
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error loading .env file: $e');
        debugPrint('Using default configuration values');
      }
      // Use defaults if .env fails to load
      apiBaseUrl = 'https://dev-api.pooch.app';
      apiTimeoutSeconds = 20;
      enableLogging = true;
      debugMode = true;
      apiKey = null;
    }
  }

  /// Get a configuration variable by key
  ///
  /// Returns null if the key doesn't exist
  static String? getEnv(String key) => dotenv.env[key];

  /// Print all loaded configuration (debug mode only)
  static void _printConfig() {
    debugPrint('╔════════════════════════════════════════════════╗');
    debugPrint('║         APPLICATION CONFIGURATION             ║');
    debugPrint('╠════════════════════════════════════════════════╣');
    debugPrint('║ API Base URL: $apiBaseUrl');
    debugPrint('║ Google Places API Key: $googlePlacesApiKey');
    debugPrint('║ API Timeout: ${apiTimeoutSeconds}s');
    debugPrint('║ Enable Logging: $enableLogging');
    debugPrint('║ Debug Mode: $debugMode');
    debugPrint('║ API Key: ${apiKey != null ? '***' : 'Not set'}');
    debugPrint('╚════════════════════════════════════════════════╝');
  }

  /// Check if app is in debug mode
  static bool isDebugMode() => debugMode || kDebugMode;

  /// Check if logging is enabled
  static bool isLoggingEnabled() => enableLogging;
}
