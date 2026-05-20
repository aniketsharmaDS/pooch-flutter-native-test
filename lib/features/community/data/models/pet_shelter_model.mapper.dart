// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pet_shelter_model.dart';

class PetShelterModelMapper extends ClassMapperBase<PetShelterModel> {
  PetShelterModelMapper._();

  static PetShelterModelMapper? _instance;
  static PetShelterModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PetShelterModelMapper._());
      PhoneNumberMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PetShelterModel';

  static String _$id(PetShelterModel v) => v.id;
  static const Field<PetShelterModel, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static String _$shelterName(PetShelterModel v) => v.shelterName;
  static const Field<PetShelterModel, String> _f$shelterName = Field(
    'shelterName',
    _$shelterName,
    opt: true,
    def: '',
  );
  static String _$shelterType(PetShelterModel v) => v.shelterType;
  static const Field<PetShelterModel, String> _f$shelterType = Field(
    'shelterType',
    _$shelterType,
    opt: true,
    def: '',
  );
  static String _$email(PetShelterModel v) => v.email;
  static const Field<PetShelterModel, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
    def: '',
  );
  static String _$website(PetShelterModel v) => v.website;
  static const Field<PetShelterModel, String> _f$website = Field(
    'website',
    _$website,
    opt: true,
    def: '',
  );
  static String _$address(PetShelterModel v) => v.address;
  static const Field<PetShelterModel, String> _f$address = Field(
    'address',
    _$address,
    opt: true,
    def: '',
  );
  static String _$city(PetShelterModel v) => v.city;
  static const Field<PetShelterModel, String> _f$city = Field(
    'city',
    _$city,
    opt: true,
    def: '',
  );
  static String _$state(PetShelterModel v) => v.state;
  static const Field<PetShelterModel, String> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: '',
  );
  static String _$pincode(PetShelterModel v) => v.pincode;
  static const Field<PetShelterModel, String> _f$pincode = Field(
    'pincode',
    _$pincode,
    opt: true,
    def: '',
  );
  static String _$country(PetShelterModel v) => v.country;
  static const Field<PetShelterModel, String> _f$country = Field(
    'country',
    _$country,
    opt: true,
    def: '',
  );
  static String _$latitude(PetShelterModel v) => v.latitude;
  static const Field<PetShelterModel, String> _f$latitude = Field(
    'latitude',
    _$latitude,
    opt: true,
    def: '',
  );
  static String _$longitude(PetShelterModel v) => v.longitude;
  static const Field<PetShelterModel, String> _f$longitude = Field(
    'longitude',
    _$longitude,
    opt: true,
    def: '',
  );
  static List<PhoneNumber> _$phoneNumbers(PetShelterModel v) => v.phoneNumbers;
  static const Field<PetShelterModel, List<PhoneNumber>> _f$phoneNumbers =
      Field(
        'phoneNumbers',
        _$phoneNumbers,
        key: r'phone_numbers',
        opt: true,
        def: const [],
        hook: SafeListHook(),
      );
  static String _$description(PetShelterModel v) => v.description;
  static const Field<PetShelterModel, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
  );
  static String _$status(PetShelterModel v) => v.status;
  static const Field<PetShelterModel, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
    def: '',
  );
  static bool _$isDeleted(PetShelterModel v) => v.isDeleted;
  static const Field<PetShelterModel, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static String _$deletedAt(PetShelterModel v) => v.deletedAt;
  static const Field<PetShelterModel, String> _f$deletedAt = Field(
    'deletedAt',
    _$deletedAt,
    opt: true,
    def: '',
  );
  static String _$deletedBy(PetShelterModel v) => v.deletedBy;
  static const Field<PetShelterModel, String> _f$deletedBy = Field(
    'deletedBy',
    _$deletedBy,
    opt: true,
    def: '',
  );
  static String _$createdAt(PetShelterModel v) => v.createdAt;
  static const Field<PetShelterModel, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
    def: '',
  );
  static String _$updatedAt(PetShelterModel v) => v.updatedAt;
  static const Field<PetShelterModel, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<PetShelterModel> fields = const {
    #id: _f$id,
    #shelterName: _f$shelterName,
    #shelterType: _f$shelterType,
    #email: _f$email,
    #website: _f$website,
    #address: _f$address,
    #city: _f$city,
    #state: _f$state,
    #pincode: _f$pincode,
    #country: _f$country,
    #latitude: _f$latitude,
    #longitude: _f$longitude,
    #phoneNumbers: _f$phoneNumbers,
    #description: _f$description,
    #status: _f$status,
    #isDeleted: _f$isDeleted,
    #deletedAt: _f$deletedAt,
    #deletedBy: _f$deletedBy,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static PetShelterModel _instantiate(DecodingData data) {
    return PetShelterModel(
      id: data.dec(_f$id),
      shelterName: data.dec(_f$shelterName),
      shelterType: data.dec(_f$shelterType),
      email: data.dec(_f$email),
      website: data.dec(_f$website),
      address: data.dec(_f$address),
      city: data.dec(_f$city),
      state: data.dec(_f$state),
      pincode: data.dec(_f$pincode),
      country: data.dec(_f$country),
      latitude: data.dec(_f$latitude),
      longitude: data.dec(_f$longitude),
      phoneNumbers: data.dec(_f$phoneNumbers),
      description: data.dec(_f$description),
      status: data.dec(_f$status),
      isDeleted: data.dec(_f$isDeleted),
      deletedAt: data.dec(_f$deletedAt),
      deletedBy: data.dec(_f$deletedBy),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PetShelterModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PetShelterModel>(map);
  }

  static PetShelterModel fromJson(String json) {
    return ensureInitialized().decodeJson<PetShelterModel>(json);
  }
}

mixin PetShelterModelMappable {
  String toJson() {
    return PetShelterModelMapper.ensureInitialized()
        .encodeJson<PetShelterModel>(this as PetShelterModel);
  }

  Map<String, dynamic> toMap() {
    return PetShelterModelMapper.ensureInitialized().encodeMap<PetShelterModel>(
      this as PetShelterModel,
    );
  }

  PetShelterModelCopyWith<PetShelterModel, PetShelterModel, PetShelterModel>
  get copyWith =>
      _PetShelterModelCopyWithImpl<PetShelterModel, PetShelterModel>(
        this as PetShelterModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PetShelterModelMapper.ensureInitialized().stringifyValue(
      this as PetShelterModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return PetShelterModelMapper.ensureInitialized().equalsValue(
      this as PetShelterModel,
      other,
    );
  }

  @override
  int get hashCode {
    return PetShelterModelMapper.ensureInitialized().hashValue(
      this as PetShelterModel,
    );
  }
}

extension PetShelterModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PetShelterModel, $Out> {
  PetShelterModelCopyWith<$R, PetShelterModel, $Out> get $asPetShelterModel =>
      $base.as((v, t, t2) => _PetShelterModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PetShelterModelCopyWith<$R, $In extends PetShelterModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    PhoneNumber,
    PhoneNumberCopyWith<$R, PhoneNumber, PhoneNumber>
  >
  get phoneNumbers;
  $R call({
    String? id,
    String? shelterName,
    String? shelterType,
    String? email,
    String? website,
    String? address,
    String? city,
    String? state,
    String? pincode,
    String? country,
    String? latitude,
    String? longitude,
    List<PhoneNumber>? phoneNumbers,
    String? description,
    String? status,
    bool? isDeleted,
    String? deletedAt,
    String? deletedBy,
    String? createdAt,
    String? updatedAt,
  });
  PetShelterModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PetShelterModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PetShelterModel, $Out>
    implements PetShelterModelCopyWith<$R, PetShelterModel, $Out> {
  _PetShelterModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PetShelterModel> $mapper =
      PetShelterModelMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    PhoneNumber,
    PhoneNumberCopyWith<$R, PhoneNumber, PhoneNumber>
  >
  get phoneNumbers => ListCopyWith(
    $value.phoneNumbers,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(phoneNumbers: v),
  );
  @override
  $R call({
    String? id,
    String? shelterName,
    String? shelterType,
    String? email,
    String? website,
    String? address,
    String? city,
    String? state,
    String? pincode,
    String? country,
    String? latitude,
    String? longitude,
    List<PhoneNumber>? phoneNumbers,
    String? description,
    String? status,
    bool? isDeleted,
    String? deletedAt,
    String? deletedBy,
    String? createdAt,
    String? updatedAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (shelterName != null) #shelterName: shelterName,
      if (shelterType != null) #shelterType: shelterType,
      if (email != null) #email: email,
      if (website != null) #website: website,
      if (address != null) #address: address,
      if (city != null) #city: city,
      if (state != null) #state: state,
      if (pincode != null) #pincode: pincode,
      if (country != null) #country: country,
      if (latitude != null) #latitude: latitude,
      if (longitude != null) #longitude: longitude,
      if (phoneNumbers != null) #phoneNumbers: phoneNumbers,
      if (description != null) #description: description,
      if (status != null) #status: status,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (deletedAt != null) #deletedAt: deletedAt,
      if (deletedBy != null) #deletedBy: deletedBy,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
    }),
  );
  @override
  PetShelterModel $make(CopyWithData data) => PetShelterModel(
    id: data.get(#id, or: $value.id),
    shelterName: data.get(#shelterName, or: $value.shelterName),
    shelterType: data.get(#shelterType, or: $value.shelterType),
    email: data.get(#email, or: $value.email),
    website: data.get(#website, or: $value.website),
    address: data.get(#address, or: $value.address),
    city: data.get(#city, or: $value.city),
    state: data.get(#state, or: $value.state),
    pincode: data.get(#pincode, or: $value.pincode),
    country: data.get(#country, or: $value.country),
    latitude: data.get(#latitude, or: $value.latitude),
    longitude: data.get(#longitude, or: $value.longitude),
    phoneNumbers: data.get(#phoneNumbers, or: $value.phoneNumbers),
    description: data.get(#description, or: $value.description),
    status: data.get(#status, or: $value.status),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    deletedAt: data.get(#deletedAt, or: $value.deletedAt),
    deletedBy: data.get(#deletedBy, or: $value.deletedBy),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
  );

  @override
  PetShelterModelCopyWith<$R2, PetShelterModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PetShelterModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PhoneNumberMapper extends ClassMapperBase<PhoneNumber> {
  PhoneNumberMapper._();

  static PhoneNumberMapper? _instance;
  static PhoneNumberMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PhoneNumberMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PhoneNumber';

  static String _$type(PhoneNumber v) => v.type;
  static const Field<PhoneNumber, String> _f$type = Field(
    'type',
    _$type,
    opt: true,
    def: '',
  );
  static String _$number(PhoneNumber v) => v.number;
  static const Field<PhoneNumber, String> _f$number = Field(
    'number',
    _$number,
    opt: true,
    def: '',
  );
  static String _$country(PhoneNumber v) => v.country;
  static const Field<PhoneNumber, String> _f$country = Field(
    'country',
    _$country,
    opt: true,
    def: '',
  );
  static String _$countryCode(PhoneNumber v) => v.countryCode;
  static const Field<PhoneNumber, String> _f$countryCode = Field(
    'countryCode',
    _$countryCode,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<PhoneNumber> fields = const {
    #type: _f$type,
    #number: _f$number,
    #country: _f$country,
    #countryCode: _f$countryCode,
  };

  static PhoneNumber _instantiate(DecodingData data) {
    return PhoneNumber(
      type: data.dec(_f$type),
      number: data.dec(_f$number),
      country: data.dec(_f$country),
      countryCode: data.dec(_f$countryCode),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PhoneNumber fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PhoneNumber>(map);
  }

  static PhoneNumber fromJson(String json) {
    return ensureInitialized().decodeJson<PhoneNumber>(json);
  }
}

mixin PhoneNumberMappable {
  String toJson() {
    return PhoneNumberMapper.ensureInitialized().encodeJson<PhoneNumber>(
      this as PhoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return PhoneNumberMapper.ensureInitialized().encodeMap<PhoneNumber>(
      this as PhoneNumber,
    );
  }

  PhoneNumberCopyWith<PhoneNumber, PhoneNumber, PhoneNumber> get copyWith =>
      _PhoneNumberCopyWithImpl<PhoneNumber, PhoneNumber>(
        this as PhoneNumber,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PhoneNumberMapper.ensureInitialized().stringifyValue(
      this as PhoneNumber,
    );
  }

  @override
  bool operator ==(Object other) {
    return PhoneNumberMapper.ensureInitialized().equalsValue(
      this as PhoneNumber,
      other,
    );
  }

  @override
  int get hashCode {
    return PhoneNumberMapper.ensureInitialized().hashValue(this as PhoneNumber);
  }
}

extension PhoneNumberValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PhoneNumber, $Out> {
  PhoneNumberCopyWith<$R, PhoneNumber, $Out> get $asPhoneNumber =>
      $base.as((v, t, t2) => _PhoneNumberCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PhoneNumberCopyWith<$R, $In extends PhoneNumber, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? type, String? number, String? country, String? countryCode});
  PhoneNumberCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PhoneNumberCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PhoneNumber, $Out>
    implements PhoneNumberCopyWith<$R, PhoneNumber, $Out> {
  _PhoneNumberCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PhoneNumber> $mapper =
      PhoneNumberMapper.ensureInitialized();
  @override
  $R call({
    String? type,
    String? number,
    String? country,
    String? countryCode,
  }) => $apply(
    FieldCopyWithData({
      if (type != null) #type: type,
      if (number != null) #number: number,
      if (country != null) #country: country,
      if (countryCode != null) #countryCode: countryCode,
    }),
  );
  @override
  PhoneNumber $make(CopyWithData data) => PhoneNumber(
    type: data.get(#type, or: $value.type),
    number: data.get(#number, or: $value.number),
    country: data.get(#country, or: $value.country),
    countryCode: data.get(#countryCode, or: $value.countryCode),
  );

  @override
  PhoneNumberCopyWith<$R2, PhoneNumber, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PhoneNumberCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

