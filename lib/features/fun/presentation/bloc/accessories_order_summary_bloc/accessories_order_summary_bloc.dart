import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_order_summary_bloc/accessories_order_summary_event.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_order_summary_bloc/accessories_order_summary_state.dart';
import 'package:poochcare/features/fun/repository/accessories_repository.dart';

class AccessoriesOrderSummaryBloc
    extends Bloc<AccessoriesOrderSummaryEvent, AccessoriesOrderSummaryState> {
  final AccessoriesRepository repository;

  AccessoriesOrderSummaryBloc(this.repository)
    : super(const AccessoriesOrderSummaryState()) {
    on<FetchAccessoriesOrderSummaryEvent>(_onFetchAccessoriesOrderSummary);
    on<PurchaseAccessory>(_onPurchaseAccessory);
  }
  FutureOr<void> _onFetchAccessoriesOrderSummary(
    FetchAccessoriesOrderSummaryEvent event,
    Emitter<AccessoriesOrderSummaryState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          accessoriesOrderSummarydStatus: AccessoriesOrderSummaryStatus.loading,
        ),
      );
      final orderSummary = await repository.getBookingSummary(
        accessoryId: event.accessoryId,
        petId: event.petId,
        quantity: event.quantity,
        country: 'India',
        couponCode: event.couponCode,
      );
      emit(
        state.copyWith(
          accessoryData: orderSummary,
          accessoriesOrderSummarydStatus: AccessoriesOrderSummaryStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          accessoriesOrderSummarydStatus: AccessoriesOrderSummaryStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  FutureOr<void> _onPurchaseAccessory(
    PurchaseAccessory event,
    Emitter<AccessoriesOrderSummaryState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          accessoryPaymentStatus: AccessoryPaymentStatus.submitting,
        ),
      );
      final purchaseData = await repository.purchaseAccessory(
        accessoryId: event.accessoryId,
        country: event.country,
        petId: event.petId,
        quantity: 1,
        couponCode: event.couponCode,
        langCode: event.langCode,
      );
      emit(
        state.copyWith(
          purchaseData: purchaseData,
          accessoryPaymentStatus: AccessoryPaymentStatus.success,
          successMessage: 'Accessory Purchased!',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          accessoryPaymentStatus: AccessoryPaymentStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
