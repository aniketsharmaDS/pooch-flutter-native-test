import 'package:equatable/equatable.dart';
import 'package:poochcare/features/ecommerce/data/models/address/address_model.dart';

enum AddressStatus { initial, loading, success, failure }

class AddressState extends Equatable {
  final AddressStatus status;
  final List<Address> addresses;
  final String? errorMessage;
  final String? successMessage;
  final int actionId;
  final Address? selectedAddress;

  const AddressState({
    this.status = AddressStatus.initial,
    this.addresses = const [],
    this.errorMessage,
    this.successMessage,
    this.actionId = 0,
    this.selectedAddress,
  });

  AddressState copyWith({
    AddressStatus? status,
    List<Address>? addresses,
    String? errorMessage,
    String? successMessage,
    int? actionId,
    Address? selectedAddress,
  }) {
    return AddressState(
      selectedAddress: selectedAddress ?? this.selectedAddress,
      status: status ?? this.status,
      addresses: addresses ?? this.addresses,
      errorMessage: errorMessage,
      successMessage: successMessage,
      actionId: (actionId ?? this.actionId),
    );
  }

  @override
  List<Object?> get props => [
    status,
    addresses,
    errorMessage,
    successMessage,
    actionId,
    selectedAddress,
  ];
}
