// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pet_response.dart';

class PetResponseMapper extends ClassMapperBase<PetResponse> {
  PetResponseMapper._();

  static PetResponseMapper? _instance;
  static PetResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PetResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PetResponse';

  static String _$id(PetResponse v) => v.id;
  static const Field<PetResponse, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$name(PetResponse v) => v.name;
  static const Field<PetResponse, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$breed(PetResponse v) => v.breed;
  static const Field<PetResponse, String> _f$breed = Field(
    'breed',
    _$breed,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<PetResponse> fields = const {
    #id: _f$id,
    #name: _f$name,
    #breed: _f$breed,
  };

  static PetResponse _instantiate(DecodingData data) {
    return PetResponse(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      breed: data.dec(_f$breed),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PetResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PetResponse>(map);
  }

  static PetResponse fromJson(String json) {
    return ensureInitialized().decodeJson<PetResponse>(json);
  }
}

mixin PetResponseMappable {
  String toJson() {
    return PetResponseMapper.ensureInitialized().encodeJson<PetResponse>(
      this as PetResponse,
    );
  }

  Map<String, dynamic> toMap() {
    return PetResponseMapper.ensureInitialized().encodeMap<PetResponse>(
      this as PetResponse,
    );
  }

  PetResponseCopyWith<PetResponse, PetResponse, PetResponse> get copyWith =>
      _PetResponseCopyWithImpl<PetResponse, PetResponse>(
        this as PetResponse,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PetResponseMapper.ensureInitialized().stringifyValue(
      this as PetResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return PetResponseMapper.ensureInitialized().equalsValue(
      this as PetResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return PetResponseMapper.ensureInitialized().hashValue(this as PetResponse);
  }
}

extension PetResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PetResponse, $Out> {
  PetResponseCopyWith<$R, PetResponse, $Out> get $asPetResponse =>
      $base.as((v, t, t2) => _PetResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PetResponseCopyWith<$R, $In extends PetResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name, String? breed});
  PetResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PetResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PetResponse, $Out>
    implements PetResponseCopyWith<$R, PetResponse, $Out> {
  _PetResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PetResponse> $mapper =
      PetResponseMapper.ensureInitialized();
  @override
  $R call({String? id, String? name, String? breed}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (breed != null) #breed: breed,
    }),
  );
  @override
  PetResponse $make(CopyWithData data) => PetResponse(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    breed: data.get(#breed, or: $value.breed),
  );

  @override
  PetResponseCopyWith<$R2, PetResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PetResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

