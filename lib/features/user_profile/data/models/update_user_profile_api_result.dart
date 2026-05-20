import 'package:poochcare/features/user_profile/data/models/user_profile_response.dart';

class UpdateUserProfileApiResult {
  const UpdateUserProfileApiResult({required this.data, required this.message});

  final UserProfileResponse data;
  final String message;
}
