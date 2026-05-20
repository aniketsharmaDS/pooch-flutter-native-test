import 'dart:io';

abstract class OrderSupportEvent {}

class SubmitOrderIssue extends OrderSupportEvent {
  final String issue;
  final String? orderId;
  final String? itemId;

  SubmitOrderIssue({required this.issue, this.orderId, this.itemId});
}

class ResetOrderSupport extends OrderSupportEvent {}

class LoadCancellationReasons extends OrderSupportEvent {}

class SubmitOrderCancellation extends OrderSupportEvent {
  final String orderId;
  final String itemId;
  final String reason;
  final List<File> images;

  SubmitOrderCancellation({
    required this.orderId,
    required this.itemId,
    required this.reason,
    required this.images,
  });
}
