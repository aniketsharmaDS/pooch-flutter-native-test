// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'product_response.dart';

class ProductResponseMapper extends ClassMapperBase<ProductResponse> {
  ProductResponseMapper._();

  static ProductResponseMapper? _instance;
  static ProductResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProductResponse';

  static String _$id(ProductResponse v) => v.id;
  static const Field<ProductResponse, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$name(ProductResponse v) => v.name;
  static const Field<ProductResponse, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static double _$price(ProductResponse v) => v.price;
  static const Field<ProductResponse, double> _f$price = Field(
    'price',
    _$price,
    opt: true,
    def: 0.0,
    hook: SafeDoubleHook(),
  );

  @override
  final MappableFields<ProductResponse> fields = const {
    #id: _f$id,
    #name: _f$name,
    #price: _f$price,
  };

  static ProductResponse _instantiate(DecodingData data) {
    return ProductResponse(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      price: data.dec(_f$price),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProductResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductResponse>(map);
  }

  static ProductResponse fromJson(String json) {
    return ensureInitialized().decodeJson<ProductResponse>(json);
  }
}

mixin ProductResponseMappable {
  String toJson() {
    return ProductResponseMapper.ensureInitialized()
        .encodeJson<ProductResponse>(this as ProductResponse);
  }

  Map<String, dynamic> toMap() {
    return ProductResponseMapper.ensureInitialized().encodeMap<ProductResponse>(
      this as ProductResponse,
    );
  }

  ProductResponseCopyWith<ProductResponse, ProductResponse, ProductResponse>
  get copyWith =>
      _ProductResponseCopyWithImpl<ProductResponse, ProductResponse>(
        this as ProductResponse,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ProductResponseMapper.ensureInitialized().stringifyValue(
      this as ProductResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProductResponseMapper.ensureInitialized().equalsValue(
      this as ProductResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return ProductResponseMapper.ensureInitialized().hashValue(
      this as ProductResponse,
    );
  }
}

extension ProductResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductResponse, $Out> {
  ProductResponseCopyWith<$R, ProductResponse, $Out> get $asProductResponse =>
      $base.as((v, t, t2) => _ProductResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProductResponseCopyWith<$R, $In extends ProductResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name, double? price});
  ProductResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ProductResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductResponse, $Out>
    implements ProductResponseCopyWith<$R, ProductResponse, $Out> {
  _ProductResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProductResponse> $mapper =
      ProductResponseMapper.ensureInitialized();
  @override
  $R call({String? id, String? name, double? price}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (price != null) #price: price,
    }),
  );
  @override
  ProductResponse $make(CopyWithData data) => ProductResponse(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    price: data.get(#price, or: $value.price),
  );

  @override
  ProductResponseCopyWith<$R2, ProductResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ProductResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

