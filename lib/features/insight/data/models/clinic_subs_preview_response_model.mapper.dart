// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'clinic_subs_preview_response_model.dart';

class ClinicSubsPreviewResponseModelMapper
    extends ClassMapperBase<ClinicSubsPreviewResponseModel> {
  ClinicSubsPreviewResponseModelMapper._();

  static ClinicSubsPreviewResponseModelMapper? _instance;
  static ClinicSubsPreviewResponseModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = ClinicSubsPreviewResponseModelMapper._(),
      );
      ClinicSubsDataMapper.ensureInitialized();
      ClinicSubsMetaMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ClinicSubsPreviewResponseModel';

  static bool _$success(ClinicSubsPreviewResponseModel v) => v.success;
  static const Field<ClinicSubsPreviewResponseModel, bool> _f$success = Field(
    'success',
    _$success,
    opt: true,
    def: false,
  );
  static String _$message(ClinicSubsPreviewResponseModel v) => v.message;
  static const Field<ClinicSubsPreviewResponseModel, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
    def: '',
  );
  static int _$status(ClinicSubsPreviewResponseModel v) => v.status;
  static const Field<ClinicSubsPreviewResponseModel, int> _f$status = Field(
    'status',
    _$status,
    opt: true,
    def: 0,
  );
  static ClinicSubsData _$data(ClinicSubsPreviewResponseModel v) => v.data;
  static const Field<ClinicSubsPreviewResponseModel, ClinicSubsData> _f$data =
      Field('data', _$data, opt: true, def: const ClinicSubsData());
  static ClinicSubsMeta _$meta(ClinicSubsPreviewResponseModel v) => v.meta;
  static const Field<ClinicSubsPreviewResponseModel, ClinicSubsMeta> _f$meta =
      Field('meta', _$meta, opt: true, def: const ClinicSubsMeta());

  @override
  final MappableFields<ClinicSubsPreviewResponseModel> fields = const {
    #success: _f$success,
    #message: _f$message,
    #status: _f$status,
    #data: _f$data,
    #meta: _f$meta,
  };

  static ClinicSubsPreviewResponseModel _instantiate(DecodingData data) {
    return ClinicSubsPreviewResponseModel(
      success: data.dec(_f$success),
      message: data.dec(_f$message),
      status: data.dec(_f$status),
      data: data.dec(_f$data),
      meta: data.dec(_f$meta),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ClinicSubsPreviewResponseModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ClinicSubsPreviewResponseModel>(map);
  }

  static ClinicSubsPreviewResponseModel fromJson(String json) {
    return ensureInitialized().decodeJson<ClinicSubsPreviewResponseModel>(json);
  }
}

mixin ClinicSubsPreviewResponseModelMappable {
  String toJson() {
    return ClinicSubsPreviewResponseModelMapper.ensureInitialized()
        .encodeJson<ClinicSubsPreviewResponseModel>(
          this as ClinicSubsPreviewResponseModel,
        );
  }

  Map<String, dynamic> toMap() {
    return ClinicSubsPreviewResponseModelMapper.ensureInitialized()
        .encodeMap<ClinicSubsPreviewResponseModel>(
          this as ClinicSubsPreviewResponseModel,
        );
  }

  ClinicSubsPreviewResponseModelCopyWith<
    ClinicSubsPreviewResponseModel,
    ClinicSubsPreviewResponseModel,
    ClinicSubsPreviewResponseModel
  >
  get copyWith =>
      _ClinicSubsPreviewResponseModelCopyWithImpl<
        ClinicSubsPreviewResponseModel,
        ClinicSubsPreviewResponseModel
      >(this as ClinicSubsPreviewResponseModel, $identity, $identity);
  @override
  String toString() {
    return ClinicSubsPreviewResponseModelMapper.ensureInitialized()
        .stringifyValue(this as ClinicSubsPreviewResponseModel);
  }

  @override
  bool operator ==(Object other) {
    return ClinicSubsPreviewResponseModelMapper.ensureInitialized().equalsValue(
      this as ClinicSubsPreviewResponseModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ClinicSubsPreviewResponseModelMapper.ensureInitialized().hashValue(
      this as ClinicSubsPreviewResponseModel,
    );
  }
}

extension ClinicSubsPreviewResponseModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ClinicSubsPreviewResponseModel, $Out> {
  ClinicSubsPreviewResponseModelCopyWith<
    $R,
    ClinicSubsPreviewResponseModel,
    $Out
  >
  get $asClinicSubsPreviewResponseModel => $base.as(
    (v, t, t2) =>
        _ClinicSubsPreviewResponseModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ClinicSubsPreviewResponseModelCopyWith<
  $R,
  $In extends ClinicSubsPreviewResponseModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ClinicSubsDataCopyWith<$R, ClinicSubsData, ClinicSubsData> get data;
  ClinicSubsMetaCopyWith<$R, ClinicSubsMeta, ClinicSubsMeta> get meta;
  $R call({
    bool? success,
    String? message,
    int? status,
    ClinicSubsData? data,
    ClinicSubsMeta? meta,
  });
  ClinicSubsPreviewResponseModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ClinicSubsPreviewResponseModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ClinicSubsPreviewResponseModel, $Out>
    implements
        ClinicSubsPreviewResponseModelCopyWith<
          $R,
          ClinicSubsPreviewResponseModel,
          $Out
        > {
  _ClinicSubsPreviewResponseModelCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<ClinicSubsPreviewResponseModel> $mapper =
      ClinicSubsPreviewResponseModelMapper.ensureInitialized();
  @override
  ClinicSubsDataCopyWith<$R, ClinicSubsData, ClinicSubsData> get data =>
      $value.data.copyWith.$chain((v) => call(data: v));
  @override
  ClinicSubsMetaCopyWith<$R, ClinicSubsMeta, ClinicSubsMeta> get meta =>
      $value.meta.copyWith.$chain((v) => call(meta: v));
  @override
  $R call({
    bool? success,
    String? message,
    int? status,
    ClinicSubsData? data,
    ClinicSubsMeta? meta,
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
  ClinicSubsPreviewResponseModel $make(CopyWithData data) =>
      ClinicSubsPreviewResponseModel(
        success: data.get(#success, or: $value.success),
        message: data.get(#message, or: $value.message),
        status: data.get(#status, or: $value.status),
        data: data.get(#data, or: $value.data),
        meta: data.get(#meta, or: $value.meta),
      );

  @override
  ClinicSubsPreviewResponseModelCopyWith<
    $R2,
    ClinicSubsPreviewResponseModel,
    $Out2
  >
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ClinicSubsPreviewResponseModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ClinicSubsDataMapper extends ClassMapperBase<ClinicSubsData> {
  ClinicSubsDataMapper._();

  static ClinicSubsDataMapper? _instance;
  static ClinicSubsDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ClinicSubsDataMapper._());
      PreviewClinicModelMapper.ensureInitialized();
      ConsultationDetailsModelMapper.ensureInitialized();
      PricingModelMapper.ensureInitialized();
      PreviewAddonModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ClinicSubsData';

  static PreviewClinicModel _$clinic(ClinicSubsData v) => v.clinic;
  static const Field<ClinicSubsData, PreviewClinicModel> _f$clinic = Field(
    'clinic',
    _$clinic,
    opt: true,
    def: const PreviewClinicModel(),
  );
  static dynamic _$vet(ClinicSubsData v) => v.vet;
  static const Field<ClinicSubsData, dynamic> _f$vet = Field(
    'vet',
    _$vet,
    opt: true,
  );
  static ConsultationDetailsModel _$consultationDetails(ClinicSubsData v) =>
      v.consultationDetails;
  static const Field<ClinicSubsData, ConsultationDetailsModel>
  _f$consultationDetails = Field(
    'consultationDetails',
    _$consultationDetails,
    key: r'consultation_details',
    opt: true,
    def: const ConsultationDetailsModel(),
  );
  static PricingModel _$pricing(ClinicSubsData v) => v.pricing;
  static const Field<ClinicSubsData, PricingModel> _f$pricing = Field(
    'pricing',
    _$pricing,
    opt: true,
    def: const PricingModel(),
  );
  static List<PreviewAddonModel> _$addons(ClinicSubsData v) => v.addons;
  static const Field<ClinicSubsData, List<PreviewAddonModel>> _f$addons = Field(
    'addons',
    _$addons,
    opt: true,
    def: const [],
    hook: SafeListHook(),
  );
  static dynamic _$coupon(ClinicSubsData v) => v.coupon;
  static const Field<ClinicSubsData, dynamic> _f$coupon = Field(
    'coupon',
    _$coupon,
    opt: true,
  );
  static bool _$hasActiveSubscription(ClinicSubsData v) =>
      v.hasActiveSubscription;
  static const Field<ClinicSubsData, bool> _f$hasActiveSubscription = Field(
    'hasActiveSubscription',
    _$hasActiveSubscription,
    key: r'has_active_subscription',
    opt: true,
    def: false,
  );
  static dynamic _$activeSubscriptionInfo(ClinicSubsData v) =>
      v.activeSubscriptionInfo;
  static const Field<ClinicSubsData, dynamic> _f$activeSubscriptionInfo = Field(
    'activeSubscriptionInfo',
    _$activeSubscriptionInfo,
    key: r'active_subscription_info',
    opt: true,
  );

  @override
  final MappableFields<ClinicSubsData> fields = const {
    #clinic: _f$clinic,
    #vet: _f$vet,
    #consultationDetails: _f$consultationDetails,
    #pricing: _f$pricing,
    #addons: _f$addons,
    #coupon: _f$coupon,
    #hasActiveSubscription: _f$hasActiveSubscription,
    #activeSubscriptionInfo: _f$activeSubscriptionInfo,
  };

  static ClinicSubsData _instantiate(DecodingData data) {
    return ClinicSubsData(
      clinic: data.dec(_f$clinic),
      vet: data.dec(_f$vet),
      consultationDetails: data.dec(_f$consultationDetails),
      pricing: data.dec(_f$pricing),
      addons: data.dec(_f$addons),
      coupon: data.dec(_f$coupon),
      hasActiveSubscription: data.dec(_f$hasActiveSubscription),
      activeSubscriptionInfo: data.dec(_f$activeSubscriptionInfo),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ClinicSubsData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ClinicSubsData>(map);
  }

  static ClinicSubsData fromJson(String json) {
    return ensureInitialized().decodeJson<ClinicSubsData>(json);
  }
}

mixin ClinicSubsDataMappable {
  String toJson() {
    return ClinicSubsDataMapper.ensureInitialized().encodeJson<ClinicSubsData>(
      this as ClinicSubsData,
    );
  }

  Map<String, dynamic> toMap() {
    return ClinicSubsDataMapper.ensureInitialized().encodeMap<ClinicSubsData>(
      this as ClinicSubsData,
    );
  }

  ClinicSubsDataCopyWith<ClinicSubsData, ClinicSubsData, ClinicSubsData>
  get copyWith => _ClinicSubsDataCopyWithImpl<ClinicSubsData, ClinicSubsData>(
    this as ClinicSubsData,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ClinicSubsDataMapper.ensureInitialized().stringifyValue(
      this as ClinicSubsData,
    );
  }

  @override
  bool operator ==(Object other) {
    return ClinicSubsDataMapper.ensureInitialized().equalsValue(
      this as ClinicSubsData,
      other,
    );
  }

  @override
  int get hashCode {
    return ClinicSubsDataMapper.ensureInitialized().hashValue(
      this as ClinicSubsData,
    );
  }
}

extension ClinicSubsDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ClinicSubsData, $Out> {
  ClinicSubsDataCopyWith<$R, ClinicSubsData, $Out> get $asClinicSubsData =>
      $base.as((v, t, t2) => _ClinicSubsDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ClinicSubsDataCopyWith<$R, $In extends ClinicSubsData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PreviewClinicModelCopyWith<$R, PreviewClinicModel, PreviewClinicModel>
  get clinic;
  ConsultationDetailsModelCopyWith<
    $R,
    ConsultationDetailsModel,
    ConsultationDetailsModel
  >
  get consultationDetails;
  PricingModelCopyWith<$R, PricingModel, PricingModel> get pricing;
  ListCopyWith<
    $R,
    PreviewAddonModel,
    PreviewAddonModelCopyWith<$R, PreviewAddonModel, PreviewAddonModel>
  >
  get addons;
  $R call({
    PreviewClinicModel? clinic,
    dynamic vet,
    ConsultationDetailsModel? consultationDetails,
    PricingModel? pricing,
    List<PreviewAddonModel>? addons,
    dynamic coupon,
    bool? hasActiveSubscription,
    dynamic activeSubscriptionInfo,
  });
  ClinicSubsDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ClinicSubsDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ClinicSubsData, $Out>
    implements ClinicSubsDataCopyWith<$R, ClinicSubsData, $Out> {
  _ClinicSubsDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ClinicSubsData> $mapper =
      ClinicSubsDataMapper.ensureInitialized();
  @override
  PreviewClinicModelCopyWith<$R, PreviewClinicModel, PreviewClinicModel>
  get clinic => $value.clinic.copyWith.$chain((v) => call(clinic: v));
  @override
  ConsultationDetailsModelCopyWith<
    $R,
    ConsultationDetailsModel,
    ConsultationDetailsModel
  >
  get consultationDetails => $value.consultationDetails.copyWith.$chain(
    (v) => call(consultationDetails: v),
  );
  @override
  PricingModelCopyWith<$R, PricingModel, PricingModel> get pricing =>
      $value.pricing.copyWith.$chain((v) => call(pricing: v));
  @override
  ListCopyWith<
    $R,
    PreviewAddonModel,
    PreviewAddonModelCopyWith<$R, PreviewAddonModel, PreviewAddonModel>
  >
  get addons => ListCopyWith(
    $value.addons,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(addons: v),
  );
  @override
  $R call({
    PreviewClinicModel? clinic,
    Object? vet = $none,
    ConsultationDetailsModel? consultationDetails,
    PricingModel? pricing,
    List<PreviewAddonModel>? addons,
    Object? coupon = $none,
    bool? hasActiveSubscription,
    Object? activeSubscriptionInfo = $none,
  }) => $apply(
    FieldCopyWithData({
      if (clinic != null) #clinic: clinic,
      if (vet != $none) #vet: vet,
      if (consultationDetails != null)
        #consultationDetails: consultationDetails,
      if (pricing != null) #pricing: pricing,
      if (addons != null) #addons: addons,
      if (coupon != $none) #coupon: coupon,
      if (hasActiveSubscription != null)
        #hasActiveSubscription: hasActiveSubscription,
      if (activeSubscriptionInfo != $none)
        #activeSubscriptionInfo: activeSubscriptionInfo,
    }),
  );
  @override
  ClinicSubsData $make(CopyWithData data) => ClinicSubsData(
    clinic: data.get(#clinic, or: $value.clinic),
    vet: data.get(#vet, or: $value.vet),
    consultationDetails: data.get(
      #consultationDetails,
      or: $value.consultationDetails,
    ),
    pricing: data.get(#pricing, or: $value.pricing),
    addons: data.get(#addons, or: $value.addons),
    coupon: data.get(#coupon, or: $value.coupon),
    hasActiveSubscription: data.get(
      #hasActiveSubscription,
      or: $value.hasActiveSubscription,
    ),
    activeSubscriptionInfo: data.get(
      #activeSubscriptionInfo,
      or: $value.activeSubscriptionInfo,
    ),
  );

  @override
  ClinicSubsDataCopyWith<$R2, ClinicSubsData, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ClinicSubsDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PreviewClinicModelMapper extends ClassMapperBase<PreviewClinicModel> {
  PreviewClinicModelMapper._();

  static PreviewClinicModelMapper? _instance;
  static PreviewClinicModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PreviewClinicModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PreviewClinicModel';

  static String _$id(PreviewClinicModel v) => v.id;
  static const Field<PreviewClinicModel, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$name(PreviewClinicModel v) => v.name;
  static const Field<PreviewClinicModel, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<PreviewClinicModel> fields = const {
    #id: _f$id,
    #name: _f$name,
  };

  static PreviewClinicModel _instantiate(DecodingData data) {
    return PreviewClinicModel(id: data.dec(_f$id), name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static PreviewClinicModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PreviewClinicModel>(map);
  }

  static PreviewClinicModel fromJson(String json) {
    return ensureInitialized().decodeJson<PreviewClinicModel>(json);
  }
}

mixin PreviewClinicModelMappable {
  String toJson() {
    return PreviewClinicModelMapper.ensureInitialized()
        .encodeJson<PreviewClinicModel>(this as PreviewClinicModel);
  }

  Map<String, dynamic> toMap() {
    return PreviewClinicModelMapper.ensureInitialized()
        .encodeMap<PreviewClinicModel>(this as PreviewClinicModel);
  }

  PreviewClinicModelCopyWith<
    PreviewClinicModel,
    PreviewClinicModel,
    PreviewClinicModel
  >
  get copyWith =>
      _PreviewClinicModelCopyWithImpl<PreviewClinicModel, PreviewClinicModel>(
        this as PreviewClinicModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PreviewClinicModelMapper.ensureInitialized().stringifyValue(
      this as PreviewClinicModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return PreviewClinicModelMapper.ensureInitialized().equalsValue(
      this as PreviewClinicModel,
      other,
    );
  }

  @override
  int get hashCode {
    return PreviewClinicModelMapper.ensureInitialized().hashValue(
      this as PreviewClinicModel,
    );
  }
}

extension PreviewClinicModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PreviewClinicModel, $Out> {
  PreviewClinicModelCopyWith<$R, PreviewClinicModel, $Out>
  get $asPreviewClinicModel => $base.as(
    (v, t, t2) => _PreviewClinicModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class PreviewClinicModelCopyWith<
  $R,
  $In extends PreviewClinicModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name});
  PreviewClinicModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PreviewClinicModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PreviewClinicModel, $Out>
    implements PreviewClinicModelCopyWith<$R, PreviewClinicModel, $Out> {
  _PreviewClinicModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PreviewClinicModel> $mapper =
      PreviewClinicModelMapper.ensureInitialized();
  @override
  $R call({String? id, String? name}) => $apply(
    FieldCopyWithData({if (id != null) #id: id, if (name != null) #name: name}),
  );
  @override
  PreviewClinicModel $make(CopyWithData data) => PreviewClinicModel(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
  );

  @override
  PreviewClinicModelCopyWith<$R2, PreviewClinicModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PreviewClinicModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ConsultationDetailsModelMapper
    extends ClassMapperBase<ConsultationDetailsModel> {
  ConsultationDetailsModelMapper._();

  static ConsultationDetailsModelMapper? _instance;
  static ConsultationDetailsModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = ConsultationDetailsModelMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'ConsultationDetailsModel';

  static String _$type(ConsultationDetailsModel v) => v.type;
  static const Field<ConsultationDetailsModel, String> _f$type = Field(
    'type',
    _$type,
    opt: true,
    def: '',
  );
  static int _$durationMinutes(ConsultationDetailsModel v) => v.durationMinutes;
  static const Field<ConsultationDetailsModel, int> _f$durationMinutes = Field(
    'durationMinutes',
    _$durationMinutes,
    key: r'duration_minutes',
    opt: true,
    def: 0,
  );

  @override
  final MappableFields<ConsultationDetailsModel> fields = const {
    #type: _f$type,
    #durationMinutes: _f$durationMinutes,
  };

  static ConsultationDetailsModel _instantiate(DecodingData data) {
    return ConsultationDetailsModel(
      type: data.dec(_f$type),
      durationMinutes: data.dec(_f$durationMinutes),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ConsultationDetailsModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ConsultationDetailsModel>(map);
  }

  static ConsultationDetailsModel fromJson(String json) {
    return ensureInitialized().decodeJson<ConsultationDetailsModel>(json);
  }
}

mixin ConsultationDetailsModelMappable {
  String toJson() {
    return ConsultationDetailsModelMapper.ensureInitialized()
        .encodeJson<ConsultationDetailsModel>(this as ConsultationDetailsModel);
  }

  Map<String, dynamic> toMap() {
    return ConsultationDetailsModelMapper.ensureInitialized()
        .encodeMap<ConsultationDetailsModel>(this as ConsultationDetailsModel);
  }

  ConsultationDetailsModelCopyWith<
    ConsultationDetailsModel,
    ConsultationDetailsModel,
    ConsultationDetailsModel
  >
  get copyWith =>
      _ConsultationDetailsModelCopyWithImpl<
        ConsultationDetailsModel,
        ConsultationDetailsModel
      >(this as ConsultationDetailsModel, $identity, $identity);
  @override
  String toString() {
    return ConsultationDetailsModelMapper.ensureInitialized().stringifyValue(
      this as ConsultationDetailsModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ConsultationDetailsModelMapper.ensureInitialized().equalsValue(
      this as ConsultationDetailsModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ConsultationDetailsModelMapper.ensureInitialized().hashValue(
      this as ConsultationDetailsModel,
    );
  }
}

extension ConsultationDetailsModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ConsultationDetailsModel, $Out> {
  ConsultationDetailsModelCopyWith<$R, ConsultationDetailsModel, $Out>
  get $asConsultationDetailsModel => $base.as(
    (v, t, t2) => _ConsultationDetailsModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ConsultationDetailsModelCopyWith<
  $R,
  $In extends ConsultationDetailsModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? type, int? durationMinutes});
  ConsultationDetailsModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ConsultationDetailsModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ConsultationDetailsModel, $Out>
    implements
        ConsultationDetailsModelCopyWith<$R, ConsultationDetailsModel, $Out> {
  _ConsultationDetailsModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ConsultationDetailsModel> $mapper =
      ConsultationDetailsModelMapper.ensureInitialized();
  @override
  $R call({String? type, int? durationMinutes}) => $apply(
    FieldCopyWithData({
      if (type != null) #type: type,
      if (durationMinutes != null) #durationMinutes: durationMinutes,
    }),
  );
  @override
  ConsultationDetailsModel $make(CopyWithData data) => ConsultationDetailsModel(
    type: data.get(#type, or: $value.type),
    durationMinutes: data.get(#durationMinutes, or: $value.durationMinutes),
  );

  @override
  ConsultationDetailsModelCopyWith<$R2, ConsultationDetailsModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ConsultationDetailsModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PricingModelMapper extends ClassMapperBase<PricingModel> {
  PricingModelMapper._();

  static PricingModelMapper? _instance;
  static PricingModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PricingModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PricingModel';

  static double _$consultingFee(PricingModel v) => v.consultingFee;
  static const Field<PricingModel, double> _f$consultingFee = Field(
    'consultingFee',
    _$consultingFee,
    key: r'consulting_fee',
    opt: true,
    def: 0,
  );
  static double _$serviceFee(PricingModel v) => v.serviceFee;
  static const Field<PricingModel, double> _f$serviceFee = Field(
    'serviceFee',
    _$serviceFee,
    key: r'service_fee',
    opt: true,
    def: 0,
  );
  static double _$subscriptionAmount(PricingModel v) => v.subscriptionAmount;
  static const Field<PricingModel, double> _f$subscriptionAmount = Field(
    'subscriptionAmount',
    _$subscriptionAmount,
    key: r'subscription_amount',
    opt: true,
    def: 0,
  );
  static double _$taxAmount(PricingModel v) => v.taxAmount;
  static const Field<PricingModel, double> _f$taxAmount = Field(
    'taxAmount',
    _$taxAmount,
    key: r'tax_amount',
    opt: true,
    def: 0,
  );
  static String _$taxRate(PricingModel v) => v.taxRate;
  static const Field<PricingModel, String> _f$taxRate = Field(
    'taxRate',
    _$taxRate,
    key: r'tax_rate',
    opt: true,
    def: '',
  );
  static double _$subtotal(PricingModel v) => v.subtotal;
  static const Field<PricingModel, double> _f$subtotal = Field(
    'subtotal',
    _$subtotal,
    opt: true,
    def: 0,
  );
  static double _$totalAmount(PricingModel v) => v.totalAmount;
  static const Field<PricingModel, double> _f$totalAmount = Field(
    'totalAmount',
    _$totalAmount,
    key: r'total_amount',
    opt: true,
    def: 0,
  );
  static String _$currency(PricingModel v) => v.currency;
  static const Field<PricingModel, String> _f$currency = Field(
    'currency',
    _$currency,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<PricingModel> fields = const {
    #consultingFee: _f$consultingFee,
    #serviceFee: _f$serviceFee,
    #subscriptionAmount: _f$subscriptionAmount,
    #taxAmount: _f$taxAmount,
    #taxRate: _f$taxRate,
    #subtotal: _f$subtotal,
    #totalAmount: _f$totalAmount,
    #currency: _f$currency,
  };

  static PricingModel _instantiate(DecodingData data) {
    return PricingModel(
      consultingFee: data.dec(_f$consultingFee),
      serviceFee: data.dec(_f$serviceFee),
      subscriptionAmount: data.dec(_f$subscriptionAmount),
      taxAmount: data.dec(_f$taxAmount),
      taxRate: data.dec(_f$taxRate),
      subtotal: data.dec(_f$subtotal),
      totalAmount: data.dec(_f$totalAmount),
      currency: data.dec(_f$currency),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PricingModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PricingModel>(map);
  }

  static PricingModel fromJson(String json) {
    return ensureInitialized().decodeJson<PricingModel>(json);
  }
}

mixin PricingModelMappable {
  String toJson() {
    return PricingModelMapper.ensureInitialized().encodeJson<PricingModel>(
      this as PricingModel,
    );
  }

  Map<String, dynamic> toMap() {
    return PricingModelMapper.ensureInitialized().encodeMap<PricingModel>(
      this as PricingModel,
    );
  }

  PricingModelCopyWith<PricingModel, PricingModel, PricingModel> get copyWith =>
      _PricingModelCopyWithImpl<PricingModel, PricingModel>(
        this as PricingModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PricingModelMapper.ensureInitialized().stringifyValue(
      this as PricingModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return PricingModelMapper.ensureInitialized().equalsValue(
      this as PricingModel,
      other,
    );
  }

  @override
  int get hashCode {
    return PricingModelMapper.ensureInitialized().hashValue(
      this as PricingModel,
    );
  }
}

extension PricingModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PricingModel, $Out> {
  PricingModelCopyWith<$R, PricingModel, $Out> get $asPricingModel =>
      $base.as((v, t, t2) => _PricingModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PricingModelCopyWith<$R, $In extends PricingModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    double? consultingFee,
    double? serviceFee,
    double? subscriptionAmount,
    double? taxAmount,
    String? taxRate,
    double? subtotal,
    double? totalAmount,
    String? currency,
  });
  PricingModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PricingModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PricingModel, $Out>
    implements PricingModelCopyWith<$R, PricingModel, $Out> {
  _PricingModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PricingModel> $mapper =
      PricingModelMapper.ensureInitialized();
  @override
  $R call({
    double? consultingFee,
    double? serviceFee,
    double? subscriptionAmount,
    double? taxAmount,
    String? taxRate,
    double? subtotal,
    double? totalAmount,
    String? currency,
  }) => $apply(
    FieldCopyWithData({
      if (consultingFee != null) #consultingFee: consultingFee,
      if (serviceFee != null) #serviceFee: serviceFee,
      if (subscriptionAmount != null) #subscriptionAmount: subscriptionAmount,
      if (taxAmount != null) #taxAmount: taxAmount,
      if (taxRate != null) #taxRate: taxRate,
      if (subtotal != null) #subtotal: subtotal,
      if (totalAmount != null) #totalAmount: totalAmount,
      if (currency != null) #currency: currency,
    }),
  );
  @override
  PricingModel $make(CopyWithData data) => PricingModel(
    consultingFee: data.get(#consultingFee, or: $value.consultingFee),
    serviceFee: data.get(#serviceFee, or: $value.serviceFee),
    subscriptionAmount: data.get(
      #subscriptionAmount,
      or: $value.subscriptionAmount,
    ),
    taxAmount: data.get(#taxAmount, or: $value.taxAmount),
    taxRate: data.get(#taxRate, or: $value.taxRate),
    subtotal: data.get(#subtotal, or: $value.subtotal),
    totalAmount: data.get(#totalAmount, or: $value.totalAmount),
    currency: data.get(#currency, or: $value.currency),
  );

  @override
  PricingModelCopyWith<$R2, PricingModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PricingModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PreviewAddonModelMapper extends ClassMapperBase<PreviewAddonModel> {
  PreviewAddonModelMapper._();

  static PreviewAddonModelMapper? _instance;
  static PreviewAddonModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PreviewAddonModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PreviewAddonModel';

  static String _$id(PreviewAddonModel v) => v.id;
  static const Field<PreviewAddonModel, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$planName(PreviewAddonModel v) => v.planName;
  static const Field<PreviewAddonModel, String> _f$planName = Field(
    'planName',
    _$planName,
    key: r'plan_name',
    opt: true,
    def: '',
  );
  static String _$planType(PreviewAddonModel v) => v.planType;
  static const Field<PreviewAddonModel, String> _f$planType = Field(
    'planType',
    _$planType,
    key: r'plan_type',
    opt: true,
    def: '',
  );
  static int _$callCredits(PreviewAddonModel v) => v.callCredits;
  static const Field<PreviewAddonModel, int> _f$callCredits = Field(
    'callCredits',
    _$callCredits,
    key: r'call_credits',
    opt: true,
    def: 0,
  );
  static double _$price(PreviewAddonModel v) => v.price;
  static const Field<PreviewAddonModel, double> _f$price = Field(
    'price',
    _$price,
    opt: true,
    def: 0,
  );
  static double _$originalPrice(PreviewAddonModel v) => v.originalPrice;
  static const Field<PreviewAddonModel, double> _f$originalPrice = Field(
    'originalPrice',
    _$originalPrice,
    key: r'original_price',
    opt: true,
    def: 0,
  );
  static String _$currency(PreviewAddonModel v) => v.currency;
  static const Field<PreviewAddonModel, String> _f$currency = Field(
    'currency',
    _$currency,
    opt: true,
    def: '',
  );
  static int _$durationDays(PreviewAddonModel v) => v.durationDays;
  static const Field<PreviewAddonModel, int> _f$durationDays = Field(
    'durationDays',
    _$durationDays,
    key: r'duration_days',
    opt: true,
    def: 0,
  );
  static bool _$isCurrentPlan(PreviewAddonModel v) => v.isCurrentPlan;
  static const Field<PreviewAddonModel, bool> _f$isCurrentPlan = Field(
    'isCurrentPlan',
    _$isCurrentPlan,
    key: r'is_current_plan',
    opt: true,
    def: false,
  );

  @override
  final MappableFields<PreviewAddonModel> fields = const {
    #id: _f$id,
    #planName: _f$planName,
    #planType: _f$planType,
    #callCredits: _f$callCredits,
    #price: _f$price,
    #originalPrice: _f$originalPrice,
    #currency: _f$currency,
    #durationDays: _f$durationDays,
    #isCurrentPlan: _f$isCurrentPlan,
  };

  static PreviewAddonModel _instantiate(DecodingData data) {
    return PreviewAddonModel(
      id: data.dec(_f$id),
      planName: data.dec(_f$planName),
      planType: data.dec(_f$planType),
      callCredits: data.dec(_f$callCredits),
      price: data.dec(_f$price),
      originalPrice: data.dec(_f$originalPrice),
      currency: data.dec(_f$currency),
      durationDays: data.dec(_f$durationDays),
      isCurrentPlan: data.dec(_f$isCurrentPlan),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PreviewAddonModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PreviewAddonModel>(map);
  }

  static PreviewAddonModel fromJson(String json) {
    return ensureInitialized().decodeJson<PreviewAddonModel>(json);
  }
}

mixin PreviewAddonModelMappable {
  String toJson() {
    return PreviewAddonModelMapper.ensureInitialized()
        .encodeJson<PreviewAddonModel>(this as PreviewAddonModel);
  }

  Map<String, dynamic> toMap() {
    return PreviewAddonModelMapper.ensureInitialized()
        .encodeMap<PreviewAddonModel>(this as PreviewAddonModel);
  }

  PreviewAddonModelCopyWith<
    PreviewAddonModel,
    PreviewAddonModel,
    PreviewAddonModel
  >
  get copyWith =>
      _PreviewAddonModelCopyWithImpl<PreviewAddonModel, PreviewAddonModel>(
        this as PreviewAddonModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PreviewAddonModelMapper.ensureInitialized().stringifyValue(
      this as PreviewAddonModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return PreviewAddonModelMapper.ensureInitialized().equalsValue(
      this as PreviewAddonModel,
      other,
    );
  }

  @override
  int get hashCode {
    return PreviewAddonModelMapper.ensureInitialized().hashValue(
      this as PreviewAddonModel,
    );
  }
}

extension PreviewAddonModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PreviewAddonModel, $Out> {
  PreviewAddonModelCopyWith<$R, PreviewAddonModel, $Out>
  get $asPreviewAddonModel => $base.as(
    (v, t, t2) => _PreviewAddonModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class PreviewAddonModelCopyWith<
  $R,
  $In extends PreviewAddonModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? planName,
    String? planType,
    int? callCredits,
    double? price,
    double? originalPrice,
    String? currency,
    int? durationDays,
    bool? isCurrentPlan,
  });
  PreviewAddonModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PreviewAddonModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PreviewAddonModel, $Out>
    implements PreviewAddonModelCopyWith<$R, PreviewAddonModel, $Out> {
  _PreviewAddonModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PreviewAddonModel> $mapper =
      PreviewAddonModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? planName,
    String? planType,
    int? callCredits,
    double? price,
    double? originalPrice,
    String? currency,
    int? durationDays,
    bool? isCurrentPlan,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (planName != null) #planName: planName,
      if (planType != null) #planType: planType,
      if (callCredits != null) #callCredits: callCredits,
      if (price != null) #price: price,
      if (originalPrice != null) #originalPrice: originalPrice,
      if (currency != null) #currency: currency,
      if (durationDays != null) #durationDays: durationDays,
      if (isCurrentPlan != null) #isCurrentPlan: isCurrentPlan,
    }),
  );
  @override
  PreviewAddonModel $make(CopyWithData data) => PreviewAddonModel(
    id: data.get(#id, or: $value.id),
    planName: data.get(#planName, or: $value.planName),
    planType: data.get(#planType, or: $value.planType),
    callCredits: data.get(#callCredits, or: $value.callCredits),
    price: data.get(#price, or: $value.price),
    originalPrice: data.get(#originalPrice, or: $value.originalPrice),
    currency: data.get(#currency, or: $value.currency),
    durationDays: data.get(#durationDays, or: $value.durationDays),
    isCurrentPlan: data.get(#isCurrentPlan, or: $value.isCurrentPlan),
  );

  @override
  PreviewAddonModelCopyWith<$R2, PreviewAddonModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PreviewAddonModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ClinicSubsMetaMapper extends ClassMapperBase<ClinicSubsMeta> {
  ClinicSubsMetaMapper._();

  static ClinicSubsMetaMapper? _instance;
  static ClinicSubsMetaMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ClinicSubsMetaMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ClinicSubsMeta';

  static String _$lang(ClinicSubsMeta v) => v.lang;
  static const Field<ClinicSubsMeta, String> _f$lang = Field(
    'lang',
    _$lang,
    opt: true,
    def: '',
  );
  static String _$timestamp(ClinicSubsMeta v) => v.timestamp;
  static const Field<ClinicSubsMeta, String> _f$timestamp = Field(
    'timestamp',
    _$timestamp,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<ClinicSubsMeta> fields = const {
    #lang: _f$lang,
    #timestamp: _f$timestamp,
  };

  static ClinicSubsMeta _instantiate(DecodingData data) {
    return ClinicSubsMeta(
      lang: data.dec(_f$lang),
      timestamp: data.dec(_f$timestamp),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ClinicSubsMeta fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ClinicSubsMeta>(map);
  }

  static ClinicSubsMeta fromJson(String json) {
    return ensureInitialized().decodeJson<ClinicSubsMeta>(json);
  }
}

mixin ClinicSubsMetaMappable {
  String toJson() {
    return ClinicSubsMetaMapper.ensureInitialized().encodeJson<ClinicSubsMeta>(
      this as ClinicSubsMeta,
    );
  }

  Map<String, dynamic> toMap() {
    return ClinicSubsMetaMapper.ensureInitialized().encodeMap<ClinicSubsMeta>(
      this as ClinicSubsMeta,
    );
  }

  ClinicSubsMetaCopyWith<ClinicSubsMeta, ClinicSubsMeta, ClinicSubsMeta>
  get copyWith => _ClinicSubsMetaCopyWithImpl<ClinicSubsMeta, ClinicSubsMeta>(
    this as ClinicSubsMeta,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ClinicSubsMetaMapper.ensureInitialized().stringifyValue(
      this as ClinicSubsMeta,
    );
  }

  @override
  bool operator ==(Object other) {
    return ClinicSubsMetaMapper.ensureInitialized().equalsValue(
      this as ClinicSubsMeta,
      other,
    );
  }

  @override
  int get hashCode {
    return ClinicSubsMetaMapper.ensureInitialized().hashValue(
      this as ClinicSubsMeta,
    );
  }
}

extension ClinicSubsMetaValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ClinicSubsMeta, $Out> {
  ClinicSubsMetaCopyWith<$R, ClinicSubsMeta, $Out> get $asClinicSubsMeta =>
      $base.as((v, t, t2) => _ClinicSubsMetaCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ClinicSubsMetaCopyWith<$R, $In extends ClinicSubsMeta, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? lang, String? timestamp});
  ClinicSubsMetaCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ClinicSubsMetaCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ClinicSubsMeta, $Out>
    implements ClinicSubsMetaCopyWith<$R, ClinicSubsMeta, $Out> {
  _ClinicSubsMetaCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ClinicSubsMeta> $mapper =
      ClinicSubsMetaMapper.ensureInitialized();
  @override
  $R call({String? lang, String? timestamp}) => $apply(
    FieldCopyWithData({
      if (lang != null) #lang: lang,
      if (timestamp != null) #timestamp: timestamp,
    }),
  );
  @override
  ClinicSubsMeta $make(CopyWithData data) => ClinicSubsMeta(
    lang: data.get(#lang, or: $value.lang),
    timestamp: data.get(#timestamp, or: $value.timestamp),
  );

  @override
  ClinicSubsMetaCopyWith<$R2, ClinicSubsMeta, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ClinicSubsMetaCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

