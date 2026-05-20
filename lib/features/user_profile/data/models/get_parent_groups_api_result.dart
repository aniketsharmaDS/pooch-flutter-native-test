import 'package:poochcare/features/user_profile/data/models/get_parent_groups_response.dart';

class GetParentGroupsApiResult {
  const GetParentGroupsApiResult({required this.data, required this.message});

  final GetParentGroupsResponse data;
  final String message;
}
