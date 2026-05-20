part of 'buy_pet_detail_bloc.dart';

enum BuyPetDetailStatus { initial, loading, success, failure, empty }

class BuyPetDetailState extends Equatable {
  const BuyPetDetailState({
    this.status = BuyPetDetailStatus.initial,
    this.detail,
    this.error,
    this.isRefreshing = false,
  });

  final BuyPetDetailStatus status;
  final ProductDetail? detail;
  final String? error;
  final bool isRefreshing;

  BuyPetDetailState copyWith({
    BuyPetDetailStatus? status,
    ProductDetail? detail,
    String? error,
    bool? isRefreshing,
    bool clearError = false,
  }) {
    return BuyPetDetailState(
      status: status ?? this.status,
      detail: detail ?? this.detail,
      error: clearError ? null : (error ?? this.error),
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => <Object?>[status, detail, error, isRefreshing];
}
