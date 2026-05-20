import 'package:poochcare/features/community/data/models/missing_pet_model.dart';
import 'package:poochcare/features/community/data/models/paginated_info.dart';

class MissingPetApiResponse {
  MissingPetApiResponse({required this.missingPets, required this.pagination});

  final List<MissingPetModel> missingPets;
  final PaginationInfo pagination;
}
