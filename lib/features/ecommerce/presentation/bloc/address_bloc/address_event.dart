import 'package:equatable/equatable.dart';
import 'package:poochcare/features/ecommerce/data/models/address/address_model.dart';

sealed class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object?> get props => [];
}

class FetchAddressesEvent extends AddressEvent {
  const FetchAddressesEvent();
}

class CreateAddressEvent extends AddressEvent {
  final String addressLine;
  final String? addressDetails;
  final String pincode;
  final String city;
  final String emirate;
  final String? country;
  final double latitude;
  final double longitude;
  final String name;
  final String phone;
  final String addressType;

  const CreateAddressEvent({
    required this.addressLine,
    this.addressDetails,
    required this.pincode,
    required this.city,
    required this.emirate,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.addressType,
    required this.name,
    required this.phone,
  });

  @override
  List<Object?> get props => [
    addressLine,
    addressDetails,
    pincode,
    city,
    emirate,
    country,
    latitude,
    longitude,
    addressType,
    name,
    phone,
  ];
}

class UpdateAddressEvent extends AddressEvent {
  final String addressId;
  final String addressLine;
  final String? addressDetails;
  final String pincode;
  final String city;
  final String emirate;
  final String country;
  final double latitude;
  final double longitude;
  final bool isPrimary;
  final String name;
  final String phone;
  final String addressType;

  const UpdateAddressEvent({
    required this.addressId,
    required this.addressLine,
    this.addressDetails,
    required this.pincode,
    required this.city,
    required this.emirate,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.isPrimary,
    required this.addressType,
    required this.name,
    required this.phone,
  });

  @override
  List<Object?> get props => [
    addressId,
    addressLine,
    addressDetails,
    pincode,
    city,
    emirate,
    country,
    latitude,
    longitude,
    isPrimary,
    addressType,
    name,
    phone,
  ];
}

class DeleteAddressEvent extends AddressEvent {
  final String addressId;

  const DeleteAddressEvent(this.addressId);

  @override
  List<Object?> get props => [addressId];
}

class MakeAddressPrimaryEvent extends AddressEvent {
  final String addressId;
  const MakeAddressPrimaryEvent(this.addressId);

  @override
  List<Object?> get props => [addressId];
}

class SelectAddressEvent extends AddressEvent {
  final Address address;

  const SelectAddressEvent({required this.address});

  @override
  List<Object?> get props => [address];
}

class ResetAddressEvent extends AddressEvent {
  const ResetAddressEvent();
}
