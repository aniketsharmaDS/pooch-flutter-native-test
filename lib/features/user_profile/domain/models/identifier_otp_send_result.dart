import 'package:equatable/equatable.dart';

class IdentifierOtpSendResult extends Equatable {
  const IdentifierOtpSendResult({required this.message});

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
