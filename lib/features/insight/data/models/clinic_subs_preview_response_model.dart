import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_annotations.dart';

part 'clinic_subs_preview_response_model.mapper.dart';

@MappableClass()
class ClinicSubsPreviewResponseModel
    with ClinicSubsPreviewResponseModelMappable {
  @SafeBool()
  final bool success;

  @SafeString()
  final String message;

  @SafeInt()
  final int status;

  final ClinicSubsData data;

  final ClinicSubsMeta meta;

  const ClinicSubsPreviewResponseModel({
    this.success = false,
    this.message = '',
    this.status = 0,
    this.data = const ClinicSubsData(),
    this.meta = const ClinicSubsMeta(),
  });
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class ClinicSubsData with ClinicSubsDataMappable {
  final PreviewClinicModel clinic;

  final dynamic vet;

  final ConsultationDetailsModel consultationDetails;

  final PricingModel pricing;

  final dynamic coupon;

  @MappableField(hook: SafeListHook())
  final List<PreviewAddonModel> addons;

  @SafeBool()
  final bool hasActiveSubscription;

  final dynamic activeSubscriptionInfo;

  const ClinicSubsData({
    this.clinic = const PreviewClinicModel(),
    this.vet,
    this.consultationDetails = const ConsultationDetailsModel(),
    this.pricing = const PricingModel(),
    this.addons = const [],
    this.coupon,
    this.hasActiveSubscription = false,
    this.activeSubscriptionInfo,
  });
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class PreviewClinicModel with PreviewClinicModelMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String name;

  const PreviewClinicModel({this.id = '', this.name = ''});
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class ConsultationDetailsModel with ConsultationDetailsModelMappable {
  @SafeString()
  final String type;

  @SafeInt()
  final int durationMinutes;

  const ConsultationDetailsModel({this.type = '', this.durationMinutes = 0});
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class PricingModel with PricingModelMappable {
  @SafeDouble()
  final double consultingFee;

  @SafeDouble()
  final double serviceFee;

  @SafeDouble()
  final double subscriptionAmount;

  @SafeDouble()
  final double taxAmount;

  @SafeString()
  final String taxRate;

  @SafeDouble()
  final double subtotal;

  @SafeDouble()
  final double totalAmount;

  @SafeString()
  final String currency;

  const PricingModel({
    this.consultingFee = 0,
    this.serviceFee = 0,
    this.subscriptionAmount = 0,
    this.taxAmount = 0,
    this.taxRate = '',
    this.subtotal = 0,
    this.totalAmount = 0,
    this.currency = '',
  });
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class PreviewAddonModel with PreviewAddonModelMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String planName;

  @SafeString()
  final String planType;

  @SafeInt()
  final int callCredits;

  @SafeDouble()
  final double price;

  @SafeDouble()
  final double originalPrice;

  @SafeString()
  final String currency;

  @SafeInt()
  final int durationDays;

  @SafeBool()
  final bool isCurrentPlan;

  const PreviewAddonModel({
    this.id = '',
    this.planName = '',
    this.planType = '',
    this.callCredits = 0,
    this.price = 0,
    this.originalPrice = 0,
    this.currency = '',
    this.durationDays = 0,
    this.isCurrentPlan = false,
  });
}

@MappableClass()
class ClinicSubsMeta with ClinicSubsMetaMappable {
  @SafeString()
  final String lang;

  @SafeString()
  final String timestamp;

  const ClinicSubsMeta({this.lang = '', this.timestamp = ''});
}
