import 'package:equatable/equatable.dart';

class OtpSendResult extends Equatable {
  const OtpSendResult({required this.message});

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
