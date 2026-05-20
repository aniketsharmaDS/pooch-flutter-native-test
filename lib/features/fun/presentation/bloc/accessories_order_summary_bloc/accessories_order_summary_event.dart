import 'package:equatable/equatable.dart';

sealed class AccessoriesOrderSummaryEvent extends Equatable {
  const AccessoriesOrderSummaryEvent();

  @override
  List<Object?> get props => [];
}

class FetchAccessoriesOrderSummaryEvent extends AccessoriesOrderSummaryEvent {
  final String accessoryId;
  final String petId;
  final int quantity;
  final String country;
  final String? couponCode;
  final int? page;
  final bool isForceRefresh;
  const FetchAccessoriesOrderSummaryEvent(
    this.page,
    this.isForceRefresh,
    this.accessoryId,
    this.country,
    this.couponCode,
    this.petId,
    this.quantity,
  );

  @override
  List<Object?> get props => [
    page,
    isForceRefresh,
    accessoryId,
    country,
    couponCode,
    petId,
    quantity,
  ];
}

class PurchaseAccessory extends AccessoriesOrderSummaryEvent {
  final String accessoryId;
  final String petId;
  final String country;
  final String? couponCode;
  final String? langCode;

  const PurchaseAccessory({
    required this.accessoryId,
    required this.petId,
    required this.country,
    this.couponCode,
    this.langCode,
  });

  @override
  List<Object?> get props => [accessoryId, petId, country];
}
