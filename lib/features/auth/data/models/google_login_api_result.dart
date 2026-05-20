import 'package:poochcare/features/auth/data/models/google_login_response.dart';

class GoogleLoginApiResult {
  const GoogleLoginApiResult({required this.data, required this.message});

  final GoogleLoginResponse data;
  final String message;
}
