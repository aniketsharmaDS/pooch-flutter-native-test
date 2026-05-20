// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'tips_category_model.dart';

class TipsCategoryModelMapper extends ClassMapperBase<TipsCategoryModel> {
  TipsCategoryModelMapper._();

  static TipsCategoryModelMapper? _instance;
  static TipsCategoryModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TipsCategoryModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TipsCategoryModel';

  static String _$id(TipsCategoryModel v) => v.id;
  static const Field<TipsCategoryModel, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$name(TipsCategoryModel v) => v.name;
  static const Field<TipsCategoryModel, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String? _$nameAr(TipsCategoryModel v) => v.nameAr;
  static const Field<TipsCategoryModel, String> _f$nameAr = Field(
    'nameAr',
    _$nameAr,
    opt: true,
  );

  @override
  final MappableFields<TipsCategoryModel> fields = const {
    #id: _f$id,
    #name: _f$name,
    #nameAr: _f$nameAr,
  };

  static TipsCategoryModel _instantiate(DecodingData data) {
    return TipsCategoryModel(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      nameAr: data.dec(_f$nameAr),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static TipsCategoryModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TipsCategoryModel>(map);
  }

  static TipsCategoryModel fromJson(String json) {
    return ensureInitialized().decodeJson<TipsCategoryModel>(json);
  }
}

mixin TipsCategoryModelMappable {
  String toJson() {
    return TipsCategoryModelMapper.ensureInitialized()
        .encodeJson<TipsCategoryModel>(this as TipsCategoryModel);
  }

  Map<String, dynamic> toMap() {
    return TipsCategoryModelMapper.ensureInitialized()
        .encodeMap<TipsCategoryModel>(this as TipsCategoryModel);
  }

  TipsCategoryModelCopyWith<
    TipsCategoryModel,
    TipsCategoryModel,
    TipsCategoryModel
  >
  get copyWith =>
      _TipsCategoryModelCopyWithImpl<TipsCategoryModel, TipsCategoryModel>(
        this as TipsCategoryModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TipsCategoryModelMapper.ensureInitialized().stringifyValue(
      this as TipsCategoryModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return TipsCategoryModelMapper.ensureInitialized().equalsValue(
      this as TipsCategoryModel,
      other,
    );
  }

  @override
  int get hashCode {
    return TipsCategoryModelMapper.ensureInitialized().hashValue(
      this as TipsCategoryModel,
    );
  }
}

extension TipsCategoryModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TipsCategoryModel, $Out> {
  TipsCategoryModelCopyWith<$R, TipsCategoryModel, $Out>
  get $asTipsCategoryModel => $base.as(
    (v, t, t2) => _TipsCategoryModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class TipsCategoryModelCopyWith<
  $R,
  $In extends TipsCategoryModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name, String? nameAr});
  TipsCategoryModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _TipsCategoryModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TipsCategoryModel, $Out>
    implements TipsCategoryModelCopyWith<$R, TipsCategoryModel, $Out> {
  _TipsCategoryModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TipsCategoryModel> $mapper =
      TipsCategoryModelMapper.ensureInitialized();
  @override
  $R call({String? id, String? name, Object? nameAr = $none}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (nameAr != $none) #nameAr: nameAr,
    }),
  );
  @override
  TipsCategoryModel $make(CopyWithData data) => TipsCategoryModel(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    nameAr: data.get(#nameAr, or: $value.nameAr),
  );

  @override
  TipsCategoryModelCopyWith<$R2, TipsCategoryModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TipsCategoryModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

