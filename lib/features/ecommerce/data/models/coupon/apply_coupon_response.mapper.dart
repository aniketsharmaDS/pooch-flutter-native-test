// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'apply_coupon_response.dart';

class ApplyCouponResponseMapper extends ClassMapperBase<ApplyCouponResponse> {
  ApplyCouponResponseMapper._();

  static ApplyCouponResponseMapper? _instance;
  static ApplyCouponResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ApplyCouponResponseMapper._());
      DiscountBreakdownMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ApplyCouponResponse';

  static double? _$subtotal(ApplyCouponResponse v) => v.subtotal;
  static const Field<ApplyCouponResponse, double> _f$subtotal = Field(
    'subtotal',
    _$subtotal,
    opt: true,
  );
  static double? _$discount(ApplyCouponResponse v) => v.discount;
  static const Field<ApplyCouponResponse, double> _f$discount = Field(
    'discount',
    _$discount,
    opt: true,
  );
  static double? _$finalTotal(ApplyCouponResponse v) => v.finalTotal;
  static const Field<ApplyCouponResponse, double> _f$finalTotal = Field(
    'finalTotal',
    _$finalTotal,
    opt: true,
  );
  static DiscountBreakdown? _$discountBreakdown(ApplyCouponResponse v) =>
      v.discountBreakdown;
  static const Field<ApplyCouponResponse, DiscountBreakdown>
  _f$discountBreakdown = Field(
    'discountBreakdown',
    _$discountBreakdown,
    opt: true,
  );

  @override
  final MappableFields<ApplyCouponResponse> fields = const {
    #subtotal: _f$subtotal,
    #discount: _f$discount,
    #finalTotal: _f$finalTotal,
    #discountBreakdown: _f$discountBreakdown,
  };

  static ApplyCouponResponse _instantiate(DecodingData data) {
    return ApplyCouponResponse(
      subtotal: data.dec(_f$subtotal),
      discount: data.dec(_f$discount),
      finalTotal: data.dec(_f$finalTotal),
      discountBreakdown: data.dec(_f$discountBreakdown),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ApplyCouponResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ApplyCouponResponse>(map);
  }

  static ApplyCouponResponse fromJson(String json) {
    return ensureInitialized().decodeJson<ApplyCouponResponse>(json);
  }
}

mixin ApplyCouponResponseMappable {
  String toJson() {
    return ApplyCouponResponseMapper.ensureInitialized()
        .encodeJson<ApplyCouponResponse>(this as ApplyCouponResponse);
  }

  Map<String, dynamic> toMap() {
    return ApplyCouponResponseMapper.ensureInitialized()
        .encodeMap<ApplyCouponResponse>(this as ApplyCouponResponse);
  }

  ApplyCouponResponseCopyWith<
    ApplyCouponResponse,
    ApplyCouponResponse,
    ApplyCouponResponse
  >
  get copyWith =>
      _ApplyCouponResponseCopyWithImpl<
        ApplyCouponResponse,
        ApplyCouponResponse
      >(this as ApplyCouponResponse, $identity, $identity);
  @override
  String toString() {
    return ApplyCouponResponseMapper.ensureInitialized().stringifyValue(
      this as ApplyCouponResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return ApplyCouponResponseMapper.ensureInitialized().equalsValue(
      this as ApplyCouponResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return ApplyCouponResponseMapper.ensureInitialized().hashValue(
      this as ApplyCouponResponse,
    );
  }
}

extension ApplyCouponResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ApplyCouponResponse, $Out> {
  ApplyCouponResponseCopyWith<$R, ApplyCouponResponse, $Out>
  get $asApplyCouponResponse => $base.as(
    (v, t, t2) => _ApplyCouponResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ApplyCouponResponseCopyWith<
  $R,
  $In extends ApplyCouponResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  DiscountBreakdownCopyWith<$R, DiscountBreakdown, DiscountBreakdown>?
  get discountBreakdown;
  $R call({
    double? subtotal,
    double? discount,
    double? finalTotal,
    DiscountBreakdown? discountBreakdown,
  });
  ApplyCouponResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ApplyCouponResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ApplyCouponResponse, $Out>
    implements ApplyCouponResponseCopyWith<$R, ApplyCouponResponse, $Out> {
  _ApplyCouponResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ApplyCouponResponse> $mapper =
      ApplyCouponResponseMapper.ensureInitialized();
  @override
  DiscountBreakdownCopyWith<$R, DiscountBreakdown, DiscountBreakdown>?
  get discountBreakdown => $value.discountBreakdown?.copyWith.$chain(
    (v) => call(discountBreakdown: v),
  );
  @override
  $R call({
    Object? subtotal = $none,
    Object? discount = $none,
    Object? finalTotal = $none,
    Object? discountBreakdown = $none,
  }) => $apply(
    FieldCopyWithData({
      if (subtotal != $none) #subtotal: subtotal,
      if (discount != $none) #discount: discount,
      if (finalTotal != $none) #finalTotal: finalTotal,
      if (discountBreakdown != $none) #discountBreakdown: discountBreakdown,
    }),
  );
  @override
  ApplyCouponResponse $make(CopyWithData data) => ApplyCouponResponse(
    subtotal: data.get(#subtotal, or: $value.subtotal),
    discount: data.get(#discount, or: $value.discount),
    finalTotal: data.get(#finalTotal, or: $value.finalTotal),
    discountBreakdown: data.get(
      #discountBreakdown,
      or: $value.discountBreakdown,
    ),
  );

  @override
  ApplyCouponResponseCopyWith<$R2, ApplyCouponResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ApplyCouponResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DiscountBreakdownMapper extends ClassMapperBase<DiscountBreakdown> {
  DiscountBreakdownMapper._();

  static DiscountBreakdownMapper? _instance;
  static DiscountBreakdownMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DiscountBreakdownMapper._());
      ItemDiscountMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DiscountBreakdown';

  static String? _$type(DiscountBreakdown v) => v.type;
  static const Field<DiscountBreakdown, String> _f$type = Field(
    'type',
    _$type,
    opt: true,
  );
  static double? _$value(DiscountBreakdown v) => v.value;
  static const Field<DiscountBreakdown, double> _f$value = Field(
    'value',
    _$value,
    opt: true,
  );
  static double? _$applied(DiscountBreakdown v) => v.applied;
  static const Field<DiscountBreakdown, double> _f$applied = Field(
    'applied',
    _$applied,
    opt: true,
  );
  static List<ItemDiscount>? _$itemDiscounts(DiscountBreakdown v) =>
      v.itemDiscounts;
  static const Field<DiscountBreakdown, List<ItemDiscount>> _f$itemDiscounts =
      Field('itemDiscounts', _$itemDiscounts, opt: true);

  @override
  final MappableFields<DiscountBreakdown> fields = const {
    #type: _f$type,
    #value: _f$value,
    #applied: _f$applied,
    #itemDiscounts: _f$itemDiscounts,
  };

  static DiscountBreakdown _instantiate(DecodingData data) {
    return DiscountBreakdown(
      type: data.dec(_f$type),
      value: data.dec(_f$value),
      applied: data.dec(_f$applied),
      itemDiscounts: data.dec(_f$itemDiscounts),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DiscountBreakdown fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DiscountBreakdown>(map);
  }

  static DiscountBreakdown fromJson(String json) {
    return ensureInitialized().decodeJson<DiscountBreakdown>(json);
  }
}

mixin DiscountBreakdownMappable {
  String toJson() {
    return DiscountBreakdownMapper.ensureInitialized()
        .encodeJson<DiscountBreakdown>(this as DiscountBreakdown);
  }

  Map<String, dynamic> toMap() {
    return DiscountBreakdownMapper.ensureInitialized()
        .encodeMap<DiscountBreakdown>(this as DiscountBreakdown);
  }

  DiscountBreakdownCopyWith<
    DiscountBreakdown,
    DiscountBreakdown,
    DiscountBreakdown
  >
  get copyWith =>
      _DiscountBreakdownCopyWithImpl<DiscountBreakdown, DiscountBreakdown>(
        this as DiscountBreakdown,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DiscountBreakdownMapper.ensureInitialized().stringifyValue(
      this as DiscountBreakdown,
    );
  }

  @override
  bool operator ==(Object other) {
    return DiscountBreakdownMapper.ensureInitialized().equalsValue(
      this as DiscountBreakdown,
      other,
    );
  }

  @override
  int get hashCode {
    return DiscountBreakdownMapper.ensureInitialized().hashValue(
      this as DiscountBreakdown,
    );
  }
}

extension DiscountBreakdownValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DiscountBreakdown, $Out> {
  DiscountBreakdownCopyWith<$R, DiscountBreakdown, $Out>
  get $asDiscountBreakdown => $base.as(
    (v, t, t2) => _DiscountBreakdownCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class DiscountBreakdownCopyWith<
  $R,
  $In extends DiscountBreakdown,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    ItemDiscount,
    ItemDiscountCopyWith<$R, ItemDiscount, ItemDiscount>
  >?
  get itemDiscounts;
  $R call({
    String? type,
    double? value,
    double? applied,
    List<ItemDiscount>? itemDiscounts,
  });
  DiscountBreakdownCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DiscountBreakdownCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DiscountBreakdown, $Out>
    implements DiscountBreakdownCopyWith<$R, DiscountBreakdown, $Out> {
  _DiscountBreakdownCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DiscountBreakdown> $mapper =
      DiscountBreakdownMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    ItemDiscount,
    ItemDiscountCopyWith<$R, ItemDiscount, ItemDiscount>
  >?
  get itemDiscounts => $value.itemDiscounts != null
      ? ListCopyWith(
          $value.itemDiscounts!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(itemDiscounts: v),
        )
      : null;
  @override
  $R call({
    Object? type = $none,
    Object? value = $none,
    Object? applied = $none,
    Object? itemDiscounts = $none,
  }) => $apply(
    FieldCopyWithData({
      if (type != $none) #type: type,
      if (value != $none) #value: value,
      if (applied != $none) #applied: applied,
      if (itemDiscounts != $none) #itemDiscounts: itemDiscounts,
    }),
  );
  @override
  DiscountBreakdown $make(CopyWithData data) => DiscountBreakdown(
    type: data.get(#type, or: $value.type),
    value: data.get(#value, or: $value.value),
    applied: data.get(#applied, or: $value.applied),
    itemDiscounts: data.get(#itemDiscounts, or: $value.itemDiscounts),
  );

  @override
  DiscountBreakdownCopyWith<$R2, DiscountBreakdown, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DiscountBreakdownCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ItemDiscountMapper extends ClassMapperBase<ItemDiscount> {
  ItemDiscountMapper._();

  static ItemDiscountMapper? _instance;
  static ItemDiscountMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ItemDiscountMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ItemDiscount';

  static String? _$productId(ItemDiscount v) => v.productId;
  static const Field<ItemDiscount, String> _f$productId = Field(
    'productId',
    _$productId,
    opt: true,
    hook: SafeStringHook(),
  );
  static double? _$originalPrice(ItemDiscount v) => v.originalPrice;
  static const Field<ItemDiscount, double> _f$originalPrice = Field(
    'originalPrice',
    _$originalPrice,
    opt: true,
  );
  static double? _$discountAmount(ItemDiscount v) => v.discountAmount;
  static const Field<ItemDiscount, double> _f$discountAmount = Field(
    'discountAmount',
    _$discountAmount,
    opt: true,
  );
  static double? _$finalPrice(ItemDiscount v) => v.finalPrice;
  static const Field<ItemDiscount, double> _f$finalPrice = Field(
    'finalPrice',
    _$finalPrice,
    opt: true,
  );

  @override
  final MappableFields<ItemDiscount> fields = const {
    #productId: _f$productId,
    #originalPrice: _f$originalPrice,
    #discountAmount: _f$discountAmount,
    #finalPrice: _f$finalPrice,
  };

  static ItemDiscount _instantiate(DecodingData data) {
    return ItemDiscount(
      productId: data.dec(_f$productId),
      originalPrice: data.dec(_f$originalPrice),
      discountAmount: data.dec(_f$discountAmount),
      finalPrice: data.dec(_f$finalPrice),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ItemDiscount fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ItemDiscount>(map);
  }

  static ItemDiscount fromJson(String json) {
    return ensureInitialized().decodeJson<ItemDiscount>(json);
  }
}

mixin ItemDiscountMappable {
  String toJson() {
    return ItemDiscountMapper.ensureInitialized().encodeJson<ItemDiscount>(
      this as ItemDiscount,
    );
  }

  Map<String, dynamic> toMap() {
    return ItemDiscountMapper.ensureInitialized().encodeMap<ItemDiscount>(
      this as ItemDiscount,
    );
  }

  ItemDiscountCopyWith<ItemDiscount, ItemDiscount, ItemDiscount> get copyWith =>
      _ItemDiscountCopyWithImpl<ItemDiscount, ItemDiscount>(
        this as ItemDiscount,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ItemDiscountMapper.ensureInitialized().stringifyValue(
      this as ItemDiscount,
    );
  }

  @override
  bool operator ==(Object other) {
    return ItemDiscountMapper.ensureInitialized().equalsValue(
      this as ItemDiscount,
      other,
    );
  }

  @override
  int get hashCode {
    return ItemDiscountMapper.ensureInitialized().hashValue(
      this as ItemDiscount,
    );
  }
}

extension ItemDiscountValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ItemDiscount, $Out> {
  ItemDiscountCopyWith<$R, ItemDiscount, $Out> get $asItemDiscount =>
      $base.as((v, t, t2) => _ItemDiscountCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ItemDiscountCopyWith<$R, $In extends ItemDiscount, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? productId,
    double? originalPrice,
    double? discountAmount,
    double? finalPrice,
  });
  ItemDiscountCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ItemDiscountCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ItemDiscount, $Out>
    implements ItemDiscountCopyWith<$R, ItemDiscount, $Out> {
  _ItemDiscountCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ItemDiscount> $mapper =
      ItemDiscountMapper.ensureInitialized();
  @override
  $R call({
    Object? productId = $none,
    Object? originalPrice = $none,
    Object? discountAmount = $none,
    Object? finalPrice = $none,
  }) => $apply(
    FieldCopyWithData({
      if (productId != $none) #productId: productId,
      if (originalPrice != $none) #originalPrice: originalPrice,
      if (discountAmount != $none) #discountAmount: discountAmount,
      if (finalPrice != $none) #finalPrice: finalPrice,
    }),
  );
  @override
  ItemDiscount $make(CopyWithData data) => ItemDiscount(
    productId: data.get(#productId, or: $value.productId),
    originalPrice: data.get(#originalPrice, or: $value.originalPrice),
    discountAmount: data.get(#discountAmount, or: $value.discountAmount),
    finalPrice: data.get(#finalPrice, or: $value.finalPrice),
  );

  @override
  ItemDiscountCopyWith<$R2, ItemDiscount, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ItemDiscountCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

