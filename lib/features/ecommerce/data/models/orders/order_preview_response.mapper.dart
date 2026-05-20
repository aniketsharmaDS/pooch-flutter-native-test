// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'order_preview_response.dart';

class OrderPreviewResponseMapper extends ClassMapperBase<OrderPreviewResponse> {
  OrderPreviewResponseMapper._();

  static OrderPreviewResponseMapper? _instance;
  static OrderPreviewResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OrderPreviewResponseMapper._());
      OrderDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'OrderPreviewResponse';

  static bool _$success(OrderPreviewResponse v) => v.success;
  static const Field<OrderPreviewResponse, bool> _f$success = Field(
    'success',
    _$success,
  );
  static String _$message(OrderPreviewResponse v) => v.message;
  static const Field<OrderPreviewResponse, String> _f$message = Field(
    'message',
    _$message,
  );
  static int _$status(OrderPreviewResponse v) => v.status;
  static const Field<OrderPreviewResponse, int> _f$status = Field(
    'status',
    _$status,
  );
  static OrderData? _$data(OrderPreviewResponse v) => v.data;
  static const Field<OrderPreviewResponse, OrderData> _f$data = Field(
    'data',
    _$data,
    opt: true,
  );

  @override
  final MappableFields<OrderPreviewResponse> fields = const {
    #success: _f$success,
    #message: _f$message,
    #status: _f$status,
    #data: _f$data,
  };

  static OrderPreviewResponse _instantiate(DecodingData data) {
    return OrderPreviewResponse(
      success: data.dec(_f$success),
      message: data.dec(_f$message),
      status: data.dec(_f$status),
      data: data.dec(_f$data),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static OrderPreviewResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<OrderPreviewResponse>(map);
  }

  static OrderPreviewResponse fromJson(String json) {
    return ensureInitialized().decodeJson<OrderPreviewResponse>(json);
  }
}

mixin OrderPreviewResponseMappable {
  String toJson() {
    return OrderPreviewResponseMapper.ensureInitialized()
        .encodeJson<OrderPreviewResponse>(this as OrderPreviewResponse);
  }

  Map<String, dynamic> toMap() {
    return OrderPreviewResponseMapper.ensureInitialized()
        .encodeMap<OrderPreviewResponse>(this as OrderPreviewResponse);
  }

  OrderPreviewResponseCopyWith<
    OrderPreviewResponse,
    OrderPreviewResponse,
    OrderPreviewResponse
  >
  get copyWith =>
      _OrderPreviewResponseCopyWithImpl<
        OrderPreviewResponse,
        OrderPreviewResponse
      >(this as OrderPreviewResponse, $identity, $identity);
  @override
  String toString() {
    return OrderPreviewResponseMapper.ensureInitialized().stringifyValue(
      this as OrderPreviewResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return OrderPreviewResponseMapper.ensureInitialized().equalsValue(
      this as OrderPreviewResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return OrderPreviewResponseMapper.ensureInitialized().hashValue(
      this as OrderPreviewResponse,
    );
  }
}

extension OrderPreviewResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, OrderPreviewResponse, $Out> {
  OrderPreviewResponseCopyWith<$R, OrderPreviewResponse, $Out>
  get $asOrderPreviewResponse => $base.as(
    (v, t, t2) => _OrderPreviewResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class OrderPreviewResponseCopyWith<
  $R,
  $In extends OrderPreviewResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  OrderDataCopyWith<$R, OrderData, OrderData>? get data;
  $R call({bool? success, String? message, int? status, OrderData? data});
  OrderPreviewResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _OrderPreviewResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OrderPreviewResponse, $Out>
    implements OrderPreviewResponseCopyWith<$R, OrderPreviewResponse, $Out> {
  _OrderPreviewResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OrderPreviewResponse> $mapper =
      OrderPreviewResponseMapper.ensureInitialized();
  @override
  OrderDataCopyWith<$R, OrderData, OrderData>? get data =>
      $value.data?.copyWith.$chain((v) => call(data: v));
  @override
  $R call({
    bool? success,
    String? message,
    int? status,
    Object? data = $none,
  }) => $apply(
    FieldCopyWithData({
      if (success != null) #success: success,
      if (message != null) #message: message,
      if (status != null) #status: status,
      if (data != $none) #data: data,
    }),
  );
  @override
  OrderPreviewResponse $make(CopyWithData data) => OrderPreviewResponse(
    success: data.get(#success, or: $value.success),
    message: data.get(#message, or: $value.message),
    status: data.get(#status, or: $value.status),
    data: data.get(#data, or: $value.data),
  );

  @override
  OrderPreviewResponseCopyWith<$R2, OrderPreviewResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _OrderPreviewResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class OrderDataMapper extends ClassMapperBase<OrderData> {
  OrderDataMapper._();

  static OrderDataMapper? _instance;
  static OrderDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OrderDataMapper._());
      OrderItemMapper.ensureInitialized();
      PricingMapper.ensureInitialized();
      ShippingAddressMapper.ensureInitialized();
      AppliedCouponMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'OrderData';

  static String _$type(OrderData v) => v.type;
  static const Field<OrderData, String> _f$type = Field('type', _$type);
  static List<OrderItem> _$items(OrderData v) => v.items;
  static const Field<OrderData, List<OrderItem>> _f$items = Field(
    'items',
    _$items,
  );
  static int _$itemCount(OrderData v) => v.itemCount;
  static const Field<OrderData, int> _f$itemCount = Field(
    'itemCount',
    _$itemCount,
  );
  static Pricing _$pricing(OrderData v) => v.pricing;
  static const Field<OrderData, Pricing> _f$pricing = Field(
    'pricing',
    _$pricing,
  );
  static ShippingAddress? _$shippingAddress(OrderData v) => v.shippingAddress;
  static const Field<OrderData, ShippingAddress> _f$shippingAddress = Field(
    'shippingAddress',
    _$shippingAddress,
    opt: true,
  );
  static AppliedCoupon? _$appliedCoupon(OrderData v) => v.appliedCoupon;
  static const Field<OrderData, AppliedCoupon> _f$appliedCoupon = Field(
    'appliedCoupon',
    _$appliedCoupon,
    opt: true,
  );

  @override
  final MappableFields<OrderData> fields = const {
    #type: _f$type,
    #items: _f$items,
    #itemCount: _f$itemCount,
    #pricing: _f$pricing,
    #shippingAddress: _f$shippingAddress,
    #appliedCoupon: _f$appliedCoupon,
  };

  static OrderData _instantiate(DecodingData data) {
    return OrderData(
      type: data.dec(_f$type),
      items: data.dec(_f$items),
      itemCount: data.dec(_f$itemCount),
      pricing: data.dec(_f$pricing),
      shippingAddress: data.dec(_f$shippingAddress),
      appliedCoupon: data.dec(_f$appliedCoupon),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static OrderData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<OrderData>(map);
  }

  static OrderData fromJson(String json) {
    return ensureInitialized().decodeJson<OrderData>(json);
  }
}

mixin OrderDataMappable {
  String toJson() {
    return OrderDataMapper.ensureInitialized().encodeJson<OrderData>(
      this as OrderData,
    );
  }

  Map<String, dynamic> toMap() {
    return OrderDataMapper.ensureInitialized().encodeMap<OrderData>(
      this as OrderData,
    );
  }

  OrderDataCopyWith<OrderData, OrderData, OrderData> get copyWith =>
      _OrderDataCopyWithImpl<OrderData, OrderData>(
        this as OrderData,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return OrderDataMapper.ensureInitialized().stringifyValue(
      this as OrderData,
    );
  }

  @override
  bool operator ==(Object other) {
    return OrderDataMapper.ensureInitialized().equalsValue(
      this as OrderData,
      other,
    );
  }

  @override
  int get hashCode {
    return OrderDataMapper.ensureInitialized().hashValue(this as OrderData);
  }
}

extension OrderDataValueCopy<$R, $Out> on ObjectCopyWith<$R, OrderData, $Out> {
  OrderDataCopyWith<$R, OrderData, $Out> get $asOrderData =>
      $base.as((v, t, t2) => _OrderDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class OrderDataCopyWith<$R, $In extends OrderData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, OrderItem, OrderItemCopyWith<$R, OrderItem, OrderItem>>
  get items;
  PricingCopyWith<$R, Pricing, Pricing> get pricing;
  ShippingAddressCopyWith<$R, ShippingAddress, ShippingAddress>?
  get shippingAddress;
  AppliedCouponCopyWith<$R, AppliedCoupon, AppliedCoupon>? get appliedCoupon;
  $R call({
    String? type,
    List<OrderItem>? items,
    int? itemCount,
    Pricing? pricing,
    ShippingAddress? shippingAddress,
    AppliedCoupon? appliedCoupon,
  });
  OrderDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _OrderDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OrderData, $Out>
    implements OrderDataCopyWith<$R, OrderData, $Out> {
  _OrderDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OrderData> $mapper =
      OrderDataMapper.ensureInitialized();
  @override
  ListCopyWith<$R, OrderItem, OrderItemCopyWith<$R, OrderItem, OrderItem>>
  get items => ListCopyWith(
    $value.items,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(items: v),
  );
  @override
  PricingCopyWith<$R, Pricing, Pricing> get pricing =>
      $value.pricing.copyWith.$chain((v) => call(pricing: v));
  @override
  ShippingAddressCopyWith<$R, ShippingAddress, ShippingAddress>?
  get shippingAddress =>
      $value.shippingAddress?.copyWith.$chain((v) => call(shippingAddress: v));
  @override
  AppliedCouponCopyWith<$R, AppliedCoupon, AppliedCoupon>? get appliedCoupon =>
      $value.appliedCoupon?.copyWith.$chain((v) => call(appliedCoupon: v));
  @override
  $R call({
    String? type,
    List<OrderItem>? items,
    int? itemCount,
    Pricing? pricing,
    Object? shippingAddress = $none,
    Object? appliedCoupon = $none,
  }) => $apply(
    FieldCopyWithData({
      if (type != null) #type: type,
      if (items != null) #items: items,
      if (itemCount != null) #itemCount: itemCount,
      if (pricing != null) #pricing: pricing,
      if (shippingAddress != $none) #shippingAddress: shippingAddress,
      if (appliedCoupon != $none) #appliedCoupon: appliedCoupon,
    }),
  );
  @override
  OrderData $make(CopyWithData data) => OrderData(
    type: data.get(#type, or: $value.type),
    items: data.get(#items, or: $value.items),
    itemCount: data.get(#itemCount, or: $value.itemCount),
    pricing: data.get(#pricing, or: $value.pricing),
    shippingAddress: data.get(#shippingAddress, or: $value.shippingAddress),
    appliedCoupon: data.get(#appliedCoupon, or: $value.appliedCoupon),
  );

  @override
  OrderDataCopyWith<$R2, OrderData, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _OrderDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class OrderItemMapper extends ClassMapperBase<OrderItem> {
  OrderItemMapper._();

  static OrderItemMapper? _instance;
  static OrderItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OrderItemMapper._());
      PetDetailsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'OrderItem';

  static String _$productId(OrderItem v) => v.productId;
  static const Field<OrderItem, String> _f$productId = Field(
    'productId',
    _$productId,
  );
  static String _$productName(OrderItem v) => v.productName;
  static const Field<OrderItem, String> _f$productName = Field(
    'productName',
    _$productName,
  );
  static double _$price(OrderItem v) => v.price;
  static const Field<OrderItem, double> _f$price = Field(
    'price',
    _$price,
    hook: StringToDoubleHook(),
  );
  static int _$quantity(OrderItem v) => v.quantity;
  static const Field<OrderItem, int> _f$quantity = Field(
    'quantity',
    _$quantity,
  );
  static PetDetails? _$petDetails(OrderItem v) => v.petDetails;
  static const Field<OrderItem, PetDetails> _f$petDetails = Field(
    'petDetails',
    _$petDetails,
    opt: true,
  );

  @override
  final MappableFields<OrderItem> fields = const {
    #productId: _f$productId,
    #productName: _f$productName,
    #price: _f$price,
    #quantity: _f$quantity,
    #petDetails: _f$petDetails,
  };

  static OrderItem _instantiate(DecodingData data) {
    return OrderItem(
      productId: data.dec(_f$productId),
      productName: data.dec(_f$productName),
      price: data.dec(_f$price),
      quantity: data.dec(_f$quantity),
      petDetails: data.dec(_f$petDetails),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static OrderItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<OrderItem>(map);
  }

  static OrderItem fromJson(String json) {
    return ensureInitialized().decodeJson<OrderItem>(json);
  }
}

mixin OrderItemMappable {
  String toJson() {
    return OrderItemMapper.ensureInitialized().encodeJson<OrderItem>(
      this as OrderItem,
    );
  }

  Map<String, dynamic> toMap() {
    return OrderItemMapper.ensureInitialized().encodeMap<OrderItem>(
      this as OrderItem,
    );
  }

  OrderItemCopyWith<OrderItem, OrderItem, OrderItem> get copyWith =>
      _OrderItemCopyWithImpl<OrderItem, OrderItem>(
        this as OrderItem,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return OrderItemMapper.ensureInitialized().stringifyValue(
      this as OrderItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return OrderItemMapper.ensureInitialized().equalsValue(
      this as OrderItem,
      other,
    );
  }

  @override
  int get hashCode {
    return OrderItemMapper.ensureInitialized().hashValue(this as OrderItem);
  }
}

extension OrderItemValueCopy<$R, $Out> on ObjectCopyWith<$R, OrderItem, $Out> {
  OrderItemCopyWith<$R, OrderItem, $Out> get $asOrderItem =>
      $base.as((v, t, t2) => _OrderItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class OrderItemCopyWith<$R, $In extends OrderItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PetDetailsCopyWith<$R, PetDetails, PetDetails>? get petDetails;
  $R call({
    String? productId,
    String? productName,
    double? price,
    int? quantity,
    PetDetails? petDetails,
  });
  OrderItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _OrderItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OrderItem, $Out>
    implements OrderItemCopyWith<$R, OrderItem, $Out> {
  _OrderItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OrderItem> $mapper =
      OrderItemMapper.ensureInitialized();
  @override
  PetDetailsCopyWith<$R, PetDetails, PetDetails>? get petDetails =>
      $value.petDetails?.copyWith.$chain((v) => call(petDetails: v));
  @override
  $R call({
    String? productId,
    String? productName,
    double? price,
    int? quantity,
    Object? petDetails = $none,
  }) => $apply(
    FieldCopyWithData({
      if (productId != null) #productId: productId,
      if (productName != null) #productName: productName,
      if (price != null) #price: price,
      if (quantity != null) #quantity: quantity,
      if (petDetails != $none) #petDetails: petDetails,
    }),
  );
  @override
  OrderItem $make(CopyWithData data) => OrderItem(
    productId: data.get(#productId, or: $value.productId),
    productName: data.get(#productName, or: $value.productName),
    price: data.get(#price, or: $value.price),
    quantity: data.get(#quantity, or: $value.quantity),
    petDetails: data.get(#petDetails, or: $value.petDetails),
  );

  @override
  OrderItemCopyWith<$R2, OrderItem, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _OrderItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PetDetailsMapper extends ClassMapperBase<PetDetails> {
  PetDetailsMapper._();

  static PetDetailsMapper? _instance;
  static PetDetailsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PetDetailsMapper._());
      BreedInfoMapper.ensureInitialized();
      TranslationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PetDetails';

  static String _$id(PetDetails v) => v.id;
  static const Field<PetDetails, String> _f$id = Field('id', _$id);
  static String _$gender(PetDetails v) => v.gender;
  static const Field<PetDetails, String> _f$gender = Field('gender', _$gender);
  static String _$lifeStage(PetDetails v) => v.lifeStage;
  static const Field<PetDetails, String> _f$lifeStage = Field(
    'lifeStage',
    _$lifeStage,
  );
  static bool _$isVaccinated(PetDetails v) => v.isVaccinated;
  static const Field<PetDetails, bool> _f$isVaccinated = Field(
    'isVaccinated',
    _$isVaccinated,
  );
  static BreedInfo? _$breedInfo(PetDetails v) => v.breedInfo;
  static const Field<PetDetails, BreedInfo> _f$breedInfo = Field(
    'breedInfo',
    _$breedInfo,
    opt: true,
  );
  static List<Translation>? _$translations(PetDetails v) => v.translations;
  static const Field<PetDetails, List<Translation>> _f$translations = Field(
    'translations',
    _$translations,
    opt: true,
  );

  @override
  final MappableFields<PetDetails> fields = const {
    #id: _f$id,
    #gender: _f$gender,
    #lifeStage: _f$lifeStage,
    #isVaccinated: _f$isVaccinated,
    #breedInfo: _f$breedInfo,
    #translations: _f$translations,
  };

  static PetDetails _instantiate(DecodingData data) {
    return PetDetails(
      id: data.dec(_f$id),
      gender: data.dec(_f$gender),
      lifeStage: data.dec(_f$lifeStage),
      isVaccinated: data.dec(_f$isVaccinated),
      breedInfo: data.dec(_f$breedInfo),
      translations: data.dec(_f$translations),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PetDetails fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PetDetails>(map);
  }

  static PetDetails fromJson(String json) {
    return ensureInitialized().decodeJson<PetDetails>(json);
  }
}

mixin PetDetailsMappable {
  String toJson() {
    return PetDetailsMapper.ensureInitialized().encodeJson<PetDetails>(
      this as PetDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return PetDetailsMapper.ensureInitialized().encodeMap<PetDetails>(
      this as PetDetails,
    );
  }

  PetDetailsCopyWith<PetDetails, PetDetails, PetDetails> get copyWith =>
      _PetDetailsCopyWithImpl<PetDetails, PetDetails>(
        this as PetDetails,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PetDetailsMapper.ensureInitialized().stringifyValue(
      this as PetDetails,
    );
  }

  @override
  bool operator ==(Object other) {
    return PetDetailsMapper.ensureInitialized().equalsValue(
      this as PetDetails,
      other,
    );
  }

  @override
  int get hashCode {
    return PetDetailsMapper.ensureInitialized().hashValue(this as PetDetails);
  }
}

extension PetDetailsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PetDetails, $Out> {
  PetDetailsCopyWith<$R, PetDetails, $Out> get $asPetDetails =>
      $base.as((v, t, t2) => _PetDetailsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PetDetailsCopyWith<$R, $In extends PetDetails, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  BreedInfoCopyWith<$R, BreedInfo, BreedInfo>? get breedInfo;
  ListCopyWith<
    $R,
    Translation,
    TranslationCopyWith<$R, Translation, Translation>
  >?
  get translations;
  $R call({
    String? id,
    String? gender,
    String? lifeStage,
    bool? isVaccinated,
    BreedInfo? breedInfo,
    List<Translation>? translations,
  });
  PetDetailsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PetDetailsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PetDetails, $Out>
    implements PetDetailsCopyWith<$R, PetDetails, $Out> {
  _PetDetailsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PetDetails> $mapper =
      PetDetailsMapper.ensureInitialized();
  @override
  BreedInfoCopyWith<$R, BreedInfo, BreedInfo>? get breedInfo =>
      $value.breedInfo?.copyWith.$chain((v) => call(breedInfo: v));
  @override
  ListCopyWith<
    $R,
    Translation,
    TranslationCopyWith<$R, Translation, Translation>
  >?
  get translations => $value.translations != null
      ? ListCopyWith(
          $value.translations!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(translations: v),
        )
      : null;
  @override
  $R call({
    String? id,
    String? gender,
    String? lifeStage,
    bool? isVaccinated,
    Object? breedInfo = $none,
    Object? translations = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (gender != null) #gender: gender,
      if (lifeStage != null) #lifeStage: lifeStage,
      if (isVaccinated != null) #isVaccinated: isVaccinated,
      if (breedInfo != $none) #breedInfo: breedInfo,
      if (translations != $none) #translations: translations,
    }),
  );
  @override
  PetDetails $make(CopyWithData data) => PetDetails(
    id: data.get(#id, or: $value.id),
    gender: data.get(#gender, or: $value.gender),
    lifeStage: data.get(#lifeStage, or: $value.lifeStage),
    isVaccinated: data.get(#isVaccinated, or: $value.isVaccinated),
    breedInfo: data.get(#breedInfo, or: $value.breedInfo),
    translations: data.get(#translations, or: $value.translations),
  );

  @override
  PetDetailsCopyWith<$R2, PetDetails, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PetDetailsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class BreedInfoMapper extends ClassMapperBase<BreedInfo> {
  BreedInfoMapper._();

  static BreedInfoMapper? _instance;
  static BreedInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BreedInfoMapper._());
      TranslationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BreedInfo';

  static String _$id(BreedInfo v) => v.id;
  static const Field<BreedInfo, String> _f$id = Field('id', _$id);
  static String _$breedName(BreedInfo v) => v.breedName;
  static const Field<BreedInfo, String> _f$breedName = Field(
    'breedName',
    _$breedName,
  );
  static List<Translation>? _$translations(BreedInfo v) => v.translations;
  static const Field<BreedInfo, List<Translation>> _f$translations = Field(
    'translations',
    _$translations,
    opt: true,
  );

  @override
  final MappableFields<BreedInfo> fields = const {
    #id: _f$id,
    #breedName: _f$breedName,
    #translations: _f$translations,
  };

  static BreedInfo _instantiate(DecodingData data) {
    return BreedInfo(
      id: data.dec(_f$id),
      breedName: data.dec(_f$breedName),
      translations: data.dec(_f$translations),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static BreedInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BreedInfo>(map);
  }

  static BreedInfo fromJson(String json) {
    return ensureInitialized().decodeJson<BreedInfo>(json);
  }
}

mixin BreedInfoMappable {
  String toJson() {
    return BreedInfoMapper.ensureInitialized().encodeJson<BreedInfo>(
      this as BreedInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return BreedInfoMapper.ensureInitialized().encodeMap<BreedInfo>(
      this as BreedInfo,
    );
  }

  BreedInfoCopyWith<BreedInfo, BreedInfo, BreedInfo> get copyWith =>
      _BreedInfoCopyWithImpl<BreedInfo, BreedInfo>(
        this as BreedInfo,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return BreedInfoMapper.ensureInitialized().stringifyValue(
      this as BreedInfo,
    );
  }

  @override
  bool operator ==(Object other) {
    return BreedInfoMapper.ensureInitialized().equalsValue(
      this as BreedInfo,
      other,
    );
  }

  @override
  int get hashCode {
    return BreedInfoMapper.ensureInitialized().hashValue(this as BreedInfo);
  }
}

extension BreedInfoValueCopy<$R, $Out> on ObjectCopyWith<$R, BreedInfo, $Out> {
  BreedInfoCopyWith<$R, BreedInfo, $Out> get $asBreedInfo =>
      $base.as((v, t, t2) => _BreedInfoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BreedInfoCopyWith<$R, $In extends BreedInfo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    Translation,
    TranslationCopyWith<$R, Translation, Translation>
  >?
  get translations;
  $R call({String? id, String? breedName, List<Translation>? translations});
  BreedInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BreedInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BreedInfo, $Out>
    implements BreedInfoCopyWith<$R, BreedInfo, $Out> {
  _BreedInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BreedInfo> $mapper =
      BreedInfoMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    Translation,
    TranslationCopyWith<$R, Translation, Translation>
  >?
  get translations => $value.translations != null
      ? ListCopyWith(
          $value.translations!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(translations: v),
        )
      : null;
  @override
  $R call({String? id, String? breedName, Object? translations = $none}) =>
      $apply(
        FieldCopyWithData({
          if (id != null) #id: id,
          if (breedName != null) #breedName: breedName,
          if (translations != $none) #translations: translations,
        }),
      );
  @override
  BreedInfo $make(CopyWithData data) => BreedInfo(
    id: data.get(#id, or: $value.id),
    breedName: data.get(#breedName, or: $value.breedName),
    translations: data.get(#translations, or: $value.translations),
  );

  @override
  BreedInfoCopyWith<$R2, BreedInfo, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BreedInfoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class TranslationMapper extends ClassMapperBase<Translation> {
  TranslationMapper._();

  static TranslationMapper? _instance;
  static TranslationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TranslationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Translation';

  static String? _$langCode(Translation v) => v.langCode;
  static const Field<Translation, String> _f$langCode = Field(
    'langCode',
    _$langCode,
    opt: true,
  );
  static String? _$languageCode(Translation v) => v.languageCode;
  static const Field<Translation, String> _f$languageCode = Field(
    'languageCode',
    _$languageCode,
    opt: true,
  );
  static String? _$name(Translation v) => v.name;
  static const Field<Translation, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static String? _$breedName(Translation v) => v.breedName;
  static const Field<Translation, String> _f$breedName = Field(
    'breedName',
    _$breedName,
    opt: true,
  );

  @override
  final MappableFields<Translation> fields = const {
    #langCode: _f$langCode,
    #languageCode: _f$languageCode,
    #name: _f$name,
    #breedName: _f$breedName,
  };

  static Translation _instantiate(DecodingData data) {
    return Translation(
      langCode: data.dec(_f$langCode),
      languageCode: data.dec(_f$languageCode),
      name: data.dec(_f$name),
      breedName: data.dec(_f$breedName),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Translation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Translation>(map);
  }

  static Translation fromJson(String json) {
    return ensureInitialized().decodeJson<Translation>(json);
  }
}

mixin TranslationMappable {
  String toJson() {
    return TranslationMapper.ensureInitialized().encodeJson<Translation>(
      this as Translation,
    );
  }

  Map<String, dynamic> toMap() {
    return TranslationMapper.ensureInitialized().encodeMap<Translation>(
      this as Translation,
    );
  }

  TranslationCopyWith<Translation, Translation, Translation> get copyWith =>
      _TranslationCopyWithImpl<Translation, Translation>(
        this as Translation,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TranslationMapper.ensureInitialized().stringifyValue(
      this as Translation,
    );
  }

  @override
  bool operator ==(Object other) {
    return TranslationMapper.ensureInitialized().equalsValue(
      this as Translation,
      other,
    );
  }

  @override
  int get hashCode {
    return TranslationMapper.ensureInitialized().hashValue(this as Translation);
  }
}

extension TranslationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Translation, $Out> {
  TranslationCopyWith<$R, Translation, $Out> get $asTranslation =>
      $base.as((v, t, t2) => _TranslationCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TranslationCopyWith<$R, $In extends Translation, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? langCode,
    String? languageCode,
    String? name,
    String? breedName,
  });
  TranslationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TranslationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Translation, $Out>
    implements TranslationCopyWith<$R, Translation, $Out> {
  _TranslationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Translation> $mapper =
      TranslationMapper.ensureInitialized();
  @override
  $R call({
    Object? langCode = $none,
    Object? languageCode = $none,
    Object? name = $none,
    Object? breedName = $none,
  }) => $apply(
    FieldCopyWithData({
      if (langCode != $none) #langCode: langCode,
      if (languageCode != $none) #languageCode: languageCode,
      if (name != $none) #name: name,
      if (breedName != $none) #breedName: breedName,
    }),
  );
  @override
  Translation $make(CopyWithData data) => Translation(
    langCode: data.get(#langCode, or: $value.langCode),
    languageCode: data.get(#languageCode, or: $value.languageCode),
    name: data.get(#name, or: $value.name),
    breedName: data.get(#breedName, or: $value.breedName),
  );

  @override
  TranslationCopyWith<$R2, Translation, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TranslationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PricingMapper extends ClassMapperBase<Pricing> {
  PricingMapper._();

  static PricingMapper? _instance;
  static PricingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PricingMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Pricing';

  static double _$subtotal(Pricing v) => v.subtotal;
  static const Field<Pricing, double> _f$subtotal = Field(
    'subtotal',
    _$subtotal,
  );
  static double _$taxAmount(Pricing v) => v.taxAmount;
  static const Field<Pricing, double> _f$taxAmount = Field(
    'taxAmount',
    _$taxAmount,
  );
  static String _$taxRate(Pricing v) => v.taxRate;
  static const Field<Pricing, String> _f$taxRate = Field('taxRate', _$taxRate);
  static double _$deliveryCharge(Pricing v) => v.deliveryCharge;
  static const Field<Pricing, double> _f$deliveryCharge = Field(
    'deliveryCharge',
    _$deliveryCharge,
  );
  static double _$totalAmount(Pricing v) => v.totalAmount;
  static const Field<Pricing, double> _f$totalAmount = Field(
    'totalAmount',
    _$totalAmount,
    hook: StringToDoubleHook(),
  );
  static double _$discountAmount(Pricing v) => v.discountAmount;
  static const Field<Pricing, double> _f$discountAmount = Field(
    'discountAmount',
    _$discountAmount,
  );

  @override
  final MappableFields<Pricing> fields = const {
    #subtotal: _f$subtotal,
    #taxAmount: _f$taxAmount,
    #taxRate: _f$taxRate,
    #deliveryCharge: _f$deliveryCharge,
    #totalAmount: _f$totalAmount,
    #discountAmount: _f$discountAmount,
  };

  static Pricing _instantiate(DecodingData data) {
    return Pricing(
      subtotal: data.dec(_f$subtotal),
      taxAmount: data.dec(_f$taxAmount),
      taxRate: data.dec(_f$taxRate),
      deliveryCharge: data.dec(_f$deliveryCharge),
      totalAmount: data.dec(_f$totalAmount),
      discountAmount: data.dec(_f$discountAmount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Pricing fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Pricing>(map);
  }

  static Pricing fromJson(String json) {
    return ensureInitialized().decodeJson<Pricing>(json);
  }
}

mixin PricingMappable {
  String toJson() {
    return PricingMapper.ensureInitialized().encodeJson<Pricing>(
      this as Pricing,
    );
  }

  Map<String, dynamic> toMap() {
    return PricingMapper.ensureInitialized().encodeMap<Pricing>(
      this as Pricing,
    );
  }

  PricingCopyWith<Pricing, Pricing, Pricing> get copyWith =>
      _PricingCopyWithImpl<Pricing, Pricing>(
        this as Pricing,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PricingMapper.ensureInitialized().stringifyValue(this as Pricing);
  }

  @override
  bool operator ==(Object other) {
    return PricingMapper.ensureInitialized().equalsValue(
      this as Pricing,
      other,
    );
  }

  @override
  int get hashCode {
    return PricingMapper.ensureInitialized().hashValue(this as Pricing);
  }
}

extension PricingValueCopy<$R, $Out> on ObjectCopyWith<$R, Pricing, $Out> {
  PricingCopyWith<$R, Pricing, $Out> get $asPricing =>
      $base.as((v, t, t2) => _PricingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PricingCopyWith<$R, $In extends Pricing, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    double? subtotal,
    double? taxAmount,
    String? taxRate,
    double? deliveryCharge,
    double? totalAmount,
    double? discountAmount,
  });
  PricingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PricingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Pricing, $Out>
    implements PricingCopyWith<$R, Pricing, $Out> {
  _PricingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Pricing> $mapper =
      PricingMapper.ensureInitialized();
  @override
  $R call({
    double? subtotal,
    double? taxAmount,
    String? taxRate,
    double? deliveryCharge,
    double? totalAmount,
    double? discountAmount,
  }) => $apply(
    FieldCopyWithData({
      if (subtotal != null) #subtotal: subtotal,
      if (taxAmount != null) #taxAmount: taxAmount,
      if (taxRate != null) #taxRate: taxRate,
      if (deliveryCharge != null) #deliveryCharge: deliveryCharge,
      if (totalAmount != null) #totalAmount: totalAmount,
      if (discountAmount != null) #discountAmount: discountAmount,
    }),
  );
  @override
  Pricing $make(CopyWithData data) => Pricing(
    subtotal: data.get(#subtotal, or: $value.subtotal),
    taxAmount: data.get(#taxAmount, or: $value.taxAmount),
    taxRate: data.get(#taxRate, or: $value.taxRate),
    deliveryCharge: data.get(#deliveryCharge, or: $value.deliveryCharge),
    totalAmount: data.get(#totalAmount, or: $value.totalAmount),
    discountAmount: data.get(#discountAmount, or: $value.discountAmount),
  );

  @override
  PricingCopyWith<$R2, Pricing, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PricingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ShippingAddressMapper extends ClassMapperBase<ShippingAddress> {
  ShippingAddressMapper._();

  static ShippingAddressMapper? _instance;
  static ShippingAddressMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ShippingAddressMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ShippingAddress';

  static String _$id(ShippingAddress v) => v.id;
  static const Field<ShippingAddress, String> _f$id = Field('id', _$id);
  static String _$addressLine(ShippingAddress v) => v.addressLine;
  static const Field<ShippingAddress, String> _f$addressLine = Field(
    'addressLine',
    _$addressLine,
  );
  static String _$city(ShippingAddress v) => v.city;
  static const Field<ShippingAddress, String> _f$city = Field('city', _$city);
  static bool _$isPrimary(ShippingAddress v) => v.isPrimary;
  static const Field<ShippingAddress, bool> _f$isPrimary = Field(
    'isPrimary',
    _$isPrimary,
  );

  @override
  final MappableFields<ShippingAddress> fields = const {
    #id: _f$id,
    #addressLine: _f$addressLine,
    #city: _f$city,
    #isPrimary: _f$isPrimary,
  };

  static ShippingAddress _instantiate(DecodingData data) {
    return ShippingAddress(
      id: data.dec(_f$id),
      addressLine: data.dec(_f$addressLine),
      city: data.dec(_f$city),
      isPrimary: data.dec(_f$isPrimary),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ShippingAddress fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ShippingAddress>(map);
  }

  static ShippingAddress fromJson(String json) {
    return ensureInitialized().decodeJson<ShippingAddress>(json);
  }
}

mixin ShippingAddressMappable {
  String toJson() {
    return ShippingAddressMapper.ensureInitialized()
        .encodeJson<ShippingAddress>(this as ShippingAddress);
  }

  Map<String, dynamic> toMap() {
    return ShippingAddressMapper.ensureInitialized().encodeMap<ShippingAddress>(
      this as ShippingAddress,
    );
  }

  ShippingAddressCopyWith<ShippingAddress, ShippingAddress, ShippingAddress>
  get copyWith =>
      _ShippingAddressCopyWithImpl<ShippingAddress, ShippingAddress>(
        this as ShippingAddress,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ShippingAddressMapper.ensureInitialized().stringifyValue(
      this as ShippingAddress,
    );
  }

  @override
  bool operator ==(Object other) {
    return ShippingAddressMapper.ensureInitialized().equalsValue(
      this as ShippingAddress,
      other,
    );
  }

  @override
  int get hashCode {
    return ShippingAddressMapper.ensureInitialized().hashValue(
      this as ShippingAddress,
    );
  }
}

extension ShippingAddressValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ShippingAddress, $Out> {
  ShippingAddressCopyWith<$R, ShippingAddress, $Out> get $asShippingAddress =>
      $base.as((v, t, t2) => _ShippingAddressCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ShippingAddressCopyWith<$R, $In extends ShippingAddress, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? addressLine, String? city, bool? isPrimary});
  ShippingAddressCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ShippingAddressCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ShippingAddress, $Out>
    implements ShippingAddressCopyWith<$R, ShippingAddress, $Out> {
  _ShippingAddressCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ShippingAddress> $mapper =
      ShippingAddressMapper.ensureInitialized();
  @override
  $R call({String? id, String? addressLine, String? city, bool? isPrimary}) =>
      $apply(
        FieldCopyWithData({
          if (id != null) #id: id,
          if (addressLine != null) #addressLine: addressLine,
          if (city != null) #city: city,
          if (isPrimary != null) #isPrimary: isPrimary,
        }),
      );
  @override
  ShippingAddress $make(CopyWithData data) => ShippingAddress(
    id: data.get(#id, or: $value.id),
    addressLine: data.get(#addressLine, or: $value.addressLine),
    city: data.get(#city, or: $value.city),
    isPrimary: data.get(#isPrimary, or: $value.isPrimary),
  );

  @override
  ShippingAddressCopyWith<$R2, ShippingAddress, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ShippingAddressCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AppliedCouponMapper extends ClassMapperBase<AppliedCoupon> {
  AppliedCouponMapper._();

  static AppliedCouponMapper? _instance;
  static AppliedCouponMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppliedCouponMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AppliedCoupon';

  static String _$code(AppliedCoupon v) => v.code;
  static const Field<AppliedCoupon, String> _f$code = Field('code', _$code);
  static bool _$applied(AppliedCoupon v) => v.applied;
  static const Field<AppliedCoupon, bool> _f$applied = Field(
    'applied',
    _$applied,
  );
  static String? _$error(AppliedCoupon v) => v.error;
  static const Field<AppliedCoupon, String> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );

  @override
  final MappableFields<AppliedCoupon> fields = const {
    #code: _f$code,
    #applied: _f$applied,
    #error: _f$error,
  };

  static AppliedCoupon _instantiate(DecodingData data) {
    return AppliedCoupon(
      code: data.dec(_f$code),
      applied: data.dec(_f$applied),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppliedCoupon fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppliedCoupon>(map);
  }

  static AppliedCoupon fromJson(String json) {
    return ensureInitialized().decodeJson<AppliedCoupon>(json);
  }
}

mixin AppliedCouponMappable {
  String toJson() {
    return AppliedCouponMapper.ensureInitialized().encodeJson<AppliedCoupon>(
      this as AppliedCoupon,
    );
  }

  Map<String, dynamic> toMap() {
    return AppliedCouponMapper.ensureInitialized().encodeMap<AppliedCoupon>(
      this as AppliedCoupon,
    );
  }

  AppliedCouponCopyWith<AppliedCoupon, AppliedCoupon, AppliedCoupon>
  get copyWith => _AppliedCouponCopyWithImpl<AppliedCoupon, AppliedCoupon>(
    this as AppliedCoupon,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return AppliedCouponMapper.ensureInitialized().stringifyValue(
      this as AppliedCoupon,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppliedCouponMapper.ensureInitialized().equalsValue(
      this as AppliedCoupon,
      other,
    );
  }

  @override
  int get hashCode {
    return AppliedCouponMapper.ensureInitialized().hashValue(
      this as AppliedCoupon,
    );
  }
}

extension AppliedCouponValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppliedCoupon, $Out> {
  AppliedCouponCopyWith<$R, AppliedCoupon, $Out> get $asAppliedCoupon =>
      $base.as((v, t, t2) => _AppliedCouponCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AppliedCouponCopyWith<$R, $In extends AppliedCoupon, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? code, bool? applied, String? error});
  AppliedCouponCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AppliedCouponCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppliedCoupon, $Out>
    implements AppliedCouponCopyWith<$R, AppliedCoupon, $Out> {
  _AppliedCouponCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppliedCoupon> $mapper =
      AppliedCouponMapper.ensureInitialized();
  @override
  $R call({String? code, bool? applied, Object? error = $none}) => $apply(
    FieldCopyWithData({
      if (code != null) #code: code,
      if (applied != null) #applied: applied,
      if (error != $none) #error: error,
    }),
  );
  @override
  AppliedCoupon $make(CopyWithData data) => AppliedCoupon(
    code: data.get(#code, or: $value.code),
    applied: data.get(#applied, or: $value.applied),
    error: data.get(#error, or: $value.error),
  );

  @override
  AppliedCouponCopyWith<$R2, AppliedCoupon, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AppliedCouponCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

