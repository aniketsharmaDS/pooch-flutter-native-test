import 'package:equatable/equatable.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_details_model.dart';

class OrderDetailState extends Equatable {
  final OrderDetailModel? order;
  final bool isLoading;
  final String? error;
  final bool isSubmittingHelp;
  final bool helpSubmitted;

  const OrderDetailState({
    this.order,
    this.isLoading = false,
    this.error,
    this.isSubmittingHelp = false,
    this.helpSubmitted = false,
  });

  OrderDetailState copyWith({
    OrderDetailModel? order,
    bool? isLoading,
    String? error,
    bool? isSubmittingHelp,
    bool? helpSubmitted,
  }) {
    return OrderDetailState(
      order: order ?? this.order,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isSubmittingHelp: isSubmittingHelp ?? this.isSubmittingHelp,
      helpSubmitted: helpSubmitted ?? this.helpSubmitted,
    );
  }

  @override
  List<Object?> get props => [
    order,
    isLoading,
    error,
    isSubmittingHelp,
    helpSubmitted,
  ];
}
