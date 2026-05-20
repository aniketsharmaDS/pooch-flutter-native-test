import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_annotations.dart';

part 'clinic_subs_plans_response_model.mapper.dart';

@MappableClass()
class ClinicSubsPlansResponseModel with ClinicSubsPlansResponseModelMappable {
  @SafeBool()
  final bool success;

  @SafeString()
  final String message;

  @SafeInt()
  final int status;

  final ClinicSubscriptionData data;

  final SubscriptionMeta meta;

  const ClinicSubsPlansResponseModel({
    this.success = false,
    this.message = '',
    this.status = 0,
    this.data = const ClinicSubscriptionData(),
    this.meta = const SubscriptionMeta(),
  });
}

@MappableClass()
class ClinicSubscriptionData with ClinicSubscriptionDataMappable {
  @MappableField(hook: SafeListHook())
  final List<ClinicPlanModel> plans;

  @MappableField(hook: SafeListHook())
  final List<ActiveSubscriptionModel> activeSubscriptions;

  const ClinicSubscriptionData({
    this.plans = const [],
    this.activeSubscriptions = const [],
  });
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class ClinicPlanModel with ClinicPlanModelMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String clinicId;

  @SafeString()
  final String planName;

  @SafeString()
  final String planType;

  @SafeString()
  final String planDuration;

  @SafeInt()
  final int callCredits;

  @SafeString()
  final String price;

  @SafeString()
  final String currency;

  @SafeInt()
  final int durationDays;

  @SafeBool()
  final bool isActive;

  @SafeBool()
  final bool isDeleted;

  @SafeBool()
  final bool isDefault;

  @SafeString()
  final String description;

  final PlanFeaturesModel features;

  @SafeString()
  final String createdAt;

  @SafeString()
  final String updatedAt;

  @MappableField(key: 'isSubscribed')
  @SafeBool()
  final bool isSubscribed;

  @MappableField(key: 'isAlreadyBought')
  @SafeBool()
  final bool isAlreadyBought;

  final dynamic subscription;

  @SafeString()
  final String priceDisplay;

  @SafeString()
  final String durationDisplay;

  const ClinicPlanModel({
    this.id = '',
    this.clinicId = '',
    this.planName = '',
    this.planType = '',
    this.planDuration = '',
    this.callCredits = 0,
    this.price = '',
    this.currency = '',
    this.durationDays = 0,
    this.isActive = false,
    this.isDeleted = false,
    this.isDefault = false,
    this.description = '',
    this.features = const PlanFeaturesModel(),
    this.createdAt = '',
    this.updatedAt = '',
    this.isSubscribed = false,
    this.isAlreadyBought = false,
    this.subscription,
    this.priceDisplay = '',
    this.durationDisplay = '',
  });
}

class HomeVisitDiscountHook extends MappingHook {
  const HomeVisitDiscountHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value == null) return '';

    if (value is bool) {
      return value ? 'Available' : 'Not Available';
    }

    return value.toString();
  }
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class PlanFeaturesModel with PlanFeaturesModelMappable {
  @SafeInt()
  final int videoCalls;

  @SafeBool()
  final bool medicalRecords;

  @SafeBool()
  final bool prioritySupport;

  @SafeBool()
  final bool appointmentBooking;

  @SafeString()
  final String homeVisitDiscount;

  @SafeBool()
  final bool prescriptionAccess;

  @SafeBool()
  final bool consultationReminders;

  @SafeBool()
  final bool freeYearlyCheckup;

  const PlanFeaturesModel({
    this.videoCalls = 0,
    this.medicalRecords = false,
    this.prioritySupport = false,
    this.appointmentBooking = false,
    this.homeVisitDiscount = '',
    this.prescriptionAccess = false,
    this.consultationReminders = false,
    this.freeYearlyCheckup = false,
  });

  List<String> get displayFeatures {
    final List<String> items = [];

    if (videoCalls > 0) {
      items.add('$videoCalls Free calls');
    }

    if (homeVisitDiscount.isNotEmpty && homeVisitDiscount != '0%') {
      items.add('$homeVisitDiscount off for In-clinic visits');
    }

    if (prioritySupport) {
      items.add('Priority support');
    }

    if (medicalRecords) {
      items.add('Medical records access');
    }

    if (appointmentBooking) {
      items.add('Appointment booking');
    }

    if (prescriptionAccess) {
      items.add('Prescription access');
    }

    if (consultationReminders) {
      items.add('Consultation reminders');
    }

    if (freeYearlyCheckup) {
      items.add('Free yearly checkup');
    }

    return items;
  }

  String get featuresText {
    final List<String> items = [];

    if (videoCalls > 0) {
      items.add('$videoCalls Free calls');
    }

    if (homeVisitDiscount.isNotEmpty && homeVisitDiscount != '0%') {
      items.add('$homeVisitDiscount off for In-clinic visits');
    }

    if (prioritySupport) {
      items.add('Priority support');
    }

    if (medicalRecords) {
      items.add('Medical records access');
    }

    if (appointmentBooking) {
      items.add('Appointment booking');
    }

    if (prescriptionAccess) {
      items.add('Prescription access');
    }

    if (consultationReminders) {
      items.add('Consultation reminders');
    }

    if (freeYearlyCheckup) {
      items.add('Free yearly checkup');
    }

    return items.join(' • ');
  }
}

@MappableClass()
class SubscriptionMeta with SubscriptionMetaMappable {
  @SafeString()
  final String lang;

  @SafeString()
  final String timestamp;

  const SubscriptionMeta({this.lang = '', this.timestamp = ''});
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class ActiveSubscriptionModel with ActiveSubscriptionModelMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String userId;

  @SafeString()
  final String petId;

  @SafeString()
  final String clinicId;

  @SafeString()
  final String planId;

  @SafeString()
  final String orderId;

  @SafeString()
  final String planName;

  @SafeString()
  final String planType;

  @SafeString()
  final String planDuration;

  @SafeInt()
  final int totalCallCredits;

  @SafeInt()
  final int remainingCallCredits;

  @SafeString()
  final String pricePaid;

  @SafeString()
  final String currency;

  @SafeString()
  final String startDate;

  @SafeString()
  final String endDate;

  @SafeString()
  final String status;

  @SafeString()
  final String purchaseDate;

  @SafeString()
  final String createdAt;

  @SafeString()
  final String updatedAt;

  final SubscriptionPlanInfoModel plan;

  const ActiveSubscriptionModel({
    this.id = '',
    this.userId = '',
    this.petId = '',
    this.clinicId = '',
    this.planId = '',
    this.orderId = '',
    this.planName = '',
    this.planType = '',
    this.planDuration = '',
    this.totalCallCredits = 0,
    this.remainingCallCredits = 0,
    this.pricePaid = '',
    this.currency = '',
    this.startDate = '',
    this.endDate = '',
    this.status = '',
    this.purchaseDate = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.plan = const SubscriptionPlanInfoModel(),
  });

  bool get hasRemainingCredits => remainingCallCredits > 0;
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class SubscriptionPlanInfoModel with SubscriptionPlanInfoModelMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String planName;

  @SafeString()
  final String planType;

  final PlanFeaturesModel features;

  const SubscriptionPlanInfoModel({
    this.id = '',
    this.planName = '',
    this.planType = '',
    this.features = const PlanFeaturesModel(),
  });
}
