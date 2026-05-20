import 'package:equatable/equatable.dart';

sealed class SubscribedClinicsEvent extends Equatable {
  const SubscribedClinicsEvent();

  @override
  List<Object?> get props => [];
}

class FetchSubscribedClinics extends SubscribedClinicsEvent {
  final int? page;
  final bool isForceRefresh;
  const FetchSubscribedClinics(this.page, this.isForceRefresh);

  @override
  List<Object?> get props => [page, isForceRefresh];
}

class PurchaseClinicSubscription extends SubscribedClinicsEvent {
  final String clinicId;
  final String planId;
  final String petId;

  const PurchaseClinicSubscription({
    required this.clinicId,
    required this.planId,
    required this.petId,
  });

  @override
  List<Object?> get props => [clinicId, planId, petId];
}

class ResetPurchaseStatus extends SubscribedClinicsEvent {}
