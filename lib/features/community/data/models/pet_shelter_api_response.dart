import 'package:poochcare/features/community/data/models/paginated_info.dart';
import 'package:poochcare/features/community/data/models/pet_shelter_model.dart';

class PetShelterApiResponse {
  PetShelterApiResponse({required this.shelters, required this.pagination});

  final List<PetShelterModel> shelters;
  final PaginationInfo pagination;
}
