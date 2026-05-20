class Env {
  static const String baseUrl = String.fromEnvironment('BASE_URL');
  static const String googlePlacesApi = String.fromEnvironment(
    'GOOGLE_PLACES_API_KEY',
  );
  static const String firebaseEnv = String.fromEnvironment('FIREBASE_ENV');
  static const String enableLogs = String.fromEnvironment('ENABLE_LOGS');
  static const String geocodingApi = String.fromEnvironment(
    'GEOCODING_API_KEY',
  );
  static const String s3PublicBaseUrl = String.fromEnvironment(
    'S3_PUBLIC_BASE_URL',
  );
}
