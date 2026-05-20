class CancellationTrackingModel {
  final String status;
  final String reason;
  final String? createdAt;
  final String type;
  final String? adminNotes;
  final String? refundAmount;
  final String? decision;
  final String? requestedAt;
  final String? reviewedAt;
  final String? decidedAt;
  final String? refundInitiatedAt;
  final String? completedAt;

  const CancellationTrackingModel({
    required this.status,
    required this.reason,
    required this.type,
    required this.adminNotes,
    required this.decision,
    this.refundAmount,
    required this.reviewedAt,
    required this.decidedAt,
    this.createdAt,
    this.requestedAt,
    this.refundInitiatedAt,
    this.completedAt,
  });

  factory CancellationTrackingModel.fromJson(Map<String, dynamic> json) {
    return CancellationTrackingModel(
      status: json['status']?.toString() ?? '',
      reason: json['reason']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      adminNotes: json['adminNotes']?.toString(),
      decision: json['decision']?.toString(),
      refundAmount: json['refundAmount']?.toString(),
      reviewedAt: json['reviewedAt']?.toString(),
      decidedAt: json['decidedAt']?.toString(),
      createdAt: json['createdAt']?.toString(),
      requestedAt: json['requestedAt']?.toString(),
      refundInitiatedAt: json['refundInitiatedAt']?.toString(),
      completedAt: json['completedAt']?.toString(),
    );
  }
}
