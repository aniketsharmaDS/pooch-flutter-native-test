import 'package:dart_mappable/dart_mappable.dart';

part 'create_event_payload_model.mapper.dart';

@MappableClass(ignoreNull: true)
class CreateEventPayloadModel with CreateEventPayloadModelMappable {
  final String? eventId;
  final String title;
  final String? description;

  @MappableField(key: 'category')
  final String? categoryId;

  @MappableField(key: 'event_start_date')
  final String? eventStartDate;

  @MappableField(key: 'event_end_date')
  final String? eventEndDate;

  @MappableField(key: 'event_time')
  final String? eventTime;

  final String? location;

  @MappableField(key: 'address_details')
  final String? addressDetails;

  final double? latitude;
  final double? longitude;

  @MappableField(key: 'is_paid')
  final bool? isPaid;

  @MappableField(key: 'is_draft')
  final bool isDraft;

  final List<dynamic>? images;

  const CreateEventPayloadModel({
    this.eventId,
    required this.title,
    this.description,
    this.categoryId,
    this.eventStartDate,
    this.eventEndDate,
    this.eventTime,
    this.location,
    this.addressDetails,
    this.latitude,
    this.longitude,
    this.isPaid,
    required this.isDraft,
    this.images,
  });
}
