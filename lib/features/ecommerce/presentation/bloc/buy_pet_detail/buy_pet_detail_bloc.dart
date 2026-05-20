import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/features/ecommerce/domain/models/product_detail.dart';
import 'package:poochcare/features/ecommerce/domain/repository/buy_pet_repository.dart';

part 'buy_pet_detail_event.dart';
part 'buy_pet_detail_state.dart';

class BuyPetDetailBloc extends Bloc<BuyPetDetailEvent, BuyPetDetailState> {
  BuyPetDetailBloc({required BuyPetRepository repository})
    : _repository = repository,
      super(const BuyPetDetailState()) {
    on<BuyPetDetailRequested>(_onRequested);
    on<BuyPetDetailRefreshed>(_onRefreshed);
    on<BuyPetDetailWishlistToggled>(_onWishlistToggled);
  }

  final BuyPetRepository _repository;

  Future<void> _onRequested(
    BuyPetDetailRequested event,
    Emitter<BuyPetDetailState> emit,
  ) async {
    if (state.status == BuyPetDetailStatus.loading) return;

    emit(
      state.copyWith(
        status: BuyPetDetailStatus.loading,
        isRefreshing: false,
        clearError: true,
      ),
    );

    await _loadDetail(event.productId, emit, isRefresh: false);
  }

  Future<void> _onRefreshed(
    BuyPetDetailRefreshed event,
    Emitter<BuyPetDetailState> emit,
  ) async {
    emit(state.copyWith(isRefreshing: true, clearError: true));
    await _loadDetail(event.productId, emit, isRefresh: true);
  }

  void _onWishlistToggled(
    BuyPetDetailWishlistToggled event,
    Emitter<BuyPetDetailState> emit,
  ) {
    final detail = state.detail;
    if (detail == null) return;

    emit(
      state.copyWith(detail: detail.copyWith(inWishlist: !detail.inWishlist)),
    );
  }

  Future<void> _loadDetail(
    String productId,
    Emitter<BuyPetDetailState> emit, {
    required bool isRefresh,
  }) async {
    try {
      final ProductDetail detail = await _repository.getProductDetail(
        productId: productId,
      );

      if (detail.id.trim().isEmpty) {
        emit(
          state.copyWith(status: BuyPetDetailStatus.empty, isRefreshing: false),
        );
        return;
      }

      emit(
        state.copyWith(
          status: BuyPetDetailStatus.success,
          detail: detail,
          isRefreshing: false,
        ),
      );
    } catch (error) {
      final message = _mapError(error);
      if (state.detail != null && isRefresh) {
        emit(state.copyWith(error: message, isRefreshing: false));
        return;
      }
      emit(
        state.copyWith(
          status: BuyPetDetailStatus.failure,
          error: message,
          isRefreshing: false,
        ),
      );
    }
  }

  String _mapError(Object error) {
    if (error is ApiException) return error.message;
    final text = error.toString();
    if (text.isNotEmpty) return text;
    return 'Something went wrong. Please try again.';
  }
}
