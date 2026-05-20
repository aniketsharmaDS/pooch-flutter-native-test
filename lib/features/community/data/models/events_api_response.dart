import 'package:poochcare/features/community/data/models/event_info_item_model.dart';
import 'package:poochcare/features/community/data/models/paginated_info.dart';

class EventsApiResponse {
  EventsApiResponse({required this.events, required this.pagination});

  final List<EventInfoItemModel> events;
  final PaginationInfo pagination;
}
