import 'package:poochcare/features/auth/data/models/register_response.dart';

class RegisterApiResult {
  const RegisterApiResult({required this.data, required this.message});

  final RegisterResponse data;
  final String message;
}
