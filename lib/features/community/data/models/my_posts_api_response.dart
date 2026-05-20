import 'package:poochcare/features/community/data/models/my_submitted_posts_model.dart';
import 'package:poochcare/features/community/data/models/paginated_info.dart';

class MyPostsApiResponse {
  MyPostsApiResponse({required this.posts, required this.pagination});

  final List<MySubmittedPostsModel> posts;
  final PaginationInfo pagination;
}
