// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'save_house_details_response.dart';

class SaveHouseDetailsResponseMapper
    extends ClassMapperBase<SaveHouseDetailsResponse> {
  SaveHouseDetailsResponseMapper._();

  static SaveHouseDetailsResponseMapper? _instance;
  static SaveHouseDetailsResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = SaveHouseDetailsResponseMapper._(),
      );
      ParentGroupResponseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SaveHouseDetailsResponse';

  static ParentGroupResponse? _$parentGroup(SaveHouseDetailsResponse v) =>
      v.parentGroup;
  static const Field<SaveHouseDetailsResponse, ParentGroupResponse>
  _f$parentGroup = Field('parentGroup', _$parentGroup, opt: true);
  static bool _$onboardingCompleted(SaveHouseDetailsResponse v) =>
      v.onboardingCompleted;
  static const Field<SaveHouseDetailsResponse, bool> _f$onboardingCompleted =
      Field(
        'onboardingCompleted',
        _$onboardingCompleted,
        opt: true,
        def: false,
        hook: SafeBoolHook(),
      );

  @override
  final MappableFields<SaveHouseDetailsResponse> fields = const {
    #parentGroup: _f$parentGroup,
    #onboardingCompleted: _f$onboardingCompleted,
  };

  static SaveHouseDetailsResponse _instantiate(DecodingData data) {
    return SaveHouseDetailsResponse(
      parentGroup: data.dec(_f$parentGroup),
      onboardingCompleted: data.dec(_f$onboardingCompleted),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SaveHouseDetailsResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SaveHouseDetailsResponse>(map);
  }

  static SaveHouseDetailsResponse fromJson(String json) {
    return ensureInitialized().decodeJson<SaveHouseDetailsResponse>(json);
  }
}

mixin SaveHouseDetailsResponseMappable {
  String toJson() {
    return SaveHouseDetailsResponseMapper.ensureInitialized()
        .encodeJson<SaveHouseDetailsResponse>(this as SaveHouseDetailsResponse);
  }

  Map<String, dynamic> toMap() {
    return SaveHouseDetailsResponseMapper.ensureInitialized()
        .encodeMap<SaveHouseDetailsResponse>(this as SaveHouseDetailsResponse);
  }

  SaveHouseDetailsResponseCopyWith<
    SaveHouseDetailsResponse,
    SaveHouseDetailsResponse,
    SaveHouseDetailsResponse
  >
  get copyWith =>
      _SaveHouseDetailsResponseCopyWithImpl<
        SaveHouseDetailsResponse,
        SaveHouseDetailsResponse
      >(this as SaveHouseDetailsResponse, $identity, $identity);
  @override
  String toString() {
    return SaveHouseDetailsResponseMapper.ensureInitialized().stringifyValue(
      this as SaveHouseDetailsResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return SaveHouseDetailsResponseMapper.ensureInitialized().equalsValue(
      this as SaveHouseDetailsResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return SaveHouseDetailsResponseMapper.ensureInitialized().hashValue(
      this as SaveHouseDetailsResponse,
    );
  }
}

extension SaveHouseDetailsResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SaveHouseDetailsResponse, $Out> {
  SaveHouseDetailsResponseCopyWith<$R, SaveHouseDetailsResponse, $Out>
  get $asSaveHouseDetailsResponse => $base.as(
    (v, t, t2) => _SaveHouseDetailsResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class SaveHouseDetailsResponseCopyWith<
  $R,
  $In extends SaveHouseDetailsResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ParentGroupResponseCopyWith<$R, ParentGroupResponse, ParentGroupResponse>?
  get parentGroup;
  $R call({ParentGroupResponse? parentGroup, bool? onboardingCompleted});
  SaveHouseDetailsResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _SaveHouseDetailsResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SaveHouseDetailsResponse, $Out>
    implements
        SaveHouseDetailsResponseCopyWith<$R, SaveHouseDetailsResponse, $Out> {
  _SaveHouseDetailsResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SaveHouseDetailsResponse> $mapper =
      SaveHouseDetailsResponseMapper.ensureInitialized();
  @override
  ParentGroupResponseCopyWith<$R, ParentGroupResponse, ParentGroupResponse>?
  get parentGroup =>
      $value.parentGroup?.copyWith.$chain((v) => call(parentGroup: v));
  @override
  $R call({Object? parentGroup = $none, bool? onboardingCompleted}) => $apply(
    FieldCopyWithData({
      if (parentGroup != $none) #parentGroup: parentGroup,
      if (onboardingCompleted != null)
        #onboardingCompleted: onboardingCompleted,
    }),
  );
  @override
  SaveHouseDetailsResponse $make(CopyWithData data) => SaveHouseDetailsResponse(
    parentGroup: data.get(#parentGroup, or: $value.parentGroup),
    onboardingCompleted: data.get(
      #onboardingCompleted,
      or: $value.onboardingCompleted,
    ),
  );

  @override
  SaveHouseDetailsResponseCopyWith<$R2, SaveHouseDetailsResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SaveHouseDetailsResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ParentGroupResponseMapper extends ClassMapperBase<ParentGroupResponse> {
  ParentGroupResponseMapper._();

  static ParentGroupResponseMapper? _instance;
  static ParentGroupResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ParentGroupResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ParentGroupResponse';

  static String _$id(ParentGroupResponse v) => v.id;
  static const Field<ParentGroupResponse, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$houseName(ParentGroupResponse v) => v.houseName;
  static const Field<ParentGroupResponse, String> _f$houseName = Field(
    'houseName',
    _$houseName,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$parentName(ParentGroupResponse v) => v.parentName;
  static const Field<ParentGroupResponse, String> _f$parentName = Field(
    'parentName',
    _$parentName,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$createdBy(ParentGroupResponse v) => v.createdBy;
  static const Field<ParentGroupResponse, String> _f$createdBy = Field(
    'createdBy',
    _$createdBy,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$createdAt(ParentGroupResponse v) => v.createdAt;
  static const Field<ParentGroupResponse, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$updatedAt(ParentGroupResponse v) => v.updatedAt;
  static const Field<ParentGroupResponse, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$deletedAt(ParentGroupResponse v) => v.deletedAt;
  static const Field<ParentGroupResponse, String> _f$deletedAt = Field(
    'deletedAt',
    _$deletedAt,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$createdByLegacy(ParentGroupResponse v) => v.createdByLegacy;
  static const Field<ParentGroupResponse, String> _f$createdByLegacy = Field(
    'createdByLegacy',
    _$createdByLegacy,
    key: r'created_by',
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<ParentGroupResponse> fields = const {
    #id: _f$id,
    #houseName: _f$houseName,
    #parentName: _f$parentName,
    #createdBy: _f$createdBy,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #deletedAt: _f$deletedAt,
    #createdByLegacy: _f$createdByLegacy,
  };

  static ParentGroupResponse _instantiate(DecodingData data) {
    return ParentGroupResponse(
      id: data.dec(_f$id),
      houseName: data.dec(_f$houseName),
      parentName: data.dec(_f$parentName),
      createdBy: data.dec(_f$createdBy),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      deletedAt: data.dec(_f$deletedAt),
      createdByLegacy: data.dec(_f$createdByLegacy),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ParentGroupResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ParentGroupResponse>(map);
  }

  static ParentGroupResponse fromJson(String json) {
    return ensureInitialized().decodeJson<ParentGroupResponse>(json);
  }
}

mixin ParentGroupResponseMappable {
  String toJson() {
    return ParentGroupResponseMapper.ensureInitialized()
        .encodeJson<ParentGroupResponse>(this as ParentGroupResponse);
  }

  Map<String, dynamic> toMap() {
    return ParentGroupResponseMapper.ensureInitialized()
        .encodeMap<ParentGroupResponse>(this as ParentGroupResponse);
  }

  ParentGroupResponseCopyWith<
    ParentGroupResponse,
    ParentGroupResponse,
    ParentGroupResponse
  >
  get copyWith =>
      _ParentGroupResponseCopyWithImpl<
        ParentGroupResponse,
        ParentGroupResponse
      >(this as ParentGroupResponse, $identity, $identity);
  @override
  String toString() {
    return ParentGroupResponseMapper.ensureInitialized().stringifyValue(
      this as ParentGroupResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return ParentGroupResponseMapper.ensureInitialized().equalsValue(
      this as ParentGroupResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return ParentGroupResponseMapper.ensureInitialized().hashValue(
      this as ParentGroupResponse,
    );
  }
}

extension ParentGroupResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ParentGroupResponse, $Out> {
  ParentGroupResponseCopyWith<$R, ParentGroupResponse, $Out>
  get $asParentGroupResponse => $base.as(
    (v, t, t2) => _ParentGroupResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ParentGroupResponseCopyWith<
  $R,
  $In extends ParentGroupResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? houseName,
    String? parentName,
    String? createdBy,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? createdByLegacy,
  });
  ParentGroupResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ParentGroupResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ParentGroupResponse, $Out>
    implements ParentGroupResponseCopyWith<$R, ParentGroupResponse, $Out> {
  _ParentGroupResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ParentGroupResponse> $mapper =
      ParentGroupResponseMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? houseName,
    String? parentName,
    String? createdBy,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? createdByLegacy,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (houseName != null) #houseName: houseName,
      if (parentName != null) #parentName: parentName,
      if (createdBy != null) #createdBy: createdBy,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
      if (deletedAt != null) #deletedAt: deletedAt,
      if (createdByLegacy != null) #createdByLegacy: createdByLegacy,
    }),
  );
  @override
  ParentGroupResponse $make(CopyWithData data) => ParentGroupResponse(
    id: data.get(#id, or: $value.id),
    houseName: data.get(#houseName, or: $value.houseName),
    parentName: data.get(#parentName, or: $value.parentName),
    createdBy: data.get(#createdBy, or: $value.createdBy),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    deletedAt: data.get(#deletedAt, or: $value.deletedAt),
    createdByLegacy: data.get(#createdByLegacy, or: $value.createdByLegacy),
  );

  @override
  ParentGroupResponseCopyWith<$R2, ParentGroupResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ParentGroupResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

