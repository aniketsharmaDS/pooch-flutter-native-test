import 'package:equatable/equatable.dart';

sealed class AccessoriesEvent extends Equatable {
  const AccessoriesEvent();

  @override
  List<Object?> get props => [];
}

class FetchAccessoriesEvent extends AccessoriesEvent {
  final int? page;
  final bool isForceRefresh;
  final String? couponCode;
  const FetchAccessoriesEvent({
    this.page,
    this.isForceRefresh = false,
    this.couponCode,
  });

  @override
  List<Object?> get props => [page, isForceRefresh, couponCode];
}

class FetchMyAccessoriesEvent extends AccessoriesEvent {
  final int? page;
  final bool isForceRefresh;
  const FetchMyAccessoriesEvent(this.page, this.isForceRefresh);

  @override
  List<Object?> get props => [page, isForceRefresh];
}
