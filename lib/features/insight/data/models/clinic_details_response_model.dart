import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/insight/data/models/clinic_operating_hours_model.dart';

class ClinicDetailsApiModel {
  const ClinicDetailsApiModel({
    required this.id,
    required this.clinicName,
    required this.description,
    required this.address,
    required this.years,
    required this.city,
    required this.emirate,
    required this.phone,
    required this.email,
    required this.website,
    required this.clinicImage,
    required this.tileImages,
    required this.latitude,
    required this.longitude,
    required this.operatingHours,
    required this.servicesOffered,
    required this.timezone,
  });

  final String id;
  final String clinicName;
  final String description;
  final String address;
  final int years;
  final String city;
  final String emirate;
  final String phone;
  final String email;
  final String website;
  final String clinicImage;
  final List<String> tileImages;
  final String latitude;
  final String longitude;
  final ClinicOperatingHoursModel operatingHours;
  final List<String> servicesOffered;
  final String timezone;

  factory ClinicDetailsApiModel.fromMap(Map<String, dynamic> map) {
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

    return ClinicDetailsApiModel(
      id: ParserUtils.readString(map['id']),
      clinicName: ParserUtils.readString(map['clinic_name']),
      description: ParserUtils.readString(map['description']),
      address: ParserUtils.readString(map['address']),
      years: ParserUtils.readInt(map['years']),
      city: ParserUtils.readString(map['city']),
      emirate: ParserUtils.readString(map['emirate']),
      phone: ParserUtils.readString(map['phone']),
      email: ParserUtils.readString(map['email']),
      website: ParserUtils.readString(map['website']),
      clinicImage: ParserUtils.readString(map['clinic_image']),
      tileImages: tileImages,
      latitude: ParserUtils.readString(map['latitude']),
      longitude: ParserUtils.readString(map['longitude']),
      operatingHours: ClinicOperatingHoursModel.fromMap(
        ParserUtils.readMap(map['operating_hours']),
      ),
      servicesOffered: ParserUtils.readStringList(map['services_offered']),
      timezone: ParserUtils.readString(map['timezone']),
    );
  }
}

class SubscriptionPlanApiModel {
  const SubscriptionPlanApiModel({
    required this.id,
    required this.planName,
    required this.planType,
    required this.callCredits,
    required this.price,
    required this.currency,
    required this.durationDays,
    required this.description,
    required this.features,
  });

  final String id;
  final String planName;
  final String planType;
  final int callCredits;
  final String price;
  final String currency;
  final int durationDays;
  final String description;

  /// Flexible shape (booleans, ints, strings like "10%")
  final Map<String, dynamic> features;

  factory SubscriptionPlanApiModel.fromMap(Map<String, dynamic> map) {
    return SubscriptionPlanApiModel(
      id: ParserUtils.readString(map['id']),
      planName: ParserUtils.readString(map['plan_name']),
      planType: ParserUtils.readString(map['plan_type']),
      callCredits: ParserUtils.readInt(map['call_credits']),
      price: ParserUtils.readString(map['price']),
      currency: ParserUtils.readString(map['currency']),
      durationDays: ParserUtils.readInt(map['duration_days']),
      description: ParserUtils.readString(map['description']),
      features: ParserUtils.readMap(map['features']),
    );
  }
}

class VetApiModel {
  const VetApiModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.specialization,
    required this.experienceYears,
    required this.bio,
    required this.profilePicture,
    required this.consultationFee,
    required this.languagesSpoken,
  });

  final String id;
  final String name;
  final String email;
  final String phone;
  final List<String> specialization;
  final int experienceYears;
  final String bio;
  final String profilePicture;
  final String? consultationFee;
  final List<String> languagesSpoken;

  factory VetApiModel.fromMap(Map<String, dynamic> map) {
    return VetApiModel(
      id: ParserUtils.readString(map['id']),
      name: ParserUtils.readString(map['name']),
      email: ParserUtils.readString(map['email']),
      phone: ParserUtils.readString(map['phone']),
      specialization: ParserUtils.readStringList(map['specialization']),
      experienceYears: ParserUtils.readInt(map['experience_years']),
      bio: ParserUtils.readString(map['bio']),
      profilePicture: ParserUtils.readString(map['profile_picture']),
      consultationFee: ParserUtils.readNullableString(map['consultation_fee']),
      languagesSpoken: ParserUtils.readStringList(map['languages_spoken']),
    );
  }
}

class ClinicDetailsResponseModel {
  const ClinicDetailsResponseModel({
    required this.clinic,
    required this.subscriptionPlans,
    required this.availableVets,
    required this.totalVets,
    required this.clinicLanguage,
  });

  final ClinicDetailsApiModel clinic;
  final List<SubscriptionPlanApiModel> subscriptionPlans;
  final List<VetApiModel> availableVets;
  final int totalVets;
  final List<String> clinicLanguage;

  factory ClinicDetailsResponseModel.fromMap(Map<String, dynamic> map) {
    return ClinicDetailsResponseModel(
      clinicLanguage: List<String>.from(map['clinic_languages'] as List? ?? []),
      clinic: ClinicDetailsApiModel.fromMap(ParserUtils.readMap(map['clinic'])),
      subscriptionPlans:
          (map['subscription_plans'] as List? ?? const <dynamic>[])
              .whereType<Map>()
              .map(
                (e) => SubscriptionPlanApiModel.fromMap(ParserUtils.readMap(e)),
              )
              .toList(growable: false),
      availableVets: (map['available_vets'] as List? ?? const <dynamic>[])
          .whereType<Map>()
          .map((e) => VetApiModel.fromMap(ParserUtils.readMap(e)))
          .toList(growable: false),
      totalVets: ParserUtils.readInt(map['total_vets']),
    );
  }
}
