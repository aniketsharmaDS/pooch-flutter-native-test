import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/insight/data/models/clinic_operating_hours_model.dart';

class SubscribedClinicSummaryApiModel {
  const SubscribedClinicSummaryApiModel({
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
    required this.operatingHours,
    required this.servicesOffered,
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
  final ClinicOperatingHoursModel operatingHours;
  final List<String> servicesOffered;

  factory SubscribedClinicSummaryApiModel.fromMap(Map<String, dynamic> map) {
    return SubscribedClinicSummaryApiModel(
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
      operatingHours: ClinicOperatingHoursModel.fromMap(
        ParserUtils.readMap(map['operating_hours']),
      ),
      servicesOffered: ParserUtils.readStringList(map['services_offered']),
    );
  }
}

class SubscribedPlanSummaryApiModel {
  const SubscribedPlanSummaryApiModel({
    required this.id,
    required this.planName,
    required this.planType,
    required this.features,
  });

  final String id;
  final String planName;
  final String planType;
  final Map<String, dynamic> features;

  factory SubscribedPlanSummaryApiModel.fromMap(Map<String, dynamic> map) {
    return SubscribedPlanSummaryApiModel(
      id: ParserUtils.readString(map['id']),
      planName: ParserUtils.readString(map['plan_name']),
      planType: ParserUtils.readString(map['plan_type']),
      features: ParserUtils.readMap(map['features']),
    );
  }
}

class ClinicSubscriptionApiModel {
  const ClinicSubscriptionApiModel({
    required this.id,
    required this.planName,
    required this.petId,
    required this.planType,
    required this.totalCallCredits,
    required this.remainingCallCredits,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.clinic,
    required this.plan,
  });

  final String id;
  final String planName;
  final String petId;
  final String planType;
  final int totalCallCredits;
  final int remainingCallCredits;
  final String startDate;
  final String? endDate;
  final String status;
  final SubscribedClinicSummaryApiModel clinic;
  final SubscribedPlanSummaryApiModel plan;

  factory ClinicSubscriptionApiModel.fromMap(Map<String, dynamic> map) {
    return ClinicSubscriptionApiModel(
      id: ParserUtils.readString(map['id']),
      planName: ParserUtils.readString(map['plan_name']),
      petId: ParserUtils.readString(map['pet_id']),
      planType: ParserUtils.readString(map['plan_type']),
      totalCallCredits: ParserUtils.readInt(map['total_call_credits']),
      remainingCallCredits: ParserUtils.readInt(map['remaining_call_credits']),
      startDate: ParserUtils.readString(map['start_date']),
      endDate: ParserUtils.readNullableString(map['end_date']),
      status: ParserUtils.readString(map['status']),
      clinic: SubscribedClinicSummaryApiModel.fromMap(
        ParserUtils.readMap(map['clinic']),
      ),
      plan: SubscribedPlanSummaryApiModel.fromMap(
        ParserUtils.readMap(map['plan']),
      ),
    );
  }
}

class SubscribedClinicsPaginationModel {
  const SubscribedClinicsPaginationModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.pages,
  });

  final int page;
  final int limit;
  final int total;
  final int pages;

  factory SubscribedClinicsPaginationModel.fromMap(Map<String, dynamic> map) {
    return SubscribedClinicsPaginationModel(
      page: ParserUtils.readInt(map['page']),
      limit: ParserUtils.readInt(map['limit']),
      total: ParserUtils.readInt(map['total']),
      pages: ParserUtils.readInt(map['pages']),
    );
  }
}

class SubscribedClinicsResponseModel {
  const SubscribedClinicsResponseModel({
    required this.subscriptions,
    required this.totalSubscriptions,
    required this.pagination,
  });

  final List<ClinicSubscriptionApiModel> subscriptions;
  final int totalSubscriptions;
  final SubscribedClinicsPaginationModel pagination;

  factory SubscribedClinicsResponseModel.fromMap(Map<String, dynamic> map) {
    return SubscribedClinicsResponseModel(
      subscriptions: (map['subscriptions'] as List? ?? const <dynamic>[])
          .whereType<Map>()
          .map(
            (e) => ClinicSubscriptionApiModel.fromMap(ParserUtils.readMap(e)),
          )
          .toList(growable: false),
      totalSubscriptions: ParserUtils.readInt(map['total_subscriptions']),
      pagination: SubscribedClinicsPaginationModel.fromMap(
        ParserUtils.readMap(map['pagination']),
      ),
    );
  }

  SubscribedClinicsResponseModel copyWith({
    List<ClinicSubscriptionApiModel>? subscriptions,
    int? totalSubscriptions,
    SubscribedClinicsPaginationModel? pagination,
  }) {
    return SubscribedClinicsResponseModel(
      subscriptions: subscriptions ?? this.subscriptions,
      totalSubscriptions: totalSubscriptions ?? this.totalSubscriptions,
      pagination: pagination ?? this.pagination,
    );
  }
}
