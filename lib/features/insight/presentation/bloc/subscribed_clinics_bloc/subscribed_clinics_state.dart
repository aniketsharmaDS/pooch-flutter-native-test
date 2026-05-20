import 'package:equatable/equatable.dart';
import 'package:poochcare/features/insight/data/models/subscribed_clinics_response_model.dart';

enum SubscrbedClinicsStatus { initial, loading, success, failure }

enum SubscriptionPurchaseStatus { initial, loading, success, failure }

class SusbcribedClinicsState extends Equatable {
  final SubscrbedClinicsStatus status;
  final SubscriptionPurchaseStatus purchaseStatus;
  final String? errorMessage;
  final String? successMessage;
  final SubscribedClinicsResponseModel? subscribedClinicsData;

  final int currentPage;
  final bool hasReachedMax;

  const SusbcribedClinicsState({
    this.status = SubscrbedClinicsStatus.initial,
    this.purchaseStatus = SubscriptionPurchaseStatus.initial,
    this.errorMessage = '',
    this.successMessage = '',
    this.subscribedClinicsData,
    this.currentPage = 1,
    this.hasReachedMax = false,
  });

  SusbcribedClinicsState copyWith({
    SubscrbedClinicsStatus? status,
    SubscriptionPurchaseStatus? purchaseStatus,
    String? errorMessage,
    String? successMessage,
    SubscribedClinicsResponseModel? subscribedClinicsData,
    int? currentPage,
    bool? hasReachedMax,
  }) {
    return SusbcribedClinicsState(
      subscribedClinicsData:
          subscribedClinicsData ?? this.subscribedClinicsData,
      status: status ?? this.status,
      purchaseStatus: purchaseStatus ?? this.purchaseStatus,
      errorMessage: errorMessage,
      successMessage: successMessage,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
    status,
    purchaseStatus,
    errorMessage,
    successMessage,
    subscribedClinicsData,
    currentPage,
    hasReachedMax,
  ];
}
