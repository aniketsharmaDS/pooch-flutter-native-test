import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'address_model.mapper.dart';

@MappableClass()
class Address with AddressMappable {
  const Address({
    required this.id,
    required this.userId,
    required this.addressLine,
    this.addressDetails,
    required this.pincode,
    required this.city,
    required this.emirate,
    required this.country,
    required this.latitude,
    required this.longitude,
    this.residentName,
    this.residentPhone,
    this.addressType,
    required this.isPrimary,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      AddressMapper.fromMap(json);

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String userId;

  @MappableField(hook: SafeStringHook())
  final String addressLine;

  final String? addressDetails;

  @MappableField(hook: SafeStringHook())
  final String pincode;

  @MappableField(hook: SafeStringHook())
  final String city;

  @MappableField(hook: SafeStringHook())
  final String emirate;

  @MappableField(hook: SafeStringHook())
  final String country;

  @MappableField(hook: SafeStringHook())
  final String latitude;

  @MappableField(hook: SafeStringHook())
  final String longitude;

  final String? residentName;

  final String? residentPhone;

  final String? addressType;

  @MappableField(hook: SafeBoolHook())
  final bool isPrimary;

  @MappableField(hook: SafeBoolHook())
  final bool isDeleted;

  final DateTime createdAt;

  final DateTime updatedAt;
}

@MappableClass()
class CreateAddressRequest with CreateAddressRequestMappable {
  const CreateAddressRequest({
    required this.addressLine,
    this.addressDetails,
    required this.pincode,
    required this.city,
    required this.emirate,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.residentName,
    required this.residentPhone,
    required this.addressType,
  });

  @MappableField(key: 'address_line', hook: SafeStringHook())
  final String addressLine;

  final String? addressDetails;

  @MappableField(hook: SafeStringHook())
  final String pincode;

  @MappableField(hook: SafeStringHook())
  final String city;

  @MappableField(hook: SafeStringHook())
  final String emirate;

  @MappableField(hook: SafeStringHook())
  final String? country;

  @MappableField(hook: SafeDoubleHook())
  final double latitude;

  @MappableField(hook: SafeDoubleHook())
  final double longitude;

  @MappableField(hook: SafeStringHook())
  final String residentName;
  @MappableField(hook: SafeStringHook())
  final String residentPhone;
  @MappableField(hook: SafeStringHook())
  final String addressType;
}

@MappableClass()
class UpdateAddressRequest with UpdateAddressRequestMappable {
  const UpdateAddressRequest({
    required this.addressLine,
    this.addressDetails,
    required this.pincode,
    required this.city,
    required this.emirate,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.isPrimary,
    required this.residentName,
    required this.residentPhone,
    required this.addressType,
  });

  @MappableField(key: 'address_line', hook: SafeStringHook())
  final String addressLine;

  final String? addressDetails;

  @MappableField(hook: SafeStringHook())
  final String pincode;

  @MappableField(hook: SafeStringHook())
  final String city;

  @MappableField(hook: SafeStringHook())
  final String emirate;

  @MappableField(hook: SafeStringHook())
  final String country;

  @MappableField(hook: SafeDoubleHook())
  final double latitude;

  @MappableField(hook: SafeDoubleHook())
  final double longitude;

  @MappableField(hook: SafeBoolHook())
  final bool isPrimary;

  @MappableField(hook: SafeStringHook())
  final String residentName;
  @MappableField(hook: SafeStringHook())
  final String residentPhone;
  @MappableField(hook: SafeStringHook())
  final String addressType;
}

@MappableClass()
class DeleteAddressResponse with DeleteAddressResponseMappable {
  const DeleteAddressResponse({
    required this.addressId,
    required this.wasDefault,
    required this.newDefaultId,
    required this.cascaded,
  });

  factory DeleteAddressResponse.fromJson(Map<String, dynamic> json) =>
      DeleteAddressResponseMapper.fromMap(json);

  @MappableField(hook: SafeStringHook())
  final String addressId;

  @MappableField(hook: SafeBoolHook())
  final bool wasDefault;

  @MappableField(hook: SafeStringHook())
  final String newDefaultId;

  final DeleteAddressCascaded cascaded;
}

@MappableClass()
class DeleteAddressCascaded with DeleteAddressCascadedMappable {
  const DeleteAddressCascaded({
    required this.defaultReassigned,
    required this.newDefaultId,
    required this.existingOrdersPreserved,
  });

  factory DeleteAddressCascaded.fromJson(Map<String, dynamic> json) =>
      DeleteAddressCascadedMapper.fromMap(json);

  @MappableField(hook: SafeBoolHook())
  final bool defaultReassigned;

  @MappableField(hook: SafeStringHook())
  final String newDefaultId;

  @MappableField(hook: SafeIntHook())
  final int existingOrdersPreserved;
}
