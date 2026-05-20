// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'coupon_model.dart';

class CouponMapper extends ClassMapperBase<Coupon> {
  CouponMapper._();

  static CouponMapper? _instance;
  static CouponMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CouponMapper._());
      CouponRuleMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Coupon';

  static String? _$id(Coupon v) => v.id;
  static const Field<Coupon, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    hook: SafeStringHook(),
  );
  static String? _$couponCode(Coupon v) => v.couponCode;
  static const Field<Coupon, String> _f$couponCode = Field(
    'couponCode',
    _$couponCode,
    opt: true,
    hook: SafeStringHook(),
  );
  static String? _$title(Coupon v) => v.title;
  static const Field<Coupon, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
    hook: SafeStringHook(),
  );
  static String? _$description(Coupon v) => v.description;
  static const Field<Coupon, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    hook: SafeStringHook(),
  );
  static int? _$usageLimit(Coupon v) => v.usageLimit;
  static const Field<Coupon, int> _f$usageLimit = Field(
    'usageLimit',
    _$usageLimit,
    opt: true,
  );
  static int? _$usagePerUser(Coupon v) => v.usagePerUser;
  static const Field<Coupon, int> _f$usagePerUser = Field(
    'usagePerUser',
    _$usagePerUser,
    opt: true,
    hook: SafeIntHook(),
  );
  static String? _$applicableProducts(Coupon v) => v.applicableProducts;
  static const Field<Coupon, String> _f$applicableProducts = Field(
    'applicableProducts',
    _$applicableProducts,
    opt: true,
  );
  static DateTime? _$validFrom(Coupon v) => v.validFrom;
  static const Field<Coupon, DateTime> _f$validFrom = Field(
    'validFrom',
    _$validFrom,
    opt: true,
  );
  static DateTime? _$validTo(Coupon v) => v.validTo;
  static const Field<Coupon, DateTime> _f$validTo = Field(
    'validTo',
    _$validTo,
    opt: true,
  );
  static String? _$bannerImageUrl(Coupon v) => v.bannerImageUrl;
  static const Field<Coupon, String> _f$bannerImageUrl = Field(
    'bannerImageUrl',
    _$bannerImageUrl,
    opt: true,
  );
  static String? _$promotionText(Coupon v) => v.promotionText;
  static const Field<Coupon, String> _f$promotionText = Field(
    'promotionText',
    _$promotionText,
    opt: true,
  );
  static String? _$status(Coupon v) => v.status;
  static const Field<Coupon, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
    hook: SafeStringHook(),
  );
  static DateTime? _$createdAt(Coupon v) => v.createdAt;
  static const Field<Coupon, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );
  static DateTime? _$updatedAt(Coupon v) => v.updatedAt;
  static const Field<Coupon, DateTime> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
  );
  static List<CouponRule>? _$rules(Coupon v) => v.rules;
  static const Field<Coupon, List<CouponRule>> _f$rules = Field(
    'rules',
    _$rules,
    opt: true,
  );

  @override
  final MappableFields<Coupon> fields = const {
    #id: _f$id,
    #couponCode: _f$couponCode,
    #title: _f$title,
    #description: _f$description,
    #usageLimit: _f$usageLimit,
    #usagePerUser: _f$usagePerUser,
    #applicableProducts: _f$applicableProducts,
    #validFrom: _f$validFrom,
    #validTo: _f$validTo,
    #bannerImageUrl: _f$bannerImageUrl,
    #promotionText: _f$promotionText,
    #status: _f$status,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #rules: _f$rules,
  };

  static Coupon _instantiate(DecodingData data) {
    return Coupon(
      id: data.dec(_f$id),
      couponCode: data.dec(_f$couponCode),
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      usageLimit: data.dec(_f$usageLimit),
      usagePerUser: data.dec(_f$usagePerUser),
      applicableProducts: data.dec(_f$applicableProducts),
      validFrom: data.dec(_f$validFrom),
      validTo: data.dec(_f$validTo),
      bannerImageUrl: data.dec(_f$bannerImageUrl),
      promotionText: data.dec(_f$promotionText),
      status: data.dec(_f$status),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      rules: data.dec(_f$rules),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Coupon fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Coupon>(map);
  }

  static Coupon fromJson(String json) {
    return ensureInitialized().decodeJson<Coupon>(json);
  }
}

mixin CouponMappable {
  String toJson() {
    return CouponMapper.ensureInitialized().encodeJson<Coupon>(this as Coupon);
  }

  Map<String, dynamic> toMap() {
    return CouponMapper.ensureInitialized().encodeMap<Coupon>(this as Coupon);
  }

  CouponCopyWith<Coupon, Coupon, Coupon> get copyWith =>
      _CouponCopyWithImpl<Coupon, Coupon>(this as Coupon, $identity, $identity);
  @override
  String toString() {
    return CouponMapper.ensureInitialized().stringifyValue(this as Coupon);
  }

  @override
  bool operator ==(Object other) {
    return CouponMapper.ensureInitialized().equalsValue(this as Coupon, other);
  }

  @override
  int get hashCode {
    return CouponMapper.ensureInitialized().hashValue(this as Coupon);
  }
}

extension CouponValueCopy<$R, $Out> on ObjectCopyWith<$R, Coupon, $Out> {
  CouponCopyWith<$R, Coupon, $Out> get $asCoupon =>
      $base.as((v, t, t2) => _CouponCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CouponCopyWith<$R, $In extends Coupon, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, CouponRule, CouponRuleCopyWith<$R, CouponRule, CouponRule>>?
  get rules;
  $R call({
    String? id,
    String? couponCode,
    String? title,
    String? description,
    int? usageLimit,
    int? usagePerUser,
    String? applicableProducts,
    DateTime? validFrom,
    DateTime? validTo,
    String? bannerImageUrl,
    String? promotionText,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<CouponRule>? rules,
  });
  CouponCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CouponCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Coupon, $Out>
    implements CouponCopyWith<$R, Coupon, $Out> {
  _CouponCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Coupon> $mapper = CouponMapper.ensureInitialized();
  @override
  ListCopyWith<$R, CouponRule, CouponRuleCopyWith<$R, CouponRule, CouponRule>>?
  get rules => $value.rules != null
      ? ListCopyWith(
          $value.rules!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(rules: v),
        )
      : null;
  @override
  $R call({
    Object? id = $none,
    Object? couponCode = $none,
    Object? title = $none,
    Object? description = $none,
    Object? usageLimit = $none,
    Object? usagePerUser = $none,
    Object? applicableProducts = $none,
    Object? validFrom = $none,
    Object? validTo = $none,
    Object? bannerImageUrl = $none,
    Object? promotionText = $none,
    Object? status = $none,
    Object? createdAt = $none,
    Object? updatedAt = $none,
    Object? rules = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (couponCode != $none) #couponCode: couponCode,
      if (title != $none) #title: title,
      if (description != $none) #description: description,
      if (usageLimit != $none) #usageLimit: usageLimit,
      if (usagePerUser != $none) #usagePerUser: usagePerUser,
      if (applicableProducts != $none) #applicableProducts: applicableProducts,
      if (validFrom != $none) #validFrom: validFrom,
      if (validTo != $none) #validTo: validTo,
      if (bannerImageUrl != $none) #bannerImageUrl: bannerImageUrl,
      if (promotionText != $none) #promotionText: promotionText,
      if (status != $none) #status: status,
      if (createdAt != $none) #createdAt: createdAt,
      if (updatedAt != $none) #updatedAt: updatedAt,
      if (rules != $none) #rules: rules,
    }),
  );
  @override
  Coupon $make(CopyWithData data) => Coupon(
    id: data.get(#id, or: $value.id),
    couponCode: data.get(#couponCode, or: $value.couponCode),
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    usageLimit: data.get(#usageLimit, or: $value.usageLimit),
    usagePerUser: data.get(#usagePerUser, or: $value.usagePerUser),
    applicableProducts: data.get(
      #applicableProducts,
      or: $value.applicableProducts,
    ),
    validFrom: data.get(#validFrom, or: $value.validFrom),
    validTo: data.get(#validTo, or: $value.validTo),
    bannerImageUrl: data.get(#bannerImageUrl, or: $value.bannerImageUrl),
    promotionText: data.get(#promotionText, or: $value.promotionText),
    status: data.get(#status, or: $value.status),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    rules: data.get(#rules, or: $value.rules),
  );

  @override
  CouponCopyWith<$R2, Coupon, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CouponCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CouponRuleMapper extends ClassMapperBase<CouponRule> {
  CouponRuleMapper._();

  static CouponRuleMapper? _instance;
  static CouponRuleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CouponRuleMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CouponRule';

  static List<String> _$targetProductTypes(CouponRule v) =>
      v.targetProductTypes;
  static const Field<CouponRule, List<String>> _f$targetProductTypes = Field(
    'targetProductTypes',
    _$targetProductTypes,
  );
  static List<String> _$targetPetTypes(CouponRule v) => v.targetPetTypes;
  static const Field<CouponRule, List<String>> _f$targetPetTypes = Field(
    'targetPetTypes',
    _$targetPetTypes,
  );
  static List<String> _$targetSubcategories(CouponRule v) =>
      v.targetSubcategories;
  static const Field<CouponRule, List<String>> _f$targetSubcategories = Field(
    'targetSubcategories',
    _$targetSubcategories,
  );
  static List<String> _$targetProductIds(CouponRule v) => v.targetProductIds;
  static const Field<CouponRule, List<String>> _f$targetProductIds = Field(
    'targetProductIds',
    _$targetProductIds,
  );
  static String? _$targetTags(CouponRule v) => v.targetTags;
  static const Field<CouponRule, String> _f$targetTags = Field(
    'targetTags',
    _$targetTags,
    opt: true,
  );
  static String? _$excludeProductIds(CouponRule v) => v.excludeProductIds;
  static const Field<CouponRule, String> _f$excludeProductIds = Field(
    'excludeProductIds',
    _$excludeProductIds,
    opt: true,
  );
  static List<String> _$targetSubscriptionTypes(CouponRule v) =>
      v.targetSubscriptionTypes;
  static const Field<CouponRule, List<String>> _f$targetSubscriptionTypes =
      Field('targetSubscriptionTypes', _$targetSubscriptionTypes);
  static List<String> _$targetSubscriptionDurations(CouponRule v) =>
      v.targetSubscriptionDurations;
  static const Field<CouponRule, List<String>> _f$targetSubscriptionDurations =
      Field('targetSubscriptionDurations', _$targetSubscriptionDurations);
  static bool _$subscriptionBundleRequired(CouponRule v) =>
      v.subscriptionBundleRequired;
  static const Field<CouponRule, bool> _f$subscriptionBundleRequired = Field(
    'subscriptionBundleRequired',
    _$subscriptionBundleRequired,
    hook: SafeBoolHook(),
  );
  static List<String> _$eligibilityRules(CouponRule v) => v.eligibilityRules;
  static const Field<CouponRule, List<String>> _f$eligibilityRules = Field(
    'eligibilityRules',
    _$eligibilityRules,
  );
  static String? _$minPurchaseAmount(CouponRule v) => v.minPurchaseAmount;
  static const Field<CouponRule, String> _f$minPurchaseAmount = Field(
    'minPurchaseAmount',
    _$minPurchaseAmount,
    opt: true,
  );
  static String? _$minPurchaseCount(CouponRule v) => v.minPurchaseCount;
  static const Field<CouponRule, String> _f$minPurchaseCount = Field(
    'minPurchaseCount',
    _$minPurchaseCount,
    opt: true,
  );
  static bool _$requireActiveSubscription(CouponRule v) =>
      v.requireActiveSubscription;
  static const Field<CouponRule, bool> _f$requireActiveSubscription = Field(
    'requireActiveSubscription',
    _$requireActiveSubscription,
    hook: SafeBoolHook(),
  );
  static List<String> _$subscriptionUpgradeFrom(CouponRule v) =>
      v.subscriptionUpgradeFrom;
  static const Field<CouponRule, List<String>> _f$subscriptionUpgradeFrom =
      Field('subscriptionUpgradeFrom', _$subscriptionUpgradeFrom);
  static String? _$inactiveDays(CouponRule v) => v.inactiveDays;
  static const Field<CouponRule, String> _f$inactiveDays = Field(
    'inactiveDays',
    _$inactiveDays,
    opt: true,
  );
  static String? _$minLifetimeValue(CouponRule v) => v.minLifetimeValue;
  static const Field<CouponRule, String> _f$minLifetimeValue = Field(
    'minLifetimeValue',
    _$minLifetimeValue,
    opt: true,
  );
  static List<String> _$whitelistedUserIds(CouponRule v) =>
      v.whitelistedUserIds;
  static const Field<CouponRule, List<String>> _f$whitelistedUserIds = Field(
    'whitelistedUserIds',
    _$whitelistedUserIds,
  );
  static List<String> _$blacklistedUserIds(CouponRule v) =>
      v.blacklistedUserIds;
  static const Field<CouponRule, List<String>> _f$blacklistedUserIds = Field(
    'blacklistedUserIds',
    _$blacklistedUserIds,
  );
  static List<String> _$eventTags(CouponRule v) => v.eventTags;
  static const Field<CouponRule, List<String>> _f$eventTags = Field(
    'eventTags',
    _$eventTags,
  );
  static String _$campaignName(CouponRule v) => v.campaignName;
  static const Field<CouponRule, String> _f$campaignName = Field(
    'campaignName',
    _$campaignName,
    hook: SafeStringHook(),
  );
  static String? _$customMetadata(CouponRule v) => v.customMetadata;
  static const Field<CouponRule, String> _f$customMetadata = Field(
    'customMetadata',
    _$customMetadata,
    opt: true,
  );
  static bool _$requireAllConditions(CouponRule v) => v.requireAllConditions;
  static const Field<CouponRule, bool> _f$requireAllConditions = Field(
    'requireAllConditions',
    _$requireAllConditions,
    hook: SafeBoolHook(),
  );
  static int _$priority(CouponRule v) => v.priority;
  static const Field<CouponRule, int> _f$priority = Field(
    'priority',
    _$priority,
    hook: SafeIntHook(),
  );
  static bool _$isActive(CouponRule v) => v.isActive;
  static const Field<CouponRule, bool> _f$isActive = Field(
    'isActive',
    _$isActive,
    hook: SafeBoolHook(),
  );

  @override
  final MappableFields<CouponRule> fields = const {
    #targetProductTypes: _f$targetProductTypes,
    #targetPetTypes: _f$targetPetTypes,
    #targetSubcategories: _f$targetSubcategories,
    #targetProductIds: _f$targetProductIds,
    #targetTags: _f$targetTags,
    #excludeProductIds: _f$excludeProductIds,
    #targetSubscriptionTypes: _f$targetSubscriptionTypes,
    #targetSubscriptionDurations: _f$targetSubscriptionDurations,
    #subscriptionBundleRequired: _f$subscriptionBundleRequired,
    #eligibilityRules: _f$eligibilityRules,
    #minPurchaseAmount: _f$minPurchaseAmount,
    #minPurchaseCount: _f$minPurchaseCount,
    #requireActiveSubscription: _f$requireActiveSubscription,
    #subscriptionUpgradeFrom: _f$subscriptionUpgradeFrom,
    #inactiveDays: _f$inactiveDays,
    #minLifetimeValue: _f$minLifetimeValue,
    #whitelistedUserIds: _f$whitelistedUserIds,
    #blacklistedUserIds: _f$blacklistedUserIds,
    #eventTags: _f$eventTags,
    #campaignName: _f$campaignName,
    #customMetadata: _f$customMetadata,
    #requireAllConditions: _f$requireAllConditions,
    #priority: _f$priority,
    #isActive: _f$isActive,
  };

  static CouponRule _instantiate(DecodingData data) {
    return CouponRule(
      targetProductTypes: data.dec(_f$targetProductTypes),
      targetPetTypes: data.dec(_f$targetPetTypes),
      targetSubcategories: data.dec(_f$targetSubcategories),
      targetProductIds: data.dec(_f$targetProductIds),
      targetTags: data.dec(_f$targetTags),
      excludeProductIds: data.dec(_f$excludeProductIds),
      targetSubscriptionTypes: data.dec(_f$targetSubscriptionTypes),
      targetSubscriptionDurations: data.dec(_f$targetSubscriptionDurations),
      subscriptionBundleRequired: data.dec(_f$subscriptionBundleRequired),
      eligibilityRules: data.dec(_f$eligibilityRules),
      minPurchaseAmount: data.dec(_f$minPurchaseAmount),
      minPurchaseCount: data.dec(_f$minPurchaseCount),
      requireActiveSubscription: data.dec(_f$requireActiveSubscription),
      subscriptionUpgradeFrom: data.dec(_f$subscriptionUpgradeFrom),
      inactiveDays: data.dec(_f$inactiveDays),
      minLifetimeValue: data.dec(_f$minLifetimeValue),
      whitelistedUserIds: data.dec(_f$whitelistedUserIds),
      blacklistedUserIds: data.dec(_f$blacklistedUserIds),
      eventTags: data.dec(_f$eventTags),
      campaignName: data.dec(_f$campaignName),
      customMetadata: data.dec(_f$customMetadata),
      requireAllConditions: data.dec(_f$requireAllConditions),
      priority: data.dec(_f$priority),
      isActive: data.dec(_f$isActive),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CouponRule fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CouponRule>(map);
  }

  static CouponRule fromJson(String json) {
    return ensureInitialized().decodeJson<CouponRule>(json);
  }
}

mixin CouponRuleMappable {
  String toJson() {
    return CouponRuleMapper.ensureInitialized().encodeJson<CouponRule>(
      this as CouponRule,
    );
  }

  Map<String, dynamic> toMap() {
    return CouponRuleMapper.ensureInitialized().encodeMap<CouponRule>(
      this as CouponRule,
    );
  }

  CouponRuleCopyWith<CouponRule, CouponRule, CouponRule> get copyWith =>
      _CouponRuleCopyWithImpl<CouponRule, CouponRule>(
        this as CouponRule,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CouponRuleMapper.ensureInitialized().stringifyValue(
      this as CouponRule,
    );
  }

  @override
  bool operator ==(Object other) {
    return CouponRuleMapper.ensureInitialized().equalsValue(
      this as CouponRule,
      other,
    );
  }

  @override
  int get hashCode {
    return CouponRuleMapper.ensureInitialized().hashValue(this as CouponRule);
  }
}

extension CouponRuleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CouponRule, $Out> {
  CouponRuleCopyWith<$R, CouponRule, $Out> get $asCouponRule =>
      $base.as((v, t, t2) => _CouponRuleCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CouponRuleCopyWith<$R, $In extends CouponRule, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get targetProductTypes;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get targetPetTypes;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get targetSubcategories;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get targetProductIds;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get targetSubscriptionTypes;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get targetSubscriptionDurations;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get eligibilityRules;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get subscriptionUpgradeFrom;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get whitelistedUserIds;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get blacklistedUserIds;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get eventTags;
  $R call({
    List<String>? targetProductTypes,
    List<String>? targetPetTypes,
    List<String>? targetSubcategories,
    List<String>? targetProductIds,
    String? targetTags,
    String? excludeProductIds,
    List<String>? targetSubscriptionTypes,
    List<String>? targetSubscriptionDurations,
    bool? subscriptionBundleRequired,
    List<String>? eligibilityRules,
    String? minPurchaseAmount,
    String? minPurchaseCount,
    bool? requireActiveSubscription,
    List<String>? subscriptionUpgradeFrom,
    String? inactiveDays,
    String? minLifetimeValue,
    List<String>? whitelistedUserIds,
    List<String>? blacklistedUserIds,
    List<String>? eventTags,
    String? campaignName,
    String? customMetadata,
    bool? requireAllConditions,
    int? priority,
    bool? isActive,
  });
  CouponRuleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CouponRuleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CouponRule, $Out>
    implements CouponRuleCopyWith<$R, CouponRule, $Out> {
  _CouponRuleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CouponRule> $mapper =
      CouponRuleMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get targetProductTypes => ListCopyWith(
    $value.targetProductTypes,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(targetProductTypes: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get targetPetTypes => ListCopyWith(
    $value.targetPetTypes,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(targetPetTypes: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get targetSubcategories => ListCopyWith(
    $value.targetSubcategories,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(targetSubcategories: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get targetProductIds => ListCopyWith(
    $value.targetProductIds,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(targetProductIds: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get targetSubscriptionTypes => ListCopyWith(
    $value.targetSubscriptionTypes,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(targetSubscriptionTypes: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get targetSubscriptionDurations => ListCopyWith(
    $value.targetSubscriptionDurations,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(targetSubscriptionDurations: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get eligibilityRules => ListCopyWith(
    $value.eligibilityRules,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(eligibilityRules: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get subscriptionUpgradeFrom => ListCopyWith(
    $value.subscriptionUpgradeFrom,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(subscriptionUpgradeFrom: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get whitelistedUserIds => ListCopyWith(
    $value.whitelistedUserIds,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(whitelistedUserIds: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get blacklistedUserIds => ListCopyWith(
    $value.blacklistedUserIds,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(blacklistedUserIds: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get eventTags =>
      ListCopyWith(
        $value.eventTags,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(eventTags: v),
      );
  @override
  $R call({
    List<String>? targetProductTypes,
    List<String>? targetPetTypes,
    List<String>? targetSubcategories,
    List<String>? targetProductIds,
    Object? targetTags = $none,
    Object? excludeProductIds = $none,
    List<String>? targetSubscriptionTypes,
    List<String>? targetSubscriptionDurations,
    bool? subscriptionBundleRequired,
    List<String>? eligibilityRules,
    Object? minPurchaseAmount = $none,
    Object? minPurchaseCount = $none,
    bool? requireActiveSubscription,
    List<String>? subscriptionUpgradeFrom,
    Object? inactiveDays = $none,
    Object? minLifetimeValue = $none,
    List<String>? whitelistedUserIds,
    List<String>? blacklistedUserIds,
    List<String>? eventTags,
    String? campaignName,
    Object? customMetadata = $none,
    bool? requireAllConditions,
    int? priority,
    bool? isActive,
  }) => $apply(
    FieldCopyWithData({
      if (targetProductTypes != null) #targetProductTypes: targetProductTypes,
      if (targetPetTypes != null) #targetPetTypes: targetPetTypes,
      if (targetSubcategories != null)
        #targetSubcategories: targetSubcategories,
      if (targetProductIds != null) #targetProductIds: targetProductIds,
      if (targetTags != $none) #targetTags: targetTags,
      if (excludeProductIds != $none) #excludeProductIds: excludeProductIds,
      if (targetSubscriptionTypes != null)
        #targetSubscriptionTypes: targetSubscriptionTypes,
      if (targetSubscriptionDurations != null)
        #targetSubscriptionDurations: targetSubscriptionDurations,
      if (subscriptionBundleRequired != null)
        #subscriptionBundleRequired: subscriptionBundleRequired,
      if (eligibilityRules != null) #eligibilityRules: eligibilityRules,
      if (minPurchaseAmount != $none) #minPurchaseAmount: minPurchaseAmount,
      if (minPurchaseCount != $none) #minPurchaseCount: minPurchaseCount,
      if (requireActiveSubscription != null)
        #requireActiveSubscription: requireActiveSubscription,
      if (subscriptionUpgradeFrom != null)
        #subscriptionUpgradeFrom: subscriptionUpgradeFrom,
      if (inactiveDays != $none) #inactiveDays: inactiveDays,
      if (minLifetimeValue != $none) #minLifetimeValue: minLifetimeValue,
      if (whitelistedUserIds != null) #whitelistedUserIds: whitelistedUserIds,
      if (blacklistedUserIds != null) #blacklistedUserIds: blacklistedUserIds,
      if (eventTags != null) #eventTags: eventTags,
      if (campaignName != null) #campaignName: campaignName,
      if (customMetadata != $none) #customMetadata: customMetadata,
      if (requireAllConditions != null)
        #requireAllConditions: requireAllConditions,
      if (priority != null) #priority: priority,
      if (isActive != null) #isActive: isActive,
    }),
  );
  @override
  CouponRule $make(CopyWithData data) => CouponRule(
    targetProductTypes: data.get(
      #targetProductTypes,
      or: $value.targetProductTypes,
    ),
    targetPetTypes: data.get(#targetPetTypes, or: $value.targetPetTypes),
    targetSubcategories: data.get(
      #targetSubcategories,
      or: $value.targetSubcategories,
    ),
    targetProductIds: data.get(#targetProductIds, or: $value.targetProductIds),
    targetTags: data.get(#targetTags, or: $value.targetTags),
    excludeProductIds: data.get(
      #excludeProductIds,
      or: $value.excludeProductIds,
    ),
    targetSubscriptionTypes: data.get(
      #targetSubscriptionTypes,
      or: $value.targetSubscriptionTypes,
    ),
    targetSubscriptionDurations: data.get(
      #targetSubscriptionDurations,
      or: $value.targetSubscriptionDurations,
    ),
    subscriptionBundleRequired: data.get(
      #subscriptionBundleRequired,
      or: $value.subscriptionBundleRequired,
    ),
    eligibilityRules: data.get(#eligibilityRules, or: $value.eligibilityRules),
    minPurchaseAmount: data.get(
      #minPurchaseAmount,
      or: $value.minPurchaseAmount,
    ),
    minPurchaseCount: data.get(#minPurchaseCount, or: $value.minPurchaseCount),
    requireActiveSubscription: data.get(
      #requireActiveSubscription,
      or: $value.requireActiveSubscription,
    ),
    subscriptionUpgradeFrom: data.get(
      #subscriptionUpgradeFrom,
      or: $value.subscriptionUpgradeFrom,
    ),
    inactiveDays: data.get(#inactiveDays, or: $value.inactiveDays),
    minLifetimeValue: data.get(#minLifetimeValue, or: $value.minLifetimeValue),
    whitelistedUserIds: data.get(
      #whitelistedUserIds,
      or: $value.whitelistedUserIds,
    ),
    blacklistedUserIds: data.get(
      #blacklistedUserIds,
      or: $value.blacklistedUserIds,
    ),
    eventTags: data.get(#eventTags, or: $value.eventTags),
    campaignName: data.get(#campaignName, or: $value.campaignName),
    customMetadata: data.get(#customMetadata, or: $value.customMetadata),
    requireAllConditions: data.get(
      #requireAllConditions,
      or: $value.requireAllConditions,
    ),
    priority: data.get(#priority, or: $value.priority),
    isActive: data.get(#isActive, or: $value.isActive),
  );

  @override
  CouponRuleCopyWith<$R2, CouponRule, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CouponRuleCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CartCountMapper extends ClassMapperBase<CartCount> {
  CartCountMapper._();

  static CartCountMapper? _instance;
  static CartCountMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CartCountMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CartCount';

  static int _$count(CartCount v) => v.count;
  static const Field<CartCount, int> _f$count = Field(
    'count',
    _$count,
    hook: SafeIntHook(),
  );

  @override
  final MappableFields<CartCount> fields = const {#count: _f$count};

  static CartCount _instantiate(DecodingData data) {
    return CartCount(count: data.dec(_f$count));
  }

  @override
  final Function instantiate = _instantiate;

  static CartCount fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CartCount>(map);
  }

  static CartCount fromJson(String json) {
    return ensureInitialized().decodeJson<CartCount>(json);
  }
}

mixin CartCountMappable {
  String toJson() {
    return CartCountMapper.ensureInitialized().encodeJson<CartCount>(
      this as CartCount,
    );
  }

  Map<String, dynamic> toMap() {
    return CartCountMapper.ensureInitialized().encodeMap<CartCount>(
      this as CartCount,
    );
  }

  CartCountCopyWith<CartCount, CartCount, CartCount> get copyWith =>
      _CartCountCopyWithImpl<CartCount, CartCount>(
        this as CartCount,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CartCountMapper.ensureInitialized().stringifyValue(
      this as CartCount,
    );
  }

  @override
  bool operator ==(Object other) {
    return CartCountMapper.ensureInitialized().equalsValue(
      this as CartCount,
      other,
    );
  }

  @override
  int get hashCode {
    return CartCountMapper.ensureInitialized().hashValue(this as CartCount);
  }
}

extension CartCountValueCopy<$R, $Out> on ObjectCopyWith<$R, CartCount, $Out> {
  CartCountCopyWith<$R, CartCount, $Out> get $asCartCount =>
      $base.as((v, t, t2) => _CartCountCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CartCountCopyWith<$R, $In extends CartCount, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? count});
  CartCountCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CartCountCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CartCount, $Out>
    implements CartCountCopyWith<$R, CartCount, $Out> {
  _CartCountCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CartCount> $mapper =
      CartCountMapper.ensureInitialized();
  @override
  $R call({int? count}) =>
      $apply(FieldCopyWithData({if (count != null) #count: count}));
  @override
  CartCount $make(CopyWithData data) =>
      CartCount(count: data.get(#count, or: $value.count));

  @override
  CartCountCopyWith<$R2, CartCount, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CartCountCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

