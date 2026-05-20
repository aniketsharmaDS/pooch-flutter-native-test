import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/ecommerce/data/models/address/address_model.dart';
import 'package:poochcare/features/ecommerce/data/models/cart/cart_item_model.dart';
import 'package:poochcare/features/ecommerce/domain/repository/cart_repository.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/address_bloc/address_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/address_bloc/address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final CartRepository repository;

  AddressBloc(this.repository) : super(const AddressState()) {
    on<FetchAddressesEvent>(_onFetchAddresses);
    on<CreateAddressEvent>(_onCreateAddress);
    on<UpdateAddressEvent>(_onUpdateAddress);
    on<DeleteAddressEvent>(_onDeleteAddress);
    on<MakeAddressPrimaryEvent>(_onMakeAddressPrimary);
    on<SelectAddressEvent>(_onSelectAddress);
    on<ResetAddressEvent>(_onReset);
  }

  Future<void> _onSelectAddress(
    SelectAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          selectedAddress: event.address,
          actionId: state.actionId + 1,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AddressStatus.failure,
          errorMessage: e.toString(),
          actionId: state.actionId + 1,
        ),
      );
    }
  }

  Future<void> _onFetchAddresses(
    FetchAddressesEvent event,
    Emitter<AddressState> emit,
  ) async {
    try {
      final addresses = await repository.getAddresses();

      emit(state.copyWith(addresses: addresses, actionId: state.actionId + 1));
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to fetch addresses',
          actionId: state.actionId + 1,
        ),
      );
    }
  }

  Future<void> _onCreateAddress(
    CreateAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    try {
      final request = CreateAddressRequest(
        addressLine: event.addressLine,
        addressDetails: event.addressDetails,
        pincode: event.pincode,
        city: event.city,
        emirate: event.emirate,
        country: event.country,
        latitude: event.latitude,
        longitude: event.longitude,
        addressType: event.addressType,
        residentName: event.name,
        residentPhone: event.phone,
      );

      final newAddress = await repository.createAddress(request);

      // Add to addresses list
      final updatedAddresses = [...state.addresses, newAddress];

      emit(
        state.copyWith(
          addresses: updatedAddresses,
          successMessage: 'Address added successfully',
          actionId: state.actionId + 1,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to create address: ${e.toString()}',
          actionId: state.actionId + 1,
        ),
      );
    }
  }

  Future<void> _onUpdateAddress(
    UpdateAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    try {
      final request = UpdateAddressRequest(
        addressLine: event.addressLine,
        addressDetails: event.addressDetails,
        pincode: event.pincode,
        city: event.city,
        emirate: event.emirate,
        country: event.country,
        latitude: event.latitude,
        longitude: event.longitude,
        isPrimary: event.isPrimary,
        addressType: event.addressType,
        residentName: event.name,
        residentPhone: event.phone,
      );

      final updatedAddress = await repository.updateAddress(
        event.addressId,
        request,
      );

      // Update in addresses list
      final updatedAddresses = state.addresses.map((address) {
        if (address.id == event.addressId) {
          return updatedAddress;
        }
        return address;
      }).toList();

      emit(
        state.copyWith(
          addresses: updatedAddresses,
          successMessage: 'Address updated successfully',
          actionId: state.actionId + 1,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to update address: ${e.toString()}',
          actionId: state.actionId + 1,
        ),
      );
    }
  }

  Future<void> _onDeleteAddress(
    DeleteAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    try {
      await repository.deleteAddress(event.addressId);

      // Remove from addresses list
      final updatedAddresses = state.addresses
          .where((address) => address.id != event.addressId)
          .toList();

      emit(
        state.copyWith(
          addresses: updatedAddresses,
          successMessage: 'Address deleted successfully',
          actionId: state.actionId + 1,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to delete address: ${e.toString()}',
          actionId: state.actionId + 1,
        ),
      );
    }
  }

  void _onReset(ResetAddressEvent event, Emitter<AddressState> emit) {
    emit(const AddressState());
  }

  Future<void> _onMakeAddressPrimary(
    MakeAddressPrimaryEvent event,
    Emitter<AddressState> emit,
  ) async {
    try {
      await repository.makeAddressPrimary(event.addressId);

      final updatedAddresses = state.addresses.map((address) {
        return address.id == event.addressId
            ? address.copyWith(isPrimary: true) // The selected one
            : address.copyWith(isPrimary: false); // Reset others to false
      }).toList();

      emit(
        state.copyWith(
          addresses: updatedAddresses,
          successMessage: 'Address deleted successfully',
          actionId: state.actionId + 1,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to make address as primary}',
          actionId: state.actionId + 1,
        ),
      );
    }
  }
}

extension CartDataCopyWith on CartData {
  CartData copyWith({
    String? userId,
    List<CartItem>? items,
    int? totalItems,
    int? currentPage,
    int? totalPages,
    bool? hasNextPage,
    bool? hasPreviousPage,
    CartPricing? pricing,
    double? totalAmount,
    CartOrderSummary? orderSummary,
  }) {
    return CartData(
      userId: userId ?? this.userId,
      items: items ?? this.items,
      totalItems: totalItems ?? this.totalItems,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
      pricing: pricing ?? this.pricing,
      totalAmount: totalAmount ?? this.totalAmount,
      orderSummary: orderSummary ?? this.orderSummary,
    );
  }
}
