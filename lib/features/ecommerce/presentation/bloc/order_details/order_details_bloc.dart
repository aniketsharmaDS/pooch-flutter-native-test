import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/ecommerce/domain/repository/orders_repository.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_details/order_details_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_details/order_details_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  final OrderRepository _repo;

  OrderDetailBloc(this._repo) : super(const OrderDetailState()) {
    on<LoadOrderDetail>(_onLoad);
    on<RefreshOrderDetail>(_onRefresh);
    on<SubmitNeedHelp>(_onSubmitNeedHelp);
    on<ResetHelpSubmission>(_onResetHelpSubmission);
    on<UpdateOrderDetailItem>(_onUpdateOrderDetailItem);
  }

  Future<void> _onLoad(
    LoadOrderDetail event,
    Emitter<OrderDetailState> emit,
  ) async {
    ///  GUARD: avoid duplicate calls
    if (!event.forceRefresh &&
        state.order != null &&
        state.order!.orderId == event.orderId &&
        state.order!.items.any((e) => e.itemId == event.itemId)) {
      return;
    }

    emit(state.copyWith(isLoading: true));

    try {
      final order = await _repo.getOrderById(event.orderId, event.itemId);

      emit(state.copyWith(isLoading: false, order: order));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onRefresh(
    RefreshOrderDetail event,
    Emitter<OrderDetailState> emit,
  ) async {
    try {
      final order = await _repo.getOrderById(event.orderId, event.itemId);

      emit(state.copyWith(order: order));
    } catch (_) {}
  }

  Future<void> _onSubmitNeedHelp(
    SubmitNeedHelp event,
    Emitter<OrderDetailState> emit,
  ) async {
    emit(
      state.copyWith(isSubmittingHelp: true, helpSubmitted: false, error: ''),
    );

    try {
      await _repo.submitNeedHelp(
        issue: event.issue,
        orderId: event.orderId,
        itemId: event.itemId,
      );

      emit(
        state.copyWith(isSubmittingHelp: false, helpSubmitted: true, error: ''),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isSubmittingHelp: false,
          helpSubmitted: false,
          error: e.toString(),
        ),
      );
    }
  }

  void _onResetHelpSubmission(
    ResetHelpSubmission event,
    Emitter<OrderDetailState> emit,
  ) {
    emit(state.copyWith(isSubmittingHelp: false, helpSubmitted: false));
  }

  Future<void> _onUpdateOrderDetailItem(
    UpdateOrderDetailItem event,
    Emitter<OrderDetailState> emit,
  ) async {
    final currentOrder = state.order;

    if (currentOrder == null) return;

    final updatedItems = currentOrder.items.map((item) {
      if (item.itemId == event.itemId) {
        return item.copyWith(
          status: event.status,
          rawStatus: event.rawStatus,
          cancellationStatus: event.cancellationStatus,
          cancellationReason: event.cancellationReason,
        );
      }
      return item;
    }).toList();

    emit(state.copyWith(order: currentOrder.copyWith(items: updatedItems)));
  }
}
