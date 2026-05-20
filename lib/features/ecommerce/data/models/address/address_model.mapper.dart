// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'address_model.dart';

class AddressMapper extends ClassMapperBase<Address> {
  AddressMapper._();

  static AddressMapper? _instance;
  static AddressMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AddressMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Address';

  static String _$id(Address v) => v.id;
  static const Field<Address, String> _f$id = Field(
    'id',
    _$id,
    hook: SafeStringHook(),
  );
  static String _$userId(Address v) => v.userId;
  static const Field<Address, String> _f$userId = Field(
    'userId',
    _$userId,
    hook: SafeStringHook(),
  );
  static String _$addressLine(Address v) => v.addressLine;
  static const Field<Address, String> _f$addressLine = Field(
    'addressLine',
    _$addressLine,
    hook: SafeStringHook(),
  );
  static String? _$addressDetails(Address v) => v.addressDetails;
  static const Field<Address, String> _f$addressDetails = Field(
    'addressDetails',
    _$addressDetails,
    opt: true,
  );
  static String _$pincode(Address v) => v.pincode;
  static const Field<Address, String> _f$pincode = Field(
    'pincode',
    _$pincode,
    hook: SafeStringHook(),
  );
  static String _$city(Address v) => v.city;
  static const Field<Address, String> _f$city = Field(
    'city',
    _$city,
    hook: SafeStringHook(),
  );
  static String _$emirate(Address v) => v.emirate;
  static const Field<Address, String> _f$emirate = Field(
    'emirate',
    _$emirate,
    hook: SafeStringHook(),
  );
  static String _$country(Address v) => v.country;
  static const Field<Address, String> _f$country = Field(
    'country',
    _$country,
    hook: SafeStringHook(),
  );
  static String _$latitude(Address v) => v.latitude;
  static const Field<Address, String> _f$latitude = Field(
    'latitude',
    _$latitude,
    hook: SafeStringHook(),
  );
  static String _$longitude(Address v) => v.longitude;
  static const Field<Address, String> _f$longitude = Field(
    'longitude',
    _$longitude,
    hook: SafeStringHook(),
  );
  static String? _$residentName(Address v) => v.residentName;
  static const Field<Address, String> _f$residentName = Field(
    'residentName',
    _$residentName,
    opt: true,
  );
  static String? _$residentPhone(Address v) => v.residentPhone;
  static const Field<Address, String> _f$residentPhone = Field(
    'residentPhone',
    _$residentPhone,
    opt: true,
  );
  static String? _$addressType(Address v) => v.addressType;
  static const Field<Address, String> _f$addressType = Field(
    'addressType',
    _$addressType,
    opt: true,
  );
  static bool _$isPrimary(Address v) => v.isPrimary;
  static const Field<Address, bool> _f$isPrimary = Field(
    'isPrimary',
    _$isPrimary,
    hook: SafeBoolHook(),
  );
  static bool _$isDeleted(Address v) => v.isDeleted;
  static const Field<Address, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    hook: SafeBoolHook(),
  );
  static DateTime _$createdAt(Address v) => v.createdAt;
  static const Field<Address, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static DateTime _$updatedAt(Address v) => v.updatedAt;
  static const Field<Address, DateTime> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
  );

  @override
  final MappableFields<Address> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #addressLine: _f$addressLine,
    #addressDetails: _f$addressDetails,
    #pincode: _f$pincode,
    #city: _f$city,
    #emirate: _f$emirate,
    #country: _f$country,
    #latitude: _f$latitude,
    #longitude: _f$longitude,
    #residentName: _f$residentName,
    #residentPhone: _f$residentPhone,
    #addressType: _f$addressType,
    #isPrimary: _f$isPrimary,
    #isDeleted: _f$isDeleted,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static Address _instantiate(DecodingData data) {
    return Address(
      id: data.dec(_f$id),
      userId: data.dec(_f$userId),
      addressLine: data.dec(_f$addressLine),
      addressDetails: data.dec(_f$addressDetails),
      pincode: data.dec(_f$pincode),
      city: data.dec(_f$city),
      emirate: data.dec(_f$emirate),
      country: data.dec(_f$country),
      latitude: data.dec(_f$latitude),
      longitude: data.dec(_f$longitude),
      residentName: data.dec(_f$residentName),
      residentPhone: data.dec(_f$residentPhone),
      addressType: data.dec(_f$addressType),
      isPrimary: data.dec(_f$isPrimary),
      isDeleted: data.dec(_f$isDeleted),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Address fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Address>(map);
  }

  static Address fromJson(String json) {
    return ensureInitialized().decodeJson<Address>(json);
  }
}

mixin AddressMappable {
  String toJson() {
    return AddressMapper.ensureInitialized().encodeJson<Address>(
      this as Address,
    );
  }

  Map<String, dynamic> toMap() {
    return AddressMapper.ensureInitialized().encodeMap<Address>(
      this as Address,
    );
  }

  AddressCopyWith<Address, Address, Address> get copyWith =>
      _AddressCopyWithImpl<Address, Address>(
        this as Address,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AddressMapper.ensureInitialized().stringifyValue(this as Address);
  }

  @override
  bool operator ==(Object other) {
    return AddressMapper.ensureInitialized().equalsValue(
      this as Address,
      other,
    );
  }

  @override
  int get hashCode {
    return AddressMapper.ensureInitialized().hashValue(this as Address);
  }
}

extension AddressValueCopy<$R, $Out> on ObjectCopyWith<$R, Address, $Out> {
  AddressCopyWith<$R, Address, $Out> get $asAddress =>
      $base.as((v, t, t2) => _AddressCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AddressCopyWith<$R, $In extends Address, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? userId,
    String? addressLine,
    String? addressDetails,
    String? pincode,
    String? city,
    String? emirate,
    String? country,
    String? latitude,
    String? longitude,
    String? residentName,
    String? residentPhone,
    String? addressType,
    bool? isPrimary,
    bool? isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  AddressCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AddressCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Address, $Out>
    implements AddressCopyWith<$R, Address, $Out> {
  _AddressCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Address> $mapper =
      AddressMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? userId,
    String? addressLine,
    Object? addressDetails = $none,
    String? pincode,
    String? city,
    String? emirate,
    String? country,
    String? latitude,
    String? longitude,
    Object? residentName = $none,
    Object? residentPhone = $none,
    Object? addressType = $none,
    bool? isPrimary,
    bool? isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (userId != null) #userId: userId,
      if (addressLine != null) #addressLine: addressLine,
      if (addressDetails != $none) #addressDetails: addressDetails,
      if (pincode != null) #pincode: pincode,
      if (city != null) #city: city,
      if (emirate != null) #emirate: emirate,
      if (country != null) #country: country,
      if (latitude != null) #latitude: latitude,
      if (longitude != null) #longitude: longitude,
      if (residentName != $none) #residentName: residentName,
      if (residentPhone != $none) #residentPhone: residentPhone,
      if (addressType != $none) #addressType: addressType,
      if (isPrimary != null) #isPrimary: isPrimary,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
    }),
  );
  @override
  Address $make(CopyWithData data) => Address(
    id: data.get(#id, or: $value.id),
    userId: data.get(#userId, or: $value.userId),
    addressLine: data.get(#addressLine, or: $value.addressLine),
    addressDetails: data.get(#addressDetails, or: $value.addressDetails),
    pincode: data.get(#pincode, or: $value.pincode),
    city: data.get(#city, or: $value.city),
    emirate: data.get(#emirate, or: $value.emirate),
    country: data.get(#country, or: $value.country),
    latitude: data.get(#latitude, or: $value.latitude),
    longitude: data.get(#longitude, or: $value.longitude),
    residentName: data.get(#residentName, or: $value.residentName),
    residentPhone: data.get(#residentPhone, or: $value.residentPhone),
    addressType: data.get(#addressType, or: $value.addressType),
    isPrimary: data.get(#isPrimary, or: $value.isPrimary),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
  );

  @override
  AddressCopyWith<$R2, Address, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AddressCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CreateAddressRequestMapper extends ClassMapperBase<CreateAddressRequest> {
  CreateAddressRequestMapper._();

  static CreateAddressRequestMapper? _instance;
  static CreateAddressRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CreateAddressRequestMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CreateAddressRequest';

  static String _$addressLine(CreateAddressRequest v) => v.addressLine;
  static const Field<CreateAddressRequest, String> _f$addressLine = Field(
    'addressLine',
    _$addressLine,
    key: r'address_line',
    hook: SafeStringHook(),
  );
  static String? _$addressDetails(CreateAddressRequest v) => v.addressDetails;
  static const Field<CreateAddressRequest, String> _f$addressDetails = Field(
    'addressDetails',
    _$addressDetails,
    opt: true,
  );
  static String _$pincode(CreateAddressRequest v) => v.pincode;
  static const Field<CreateAddressRequest, String> _f$pincode = Field(
    'pincode',
    _$pincode,
    hook: SafeStringHook(),
  );
  static String _$city(CreateAddressRequest v) => v.city;
  static const Field<CreateAddressRequest, String> _f$city = Field(
    'city',
    _$city,
    hook: SafeStringHook(),
  );
  static String _$emirate(CreateAddressRequest v) => v.emirate;
  static const Field<CreateAddressRequest, String> _f$emirate = Field(
    'emirate',
    _$emirate,
    hook: SafeStringHook(),
  );
  static String? _$country(CreateAddressRequest v) => v.country;
  static const Field<CreateAddressRequest, String> _f$country = Field(
    'country',
    _$country,
    hook: SafeStringHook(),
  );
  static double _$latitude(CreateAddressRequest v) => v.latitude;
  static const Field<CreateAddressRequest, double> _f$latitude = Field(
    'latitude',
    _$latitude,
    hook: SafeDoubleHook(),
  );
  static double _$longitude(CreateAddressRequest v) => v.longitude;
  static const Field<CreateAddressRequest, double> _f$longitude = Field(
    'longitude',
    _$longitude,
    hook: SafeDoubleHook(),
  );
  static String _$residentName(CreateAddressRequest v) => v.residentName;
  static const Field<CreateAddressRequest, String> _f$residentName = Field(
    'residentName',
    _$residentName,
    hook: SafeStringHook(),
  );
  static String _$residentPhone(CreateAddressRequest v) => v.residentPhone;
  static const Field<CreateAddressRequest, String> _f$residentPhone = Field(
    'residentPhone',
    _$residentPhone,
    hook: SafeStringHook(),
  );
  static String _$addressType(CreateAddressRequest v) => v.addressType;
  static const Field<CreateAddressRequest, String> _f$addressType = Field(
    'addressType',
    _$addressType,
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<CreateAddressRequest> fields = const {
    #addressLine: _f$addressLine,
    #addressDetails: _f$addressDetails,
    #pincode: _f$pincode,
    #city: _f$city,
    #emirate: _f$emirate,
    #country: _f$country,
    #latitude: _f$latitude,
    #longitude: _f$longitude,
    #residentName: _f$residentName,
    #residentPhone: _f$residentPhone,
    #addressType: _f$addressType,
  };

  static CreateAddressRequest _instantiate(DecodingData data) {
    return CreateAddressRequest(
      addressLine: data.dec(_f$addressLine),
      addressDetails: data.dec(_f$addressDetails),
      pincode: data.dec(_f$pincode),
      city: data.dec(_f$city),
      emirate: data.dec(_f$emirate),
      country: data.dec(_f$country),
      latitude: data.dec(_f$latitude),
      longitude: data.dec(_f$longitude),
      residentName: data.dec(_f$residentName),
      residentPhone: data.dec(_f$residentPhone),
      addressType: data.dec(_f$addressType),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CreateAddressRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CreateAddressRequest>(map);
  }

  static CreateAddressRequest fromJson(String json) {
    return ensureInitialized().decodeJson<CreateAddressRequest>(json);
  }
}

mixin CreateAddressRequestMappable {
  String toJson() {
    return CreateAddressRequestMapper.ensureInitialized()
        .encodeJson<CreateAddressRequest>(this as CreateAddressRequest);
  }

  Map<String, dynamic> toMap() {
    return CreateAddressRequestMapper.ensureInitialized()
        .encodeMap<CreateAddressRequest>(this as CreateAddressRequest);
  }

  CreateAddressRequestCopyWith<
    CreateAddressRequest,
    CreateAddressRequest,
    CreateAddressRequest
  >
  get copyWith =>
      _CreateAddressRequestCopyWithImpl<
        CreateAddressRequest,
        CreateAddressRequest
      >(this as CreateAddressRequest, $identity, $identity);
  @override
  String toString() {
    return CreateAddressRequestMapper.ensureInitialized().stringifyValue(
      this as CreateAddressRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return CreateAddressRequestMapper.ensureInitialized().equalsValue(
      this as CreateAddressRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return CreateAddressRequestMapper.ensureInitialized().hashValue(
      this as CreateAddressRequest,
    );
  }
}

extension CreateAddressRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CreateAddressRequest, $Out> {
  CreateAddressRequestCopyWith<$R, CreateAddressRequest, $Out>
  get $asCreateAddressRequest => $base.as(
    (v, t, t2) => _CreateAddressRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CreateAddressRequestCopyWith<
  $R,
  $In extends CreateAddressRequest,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? addressLine,
    String? addressDetails,
    String? pincode,
    String? city,
    String? emirate,
    String? country,
    double? latitude,
    double? longitude,
    String? residentName,
    String? residentPhone,
    String? addressType,
  });
  CreateAddressRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CreateAddressRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CreateAddressRequest, $Out>
    implements CreateAddressRequestCopyWith<$R, CreateAddressRequest, $Out> {
  _CreateAddressRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CreateAddressRequest> $mapper =
      CreateAddressRequestMapper.ensureInitialized();
  @override
  $R call({
    String? addressLine,
    Object? addressDetails = $none,
    String? pincode,
    String? city,
    String? emirate,
    Object? country = $none,
    double? latitude,
    double? longitude,
    String? residentName,
    String? residentPhone,
    String? addressType,
  }) => $apply(
    FieldCopyWithData({
      if (addressLine != null) #addressLine: addressLine,
      if (addressDetails != $none) #addressDetails: addressDetails,
      if (pincode != null) #pincode: pincode,
      if (city != null) #city: city,
      if (emirate != null) #emirate: emirate,
      if (country != $none) #country: country,
      if (latitude != null) #latitude: latitude,
      if (longitude != null) #longitude: longitude,
      if (residentName != null) #residentName: residentName,
      if (residentPhone != null) #residentPhone: residentPhone,
      if (addressType != null) #addressType: addressType,
    }),
  );
  @override
  CreateAddressRequest $make(CopyWithData data) => CreateAddressRequest(
    addressLine: data.get(#addressLine, or: $value.addressLine),
    addressDetails: data.get(#addressDetails, or: $value.addressDetails),
    pincode: data.get(#pincode, or: $value.pincode),
    city: data.get(#city, or: $value.city),
    emirate: data.get(#emirate, or: $value.emirate),
    country: data.get(#country, or: $value.country),
    latitude: data.get(#latitude, or: $value.latitude),
    longitude: data.get(#longitude, or: $value.longitude),
    residentName: data.get(#residentName, or: $value.residentName),
    residentPhone: data.get(#residentPhone, or: $value.residentPhone),
    addressType: data.get(#addressType, or: $value.addressType),
  );

  @override
  CreateAddressRequestCopyWith<$R2, CreateAddressRequest, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CreateAddressRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class UpdateAddressRequestMapper extends ClassMapperBase<UpdateAddressRequest> {
  UpdateAddressRequestMapper._();

  static UpdateAddressRequestMapper? _instance;
  static UpdateAddressRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UpdateAddressRequestMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UpdateAddressRequest';

  static String _$addressLine(UpdateAddressRequest v) => v.addressLine;
  static const Field<UpdateAddressRequest, String> _f$addressLine = Field(
    'addressLine',
    _$addressLine,
    key: r'address_line',
    hook: SafeStringHook(),
  );
  static String? _$addressDetails(UpdateAddressRequest v) => v.addressDetails;
  static const Field<UpdateAddressRequest, String> _f$addressDetails = Field(
    'addressDetails',
    _$addressDetails,
    opt: true,
  );
  static String _$pincode(UpdateAddressRequest v) => v.pincode;
  static const Field<UpdateAddressRequest, String> _f$pincode = Field(
    'pincode',
    _$pincode,
    hook: SafeStringHook(),
  );
  static String _$city(UpdateAddressRequest v) => v.city;
  static const Field<UpdateAddressRequest, String> _f$city = Field(
    'city',
    _$city,
    hook: SafeStringHook(),
  );
  static String _$emirate(UpdateAddressRequest v) => v.emirate;
  static const Field<UpdateAddressRequest, String> _f$emirate = Field(
    'emirate',
    _$emirate,
    hook: SafeStringHook(),
  );
  static String _$country(UpdateAddressRequest v) => v.country;
  static const Field<UpdateAddressRequest, String> _f$country = Field(
    'country',
    _$country,
    hook: SafeStringHook(),
  );
  static double _$latitude(UpdateAddressRequest v) => v.latitude;
  static const Field<UpdateAddressRequest, double> _f$latitude = Field(
    'latitude',
    _$latitude,
    hook: SafeDoubleHook(),
  );
  static double _$longitude(UpdateAddressRequest v) => v.longitude;
  static const Field<UpdateAddressRequest, double> _f$longitude = Field(
    'longitude',
    _$longitude,
    hook: SafeDoubleHook(),
  );
  static bool _$isPrimary(UpdateAddressRequest v) => v.isPrimary;
  static const Field<UpdateAddressRequest, bool> _f$isPrimary = Field(
    'isPrimary',
    _$isPrimary,
    hook: SafeBoolHook(),
  );
  static String _$residentName(UpdateAddressRequest v) => v.residentName;
  static const Field<UpdateAddressRequest, String> _f$residentName = Field(
    'residentName',
    _$residentName,
    hook: SafeStringHook(),
  );
  static String _$residentPhone(UpdateAddressRequest v) => v.residentPhone;
  static const Field<UpdateAddressRequest, String> _f$residentPhone = Field(
    'residentPhone',
    _$residentPhone,
    hook: SafeStringHook(),
  );
  static String _$addressType(UpdateAddressRequest v) => v.addressType;
  static const Field<UpdateAddressRequest, String> _f$addressType = Field(
    'addressType',
    _$addressType,
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<UpdateAddressRequest> fields = const {
    #addressLine: _f$addressLine,
    #addressDetails: _f$addressDetails,
    #pincode: _f$pincode,
    #city: _f$city,
    #emirate: _f$emirate,
    #country: _f$country,
    #latitude: _f$latitude,
    #longitude: _f$longitude,
    #isPrimary: _f$isPrimary,
    #residentName: _f$residentName,
    #residentPhone: _f$residentPhone,
    #addressType: _f$addressType,
  };

  static UpdateAddressRequest _instantiate(DecodingData data) {
    return UpdateAddressRequest(
      addressLine: data.dec(_f$addressLine),
      addressDetails: data.dec(_f$addressDetails),
      pincode: data.dec(_f$pincode),
      city: data.dec(_f$city),
      emirate: data.dec(_f$emirate),
      country: data.dec(_f$country),
      latitude: data.dec(_f$latitude),
      longitude: data.dec(_f$longitude),
      isPrimary: data.dec(_f$isPrimary),
      residentName: data.dec(_f$residentName),
      residentPhone: data.dec(_f$residentPhone),
      addressType: data.dec(_f$addressType),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static UpdateAddressRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UpdateAddressRequest>(map);
  }

  static UpdateAddressRequest fromJson(String json) {
    return ensureInitialized().decodeJson<UpdateAddressRequest>(json);
  }
}

mixin UpdateAddressRequestMappable {
  String toJson() {
    return UpdateAddressRequestMapper.ensureInitialized()
        .encodeJson<UpdateAddressRequest>(this as UpdateAddressRequest);
  }

  Map<String, dynamic> toMap() {
    return UpdateAddressRequestMapper.ensureInitialized()
        .encodeMap<UpdateAddressRequest>(this as UpdateAddressRequest);
  }

  UpdateAddressRequestCopyWith<
    UpdateAddressRequest,
    UpdateAddressRequest,
    UpdateAddressRequest
  >
  get copyWith =>
      _UpdateAddressRequestCopyWithImpl<
        UpdateAddressRequest,
        UpdateAddressRequest
      >(this as UpdateAddressRequest, $identity, $identity);
  @override
  String toString() {
    return UpdateAddressRequestMapper.ensureInitialized().stringifyValue(
      this as UpdateAddressRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return UpdateAddressRequestMapper.ensureInitialized().equalsValue(
      this as UpdateAddressRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return UpdateAddressRequestMapper.ensureInitialized().hashValue(
      this as UpdateAddressRequest,
    );
  }
}

extension UpdateAddressRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UpdateAddressRequest, $Out> {
  UpdateAddressRequestCopyWith<$R, UpdateAddressRequest, $Out>
  get $asUpdateAddressRequest => $base.as(
    (v, t, t2) => _UpdateAddressRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class UpdateAddressRequestCopyWith<
  $R,
  $In extends UpdateAddressRequest,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? addressLine,
    String? addressDetails,
    String? pincode,
    String? city,
    String? emirate,
    String? country,
    double? latitude,
    double? longitude,
    bool? isPrimary,
    String? residentName,
    String? residentPhone,
    String? addressType,
  });
  UpdateAddressRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _UpdateAddressRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UpdateAddressRequest, $Out>
    implements UpdateAddressRequestCopyWith<$R, UpdateAddressRequest, $Out> {
  _UpdateAddressRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UpdateAddressRequest> $mapper =
      UpdateAddressRequestMapper.ensureInitialized();
  @override
  $R call({
    String? addressLine,
    Object? addressDetails = $none,
    String? pincode,
    String? city,
    String? emirate,
    String? country,
    double? latitude,
    double? longitude,
    bool? isPrimary,
    String? residentName,
    String? residentPhone,
    String? addressType,
  }) => $apply(
    FieldCopyWithData({
      if (addressLine != null) #addressLine: addressLine,
      if (addressDetails != $none) #addressDetails: addressDetails,
      if (pincode != null) #pincode: pincode,
      if (city != null) #city: city,
      if (emirate != null) #emirate: emirate,
      if (country != null) #country: country,
      if (latitude != null) #latitude: latitude,
      if (longitude != null) #longitude: longitude,
      if (isPrimary != null) #isPrimary: isPrimary,
      if (residentName != null) #residentName: residentName,
      if (residentPhone != null) #residentPhone: residentPhone,
      if (addressType != null) #addressType: addressType,
    }),
  );
  @override
  UpdateAddressRequest $make(CopyWithData data) => UpdateAddressRequest(
    addressLine: data.get(#addressLine, or: $value.addressLine),
    addressDetails: data.get(#addressDetails, or: $value.addressDetails),
    pincode: data.get(#pincode, or: $value.pincode),
    city: data.get(#city, or: $value.city),
    emirate: data.get(#emirate, or: $value.emirate),
    country: data.get(#country, or: $value.country),
    latitude: data.get(#latitude, or: $value.latitude),
    longitude: data.get(#longitude, or: $value.longitude),
    isPrimary: data.get(#isPrimary, or: $value.isPrimary),
    residentName: data.get(#residentName, or: $value.residentName),
    residentPhone: data.get(#residentPhone, or: $value.residentPhone),
    addressType: data.get(#addressType, or: $value.addressType),
  );

  @override
  UpdateAddressRequestCopyWith<$R2, UpdateAddressRequest, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _UpdateAddressRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DeleteAddressResponseMapper
    extends ClassMapperBase<DeleteAddressResponse> {
  DeleteAddressResponseMapper._();

  static DeleteAddressResponseMapper? _instance;
  static DeleteAddressResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DeleteAddressResponseMapper._());
      DeleteAddressCascadedMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DeleteAddressResponse';

  static String _$addressId(DeleteAddressResponse v) => v.addressId;
  static const Field<DeleteAddressResponse, String> _f$addressId = Field(
    'addressId',
    _$addressId,
    hook: SafeStringHook(),
  );
  static bool _$wasDefault(DeleteAddressResponse v) => v.wasDefault;
  static const Field<DeleteAddressResponse, bool> _f$wasDefault = Field(
    'wasDefault',
    _$wasDefault,
    hook: SafeBoolHook(),
  );
  static String _$newDefaultId(DeleteAddressResponse v) => v.newDefaultId;
  static const Field<DeleteAddressResponse, String> _f$newDefaultId = Field(
    'newDefaultId',
    _$newDefaultId,
    hook: SafeStringHook(),
  );
  static DeleteAddressCascaded _$cascaded(DeleteAddressResponse v) =>
      v.cascaded;
  static const Field<DeleteAddressResponse, DeleteAddressCascaded> _f$cascaded =
      Field('cascaded', _$cascaded);

  @override
  final MappableFields<DeleteAddressResponse> fields = const {
    #addressId: _f$addressId,
    #wasDefault: _f$wasDefault,
    #newDefaultId: _f$newDefaultId,
    #cascaded: _f$cascaded,
  };

  static DeleteAddressResponse _instantiate(DecodingData data) {
    return DeleteAddressResponse(
      addressId: data.dec(_f$addressId),
      wasDefault: data.dec(_f$wasDefault),
      newDefaultId: data.dec(_f$newDefaultId),
      cascaded: data.dec(_f$cascaded),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DeleteAddressResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DeleteAddressResponse>(map);
  }

  static DeleteAddressResponse fromJson(String json) {
    return ensureInitialized().decodeJson<DeleteAddressResponse>(json);
  }
}

mixin DeleteAddressResponseMappable {
  String toJson() {
    return DeleteAddressResponseMapper.ensureInitialized()
        .encodeJson<DeleteAddressResponse>(this as DeleteAddressResponse);
  }

  Map<String, dynamic> toMap() {
    return DeleteAddressResponseMapper.ensureInitialized()
        .encodeMap<DeleteAddressResponse>(this as DeleteAddressResponse);
  }

  DeleteAddressResponseCopyWith<
    DeleteAddressResponse,
    DeleteAddressResponse,
    DeleteAddressResponse
  >
  get copyWith =>
      _DeleteAddressResponseCopyWithImpl<
        DeleteAddressResponse,
        DeleteAddressResponse
      >(this as DeleteAddressResponse, $identity, $identity);
  @override
  String toString() {
    return DeleteAddressResponseMapper.ensureInitialized().stringifyValue(
      this as DeleteAddressResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return DeleteAddressResponseMapper.ensureInitialized().equalsValue(
      this as DeleteAddressResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return DeleteAddressResponseMapper.ensureInitialized().hashValue(
      this as DeleteAddressResponse,
    );
  }
}

extension DeleteAddressResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DeleteAddressResponse, $Out> {
  DeleteAddressResponseCopyWith<$R, DeleteAddressResponse, $Out>
  get $asDeleteAddressResponse => $base.as(
    (v, t, t2) => _DeleteAddressResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class DeleteAddressResponseCopyWith<
  $R,
  $In extends DeleteAddressResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  DeleteAddressCascadedCopyWith<
    $R,
    DeleteAddressCascaded,
    DeleteAddressCascaded
  >
  get cascaded;
  $R call({
    String? addressId,
    bool? wasDefault,
    String? newDefaultId,
    DeleteAddressCascaded? cascaded,
  });
  DeleteAddressResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DeleteAddressResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DeleteAddressResponse, $Out>
    implements DeleteAddressResponseCopyWith<$R, DeleteAddressResponse, $Out> {
  _DeleteAddressResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DeleteAddressResponse> $mapper =
      DeleteAddressResponseMapper.ensureInitialized();
  @override
  DeleteAddressCascadedCopyWith<
    $R,
    DeleteAddressCascaded,
    DeleteAddressCascaded
  >
  get cascaded => $value.cascaded.copyWith.$chain((v) => call(cascaded: v));
  @override
  $R call({
    String? addressId,
    bool? wasDefault,
    String? newDefaultId,
    DeleteAddressCascaded? cascaded,
  }) => $apply(
    FieldCopyWithData({
      if (addressId != null) #addressId: addressId,
      if (wasDefault != null) #wasDefault: wasDefault,
      if (newDefaultId != null) #newDefaultId: newDefaultId,
      if (cascaded != null) #cascaded: cascaded,
    }),
  );
  @override
  DeleteAddressResponse $make(CopyWithData data) => DeleteAddressResponse(
    addressId: data.get(#addressId, or: $value.addressId),
    wasDefault: data.get(#wasDefault, or: $value.wasDefault),
    newDefaultId: data.get(#newDefaultId, or: $value.newDefaultId),
    cascaded: data.get(#cascaded, or: $value.cascaded),
  );

  @override
  DeleteAddressResponseCopyWith<$R2, DeleteAddressResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _DeleteAddressResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DeleteAddressCascadedMapper
    extends ClassMapperBase<DeleteAddressCascaded> {
  DeleteAddressCascadedMapper._();

  static DeleteAddressCascadedMapper? _instance;
  static DeleteAddressCascadedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DeleteAddressCascadedMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DeleteAddressCascaded';

  static bool _$defaultReassigned(DeleteAddressCascaded v) =>
      v.defaultReassigned;
  static const Field<DeleteAddressCascaded, bool> _f$defaultReassigned = Field(
    'defaultReassigned',
    _$defaultReassigned,
    hook: SafeBoolHook(),
  );
  static String _$newDefaultId(DeleteAddressCascaded v) => v.newDefaultId;
  static const Field<DeleteAddressCascaded, String> _f$newDefaultId = Field(
    'newDefaultId',
    _$newDefaultId,
    hook: SafeStringHook(),
  );
  static int _$existingOrdersPreserved(DeleteAddressCascaded v) =>
      v.existingOrdersPreserved;
  static const Field<DeleteAddressCascaded, int> _f$existingOrdersPreserved =
      Field(
        'existingOrdersPreserved',
        _$existingOrdersPreserved,
        hook: SafeIntHook(),
      );

  @override
  final MappableFields<DeleteAddressCascaded> fields = const {
    #defaultReassigned: _f$defaultReassigned,
    #newDefaultId: _f$newDefaultId,
    #existingOrdersPreserved: _f$existingOrdersPreserved,
  };

  static DeleteAddressCascaded _instantiate(DecodingData data) {
    return DeleteAddressCascaded(
      defaultReassigned: data.dec(_f$defaultReassigned),
      newDefaultId: data.dec(_f$newDefaultId),
      existingOrdersPreserved: data.dec(_f$existingOrdersPreserved),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DeleteAddressCascaded fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DeleteAddressCascaded>(map);
  }

  static DeleteAddressCascaded fromJson(String json) {
    return ensureInitialized().decodeJson<DeleteAddressCascaded>(json);
  }
}

mixin DeleteAddressCascadedMappable {
  String toJson() {
    return DeleteAddressCascadedMapper.ensureInitialized()
        .encodeJson<DeleteAddressCascaded>(this as DeleteAddressCascaded);
  }

  Map<String, dynamic> toMap() {
    return DeleteAddressCascadedMapper.ensureInitialized()
        .encodeMap<DeleteAddressCascaded>(this as DeleteAddressCascaded);
  }

  DeleteAddressCascadedCopyWith<
    DeleteAddressCascaded,
    DeleteAddressCascaded,
    DeleteAddressCascaded
  >
  get copyWith =>
      _DeleteAddressCascadedCopyWithImpl<
        DeleteAddressCascaded,
        DeleteAddressCascaded
      >(this as DeleteAddressCascaded, $identity, $identity);
  @override
  String toString() {
    return DeleteAddressCascadedMapper.ensureInitialized().stringifyValue(
      this as DeleteAddressCascaded,
    );
  }

  @override
  bool operator ==(Object other) {
    return DeleteAddressCascadedMapper.ensureInitialized().equalsValue(
      this as DeleteAddressCascaded,
      other,
    );
  }

  @override
  int get hashCode {
    return DeleteAddressCascadedMapper.ensureInitialized().hashValue(
      this as DeleteAddressCascaded,
    );
  }
}

extension DeleteAddressCascadedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DeleteAddressCascaded, $Out> {
  DeleteAddressCascadedCopyWith<$R, DeleteAddressCascaded, $Out>
  get $asDeleteAddressCascaded => $base.as(
    (v, t, t2) => _DeleteAddressCascadedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class DeleteAddressCascadedCopyWith<
  $R,
  $In extends DeleteAddressCascaded,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    bool? defaultReassigned,
    String? newDefaultId,
    int? existingOrdersPreserved,
  });
  DeleteAddressCascadedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DeleteAddressCascadedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DeleteAddressCascaded, $Out>
    implements DeleteAddressCascadedCopyWith<$R, DeleteAddressCascaded, $Out> {
  _DeleteAddressCascadedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DeleteAddressCascaded> $mapper =
      DeleteAddressCascadedMapper.ensureInitialized();
  @override
  $R call({
    bool? defaultReassigned,
    String? newDefaultId,
    int? existingOrdersPreserved,
  }) => $apply(
    FieldCopyWithData({
      if (defaultReassigned != null) #defaultReassigned: defaultReassigned,
      if (newDefaultId != null) #newDefaultId: newDefaultId,
      if (existingOrdersPreserved != null)
        #existingOrdersPreserved: existingOrdersPreserved,
    }),
  );
  @override
  DeleteAddressCascaded $make(CopyWithData data) => DeleteAddressCascaded(
    defaultReassigned: data.get(
      #defaultReassigned,
      or: $value.defaultReassigned,
    ),
    newDefaultId: data.get(#newDefaultId, or: $value.newDefaultId),
    existingOrdersPreserved: data.get(
      #existingOrdersPreserved,
      or: $value.existingOrdersPreserved,
    ),
  );

  @override
  DeleteAddressCascadedCopyWith<$R2, DeleteAddressCascaded, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _DeleteAddressCascadedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

