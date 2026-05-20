// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'clinic_subs_plans_response_model.dart';

class ClinicSubsPlansResponseModelMapper
    extends ClassMapperBase<ClinicSubsPlansResponseModel> {
  ClinicSubsPlansResponseModelMapper._();

  static ClinicSubsPlansResponseModelMapper? _instance;
  static ClinicSubsPlansResponseModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = ClinicSubsPlansResponseModelMapper._(),
      );
      ClinicSubscriptionDataMapper.ensureInitialized();
      SubscriptionMetaMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ClinicSubsPlansResponseModel';

  static bool _$success(ClinicSubsPlansResponseModel v) => v.success;
  static const Field<ClinicSubsPlansResponseModel, bool> _f$success = Field(
    'success',
    _$success,
    opt: true,
    def: false,
  );
  static String _$message(ClinicSubsPlansResponseModel v) => v.message;
  static const Field<ClinicSubsPlansResponseModel, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
    def: '',
  );
  static int _$status(ClinicSubsPlansResponseModel v) => v.status;
  static const Field<ClinicSubsPlansResponseModel, int> _f$status = Field(
    'status',
    _$status,
    opt: true,
    def: 0,
  );
  static ClinicSubscriptionData _$data(ClinicSubsPlansResponseModel v) =>
      v.data;
  static const Field<ClinicSubsPlansResponseModel, ClinicSubscriptionData>
  _f$data = Field(
    'data',
    _$data,
    opt: true,
    def: const ClinicSubscriptionData(),
  );
  static SubscriptionMeta _$meta(ClinicSubsPlansResponseModel v) => v.meta;
  static const Field<ClinicSubsPlansResponseModel, SubscriptionMeta> _f$meta =
      Field('meta', _$meta, opt: true, def: const SubscriptionMeta());

  @override
  final MappableFields<ClinicSubsPlansResponseModel> fields = const {
    #success: _f$success,
    #message: _f$message,
    #status: _f$status,
    #data: _f$data,
    #meta: _f$meta,
  };

  static ClinicSubsPlansResponseModel _instantiate(DecodingData data) {
    return ClinicSubsPlansResponseModel(
      success: data.dec(_f$success),
      message: data.dec(_f$message),
      status: data.dec(_f$status),
      data: data.dec(_f$data),
      meta: data.dec(_f$meta),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ClinicSubsPlansResponseModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ClinicSubsPlansResponseModel>(map);
  }

  static ClinicSubsPlansResponseModel fromJson(String json) {
    return ensureInitialized().decodeJson<ClinicSubsPlansResponseModel>(json);
  }
}

mixin ClinicSubsPlansResponseModelMappable {
  String toJson() {
    return ClinicSubsPlansResponseModelMapper.ensureInitialized()
        .encodeJson<ClinicSubsPlansResponseModel>(
          this as ClinicSubsPlansResponseModel,
        );
  }

  Map<String, dynamic> toMap() {
    return ClinicSubsPlansResponseModelMapper.ensureInitialized()
        .encodeMap<ClinicSubsPlansResponseModel>(
          this as ClinicSubsPlansResponseModel,
        );
  }

  ClinicSubsPlansResponseModelCopyWith<
    ClinicSubsPlansResponseModel,
    ClinicSubsPlansResponseModel,
    ClinicSubsPlansResponseModel
  >
  get copyWith =>
      _ClinicSubsPlansResponseModelCopyWithImpl<
        ClinicSubsPlansResponseModel,
        ClinicSubsPlansResponseModel
      >(this as ClinicSubsPlansResponseModel, $identity, $identity);
  @override
  String toString() {
    return ClinicSubsPlansResponseModelMapper.ensureInitialized()
        .stringifyValue(this as ClinicSubsPlansResponseModel);
  }

  @override
  bool operator ==(Object other) {
    return ClinicSubsPlansResponseModelMapper.ensureInitialized().equalsValue(
      this as ClinicSubsPlansResponseModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ClinicSubsPlansResponseModelMapper.ensureInitialized().hashValue(
      this as ClinicSubsPlansResponseModel,
    );
  }
}

extension ClinicSubsPlansResponseModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ClinicSubsPlansResponseModel, $Out> {
  ClinicSubsPlansResponseModelCopyWith<$R, ClinicSubsPlansResponseModel, $Out>
  get $asClinicSubsPlansResponseModel => $base.as(
    (v, t, t2) => _ClinicSubsPlansResponseModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ClinicSubsPlansResponseModelCopyWith<
  $R,
  $In extends ClinicSubsPlansResponseModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ClinicSubscriptionDataCopyWith<
    $R,
    ClinicSubscriptionData,
    ClinicSubscriptionData
  >
  get data;
  SubscriptionMetaCopyWith<$R, SubscriptionMeta, SubscriptionMeta> get meta;
  $R call({
    bool? success,
    String? message,
    int? status,
    ClinicSubscriptionData? data,
    SubscriptionMeta? meta,
  });
  ClinicSubsPlansResponseModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ClinicSubsPlansResponseModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ClinicSubsPlansResponseModel, $Out>
    implements
        ClinicSubsPlansResponseModelCopyWith<
          $R,
          ClinicSubsPlansResponseModel,
          $Out
        > {
  _ClinicSubsPlansResponseModelCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<ClinicSubsPlansResponseModel> $mapper =
      ClinicSubsPlansResponseModelMapper.ensureInitialized();
  @override
  ClinicSubscriptionDataCopyWith<
    $R,
    ClinicSubscriptionData,
    ClinicSubscriptionData
  >
  get data => $value.data.copyWith.$chain((v) => call(data: v));
  @override
  SubscriptionMetaCopyWith<$R, SubscriptionMeta, SubscriptionMeta> get meta =>
      $value.meta.copyWith.$chain((v) => call(meta: v));
  @override
  $R call({
    bool? success,
    String? message,
    int? status,
    ClinicSubscriptionData? data,
    SubscriptionMeta? meta,
  }) => $apply(
    FieldCopyWithData({
      if (success != null) #success: success,
      if (message != null) #message: message,
      if (status != null) #status: status,
      if (data != null) #data: data,
      if (meta != null) #meta: meta,
    }),
  );
  @override
  ClinicSubsPlansResponseModel $make(CopyWithData data) =>
      ClinicSubsPlansResponseModel(
        success: data.get(#success, or: $value.success),
        message: data.get(#message, or: $value.message),
        status: data.get(#status, or: $value.status),
        data: data.get(#data, or: $value.data),
        meta: data.get(#meta, or: $value.meta),
      );

  @override
  ClinicSubsPlansResponseModelCopyWith<$R2, ClinicSubsPlansResponseModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ClinicSubsPlansResponseModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ClinicSubscriptionDataMapper
    extends ClassMapperBase<ClinicSubscriptionData> {
  ClinicSubscriptionDataMapper._();

  static ClinicSubscriptionDataMapper? _instance;
  static ClinicSubscriptionDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ClinicSubscriptionDataMapper._());
      ClinicPlanModelMapper.ensureInitialized();
      ActiveSubscriptionModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ClinicSubscriptionData';

  static List<ClinicPlanModel> _$plans(ClinicSubscriptionData v) => v.plans;
  static const Field<ClinicSubscriptionData, List<ClinicPlanModel>> _f$plans =
      Field('plans', _$plans, opt: true, def: const [], hook: SafeListHook());
  static List<ActiveSubscriptionModel> _$activeSubscriptions(
    ClinicSubscriptionData v,
  ) => v.activeSubscriptions;
  static const Field<ClinicSubscriptionData, List<ActiveSubscriptionModel>>
  _f$activeSubscriptions = Field(
    'activeSubscriptions',
    _$activeSubscriptions,
    opt: true,
    def: const [],
    hook: SafeListHook(),
  );

  @override
  final MappableFields<ClinicSubscriptionData> fields = const {
    #plans: _f$plans,
    #activeSubscriptions: _f$activeSubscriptions,
  };

  static ClinicSubscriptionData _instantiate(DecodingData data) {
    return ClinicSubscriptionData(
      plans: data.dec(_f$plans),
      activeSubscriptions: data.dec(_f$activeSubscriptions),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ClinicSubscriptionData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ClinicSubscriptionData>(map);
  }

  static ClinicSubscriptionData fromJson(String json) {
    return ensureInitialized().decodeJson<ClinicSubscriptionData>(json);
  }
}

mixin ClinicSubscriptionDataMappable {
  String toJson() {
    return ClinicSubscriptionDataMapper.ensureInitialized()
        .encodeJson<ClinicSubscriptionData>(this as ClinicSubscriptionData);
  }

  Map<String, dynamic> toMap() {
    return ClinicSubscriptionDataMapper.ensureInitialized()
        .encodeMap<ClinicSubscriptionData>(this as ClinicSubscriptionData);
  }

  ClinicSubscriptionDataCopyWith<
    ClinicSubscriptionData,
    ClinicSubscriptionData,
    ClinicSubscriptionData
  >
  get copyWith =>
      _ClinicSubscriptionDataCopyWithImpl<
        ClinicSubscriptionData,
        ClinicSubscriptionData
      >(this as ClinicSubscriptionData, $identity, $identity);
  @override
  String toString() {
    return ClinicSubscriptionDataMapper.ensureInitialized().stringifyValue(
      this as ClinicSubscriptionData,
    );
  }

  @override
  bool operator ==(Object other) {
    return ClinicSubscriptionDataMapper.ensureInitialized().equalsValue(
      this as ClinicSubscriptionData,
      other,
    );
  }

  @override
  int get hashCode {
    return ClinicSubscriptionDataMapper.ensureInitialized().hashValue(
      this as ClinicSubscriptionData,
    );
  }
}

extension ClinicSubscriptionDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ClinicSubscriptionData, $Out> {
  ClinicSubscriptionDataCopyWith<$R, ClinicSubscriptionData, $Out>
  get $asClinicSubscriptionData => $base.as(
    (v, t, t2) => _ClinicSubscriptionDataCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ClinicSubscriptionDataCopyWith<
  $R,
  $In extends ClinicSubscriptionData,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    ClinicPlanModel,
    ClinicPlanModelCopyWith<$R, ClinicPlanModel, ClinicPlanModel>
  >
  get plans;
  ListCopyWith<
    $R,
    ActiveSubscriptionModel,
    ActiveSubscriptionModelCopyWith<
      $R,
      ActiveSubscriptionModel,
      ActiveSubscriptionModel
    >
  >
  get activeSubscriptions;
  $R call({
    List<ClinicPlanModel>? plans,
    List<ActiveSubscriptionModel>? activeSubscriptions,
  });
  ClinicSubscriptionDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ClinicSubscriptionDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ClinicSubscriptionData, $Out>
    implements
        ClinicSubscriptionDataCopyWith<$R, ClinicSubscriptionData, $Out> {
  _ClinicSubscriptionDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ClinicSubscriptionData> $mapper =
      ClinicSubscriptionDataMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    ClinicPlanModel,
    ClinicPlanModelCopyWith<$R, ClinicPlanModel, ClinicPlanModel>
  >
  get plans => ListCopyWith(
    $value.plans,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(plans: v),
  );
  @override
  ListCopyWith<
    $R,
    ActiveSubscriptionModel,
    ActiveSubscriptionModelCopyWith<
      $R,
      ActiveSubscriptionModel,
      ActiveSubscriptionModel
    >
  >
  get activeSubscriptions => ListCopyWith(
    $value.activeSubscriptions,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(activeSubscriptions: v),
  );
  @override
  $R call({
    List<ClinicPlanModel>? plans,
    List<ActiveSubscriptionModel>? activeSubscriptions,
  }) => $apply(
    FieldCopyWithData({
      if (plans != null) #plans: plans,
      if (activeSubscriptions != null)
        #activeSubscriptions: activeSubscriptions,
    }),
  );
  @override
  ClinicSubscriptionData $make(CopyWithData data) => ClinicSubscriptionData(
    plans: data.get(#plans, or: $value.plans),
    activeSubscriptions: data.get(
      #activeSubscriptions,
      or: $value.activeSubscriptions,
    ),
  );

  @override
  ClinicSubscriptionDataCopyWith<$R2, ClinicSubscriptionData, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ClinicSubscriptionDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ClinicPlanModelMapper extends ClassMapperBase<ClinicPlanModel> {
  ClinicPlanModelMapper._();

  static ClinicPlanModelMapper? _instance;
  static ClinicPlanModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ClinicPlanModelMapper._());
      PlanFeaturesModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ClinicPlanModel';

  static String _$id(ClinicPlanModel v) => v.id;
  static const Field<ClinicPlanModel, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$clinicId(ClinicPlanModel v) => v.clinicId;
  static const Field<ClinicPlanModel, String> _f$clinicId = Field(
    'clinicId',
    _$clinicId,
    key: r'clinic_id',
    opt: true,
    def: '',
  );
  static String _$planName(ClinicPlanModel v) => v.planName;
  static const Field<ClinicPlanModel, String> _f$planName = Field(
    'planName',
    _$planName,
    key: r'plan_name',
    opt: true,
    def: '',
  );
  static String _$planType(ClinicPlanModel v) => v.planType;
  static const Field<ClinicPlanModel, String> _f$planType = Field(
    'planType',
    _$planType,
    key: r'plan_type',
    opt: true,
    def: '',
  );
  static String _$planDuration(ClinicPlanModel v) => v.planDuration;
  static const Field<ClinicPlanModel, String> _f$planDuration = Field(
    'planDuration',
    _$planDuration,
    key: r'plan_duration',
    opt: true,
    def: '',
  );
  static int _$callCredits(ClinicPlanModel v) => v.callCredits;
  static const Field<ClinicPlanModel, int> _f$callCredits = Field(
    'callCredits',
    _$callCredits,
    key: r'call_credits',
    opt: true,
    def: 0,
  );
  static String _$price(ClinicPlanModel v) => v.price;
  static const Field<ClinicPlanModel, String> _f$price = Field(
    'price',
    _$price,
    opt: true,
    def: '',
  );
  static String _$currency(ClinicPlanModel v) => v.currency;
  static const Field<ClinicPlanModel, String> _f$currency = Field(
    'currency',
    _$currency,
    opt: true,
    def: '',
  );
  static int _$durationDays(ClinicPlanModel v) => v.durationDays;
  static const Field<ClinicPlanModel, int> _f$durationDays = Field(
    'durationDays',
    _$durationDays,
    key: r'duration_days',
    opt: true,
    def: 0,
  );
  static bool _$isActive(ClinicPlanModel v) => v.isActive;
  static const Field<ClinicPlanModel, bool> _f$isActive = Field(
    'isActive',
    _$isActive,
    key: r'is_active',
    opt: true,
    def: false,
  );
  static bool _$isDeleted(ClinicPlanModel v) => v.isDeleted;
  static const Field<ClinicPlanModel, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    key: r'is_deleted',
    opt: true,
    def: false,
  );
  static bool _$isDefault(ClinicPlanModel v) => v.isDefault;
  static const Field<ClinicPlanModel, bool> _f$isDefault = Field(
    'isDefault',
    _$isDefault,
    key: r'is_default',
    opt: true,
    def: false,
  );
  static String _$description(ClinicPlanModel v) => v.description;
  static const Field<ClinicPlanModel, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
  );
  static PlanFeaturesModel _$features(ClinicPlanModel v) => v.features;
  static const Field<ClinicPlanModel, PlanFeaturesModel> _f$features = Field(
    'features',
    _$features,
    opt: true,
    def: const PlanFeaturesModel(),
  );
  static String _$createdAt(ClinicPlanModel v) => v.createdAt;
  static const Field<ClinicPlanModel, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    key: r'created_at',
    opt: true,
    def: '',
  );
  static String _$updatedAt(ClinicPlanModel v) => v.updatedAt;
  static const Field<ClinicPlanModel, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    key: r'updated_at',
    opt: true,
    def: '',
  );
  static bool _$isSubscribed(ClinicPlanModel v) => v.isSubscribed;
  static const Field<ClinicPlanModel, bool> _f$isSubscribed = Field(
    'isSubscribed',
    _$isSubscribed,
    opt: true,
    def: false,
  );
  static bool _$isAlreadyBought(ClinicPlanModel v) => v.isAlreadyBought;
  static const Field<ClinicPlanModel, bool> _f$isAlreadyBought = Field(
    'isAlreadyBought',
    _$isAlreadyBought,
    opt: true,
    def: false,
  );
  static dynamic _$subscription(ClinicPlanModel v) => v.subscription;
  static const Field<ClinicPlanModel, dynamic> _f$subscription = Field(
    'subscription',
    _$subscription,
    opt: true,
  );
  static String _$priceDisplay(ClinicPlanModel v) => v.priceDisplay;
  static const Field<ClinicPlanModel, String> _f$priceDisplay = Field(
    'priceDisplay',
    _$priceDisplay,
    key: r'price_display',
    opt: true,
    def: '',
  );
  static String _$durationDisplay(ClinicPlanModel v) => v.durationDisplay;
  static const Field<ClinicPlanModel, String> _f$durationDisplay = Field(
    'durationDisplay',
    _$durationDisplay,
    key: r'duration_display',
    opt: true,
    def: '',
  );

  @override
  final MappableFields<ClinicPlanModel> fields = const {
    #id: _f$id,
    #clinicId: _f$clinicId,
    #planName: _f$planName,
    #planType: _f$planType,
    #planDuration: _f$planDuration,
    #callCredits: _f$callCredits,
    #price: _f$price,
    #currency: _f$currency,
    #durationDays: _f$durationDays,
    #isActive: _f$isActive,
    #isDeleted: _f$isDeleted,
    #isDefault: _f$isDefault,
    #description: _f$description,
    #features: _f$features,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #isSubscribed: _f$isSubscribed,
    #isAlreadyBought: _f$isAlreadyBought,
    #subscription: _f$subscription,
    #priceDisplay: _f$priceDisplay,
    #durationDisplay: _f$durationDisplay,
  };

  static ClinicPlanModel _instantiate(DecodingData data) {
    return ClinicPlanModel(
      id: data.dec(_f$id),
      clinicId: data.dec(_f$clinicId),
      planName: data.dec(_f$planName),
      planType: data.dec(_f$planType),
      planDuration: data.dec(_f$planDuration),
      callCredits: data.dec(_f$callCredits),
      price: data.dec(_f$price),
      currency: data.dec(_f$currency),
      durationDays: data.dec(_f$durationDays),
      isActive: data.dec(_f$isActive),
      isDeleted: data.dec(_f$isDeleted),
      isDefault: data.dec(_f$isDefault),
      description: data.dec(_f$description),
      features: data.dec(_f$features),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      isSubscribed: data.dec(_f$isSubscribed),
      isAlreadyBought: data.dec(_f$isAlreadyBought),
      subscription: data.dec(_f$subscription),
      priceDisplay: data.dec(_f$priceDisplay),
      durationDisplay: data.dec(_f$durationDisplay),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ClinicPlanModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ClinicPlanModel>(map);
  }

  static ClinicPlanModel fromJson(String json) {
    return ensureInitialized().decodeJson<ClinicPlanModel>(json);
  }
}

mixin ClinicPlanModelMappable {
  String toJson() {
    return ClinicPlanModelMapper.ensureInitialized()
        .encodeJson<ClinicPlanModel>(this as ClinicPlanModel);
  }

  Map<String, dynamic> toMap() {
    return ClinicPlanModelMapper.ensureInitialized().encodeMap<ClinicPlanModel>(
      this as ClinicPlanModel,
    );
  }

  ClinicPlanModelCopyWith<ClinicPlanModel, ClinicPlanModel, ClinicPlanModel>
  get copyWith =>
      _ClinicPlanModelCopyWithImpl<ClinicPlanModel, ClinicPlanModel>(
        this as ClinicPlanModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ClinicPlanModelMapper.ensureInitialized().stringifyValue(
      this as ClinicPlanModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ClinicPlanModelMapper.ensureInitialized().equalsValue(
      this as ClinicPlanModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ClinicPlanModelMapper.ensureInitialized().hashValue(
      this as ClinicPlanModel,
    );
  }
}

extension ClinicPlanModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ClinicPlanModel, $Out> {
  ClinicPlanModelCopyWith<$R, ClinicPlanModel, $Out> get $asClinicPlanModel =>
      $base.as((v, t, t2) => _ClinicPlanModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ClinicPlanModelCopyWith<$R, $In extends ClinicPlanModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PlanFeaturesModelCopyWith<$R, PlanFeaturesModel, PlanFeaturesModel>
  get features;
  $R call({
    String? id,
    String? clinicId,
    String? planName,
    String? planType,
    String? planDuration,
    int? callCredits,
    String? price,
    String? currency,
    int? durationDays,
    bool? isActive,
    bool? isDeleted,
    bool? isDefault,
    String? description,
    PlanFeaturesModel? features,
    String? createdAt,
    String? updatedAt,
    bool? isSubscribed,
    bool? isAlreadyBought,
    dynamic subscription,
    String? priceDisplay,
    String? durationDisplay,
  });
  ClinicPlanModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ClinicPlanModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ClinicPlanModel, $Out>
    implements ClinicPlanModelCopyWith<$R, ClinicPlanModel, $Out> {
  _ClinicPlanModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ClinicPlanModel> $mapper =
      ClinicPlanModelMapper.ensureInitialized();
  @override
  PlanFeaturesModelCopyWith<$R, PlanFeaturesModel, PlanFeaturesModel>
  get features => $value.features.copyWith.$chain((v) => call(features: v));
  @override
  $R call({
    String? id,
    String? clinicId,
    String? planName,
    String? planType,
    String? planDuration,
    int? callCredits,
    String? price,
    String? currency,
    int? durationDays,
    bool? isActive,
    bool? isDeleted,
    bool? isDefault,
    String? description,
    PlanFeaturesModel? features,
    String? createdAt,
    String? updatedAt,
    bool? isSubscribed,
    bool? isAlreadyBought,
    Object? subscription = $none,
    String? priceDisplay,
    String? durationDisplay,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (clinicId != null) #clinicId: clinicId,
      if (planName != null) #planName: planName,
      if (planType != null) #planType: planType,
      if (planDuration != null) #planDuration: planDuration,
      if (callCredits != null) #callCredits: callCredits,
      if (price != null) #price: price,
      if (currency != null) #currency: currency,
      if (durationDays != null) #durationDays: durationDays,
      if (isActive != null) #isActive: isActive,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (isDefault != null) #isDefault: isDefault,
      if (description != null) #description: description,
      if (features != null) #features: features,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
      if (isSubscribed != null) #isSubscribed: isSubscribed,
      if (isAlreadyBought != null) #isAlreadyBought: isAlreadyBought,
      if (subscription != $none) #subscription: subscription,
      if (priceDisplay != null) #priceDisplay: priceDisplay,
      if (durationDisplay != null) #durationDisplay: durationDisplay,
    }),
  );
  @override
  ClinicPlanModel $make(CopyWithData data) => ClinicPlanModel(
    id: data.get(#id, or: $value.id),
    clinicId: data.get(#clinicId, or: $value.clinicId),
    planName: data.get(#planName, or: $value.planName),
    planType: data.get(#planType, or: $value.planType),
    planDuration: data.get(#planDuration, or: $value.planDuration),
    callCredits: data.get(#callCredits, or: $value.callCredits),
    price: data.get(#price, or: $value.price),
    currency: data.get(#currency, or: $value.currency),
    durationDays: data.get(#durationDays, or: $value.durationDays),
    isActive: data.get(#isActive, or: $value.isActive),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    isDefault: data.get(#isDefault, or: $value.isDefault),
    description: data.get(#description, or: $value.description),
    features: data.get(#features, or: $value.features),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    isSubscribed: data.get(#isSubscribed, or: $value.isSubscribed),
    isAlreadyBought: data.get(#isAlreadyBought, or: $value.isAlreadyBought),
    subscription: data.get(#subscription, or: $value.subscription),
    priceDisplay: data.get(#priceDisplay, or: $value.priceDisplay),
    durationDisplay: data.get(#durationDisplay, or: $value.durationDisplay),
  );

  @override
  ClinicPlanModelCopyWith<$R2, ClinicPlanModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ClinicPlanModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PlanFeaturesModelMapper extends ClassMapperBase<PlanFeaturesModel> {
  PlanFeaturesModelMapper._();

  static PlanFeaturesModelMapper? _instance;
  static PlanFeaturesModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PlanFeaturesModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PlanFeaturesModel';

  static int _$videoCalls(PlanFeaturesModel v) => v.videoCalls;
  static const Field<PlanFeaturesModel, int> _f$videoCalls = Field(
    'videoCalls',
    _$videoCalls,
    key: r'video_calls',
    opt: true,
    def: 0,
  );
  static bool _$medicalRecords(PlanFeaturesModel v) => v.medicalRecords;
  static const Field<PlanFeaturesModel, bool> _f$medicalRecords = Field(
    'medicalRecords',
    _$medicalRecords,
    key: r'medical_records',
    opt: true,
    def: false,
  );
  static bool _$prioritySupport(PlanFeaturesModel v) => v.prioritySupport;
  static const Field<PlanFeaturesModel, bool> _f$prioritySupport = Field(
    'prioritySupport',
    _$prioritySupport,
    key: r'priority_support',
    opt: true,
    def: false,
  );
  static bool _$appointmentBooking(PlanFeaturesModel v) => v.appointmentBooking;
  static const Field<PlanFeaturesModel, bool> _f$appointmentBooking = Field(
    'appointmentBooking',
    _$appointmentBooking,
    key: r'appointment_booking',
    opt: true,
    def: false,
  );
  static String _$homeVisitDiscount(PlanFeaturesModel v) => v.homeVisitDiscount;
  static const Field<PlanFeaturesModel, String> _f$homeVisitDiscount = Field(
    'homeVisitDiscount',
    _$homeVisitDiscount,
    key: r'home_visit_discount',
    opt: true,
    def: '',
  );
  static bool _$prescriptionAccess(PlanFeaturesModel v) => v.prescriptionAccess;
  static const Field<PlanFeaturesModel, bool> _f$prescriptionAccess = Field(
    'prescriptionAccess',
    _$prescriptionAccess,
    key: r'prescription_access',
    opt: true,
    def: false,
  );
  static bool _$consultationReminders(PlanFeaturesModel v) =>
      v.consultationReminders;
  static const Field<PlanFeaturesModel, bool> _f$consultationReminders = Field(
    'consultationReminders',
    _$consultationReminders,
    key: r'consultation_reminders',
    opt: true,
    def: false,
  );
  static bool _$freeYearlyCheckup(PlanFeaturesModel v) => v.freeYearlyCheckup;
  static const Field<PlanFeaturesModel, bool> _f$freeYearlyCheckup = Field(
    'freeYearlyCheckup',
    _$freeYearlyCheckup,
    key: r'free_yearly_checkup',
    opt: true,
    def: false,
  );

  @override
  final MappableFields<PlanFeaturesModel> fields = const {
    #videoCalls: _f$videoCalls,
    #medicalRecords: _f$medicalRecords,
    #prioritySupport: _f$prioritySupport,
    #appointmentBooking: _f$appointmentBooking,
    #homeVisitDiscount: _f$homeVisitDiscount,
    #prescriptionAccess: _f$prescriptionAccess,
    #consultationReminders: _f$consultationReminders,
    #freeYearlyCheckup: _f$freeYearlyCheckup,
  };

  static PlanFeaturesModel _instantiate(DecodingData data) {
    return PlanFeaturesModel(
      videoCalls: data.dec(_f$videoCalls),
      medicalRecords: data.dec(_f$medicalRecords),
      prioritySupport: data.dec(_f$prioritySupport),
      appointmentBooking: data.dec(_f$appointmentBooking),
      homeVisitDiscount: data.dec(_f$homeVisitDiscount),
      prescriptionAccess: data.dec(_f$prescriptionAccess),
      consultationReminders: data.dec(_f$consultationReminders),
      freeYearlyCheckup: data.dec(_f$freeYearlyCheckup),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PlanFeaturesModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PlanFeaturesModel>(map);
  }

  static PlanFeaturesModel fromJson(String json) {
    return ensureInitialized().decodeJson<PlanFeaturesModel>(json);
  }
}

mixin PlanFeaturesModelMappable {
  String toJson() {
    return PlanFeaturesModelMapper.ensureInitialized()
        .encodeJson<PlanFeaturesModel>(this as PlanFeaturesModel);
  }

  Map<String, dynamic> toMap() {
    return PlanFeaturesModelMapper.ensureInitialized()
        .encodeMap<PlanFeaturesModel>(this as PlanFeaturesModel);
  }

  PlanFeaturesModelCopyWith<
    PlanFeaturesModel,
    PlanFeaturesModel,
    PlanFeaturesModel
  >
  get copyWith =>
      _PlanFeaturesModelCopyWithImpl<PlanFeaturesModel, PlanFeaturesModel>(
        this as PlanFeaturesModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PlanFeaturesModelMapper.ensureInitialized().stringifyValue(
      this as PlanFeaturesModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return PlanFeaturesModelMapper.ensureInitialized().equalsValue(
      this as PlanFeaturesModel,
      other,
    );
  }

  @override
  int get hashCode {
    return PlanFeaturesModelMapper.ensureInitialized().hashValue(
      this as PlanFeaturesModel,
    );
  }
}

extension PlanFeaturesModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PlanFeaturesModel, $Out> {
  PlanFeaturesModelCopyWith<$R, PlanFeaturesModel, $Out>
  get $asPlanFeaturesModel => $base.as(
    (v, t, t2) => _PlanFeaturesModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class PlanFeaturesModelCopyWith<
  $R,
  $In extends PlanFeaturesModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? videoCalls,
    bool? medicalRecords,
    bool? prioritySupport,
    bool? appointmentBooking,
    String? homeVisitDiscount,
    bool? prescriptionAccess,
    bool? consultationReminders,
    bool? freeYearlyCheckup,
  });
  PlanFeaturesModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PlanFeaturesModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PlanFeaturesModel, $Out>
    implements PlanFeaturesModelCopyWith<$R, PlanFeaturesModel, $Out> {
  _PlanFeaturesModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PlanFeaturesModel> $mapper =
      PlanFeaturesModelMapper.ensureInitialized();
  @override
  $R call({
    int? videoCalls,
    bool? medicalRecords,
    bool? prioritySupport,
    bool? appointmentBooking,
    String? homeVisitDiscount,
    bool? prescriptionAccess,
    bool? consultationReminders,
    bool? freeYearlyCheckup,
  }) => $apply(
    FieldCopyWithData({
      if (videoCalls != null) #videoCalls: videoCalls,
      if (medicalRecords != null) #medicalRecords: medicalRecords,
      if (prioritySupport != null) #prioritySupport: prioritySupport,
      if (appointmentBooking != null) #appointmentBooking: appointmentBooking,
      if (homeVisitDiscount != null) #homeVisitDiscount: homeVisitDiscount,
      if (prescriptionAccess != null) #prescriptionAccess: prescriptionAccess,
      if (consultationReminders != null)
        #consultationReminders: consultationReminders,
      if (freeYearlyCheckup != null) #freeYearlyCheckup: freeYearlyCheckup,
    }),
  );
  @override
  PlanFeaturesModel $make(CopyWithData data) => PlanFeaturesModel(
    videoCalls: data.get(#videoCalls, or: $value.videoCalls),
    medicalRecords: data.get(#medicalRecords, or: $value.medicalRecords),
    prioritySupport: data.get(#prioritySupport, or: $value.prioritySupport),
    appointmentBooking: data.get(
      #appointmentBooking,
      or: $value.appointmentBooking,
    ),
    homeVisitDiscount: data.get(
      #homeVisitDiscount,
      or: $value.homeVisitDiscount,
    ),
    prescriptionAccess: data.get(
      #prescriptionAccess,
      or: $value.prescriptionAccess,
    ),
    consultationReminders: data.get(
      #consultationReminders,
      or: $value.consultationReminders,
    ),
    freeYearlyCheckup: data.get(
      #freeYearlyCheckup,
      or: $value.freeYearlyCheckup,
    ),
  );

  @override
  PlanFeaturesModelCopyWith<$R2, PlanFeaturesModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PlanFeaturesModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ActiveSubscriptionModelMapper
    extends ClassMapperBase<ActiveSubscriptionModel> {
  ActiveSubscriptionModelMapper._();

  static ActiveSubscriptionModelMapper? _instance;
  static ActiveSubscriptionModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = ActiveSubscriptionModelMapper._(),
      );
      SubscriptionPlanInfoModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ActiveSubscriptionModel';

  static String _$id(ActiveSubscriptionModel v) => v.id;
  static const Field<ActiveSubscriptionModel, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$userId(ActiveSubscriptionModel v) => v.userId;
  static const Field<ActiveSubscriptionModel, String> _f$userId = Field(
    'userId',
    _$userId,
    key: r'user_id',
    opt: true,
    def: '',
  );
  static String _$petId(ActiveSubscriptionModel v) => v.petId;
  static const Field<ActiveSubscriptionModel, String> _f$petId = Field(
    'petId',
    _$petId,
    key: r'pet_id',
    opt: true,
    def: '',
  );
  static String _$clinicId(ActiveSubscriptionModel v) => v.clinicId;
  static const Field<ActiveSubscriptionModel, String> _f$clinicId = Field(
    'clinicId',
    _$clinicId,
    key: r'clinic_id',
    opt: true,
    def: '',
  );
  static String _$planId(ActiveSubscriptionModel v) => v.planId;
  static const Field<ActiveSubscriptionModel, String> _f$planId = Field(
    'planId',
    _$planId,
    key: r'plan_id',
    opt: true,
    def: '',
  );
  static String _$orderId(ActiveSubscriptionModel v) => v.orderId;
  static const Field<ActiveSubscriptionModel, String> _f$orderId = Field(
    'orderId',
    _$orderId,
    key: r'order_id',
    opt: true,
    def: '',
  );
  static String _$planName(ActiveSubscriptionModel v) => v.planName;
  static const Field<ActiveSubscriptionModel, String> _f$planName = Field(
    'planName',
    _$planName,
    key: r'plan_name',
    opt: true,
    def: '',
  );
  static String _$planType(ActiveSubscriptionModel v) => v.planType;
  static const Field<ActiveSubscriptionModel, String> _f$planType = Field(
    'planType',
    _$planType,
    key: r'plan_type',
    opt: true,
    def: '',
  );
  static String _$planDuration(ActiveSubscriptionModel v) => v.planDuration;
  static const Field<ActiveSubscriptionModel, String> _f$planDuration = Field(
    'planDuration',
    _$planDuration,
    key: r'plan_duration',
    opt: true,
    def: '',
  );
  static int _$totalCallCredits(ActiveSubscriptionModel v) =>
      v.totalCallCredits;
  static const Field<ActiveSubscriptionModel, int> _f$totalCallCredits = Field(
    'totalCallCredits',
    _$totalCallCredits,
    key: r'total_call_credits',
    opt: true,
    def: 0,
  );
  static int _$remainingCallCredits(ActiveSubscriptionModel v) =>
      v.remainingCallCredits;
  static const Field<ActiveSubscriptionModel, int> _f$remainingCallCredits =
      Field(
        'remainingCallCredits',
        _$remainingCallCredits,
        key: r'remaining_call_credits',
        opt: true,
        def: 0,
      );
  static String _$pricePaid(ActiveSubscriptionModel v) => v.pricePaid;
  static const Field<ActiveSubscriptionModel, String> _f$pricePaid = Field(
    'pricePaid',
    _$pricePaid,
    key: r'price_paid',
    opt: true,
    def: '',
  );
  static String _$currency(ActiveSubscriptionModel v) => v.currency;
  static const Field<ActiveSubscriptionModel, String> _f$currency = Field(
    'currency',
    _$currency,
    opt: true,
    def: '',
  );
  static String _$startDate(ActiveSubscriptionModel v) => v.startDate;
  static const Field<ActiveSubscriptionModel, String> _f$startDate = Field(
    'startDate',
    _$startDate,
    key: r'start_date',
    opt: true,
    def: '',
  );
  static String _$endDate(ActiveSubscriptionModel v) => v.endDate;
  static const Field<ActiveSubscriptionModel, String> _f$endDate = Field(
    'endDate',
    _$endDate,
    key: r'end_date',
    opt: true,
    def: '',
  );
  static String _$status(ActiveSubscriptionModel v) => v.status;
  static const Field<ActiveSubscriptionModel, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
    def: '',
  );
  static String _$purchaseDate(ActiveSubscriptionModel v) => v.purchaseDate;
  static const Field<ActiveSubscriptionModel, String> _f$purchaseDate = Field(
    'purchaseDate',
    _$purchaseDate,
    key: r'purchase_date',
    opt: true,
    def: '',
  );
  static String _$createdAt(ActiveSubscriptionModel v) => v.createdAt;
  static const Field<ActiveSubscriptionModel, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    key: r'created_at',
    opt: true,
    def: '',
  );
  static String _$updatedAt(ActiveSubscriptionModel v) => v.updatedAt;
  static const Field<ActiveSubscriptionModel, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    key: r'updated_at',
    opt: true,
    def: '',
  );
  static SubscriptionPlanInfoModel _$plan(ActiveSubscriptionModel v) => v.plan;
  static const Field<ActiveSubscriptionModel, SubscriptionPlanInfoModel>
  _f$plan = Field(
    'plan',
    _$plan,
    opt: true,
    def: const SubscriptionPlanInfoModel(),
  );

  @override
  final MappableFields<ActiveSubscriptionModel> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #petId: _f$petId,
    #clinicId: _f$clinicId,
    #planId: _f$planId,
    #orderId: _f$orderId,
    #planName: _f$planName,
    #planType: _f$planType,
    #planDuration: _f$planDuration,
    #totalCallCredits: _f$totalCallCredits,
    #remainingCallCredits: _f$remainingCallCredits,
    #pricePaid: _f$pricePaid,
    #currency: _f$currency,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
    #status: _f$status,
    #purchaseDate: _f$purchaseDate,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #plan: _f$plan,
  };

  static ActiveSubscriptionModel _instantiate(DecodingData data) {
    return ActiveSubscriptionModel(
      id: data.dec(_f$id),
      userId: data.dec(_f$userId),
      petId: data.dec(_f$petId),
      clinicId: data.dec(_f$clinicId),
      planId: data.dec(_f$planId),
      orderId: data.dec(_f$orderId),
      planName: data.dec(_f$planName),
      planType: data.dec(_f$planType),
      planDuration: data.dec(_f$planDuration),
      totalCallCredits: data.dec(_f$totalCallCredits),
      remainingCallCredits: data.dec(_f$remainingCallCredits),
      pricePaid: data.dec(_f$pricePaid),
      currency: data.dec(_f$currency),
      startDate: data.dec(_f$startDate),
      endDate: data.dec(_f$endDate),
      status: data.dec(_f$status),
      purchaseDate: data.dec(_f$purchaseDate),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      plan: data.dec(_f$plan),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ActiveSubscriptionModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ActiveSubscriptionModel>(map);
  }

  static ActiveSubscriptionModel fromJson(String json) {
    return ensureInitialized().decodeJson<ActiveSubscriptionModel>(json);
  }
}

mixin ActiveSubscriptionModelMappable {
  String toJson() {
    return ActiveSubscriptionModelMapper.ensureInitialized()
        .encodeJson<ActiveSubscriptionModel>(this as ActiveSubscriptionModel);
  }

  Map<String, dynamic> toMap() {
    return ActiveSubscriptionModelMapper.ensureInitialized()
        .encodeMap<ActiveSubscriptionModel>(this as ActiveSubscriptionModel);
  }

  ActiveSubscriptionModelCopyWith<
    ActiveSubscriptionModel,
    ActiveSubscriptionModel,
    ActiveSubscriptionModel
  >
  get copyWith =>
      _ActiveSubscriptionModelCopyWithImpl<
        ActiveSubscriptionModel,
        ActiveSubscriptionModel
      >(this as ActiveSubscriptionModel, $identity, $identity);
  @override
  String toString() {
    return ActiveSubscriptionModelMapper.ensureInitialized().stringifyValue(
      this as ActiveSubscriptionModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ActiveSubscriptionModelMapper.ensureInitialized().equalsValue(
      this as ActiveSubscriptionModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ActiveSubscriptionModelMapper.ensureInitialized().hashValue(
      this as ActiveSubscriptionModel,
    );
  }
}

extension ActiveSubscriptionModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ActiveSubscriptionModel, $Out> {
  ActiveSubscriptionModelCopyWith<$R, ActiveSubscriptionModel, $Out>
  get $asActiveSubscriptionModel => $base.as(
    (v, t, t2) => _ActiveSubscriptionModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ActiveSubscriptionModelCopyWith<
  $R,
  $In extends ActiveSubscriptionModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  SubscriptionPlanInfoModelCopyWith<
    $R,
    SubscriptionPlanInfoModel,
    SubscriptionPlanInfoModel
  >
  get plan;
  $R call({
    String? id,
    String? userId,
    String? petId,
    String? clinicId,
    String? planId,
    String? orderId,
    String? planName,
    String? planType,
    String? planDuration,
    int? totalCallCredits,
    int? remainingCallCredits,
    String? pricePaid,
    String? currency,
    String? startDate,
    String? endDate,
    String? status,
    String? purchaseDate,
    String? createdAt,
    String? updatedAt,
    SubscriptionPlanInfoModel? plan,
  });
  ActiveSubscriptionModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ActiveSubscriptionModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ActiveSubscriptionModel, $Out>
    implements
        ActiveSubscriptionModelCopyWith<$R, ActiveSubscriptionModel, $Out> {
  _ActiveSubscriptionModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ActiveSubscriptionModel> $mapper =
      ActiveSubscriptionModelMapper.ensureInitialized();
  @override
  SubscriptionPlanInfoModelCopyWith<
    $R,
    SubscriptionPlanInfoModel,
    SubscriptionPlanInfoModel
  >
  get plan => $value.plan.copyWith.$chain((v) => call(plan: v));
  @override
  $R call({
    String? id,
    String? userId,
    String? petId,
    String? clinicId,
    String? planId,
    String? orderId,
    String? planName,
    String? planType,
    String? planDuration,
    int? totalCallCredits,
    int? remainingCallCredits,
    String? pricePaid,
    String? currency,
    String? startDate,
    String? endDate,
    String? status,
    String? purchaseDate,
    String? createdAt,
    String? updatedAt,
    SubscriptionPlanInfoModel? plan,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (userId != null) #userId: userId,
      if (petId != null) #petId: petId,
      if (clinicId != null) #clinicId: clinicId,
      if (planId != null) #planId: planId,
      if (orderId != null) #orderId: orderId,
      if (planName != null) #planName: planName,
      if (planType != null) #planType: planType,
      if (planDuration != null) #planDuration: planDuration,
      if (totalCallCredits != null) #totalCallCredits: totalCallCredits,
      if (remainingCallCredits != null)
        #remainingCallCredits: remainingCallCredits,
      if (pricePaid != null) #pricePaid: pricePaid,
      if (currency != null) #currency: currency,
      if (startDate != null) #startDate: startDate,
      if (endDate != null) #endDate: endDate,
      if (status != null) #status: status,
      if (purchaseDate != null) #purchaseDate: purchaseDate,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
      if (plan != null) #plan: plan,
    }),
  );
  @override
  ActiveSubscriptionModel $make(CopyWithData data) => ActiveSubscriptionModel(
    id: data.get(#id, or: $value.id),
    userId: data.get(#userId, or: $value.userId),
    petId: data.get(#petId, or: $value.petId),
    clinicId: data.get(#clinicId, or: $value.clinicId),
    planId: data.get(#planId, or: $value.planId),
    orderId: data.get(#orderId, or: $value.orderId),
    planName: data.get(#planName, or: $value.planName),
    planType: data.get(#planType, or: $value.planType),
    planDuration: data.get(#planDuration, or: $value.planDuration),
    totalCallCredits: data.get(#totalCallCredits, or: $value.totalCallCredits),
    remainingCallCredits: data.get(
      #remainingCallCredits,
      or: $value.remainingCallCredits,
    ),
    pricePaid: data.get(#pricePaid, or: $value.pricePaid),
    currency: data.get(#currency, or: $value.currency),
    startDate: data.get(#startDate, or: $value.startDate),
    endDate: data.get(#endDate, or: $value.endDate),
    status: data.get(#status, or: $value.status),
    purchaseDate: data.get(#purchaseDate, or: $value.purchaseDate),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    plan: data.get(#plan, or: $value.plan),
  );

  @override
  ActiveSubscriptionModelCopyWith<$R2, ActiveSubscriptionModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ActiveSubscriptionModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class SubscriptionPlanInfoModelMapper
    extends ClassMapperBase<SubscriptionPlanInfoModel> {
  SubscriptionPlanInfoModelMapper._();

  static SubscriptionPlanInfoModelMapper? _instance;
  static SubscriptionPlanInfoModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = SubscriptionPlanInfoModelMapper._(),
      );
      PlanFeaturesModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SubscriptionPlanInfoModel';

  static String _$id(SubscriptionPlanInfoModel v) => v.id;
  static const Field<SubscriptionPlanInfoModel, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$planName(SubscriptionPlanInfoModel v) => v.planName;
  static const Field<SubscriptionPlanInfoModel, String> _f$planName = Field(
    'planName',
    _$planName,
    key: r'plan_name',
    opt: true,
    def: '',
  );
  static String _$planType(SubscriptionPlanInfoModel v) => v.planType;
  static const Field<SubscriptionPlanInfoModel, String> _f$planType = Field(
    'planType',
    _$planType,
    key: r'plan_type',
    opt: true,
    def: '',
  );
  static PlanFeaturesModel _$features(SubscriptionPlanInfoModel v) =>
      v.features;
  static const Field<SubscriptionPlanInfoModel, PlanFeaturesModel> _f$features =
      Field('features', _$features, opt: true, def: const PlanFeaturesModel());

  @override
  final MappableFields<SubscriptionPlanInfoModel> fields = const {
    #id: _f$id,
    #planName: _f$planName,
    #planType: _f$planType,
    #features: _f$features,
  };

  static SubscriptionPlanInfoModel _instantiate(DecodingData data) {
    return SubscriptionPlanInfoModel(
      id: data.dec(_f$id),
      planName: data.dec(_f$planName),
      planType: data.dec(_f$planType),
      features: data.dec(_f$features),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SubscriptionPlanInfoModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SubscriptionPlanInfoModel>(map);
  }

  static SubscriptionPlanInfoModel fromJson(String json) {
    return ensureInitialized().decodeJson<SubscriptionPlanInfoModel>(json);
  }
}

mixin SubscriptionPlanInfoModelMappable {
  String toJson() {
    return SubscriptionPlanInfoModelMapper.ensureInitialized()
        .encodeJson<SubscriptionPlanInfoModel>(
          this as SubscriptionPlanInfoModel,
        );
  }

  Map<String, dynamic> toMap() {
    return SubscriptionPlanInfoModelMapper.ensureInitialized()
        .encodeMap<SubscriptionPlanInfoModel>(
          this as SubscriptionPlanInfoModel,
        );
  }

  SubscriptionPlanInfoModelCopyWith<
    SubscriptionPlanInfoModel,
    SubscriptionPlanInfoModel,
    SubscriptionPlanInfoModel
  >
  get copyWith =>
      _SubscriptionPlanInfoModelCopyWithImpl<
        SubscriptionPlanInfoModel,
        SubscriptionPlanInfoModel
      >(this as SubscriptionPlanInfoModel, $identity, $identity);
  @override
  String toString() {
    return SubscriptionPlanInfoModelMapper.ensureInitialized().stringifyValue(
      this as SubscriptionPlanInfoModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return SubscriptionPlanInfoModelMapper.ensureInitialized().equalsValue(
      this as SubscriptionPlanInfoModel,
      other,
    );
  }

  @override
  int get hashCode {
    return SubscriptionPlanInfoModelMapper.ensureInitialized().hashValue(
      this as SubscriptionPlanInfoModel,
    );
  }
}

extension SubscriptionPlanInfoModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SubscriptionPlanInfoModel, $Out> {
  SubscriptionPlanInfoModelCopyWith<$R, SubscriptionPlanInfoModel, $Out>
  get $asSubscriptionPlanInfoModel => $base.as(
    (v, t, t2) => _SubscriptionPlanInfoModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class SubscriptionPlanInfoModelCopyWith<
  $R,
  $In extends SubscriptionPlanInfoModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  PlanFeaturesModelCopyWith<$R, PlanFeaturesModel, PlanFeaturesModel>
  get features;
  $R call({
    String? id,
    String? planName,
    String? planType,
    PlanFeaturesModel? features,
  });
  SubscriptionPlanInfoModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _SubscriptionPlanInfoModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SubscriptionPlanInfoModel, $Out>
    implements
        SubscriptionPlanInfoModelCopyWith<$R, SubscriptionPlanInfoModel, $Out> {
  _SubscriptionPlanInfoModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SubscriptionPlanInfoModel> $mapper =
      SubscriptionPlanInfoModelMapper.ensureInitialized();
  @override
  PlanFeaturesModelCopyWith<$R, PlanFeaturesModel, PlanFeaturesModel>
  get features => $value.features.copyWith.$chain((v) => call(features: v));
  @override
  $R call({
    String? id,
    String? planName,
    String? planType,
    PlanFeaturesModel? features,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (planName != null) #planName: planName,
      if (planType != null) #planType: planType,
      if (features != null) #features: features,
    }),
  );
  @override
  SubscriptionPlanInfoModel $make(CopyWithData data) =>
      SubscriptionPlanInfoModel(
        id: data.get(#id, or: $value.id),
        planName: data.get(#planName, or: $value.planName),
        planType: data.get(#planType, or: $value.planType),
        features: data.get(#features, or: $value.features),
      );

  @override
  SubscriptionPlanInfoModelCopyWith<$R2, SubscriptionPlanInfoModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SubscriptionPlanInfoModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class SubscriptionMetaMapper extends ClassMapperBase<SubscriptionMeta> {
  SubscriptionMetaMapper._();

  static SubscriptionMetaMapper? _instance;
  static SubscriptionMetaMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SubscriptionMetaMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SubscriptionMeta';

  static String _$lang(SubscriptionMeta v) => v.lang;
  static const Field<SubscriptionMeta, String> _f$lang = Field(
    'lang',
    _$lang,
    opt: true,
    def: '',
  );
  static String _$timestamp(SubscriptionMeta v) => v.timestamp;
  static const Field<SubscriptionMeta, String> _f$timestamp = Field(
    'timestamp',
    _$timestamp,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<SubscriptionMeta> fields = const {
    #lang: _f$lang,
    #timestamp: _f$timestamp,
  };

  static SubscriptionMeta _instantiate(DecodingData data) {
    return SubscriptionMeta(
      lang: data.dec(_f$lang),
      timestamp: data.dec(_f$timestamp),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SubscriptionMeta fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SubscriptionMeta>(map);
  }

  static SubscriptionMeta fromJson(String json) {
    return ensureInitialized().decodeJson<SubscriptionMeta>(json);
  }
}

mixin SubscriptionMetaMappable {
  String toJson() {
    return SubscriptionMetaMapper.ensureInitialized()
        .encodeJson<SubscriptionMeta>(this as SubscriptionMeta);
  }

  Map<String, dynamic> toMap() {
    return SubscriptionMetaMapper.ensureInitialized()
        .encodeMap<SubscriptionMeta>(this as SubscriptionMeta);
  }

  SubscriptionMetaCopyWith<SubscriptionMeta, SubscriptionMeta, SubscriptionMeta>
  get copyWith =>
      _SubscriptionMetaCopyWithImpl<SubscriptionMeta, SubscriptionMeta>(
        this as SubscriptionMeta,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SubscriptionMetaMapper.ensureInitialized().stringifyValue(
      this as SubscriptionMeta,
    );
  }

  @override
  bool operator ==(Object other) {
    return SubscriptionMetaMapper.ensureInitialized().equalsValue(
      this as SubscriptionMeta,
      other,
    );
  }

  @override
  int get hashCode {
    return SubscriptionMetaMapper.ensureInitialized().hashValue(
      this as SubscriptionMeta,
    );
  }
}

extension SubscriptionMetaValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SubscriptionMeta, $Out> {
  SubscriptionMetaCopyWith<$R, SubscriptionMeta, $Out>
  get $asSubscriptionMeta =>
      $base.as((v, t, t2) => _SubscriptionMetaCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SubscriptionMetaCopyWith<$R, $In extends SubscriptionMeta, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? lang, String? timestamp});
  SubscriptionMetaCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _SubscriptionMetaCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SubscriptionMeta, $Out>
    implements SubscriptionMetaCopyWith<$R, SubscriptionMeta, $Out> {
  _SubscriptionMetaCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SubscriptionMeta> $mapper =
      SubscriptionMetaMapper.ensureInitialized();
  @override
  $R call({String? lang, String? timestamp}) => $apply(
    FieldCopyWithData({
      if (lang != null) #lang: lang,
      if (timestamp != null) #timestamp: timestamp,
    }),
  );
  @override
  SubscriptionMeta $make(CopyWithData data) => SubscriptionMeta(
    lang: data.get(#lang, or: $value.lang),
    timestamp: data.get(#timestamp, or: $value.timestamp),
  );

  @override
  SubscriptionMetaCopyWith<$R2, SubscriptionMeta, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SubscriptionMetaCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

