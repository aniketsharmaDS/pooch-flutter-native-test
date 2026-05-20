class InviteActionApiResult {
  const InviteActionApiResult({
    required this.success,
    required this.status,
    required this.message,
  });

  final bool success;
  final int status;
  final String message;
}
