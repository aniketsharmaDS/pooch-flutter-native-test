import 'package:equatable/equatable.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/sections/reason_for_cancellation_section.dart';

class OrderSupportState extends Equatable {
  final List<CancellationReasonOption> reasons;
  final String refundPolicy;
  final bool isLoadingReasons;
  final bool isSubmitting;
  final bool isSuccess;
  final String? error;

  const OrderSupportState({
    this.reasons = const [],
    this.refundPolicy = '',
    this.isLoadingReasons = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.error,
  });

  OrderSupportState copyWith({
    List<CancellationReasonOption>? reasons,
    String? refundPolicy,
    bool? isLoadingReasons,
    bool? isSubmitting,
    bool? isSuccess,
    String? error,
    bool clearError = false,
  }) {
    return OrderSupportState(
      reasons: reasons ?? this.reasons,
      refundPolicy: refundPolicy ?? this.refundPolicy,
      isLoadingReasons: isLoadingReasons ?? this.isLoadingReasons,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [
    reasons,
    refundPolicy,
    isLoadingReasons,
    isSubmitting,
    isSuccess,
    error,
  ];
}
