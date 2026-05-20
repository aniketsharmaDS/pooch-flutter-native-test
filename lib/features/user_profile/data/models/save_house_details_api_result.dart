import 'package:poochcare/features/user_profile/data/models/save_house_details_response.dart';

class SaveHouseDetailsApiResult {
  const SaveHouseDetailsApiResult({required this.data, required this.message});

  final SaveHouseDetailsResponse data;
  final String message;
}
