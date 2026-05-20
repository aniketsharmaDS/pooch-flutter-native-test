import 'package:poochcare/features/community/data/models/paginated_info.dart';
import 'package:poochcare/features/community/data/models/tips_comment_info_model.dart';

class TipsCommentApiResponse {
  TipsCommentApiResponse({required this.comments, required this.pagination});

  final List<TipsCommentInfoModel> comments;
  final PaginationInfo pagination;
}

class TipsRepliesApiResponse {
  TipsRepliesApiResponse({required this.replies, required this.pagination});

  final List<TipsCommentInfoModel> replies;
  final PaginationInfo pagination;
}
