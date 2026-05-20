import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/ecommerce/domain/repository/cart_repository.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_state.dart';
import 'package:poochcare/features/fun/repository/accessories_repository.dart';

class CouponsBloc extends Bloc<CouponsEvent, CouponsState> {
  final CartRepository repository;
  final AccessoriesRepository accessoryRepository;

  CouponsBloc(this.repository, this.accessoryRepository)
    : super(const CouponsState()) {
    on<FetchCouponsEvent>(_onFetchCoupons);
    on<ApplyCouponEvent>(_onApplyCoupon);
    on<RemoveCouponEvent>(_onRemoveCoupon);
    on<ResetCouponsEvent>(_onReset);
    on<ApplyCouponLocally>(_onApplyCouponLocally);
    on<ApplyAccessoryCouponEvent>(_onApplyAccessoryCoupon);
    on<RemoveCouponLocallyEvent>(_onRemoveCouponLocally);
    on<ApplyAccessoryCouponLocally>(_onApplyAccessoryCouponLocally);
  }

  Future<void> _onFetchCoupons(
    FetchCouponsEvent event,
    Emitter<CouponsState> emit,
  ) async {
    emit(state.copyWith(status: CouponsStatus.loading));
    try {
      final coupons = await repository.getCoupons(
        page: event.page,
        // couponsType: 'products',
      );
      emit(
        state.copyWith(
          status: CouponsStatus.success,
          coupons: coupons,
          actionId: state.actionId + 1,
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(
        state.copyWith(
          status: CouponsStatus.failure,
          errorMessage: 'Failed to fetch coupons',
          actionId: state.actionId + 1,
        ),
      );
    }
  }

  Future<void> _onApplyCouponLocally(
    ApplyCouponLocally event,
    Emitter<CouponsState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: CouponsStatus.success,
          applyCouponResponse: event.applyCouponResponse,
          successMessage: 'Coupon applied successfully',
          actionId: state.actionId + 1,
          appliedCouponCodeInCart: event.couponCode,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CouponsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onApplyCoupon(
    ApplyCouponEvent event,
    Emitter<CouponsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: CouponsStatus.loading,
        applyingCouponCodeInCart: event.couponCode,
      ),
    );
    try {
      final response = await repository.applyCoupon(event.couponCode);

      emit(
        state.copyWith(
          status: CouponsStatus.success,
          applyCouponResponse: response,
          successMessage: 'Coupon applied successfully',
          actionId: state.actionId + 1,
          appliedCouponCodeInCart: event.couponCode,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CouponsStatus.failure,
          errorMessage: e.toString(),
          actionId: state.actionId + 1,
        ),
      );
    }
  }

  Future<void> _onRemoveCoupon(
    RemoveCouponEvent event,
    Emitter<CouponsState> emit,
  ) async {
    emit(state.copyWith(status: CouponsStatus.loading));
    try {
      final result = await repository.removeCoupon(event.couponCode);
      if (result.success) {
        emit(
          state.copyWith(
            status: CouponsStatus.success,
            successMessage: result.message,
            actionId: state.actionId + 1,
            appliedCouponCodeInCart: '', // Clear applied code
            clearApplyCouponResponse: true, // Clear response data
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: CouponsStatus.failure,
            errorMessage: result.message,
            actionId: state.actionId + 1,
          ),
        );
      }
    } catch (e) {
      log(e.toString());
      emit(
        state.copyWith(
          status: CouponsStatus.failure,
          errorMessage: e.toString(),
          actionId: state.actionId + 1,
        ),
      );
    }
  }

  void _onReset(ResetCouponsEvent event, Emitter<CouponsState> emit) {
    emit(const CouponsState());
  }

  void _onRemoveCouponLocally(
    RemoveCouponLocallyEvent event,
    Emitter<CouponsState> emit,
  ) {
    emit(
      const CouponsState(
        status: CouponsStatus.success,
        successMessage: 'Coupon Removed',
      ),
    );
  }

  FutureOr<void> _onApplyAccessoryCoupon(
    ApplyAccessoryCouponEvent event,
    Emitter<CouponsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: CouponsStatus.loading,
        applyingCouponCodeInAccessory: event.couponCode,
      ),
    );
    try {
      final response = await accessoryRepository.getBookingSummary(
        country: event.country,
        petId: event.petId,
        quantity: 1,
        accessoryId: event.accessoryId,
        couponCode: event.couponCode,
      );
      emit(
        state.copyWith(
          accessoryCouponResponse: response.coupon,
          status: CouponsStatus.success,
          successMessage: 'Coupon applied successfully',
          actionId: state.actionId + 1,
          appliedCouponCodeInAccessory: event.couponCode,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CouponsStatus.failure,
          errorMessage: e.toString(),
          actionId: state.actionId + 1,
        ),
      );
    }
  }

  FutureOr<void> _onApplyAccessoryCouponLocally(
    ApplyAccessoryCouponLocally event,
    Emitter<CouponsState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: CouponsStatus.success,
          accessoryCouponResponse: event.applyCouponResponse,
          successMessage: 'Coupon applied successfully',
          actionId: state.actionId + 1,
          appliedCouponCodeInAccessory: event.couponCode,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CouponsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
