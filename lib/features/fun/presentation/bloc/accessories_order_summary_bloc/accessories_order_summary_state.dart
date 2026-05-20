import 'package:equatable/equatable.dart';
import 'package:poochcare/features/fun/data/models/accessory_booking_summary_response_model.dart';
import 'package:poochcare/features/fun/data/models/accessory_purchase_response_model.dart';

enum AccessoriesOrderSummaryStatus { initial, loading, success, failure }

enum AccessoryPaymentStatus { initial, submitting, success, failure }

class AccessoriesOrderSummaryState extends Equatable {
  final AccessoriesOrderSummaryStatus accessoriesOrderSummarydStatus;
  final String? errorMessage;
  final String? successMessage;
  final AccessoryBookingSummaryModel? accessoryData;
  final AccessoryPurchaseResponseModel? purchaseData;
  final AccessoryPaymentStatus accessoryPaymentStatus;

  const AccessoriesOrderSummaryState({
    this.errorMessage = '',
    this.successMessage = '',
    this.accessoriesOrderSummarydStatus = AccessoriesOrderSummaryStatus.initial,
    this.accessoryData,
    this.purchaseData,
    this.accessoryPaymentStatus = AccessoryPaymentStatus.initial,
  });

  AccessoriesOrderSummaryState copyWith({
    AccessoriesOrderSummaryStatus? accessoriesOrderSummarydStatus,
    String? errorMessage,
    String? successMessage,
    AccessoryBookingSummaryModel? accessoryData,
    AccessoryPurchaseResponseModel? purchaseData,
    AccessoryPaymentStatus? accessoryPaymentStatus,
  }) {
    return AccessoriesOrderSummaryState(
      accessoryPaymentStatus:
          accessoryPaymentStatus ?? this.accessoryPaymentStatus,
      accessoryData: accessoryData ?? this.accessoryData,
      accessoriesOrderSummarydStatus:
          accessoriesOrderSummarydStatus ?? this.accessoriesOrderSummarydStatus,
      errorMessage: errorMessage,
      successMessage: successMessage,
      purchaseData: purchaseData ?? this.purchaseData,
    );
  }

  @override
  List<Object?> get props => [
    errorMessage,
    successMessage,
    accessoriesOrderSummarydStatus,
    accessoryData,
    purchaseData,
    accessoryPaymentStatus,
  ];
}
