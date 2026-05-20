import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'coupon_model.mapper.dart';

@MappableClass()
class Coupon with CouponMappable {
  const Coupon({
    this.id,
    this.couponCode,
    this.title,
    this.description,
    this.usageLimit,
    this.usagePerUser,
    this.applicableProducts,
    this.validFrom,
    this.validTo,
    this.bannerImageUrl,
    this.promotionText,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.rules,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) =>
      CouponMapper.fromMap(json);

  @MappableField(hook: SafeStringHook())
  final String? id;

  @MappableField(hook: SafeStringHook())
  final String? couponCode;

  @MappableField(hook: SafeStringHook())
  final String? title;

  @MappableField(hook: SafeStringHook())
  final String? description;

  final int? usageLimit;

  @MappableField(hook: SafeIntHook())
  final int? usagePerUser;

  final String? applicableProducts;

  final DateTime? validFrom;

  final DateTime? validTo;

  final String? bannerImageUrl;

  final String? promotionText;

  @MappableField(hook: SafeStringHook())
  final String? status;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final List<CouponRule>? rules;

  bool get isValid {
    if (status == null || validFrom == null || validTo == null) {
      return false;
    }
    final now = DateTime.now();
    return status == 'active' &&
        now.isAfter(validFrom!) &&
        now.isBefore(validTo!);
  }

  bool get isExpired {
    if (validTo == null) {
      return false;
    }
    return DateTime.now().isAfter(validTo!);
  }

  String get validityDisplay {
    if (validTo == null) {
      return 'No expiration date';
    }
    final remainingDays = validTo!.difference(DateTime.now()).inDays;
    if (remainingDays <= 0) {
      return 'Expired';
    } else if (remainingDays == 1) {
      return 'Expires tomorrow';
    } else {
      return 'Expires in $remainingDays days';
    }
  }
}

@MappableClass()
class CouponRule with CouponRuleMappable {
  const CouponRule({
    required this.targetProductTypes,
    required this.targetPetTypes,
    required this.targetSubcategories,
    required this.targetProductIds,
    this.targetTags,
    this.excludeProductIds,
    required this.targetSubscriptionTypes,
    required this.targetSubscriptionDurations,
    required this.subscriptionBundleRequired,
    required this.eligibilityRules,
    this.minPurchaseAmount,
    this.minPurchaseCount,
    required this.requireActiveSubscription,
    required this.subscriptionUpgradeFrom,
    this.inactiveDays,
    this.minLifetimeValue,
    required this.whitelistedUserIds,
    required this.blacklistedUserIds,
    required this.eventTags,
    required this.campaignName,
    this.customMetadata,
    required this.requireAllConditions,
    required this.priority,
    required this.isActive,
  });

  factory CouponRule.fromJson(Map<String, dynamic> json) =>
      CouponRuleMapper.fromMap(json);

  final List<String> targetProductTypes;

  final List<String> targetPetTypes;

  final List<String> targetSubcategories;

  final List<String> targetProductIds;

  final String? targetTags;

  final String? excludeProductIds;

  final List<String> targetSubscriptionTypes;

  final List<String> targetSubscriptionDurations;

  @MappableField(hook: SafeBoolHook())
  final bool subscriptionBundleRequired;

  final List<String> eligibilityRules;

  final String? minPurchaseAmount;

  final String? minPurchaseCount;

  @MappableField(hook: SafeBoolHook())
  final bool requireActiveSubscription;

  final List<String> subscriptionUpgradeFrom;

  final String? inactiveDays;

  final String? minLifetimeValue;

  final List<String> whitelistedUserIds;

  final List<String> blacklistedUserIds;

  final List<String> eventTags;

  @MappableField(hook: SafeStringHook())
  final String campaignName;

  final String? customMetadata;

  @MappableField(hook: SafeBoolHook())
  final bool requireAllConditions;

  @MappableField(hook: SafeIntHook())
  final int priority;

  @MappableField(hook: SafeBoolHook())
  final bool isActive;
}

@MappableClass()
class CartCount with CartCountMappable {
  const CartCount({required this.count});

  factory CartCount.fromJson(Map<String, dynamic> json) =>
      CartCountMapper.fromMap(json);

  @MappableField(hook: SafeIntHook())
  final int count;
}
