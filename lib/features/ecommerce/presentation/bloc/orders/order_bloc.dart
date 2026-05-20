import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';
import 'package:poochcare/features/ecommerce/domain/repository/cart_repository.dart';
import 'package:poochcare/features/ecommerce/domain/repository/orders_repository.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/orders/order_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/orders/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _repo;
  final CartRepository _cartRepository;

  OrderBloc(this._repo, this._cartRepository) : super(const OrderState()) {
    on<LoadOrders>(_onLoadOrders);
    on<LoadMoreOrders>(_onLoadMoreOrders);
    on<UpdateOrderItemStatus>(_onUpdateOrderItemStatus);
    on<PlaceOrderFromCart>(_onPlaceOrderFromCart);
  }

  /// =========================
  /// LOAD ORDERS (TAB / REFRESH)
  /// =========================
  Future<void> _onLoadOrders(LoadOrders event, Emitter<OrderState> emit) async {
    if (state.isLoading) return;

    /// ✅ USE CACHE ONLY when:
    /// same tab + not refresh + cache exists
    if (state.status == event.status && !event.isRefresh) {
      final cached = state.cache[event.status];

      if (cached != null && cached.isNotEmpty) {
        emit(
          state.copyWith(
            orders: cached,
            status: event.status,
            isLoading: false,
          ),
        );
        return;
      }
    }

    /// ✅ CLEAR CACHE on refresh
    final newCache = Map<String?, List<OrderItemModel>>.from(state.cache);
    if (event.isRefresh) {
      newCache.remove(event.status);
    }

    /// Fresh load
    emit(
      state.copyWith(
        isLoading: true,
        page: 1,
        hasReachedMax: false,
        status: event.status,
        orders: [],
        cache: newCache,
      ),
    );

    try {
      final response = await _repo.getOrders(page: 1, status: event.status);

      final updatedCache = Map<String?, List<OrderItemModel>>.from(newCache);
      updatedCache[event.status] = response.orders;

      emit(
        state.copyWith(
          isLoading: false,
          orders: response.orders,
          page: 1,
          status: event.status,
          cache: updatedCache,
          hasReachedMax:
              response.orders.isEmpty || response.page >= response.pages,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  /// =========================
  /// LOAD MORE (PAGINATION)
  /// =========================
  Future<void> _onLoadMoreOrders(
    LoadMoreOrders event,
    Emitter<OrderState> emit,
  ) async {
    if (state.hasReachedMax || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.page + 1;

    try {
      final response = await _repo.getOrders(
        page: nextPage,
        status: state.status,
      );

      final updatedOrders = [...state.orders, ...response.orders];

      /// Update cache with paginated data
      final newCache = Map<String?, List<OrderItemModel>>.from(state.cache);
      newCache[state.status] = updatedOrders;

      emit(
        state.copyWith(
          isLoadingMore: false,
          page: nextPage,
          orders: updatedOrders,
          cache: newCache,
          hasReachedMax: response.orders.isEmpty || nextPage >= response.pages,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingMore: false));
    }
  }

  Future<void> _onUpdateOrderItemStatus(
    UpdateOrderItemStatus event,
    Emitter<OrderState> emit,
  ) async {
    /// 🔁 Update current visible list
    final updatedOrders = state.orders.map((item) {
      if (item.itemId == event.itemId) {
        return item.copyWith(
          status: event.newStatus,
          rawStatus: event.newRawStatus,
          cancellationStatus: event.cancellationStatus,
          cancellationReason: event.cancellationReason,
        );
      }
      return item;
    }).toList();

    /// 🔁 Update ALL cached tabs
    final updatedCache = <String?, List<OrderItemModel>>{};

    state.cache.forEach((key, list) {
      updatedCache[key] = list.map((item) {
        if (item.itemId == event.itemId) {
          return item.copyWith(
            status: event.newStatus,
            rawStatus: event.newRawStatus,
            cancellationStatus: event.cancellationStatus,
            cancellationReason: event.cancellationReason,
          );
        }
        return item;
      }).toList();
    });

    emit(state.copyWith(orders: updatedOrders, cache: updatedCache));
  }

  Future<void> _onPlaceOrderFromCart(
    PlaceOrderFromCart event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(isPlacingOrder: true));

    try {
      final result = await _cartRepository.placeOrder(event.request);

      emit(state.copyWith(isPlacingOrder: false, placedOrder: result));

      event.completer.complete(result);
    } catch (e, stackTrace) {
      emit(
        state.copyWith(isPlacingOrder: false, placeOrderError: e.toString()),
      );

      event.completer.completeError(e, stackTrace);
    }
  }
}
