abstract class OrderDetailEvent {}

class LoadOrderDetail extends OrderDetailEvent {
  final String orderId;
  final String itemId;
  final bool forceRefresh;

  LoadOrderDetail(this.orderId, this.itemId, {this.forceRefresh = false});
}

class RefreshOrderDetail extends OrderDetailEvent {
  final String orderId;
  final String itemId;

  RefreshOrderDetail(this.orderId, this.itemId);
}

class SubmitNeedHelp extends OrderDetailEvent {
  final String issue;
  final String? orderId;
  final String? itemId;

  SubmitNeedHelp({required this.issue, this.orderId, this.itemId});
}

class ResetHelpSubmission extends OrderDetailEvent {}

class UpdateOrderDetailItem extends OrderDetailEvent {
  final String itemId;
  final String status;
  final String rawStatus;
  final String? cancellationStatus;
  final String? cancellationReason;

  UpdateOrderDetailItem({
    required this.itemId,
    required this.status,
    required this.rawStatus,
    this.cancellationStatus,
    this.cancellationReason,
  });
}
