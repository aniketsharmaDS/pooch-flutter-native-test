import 'package:poochcare/features/community/data/models/paginated_info.dart';
import 'package:poochcare/features/community/data/models/tips_info_item_model.dart';

class TipsApiResponse {
  TipsApiResponse({required this.tips, required this.pagination});

  final List<TipsInfoItemModel> tips;
  final PaginationInfo pagination;
}
