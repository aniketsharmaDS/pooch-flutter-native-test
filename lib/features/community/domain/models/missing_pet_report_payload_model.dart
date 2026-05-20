import 'package:dart_mappable/dart_mappable.dart';

part 'missing_pet_report_payload_model.mapper.dart';

@MappableClass(ignoreNull: true)
class MissingPetReportPayloadModel with MissingPetReportPayloadModelMappable {
  @MappableField(key: 'pet_id')
  final String petId;

  @MappableField(key: 'missing_date')
  final String? missingDate;

  @MappableField(key: 'missing_time')
  final String? missingTime;

  final String? color;

  @MappableField(key: 'last_known_location')
  final String? lastKnownLocation;

  @MappableField(key: 'latitude')
  final double? latitude;

  @MappableField(key: 'longitude')
  final double? longitude;

  final String? description;

  @MappableField(key: 'reward_amount')
  final int? rewardAmount;

  final List<dynamic>? images;

  const MissingPetReportPayloadModel({
    required this.petId,
    this.missingDate,
    this.missingTime,
    this.color,
    this.lastKnownLocation,
    this.latitude,
    this.longitude,
    this.description,
    this.rewardAmount,
    this.images,
  });
}
