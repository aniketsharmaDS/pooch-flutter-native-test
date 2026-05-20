import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/insight/data/models/clinic_operating_hours_model.dart';

class ClinicApiModel {
  const ClinicApiModel({
    required this.id,
    required this.clinicName,
    required this.description,
    required this.address,
    required this.city,
    required this.emirate,
    required this.country,
    required this.phone,
    required this.email,
    required this.clinicImage,
    required this.tileImages,
    required this.latitude,
    required this.longitude,
    required this.operatingHours,
    required this.servicesOffered,
    required this.years,
    required this.distance,
    required this.vetCount,
    required this.minConsultationFee,
    required this.nextAvailableSlot,
  });

  final String id;
  final String clinicName;
  final String description;
  final String address;
  final String city;
  final String emirate;
  final String country;
  final String phone;
  final String email;
  final String clinicImage;

  /// Some APIs return a single string, some a list, sometimes null.
  final List<String> tileImages;

  final String latitude;
  final String longitude;

  final ClinicOperatingHoursModel operatingHours;

  final List<String> servicesOffered;

  /// Years of service.
  final int years;

  final double distance;
  final int vetCount;
  final String minConsultationFee;

  /// Not yet used in UI; keep it flexible.
  final dynamic nextAvailableSlot;

  factory ClinicApiModel.fromMap(Map<String, dynamic> map) {
    final dynamic tileImageRaw = map['tileImage'];
    final List<String> tileImages = tileImageRaw is List
        ? tileImageRaw
              .map((e) => ParserUtils.readString(e))
              .where((e) => e.isNotEmpty)
              .toList(growable: false)
        : (tileImageRaw == null
              ? const <String>[]
              : <String>[
                  ParserUtils.readString(tileImageRaw),
                ].where((e) => e.isNotEmpty).toList(growable: false));

    return ClinicApiModel(
      id: ParserUtils.readString(map['id']),
      clinicName: ParserUtils.readString(map['clinic_name']),
      description: ParserUtils.readString(map['description']),
      address: ParserUtils.readString(map['address']),
      city: ParserUtils.readString(map['city']),
      emirate: ParserUtils.readString(map['emirate']),
      country: ParserUtils.readString(map['country']),
      phone: ParserUtils.readString(map['phone']),
      email: ParserUtils.readString(map['email']),
      clinicImage: ParserUtils.readString(map['clinic_image']),
      tileImages: tileImages,
      latitude: ParserUtils.readString(map['latitude']),
      longitude: ParserUtils.readString(map['longitude']),
      operatingHours: ClinicOperatingHoursModel.fromMap(
        ParserUtils.readMap(map['operating_hours']),
      ),
      servicesOffered: ParserUtils.readStringList(map['services_offered']),
      years: ParserUtils.readInt(map['years']),
      distance: ParserUtils.readDouble(map['distance']),
      vetCount: ParserUtils.readInt(map['vet_count']),
      minConsultationFee: ParserUtils.readString(map['min_consultation_fee']),
      nextAvailableSlot: map['next_available_slot'],
    );
  }
}
