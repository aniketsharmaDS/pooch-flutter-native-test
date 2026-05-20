import 'package:poochcare/features/community/data/models/found_pet_model.dart';
import 'package:poochcare/features/community/data/models/paginated_info.dart';

class FoundPetApiResponse {
  FoundPetApiResponse({required this.foundPets, required this.pagination});

  final List<FoundPetModel> foundPets;
  final PaginationInfo pagination;
}
