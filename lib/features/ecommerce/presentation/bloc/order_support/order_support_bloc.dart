import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/ecommerce/domain/repository/orders_repository.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_support/order_support_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_support/order_support_state.dart';

class OrderSupportBloc extends Bloc<OrderSupportEvent, OrderSupportState> {
  final OrderRepository _repo;

  OrderSupportBloc(this._repo) : super(const OrderSupportState()) {
    on<SubmitOrderIssue>(_onSubmit);
    on<ResetOrderSupport>(_onReset);
    on<LoadCancellationReasons>(_onLoadReasons);
    on<SubmitOrderCancellation>(_onCancel);
  }

  Future<void> _onSubmit(
    SubmitOrderIssue event,
    Emitter<OrderSupportState> emit,
  ) async {
    emit(
      state.copyWith(isSubmitting: true, isSuccess: false, clearError: true),
    );

    try {
      await _repo.submitNeedHelp(
        issue: event.issue,
        orderId: event.orderId,
        itemId: event.itemId,
      );

      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          isSuccess: false,
          error: e.toString(),
        ),
      );
    }
  }

  void _onReset(ResetOrderSupport event, Emitter<OrderSupportState> emit) {
    emit(const OrderSupportState());
  }

  Future<void> _onLoadReasons(
    LoadCancellationReasons event,
    Emitter<OrderSupportState> emit,
  ) async {
    emit(state.copyWith(isLoadingReasons: true));

    try {
      final (reasons, policy) = await _repo.getCancellationReasons();

      emit(
        state.copyWith(
          isLoadingReasons: false,
          reasons: reasons,
          refundPolicy: policy,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingReasons: false, error: e.toString()));
    }
  }

  Future<void> _onCancel(
    SubmitOrderCancellation event,
    Emitter<OrderSupportState> emit,
  ) async {
    emit(
      state.copyWith(isSubmitting: true, isSuccess: false, clearError: true),
    );

    try {
      await _repo.cancelOrder(
        orderId: event.orderId,
        itemId: event.itemId,
        reason: event.reason,
        images: event.images,
      );
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          isSuccess: false,
          error: e.toString(),
        ),
      );
    }
  }
}
