import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/insight/data/models/subscribed_clinics_response_model.dart';
import 'package:poochcare/features/insight/presentation/bloc/subscribed_clinics_bloc/subscribed_clinics_event.dart';
import 'package:poochcare/features/insight/presentation/bloc/subscribed_clinics_bloc/subscribed_clinics_state.dart';
import 'package:poochcare/features/insight/repository/clinics_repository.dart';

class SubscribedClinicsBloc
    extends Bloc<SubscribedClinicsEvent, SusbcribedClinicsState> {
  final ClinicsRepository repository;

  SubscribedClinicsBloc(this.repository)
    : super(const SusbcribedClinicsState()) {
    on<FetchSubscribedClinics>(_onFetchClinics);
    on<PurchaseClinicSubscription>(_onPurchaseClinicSubscription);
    on<ResetPurchaseStatus>(_onResetPurchaseStatus);
  }

  Future<void> _onFetchClinics(
    FetchSubscribedClinics event,
    Emitter<SusbcribedClinicsState> emit,
  ) async {
    final isRefresh = event.isForceRefresh;
    final nextPage = event.page ?? 1;

    try {
      // Show loading only for first page or refresh
      if (isRefresh || nextPage == 1) {
        emit(state.copyWith(status: SubscrbedClinicsStatus.loading));
      }

      final responseData = await repository.getSubscribedClinics(
        page: nextPage,
        isForceRefresh: isRefresh,
      );

      // Merge with existing subscriptions if not refresh
      final oldSubscriptions = isRefresh
          ? <ClinicSubscriptionApiModel>[]
          : (state.subscribedClinicsData?.subscriptions ??
                <ClinicSubscriptionApiModel>[]);

      final combinedSubscriptions = <ClinicSubscriptionApiModel>[
        ...oldSubscriptions,
        ...responseData.subscriptions,
      ];

      final hasReachedMax =
          combinedSubscriptions.length >= responseData.totalSubscriptions;

      final newData = responseData.copyWith(
        subscriptions: combinedSubscriptions,
      );

      emit(
        state.copyWith(
          status: SubscrbedClinicsStatus.success,
          subscribedClinicsData: newData,
          currentPage: nextPage,
          hasReachedMax: hasReachedMax,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SubscrbedClinicsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onPurchaseClinicSubscription(
    PurchaseClinicSubscription event,
    Emitter<SusbcribedClinicsState> emit,
  ) async {
    emit(
      state.copyWith(
        purchaseStatus: SubscriptionPurchaseStatus.loading,
        errorMessage: '',
        successMessage: '',
      ),
    );

    try {
      await repository.purchaseSubscription(
        clinicId: event.clinicId,
        planId: event.planId,
        petId: event.petId,
      );

      final refreshedData = await repository.getSubscribedClinics(
        // ignore: avoid_redundant_argument_values
        page: 1,
        isForceRefresh: true,
      );

      emit(
        state.copyWith(
          purchaseStatus: SubscriptionPurchaseStatus.success,
          status: SubscrbedClinicsStatus.success,
          subscribedClinicsData: refreshedData,
          successMessage: 'Subscription purchased successfully',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          purchaseStatus: SubscriptionPurchaseStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onResetPurchaseStatus(
    ResetPurchaseStatus event,
    Emitter<SusbcribedClinicsState> emit,
  ) {
    emit(state.copyWith(purchaseStatus: SubscriptionPurchaseStatus.initial));
  }
}
